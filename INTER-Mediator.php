<?php
/*
 * INTER-Mediator Ver.@@@@2@@@@ Released @@@@1@@@@
 * 
 *   by Masayuki Nii  msyk@msyk.net Copyright (c) 2010-2014 Masayuki Nii, All rights reserved.
 * 
 *   This project started at the end of 2009.
 *   INTER-Mediator is supplied under MIT License.
 */

require_once(dirname(__FILE__) . '/INTERMediator_Lib.php');
require_once(dirname(__FILE__) . '/DB_Interfaces.php');
require_once(dirname(__FILE__) . '/DB_Logger.php');
require_once(dirname(__FILE__) . '/DB_Settings.php');
require_once(dirname(__FILE__) . '/DB_UseSharedObjects.php');
require_once(dirname(__FILE__) . '/DB_Proxy.php');

if (function_exists('mb_internal_encoding')) {
    mb_internal_encoding('UTF-8');
}

$currentDir = dirname(__FILE__) . DIRECTORY_SEPARATOR . 'lib' . DIRECTORY_SEPARATOR;

if (!class_exists('Crypt_RSA')) {
    require_once($currentDir . 'phpseclib' . DIRECTORY_SEPARATOR . 'Crypt' . DIRECTORY_SEPARATOR . 'RSA.php');
}
if (!class_exists('Crypt_Hash')) {
    require_once($currentDir . 'phpseclib' . DIRECTORY_SEPARATOR . 'Crypt' . DIRECTORY_SEPARATOR . 'Hash.php');
}
if (!class_exists('Math_BigInteger')) {
    require_once($currentDir . 'phpseclib' . DIRECTORY_SEPARATOR . 'Math' . DIRECTORY_SEPARATOR . 'BigInteger.php');
}

$currentDir = dirname(__FILE__) . DIRECTORY_SEPARATOR;
$currentDirParam = $currentDir . 'params.php';
$parentDirParam = dirname(dirname(__FILE__)) . DIRECTORY_SEPARATOR . 'params.php';
if (file_exists($parentDirParam)) {
    include($parentDirParam);
} else if (file_exists($currentDirParam)) {
    include($currentDirParam);
}

if (isset($defaultTimezone)) {
    date_default_timezone_set($defaultTimezone);
} else if (ini_get('date.timezone') == null) {
    date_default_timezone_set('UTC');
}


$g_dbInstance = null;

function IM_Entry($datasource, $options, $dbspecification, $debug = false)
{
    global $g_dbInstance, $g_serverSideCall;
    spl_autoload_register('loadClass');

    // check required PHP extensions
    $requiredFunctions = array(
        'mbstring' => 'mb_internal_encoding',
    );
    if (isset($options) && is_array($options)) {
        foreach ($options as $key => $option) {
            if ($key == 'authentication'
                && isset($option['user'])
                && is_array($option['user'])
                && array_search('database_native', $option['user']) !== false) {
                // Native Authentication requires BC Math functions
                $requiredFunctions = array_merge($requiredFunctions, array('bcmath' => 'bcadd'));
                break;
            }
        }
    }
    foreach ($requiredFunctions as $key => $value) {
        if (!function_exists($value)) {
            $generator = new GenerateJSCode();
            $generator->generateInitialJSCode($datasource, $options, $dbspecification, $debug);
            $generator->generateErrorMessageJS("PHP extension \"" . $key . "\" is required for running INTER-Mediator.");
            return;
        }
    }

    if ($debug) {
        $dc = new DefinitionChecker();
        $defErrorMessage = $dc->checkDefinitions($datasource, $options, $dbspecification);
        if (strlen($defErrorMessage) > 0) {
            $generator = new GenerateJSCode();
            $generator->generateInitialJSCode($datasource, $options, $dbspecification, $debug);
            $generator->generateErrorMessageJS($defErrorMessage);
            return;
        }
    }

    if (isset($g_serverSideCall) && $g_serverSideCall) {
        $dbInstance = new DB_Proxy(true);
        $dbInstance->initialize($datasource, $options, $dbspecification, $debug);
        $dbInstance->processingRequest($options, 'NON');
        $g_dbInstance = $dbInstance;
        $authResult = false;
        $redirect = false;

        $currentDir = dirname(__FILE__) . DIRECTORY_SEPARATOR;
        $currentDirParam = $currentDir . 'params.php';
        $parentDirParam = dirname(dirname(__FILE__)) . DIRECTORY_SEPARATOR . 'params.php';
        if (file_exists($parentDirParam)) {
            include($parentDirParam);
        } else if (file_exists($currentDirParam)) {
            include($currentDirParam);
        }

        if (isset($_COOKIE) && isset($_COOKIE['_im_credential']) && !empty($_COOKIE['_im_credential'])) {
            $credential = isset($_COOKIE['_im_credential']) ? $_COOKIE['_im_credential'] : '';
            $username = isset($_COOKIE['_im_username']) ? $_COOKIE['_im_username'] : '';
            
            $clientId = isset($securitySalt) ? $securitySalt : $this->generateClientId('');
            $challenge = $dbInstance->generateChallenge();
            $dbInstance->saveChallenge($username, $challenge, $clientId);

            $calcuratedHash = hash_hmac('sha256', $credential, $challenge);

            $authResult = $dbInstance->checkAuthorization($username, $calcuratedHash, $clientId);
        } else if (isset($_POST) && isset($_POST['_im_username'])) {
            $clientId = isset($_POST['clientid']) ? $_POST['clientid'] :
                (isset($_SERVER['REMOTE_ADDR']) ? $_SERVER['REMOTE_ADDR'] : 'Non-browser-client');
            $username = isset($_POST['_im_username']) ? $_POST['_im_username'] : '';
            $password = isset($_POST['_im_password']) ? $_POST['_im_password'] : '';
            $uid = $dbInstance->dbClass->authSupportGetUserIdFromUsername($username);
            
            $retrievedHexSalt = $dbInstance->authSupportGetSalt($username);
            $retrievedSalt = pack('N', hexdec($retrievedHexSalt));
            
            $clientId = isset($securitySalt) ? $securitySalt : $this->generateClientId('');
            $challenge = $dbInstance->generateChallenge();
            $dbInstance->saveChallenge($username, $challenge, $clientId);
            
            $hashedvalue = sha1($password . $retrievedSalt) . bin2hex($retrievedSalt);
            $calcuratedHash = hash_hmac('sha256', $hashedvalue, $challenge);
            
            $authResult = $dbInstance->checkAuthorization($username, $calcuratedHash, $clientId);
            $redirect = true;
        }
        if ($authResult) {
            if ($redirect) {
                $scheme = isset($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] == "on" ? "https://" : "http://";
                $port = '';
                if (($scheme == "http://" && $_SERVER['SERVER_PORT'] != 80) || ($scheme == "https://" && $_SERVER['SERVER_PORT'] != 443)) {
                    $port = ':' . $_SERVER['SERVER_PORT'];
                }
                $url = $scheme . $_SERVER['SERVER_NAME'] . $port . $_SERVER['REQUEST_URI'];
                header("Location: {$url}");
            }
            if (isset($hashedvalue)) {
                setcookie('_im_username', $username);
                setcookie('_im_credential', $hashedvalue);
            }
        } else {
            $imlib = new INTERMediator_Lib();
            $html = $imlib->getLoginPage();
            echo $html;
            die;
        }
    } else if (!isset($_POST['access']) && isset($_GET['uploadprocess'])) {
        $fileUploader = new FileUploader();
        $fileUploader->processInfo();
    } else if (!isset($_POST['access']) && isset($_GET['media'])) {
        $dbProxyInstance = new DB_Proxy();
        $dbProxyInstance->initialize($datasource, $options, $dbspecification, $debug);
        $mediaHandler = new MediaAccess();
        if (isset($_GET['attach'])) {
            $mediaHandler->asAttachment();
        }
        $mediaHandler->processing($dbProxyInstance, $options, $_GET['media']);
    } else if ((isset($_POST['access']) && $_POST['access'] == 'uploadfile')
        || (isset($_GET['access']) && $_GET['access'] == 'uploadfile')
    ) {
        $fileUploader = new FileUploader();
        $fileUploader->processing($datasource, $options, $dbspecification, $debug);
    } else if (!isset($_POST['access']) && !isset($_GET['media'])) {
        $generator = new GenerateJSCode();
        $generator->generateInitialJSCode($datasource, $options, $dbspecification, $debug);
    } else {
        $dbInstance = new DB_Proxy();
        $dbInstance->initialize($datasource, $options, $dbspecification, $debug);
        $dbInstance->processingRequest($options);
        $dbInstance->finishCommunication(false);
        $dbInstance->exportOutputDataAsJason();
    }
}


/**
 * Dynamic class loader
 * @param $className
 */
function loadClass($className)
{
    if ((include_once $className . '.php') === false) {
        $errorGenerator = new GenerateJSCode();
        if (strpos($className, "MessageStrings_") !== 0) {
            $errorGenerator->generateErrorMessageJS("The class '{$className}' is not defined.");
        }
    }

}

/**
 * Convert strings to JavaScript friendly strings.
 * Contributed by Atsushi Matsuo at Jan 17, 2010
 * @return string strings for JavaScript
 */
function valueForJSInsert($str)
{
    return str_replace("'", "\\'",
        str_replace('"', '\\"',
            str_replace("/", "\\/",
                str_replace(">", "\\x3e",
                    str_replace("<", "\\x3c",
                        str_replace("\n", "\\n",
                            str_replace("\r", "\\r",
                                str_replace("\xe2\x80\xa8", "\\n",      // U+2028
                                    str_replace("\xe2\x80\xa9", "\\n",  // U+2029
                                        str_replace("\\", "\\\\", $str))))))))));
}

/**
 * Create JavaScript source from array
 * @param array ar parameter array
 * @param string prefix strings for the prefix for key
 * @return string JavaScript source
 */
function arrayToJS($ar, $prefix)
{
    if (is_array($ar)) {
        $items = array();
        foreach ($ar as $key => $value) {
            $items[] = arrayToJS($value, $key);
        }
        $currentKey = (string)$prefix;
        if ($currentKey == '')
            $returnStr = "{" . implode(',', $items) . '}';
        else
            $returnStr = "'{$currentKey}':{" . implode(',', $items) . '}';
    } else {
        $currentKey = (string)$prefix;
        if ($currentKey == '') {
            $returnStr = "'" . valueForJSInsert($ar) . "'";
        } else {
            $returnStr = "'{$prefix}':'" . valueForJSInsert($ar) . "'";
        }
    }
    return $returnStr;
}

/**
 * Create JavaScript source from array
 * @param array ar parameter array
 * @param string prefix strings for the prefix for key
 * @param array exarray array containing excluding keys
 * @return string JavaScript source
 */
function arrayToJSExcluding($ar, $prefix, $exarray)
{
    $returnStr = '';

    if (is_array($ar)) {
        $items = array();
        foreach ($ar as $key => $value) {
            $items[] = arrayToJSExcluding($value, $key, $exarray);
        }
        $currentKey = (string)$prefix;
        foreach ($items as $item) {
            if (!in_array($currentKey, $exarray) && $item != '') {
                if ($returnStr == '') {
                    $returnStr .= $item;
                } else {
                    $returnStr .= ',' . $item;
                }
            }
        }
        if ($currentKey == '') {
            $returnStr = '{' . $returnStr . '}';
        } else {
            $returnStr = "'{$currentKey}':{" . $returnStr . '}';
        }
    } else {
        $currentKey = (string)$prefix;
        if ($currentKey == '') {
            $returnStr = "'" . valueForJSInsert($ar) . "'";
        } else if (!in_array($currentKey, $exarray)) {
            $returnStr = "'{$prefix}':'" . valueForJSInsert($ar) . "'";
        }
    }

    return $returnStr;
}

/**
 * Create parameter strng from array
 * @param array ar parameter array
 * @param string prefix strings for the prefix for key
 * @return string parameter string
 */
function arrayToQuery($ar, $prefix)
{
    if (is_array($ar)) {
        $items = array();
        foreach ($ar as $key => $value) {
            $items[] = arrayToQuery($value, "{$prefix}_{$key}");
        }
        $returnStr = implode('', $items);
    } else {
        $returnStr = "&{$prefix}=" . urlencode($ar);
    }
    return $returnStr;
}

/**
 * Get the relative path from the caller to the directory of 'INTER-Mediator.php'.
 * @return Relative path as a part of URL.
 */
function getRelativePath()
{
    $caller = explode(DIRECTORY_SEPARATOR, dirname($_SERVER['SCRIPT_FILENAME']));
    $imDirectory = explode(DIRECTORY_SEPARATOR, dirname(__FILE__));
    $commonPath = '';
    $shorterLength = min(count($caller), count($imDirectory));
    for ($i = 0; $i < $shorterLength; $i++) {
        if ($caller[$i] != $imDirectory[$i]) {
            break;
        }
    }
    $relPath = str_repeat('../', count($caller) - $i)
        . implode('/', array_slice($imDirectory, $i));
    return $relPath;
}

/**
 * Generate the instance of the message class associated with browser's language.
 * @return object Generated instance of the message class.
 */
//function getErrorMessageClass()
//{
//    $currentDir = dirname(__FILE__);
//    $lang = getLocaleFromBrowser($_SERVER['HTTP_ACCEPT_LANGUAGE']);
//    $candClassName = 'MessageStrings_' . $lang;
//    if (!file_exists($currentDir . DIRECTORY_SEPARATOR . $candClassName . '.php')) {
//        if (strpos($lang, '_') !== false) {
//            $lang = substr($lang, 0, strpos($lang, '_'));
//            $candClassName = 'MessageStrings_' . $lang;
//            if (!file_exists($currentDir . DIRECTORY_SEPARATOR . $candClassName . '.php')) {
//                $candClassName = 'MessageStrings';
//            }
//        }
//    }
//    $c = null;
//    require_once($candClassName . '.php');
//    eval("\$c = new {$candClassName}();");
//    return $c->getMessages();
//}

/**
 * Set the locale with parameter, for UNIX and Windows OS.
 * @param string locType locale identifier string.
 * @return boolean If true, strings with locale are possibly multi-byte string.
 */
function setLocaleAsBrowser($locType)
{
    $lstr = getLocaleFromBrowser(
        (!isset($_SERVER['HTTP_ACCEPT_LANGUAGE'])) ? 'ja_JP' : $_SERVER['HTTP_ACCEPT_LANGUAGE']);

    // Detect server platform, Windows or Unix
    $isWindows = false;
    $uname = php_uname();
    if (strpos($uname, 'Windows')) {
        $isWindows = true;
    }

    $useMbstring = false;
    if ($lstr == 'ja_JP') {
        $useMbstring = true;
        if ($isWindows) {
            setlocale($locType, 'jpn_jpn');
        } else {
            setlocale($locType, 'ja_JP');
        }
    } else if ($lstr == 'ja') {
        $useMbstring = true;
        if ($isWindows) {
            setlocale($locType, 'jpn_jpn');
        } else {
            setlocale($locType, 'ja_JP');
        }
    } else if ($lstr == 'en_US') {
        if ($isWindows) {
            setlocale($locType, 'jpn_jpn');
        } else {
            setlocale($locType, 'en_US');
        }
    } else if ($lstr == 'en') {
        if ($isWindows) {
            setlocale($locType, 'jpn_jpn');
        } else {
            setlocale($locType, 'en_US');
        }
    } else {
        setlocale($locType, '');
    }
    return $useMbstring;
}

/**
 * Get the locale string (ex. 'ja_JP') from HTTP header from a browser.
 * @param string $accept $_SERVER['HTTP_ACCEPT_LANGUAGE']
 * @return string Most prior locale identifier
 */
function getLocaleFromBrowser($accept)
{
    $lstr = strtolower($accept);
    // Extracting first item and cutting the priority infos.
    if (strpos($lstr, ',') !== false) $lstr = substr($lstr, 0, strpos($lstr, ','));
    if (strpos($lstr, ';') !== false) $lstr = substr($lstr, 0, strpos($lstr, ';'));

    // Convert to the right locale identifier.
    if (strpos($lstr, '-') !== false) {
        $lstr = explode('-', $lstr);
    } else if (strpos($lstr, '_') !== false) {
        $lstr = explode('_', $lstr);
    } else {
        $lstr = array($lstr);
    }
    if (count($lstr) == 1)
        $lstr = $lstr[0];
    else
        $lstr = strtolower($lstr[0]) . '_' . strtoupper($lstr[1]);
    return $lstr;
}

function hex2bin_for53($str)
{
    return pack("H*", $str);
}

function randomString($digit)
{
    $resultStr = '';
    for ($i = 0; $i < $digit; $i++) {
        $resultStr .= chr(rand(20, 126));
    }
    return $resultStr;
}
