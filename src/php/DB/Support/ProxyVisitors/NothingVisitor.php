<?php

namespace INTERMediator\DB\Support\ProxyVisitors;

use INTERMediator\DB\Support\ProxyElements\CheckAuthenticationElement;
use INTERMediator\DB\Support\ProxyElements\DataOperationElement;
use INTERMediator\DB\Support\ProxyElements\HandleChallengeElement;

/**
 *
 */
class NothingVisitor extends OperationVisitor
{
    /**
     * @param CheckAuthenticationElement $e
     * @return void
     */
    public function visitCheckAuthentication(CheckAuthenticationElement $e): void
    {
    }


    /**
     * @param DataOperationElement $e
     * @return void
     */
    public function visitDataOperation(DataOperationElement $e): void
    {
    }


    /**
     * @param HandleChallengeElement $e
     * @return void
     */
    public function visitHandleChallenge(HandleChallengeElement $e): void
    {
    }

}