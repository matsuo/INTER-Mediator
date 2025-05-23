<?php

namespace INTERMediator\DB\Support\ProxyVisitors;

use INTERMediator\DB\Logger;
use INTERMediator\DB\Support\ProxyElements\OperationElement;
use INTERMediator\IMUtil;
use INTERMediator\Messaging\MessagingProxy;
use INTERMediator\Params;

/**
 * Visitor class for handling credential-based authentication operations in the Proxy pattern.
 * Implements methods for authentication, authorization, challenge handling, and 2FA support.
 */
class CredentialVisitor extends OperationVisitor
{
    /**
     * Visits the IsAuthAccessing operation.
     *
     * @param OperationElement $e The operation element being visited.
     * @return bool Always returns true for credential access.
     */
    public function visitIsAuthAccessing(OperationElement $e): bool
    {
        return true;
    }

    /**
     * Visits the CheckAuthentication operation for credential access.
     *
     * @param OperationElement $e The operation element being visited.
     * @return bool True if authentication succeeds, false otherwise.
     */
    public function visitCheckAuthentication(OperationElement $e): bool
    {
        $result = $this->prepareCheckAuthentication($e);
        if ($result) {
            $result = $this->sessionStorageCheckAuth();
            // Hash Auth checking. Here comes not only 'session-storage' but also 'credential'.
        }
        return $result;
    }

    /**
     * Visits the CheckAuthorization operation for credential access.
     *
     * @param OperationElement $e The operation element being visited.
     * @return bool True if authorization succeeds, false otherwise.
     */
    public function visitCheckAuthorization(OperationElement $e): bool
    {
        $proxy = $this->proxy;
        return $proxy->authSucceed && $this->checkAuthorization();
    }

    /**
     * Visits the DataOperation operation. No operation for credential visitor.
     *
     * @param OperationElement $e The operation element being visited.
     * @return void
     */
    public function visitDataOperation(OperationElement $e): void
    {
    }

    /**
     * Visits the HandleChallenge operation to process challenge/response for credential access and 2FA.
     *
     * @param OperationElement $e The operation element being visited.
     * @return void
     */
    public function visitHandleChallenge(OperationElement $e): void
    {
        $proxy = $this->proxy;
        Logger::getInstance()->setDebugMessage("[handleChallenge] access={$proxy->access}, succeed={$proxy->authSucceed}", 2);

        $proxy->generatedClientID = IMUtil::generateClientId('', $proxy->passwordHash);
        $userSalt = $proxy->authSupportGetSalt($proxy->signedUser);

        if ($proxy->authSucceed) {
            switch ($proxy->authStoring) {
                case 'credential':
                    $code2FA = Params::getParameterValue("fixed2FACode", IMUtil::randomDigit($proxy->digitsOf2FACode));
                    $challenge = $this->generateAndSaveChallenge($proxy->signedUser, $proxy->generatedClientID, "+",
                        ($proxy->required2FA ? $code2FA : ""));
                    $proxy->outputOfProcessing['challenge'] = "{$challenge}{$userSalt}";
                    $proxy->outputOfProcessing['authUser'] = $proxy->signedUser;
                    $this->setCookieOfChallenge('_im_credential_token',
                        $challenge, $proxy->generatedClientID, $proxy->hashedPassword);
                    if ($proxy->required2FA && !Params::getParameterValue("fixed2FACode", false)) { // Send mail containing 2FA code.
                        $proxy->logger->setDebugMessage("Try to send a message.", 2);
                        $email = $proxy->dbClass->authHandler->authSupportEmailFromUnifiedUsername($proxy->signedUser);
                        if (!$email) {
                            $proxy->logger->setWarningMessage("The logging-in user has no email info.");
                            break;
                        }
                        if ($proxy->mailContext2FA) {
                            $msgProxy = new MessagingProxy("mail");
                            $msgProxy->processing($proxy, ['template-context' => $proxy->mailContext2FA],
                                [['mail' => $email, 'code' => $code2FA]]);
                        } else {
                            $messageClass = IMUtil::getMessageClassInstance();
                            $proxy->logger->setWarningMessage($messageClass->getMessageAs(2033));
                        }
                    }
                    break;
                case
                'session-storage':
                    $challenge = $this->generateAndSaveChallenge($proxy->signedUser, $proxy->generatedClientID, "#");
                    $proxy->outputOfProcessing['challenge'] = "{$challenge}{$userSalt}";
            }
        } else {
            $this->clearAuthenticationCookies();
        }
    }
}