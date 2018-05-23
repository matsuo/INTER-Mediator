<?php
/**
 * INTER-Mediator
 * Copyright (c) INTER-Mediator Directive Committee (http://inter-mediator.org)
 * This project started at the end of 2009 by Masayuki Nii msyk@msyk.net.
 *
 * INTER-Mediator is supplied under MIT License.
 * Please see the full license for details:
 * https://github.com/INTER-Mediator/INTER-Mediator/blob/master/dist-docs/License.txt
 *
 * @copyright     Copyright (c) INTER-Mediator Directive Committee (http://inter-mediator.org)
 * @link          https://inter-mediator.com/
 * @license       http://www.opensource.org/licenses/mit-license.php MIT License
 */

namespace INTERMediator;
// Setup autoloader
$imRoot = dirname(dirname(dirname(__FILE__))) . DIRECTORY_SEPARATOR;
require($imRoot . 'src/vendor/autoload.php');
// Character set for mbstring
if (function_exists('mb_internal_encoding')) {
    mb_internal_encoding('UTF-8');
}
// Setup Timezone
$params = IMUtil::getFromParamsPHPFile(array("defaultTimezone"), true);
if (isset($params['defaultTimezone'])) {
    date_default_timezone_set($params['defaultTimezone']);
} else if (ini_get('date.timezone') == null) {
    date_default_timezone_set('UTC');
}
// Setup Locale
Locale\IMLocale::setLocale(LC_ALL);
// Define constant
define("IM_TODAY", strftime('%Y-%m-%d'));

/**
 * INTER-Mediator entry point
 * @param $datasource
 * @param $options
 * @param $dbspecification
 * @param bool $debug
 */
function IM_Entry($datasource, $options, $dbspecification, $debug = false)
{
    // check required PHP extensions
    $requiredFunctions = array(
        'mbstring' => 'mb_internal_encoding',
    );
    if (isset($options) && is_array($options)) {
        foreach ($options as $key => $option) {
            if ($key == 'authentication'
                && isset($option['user'])
                && is_array($option['user'])
                && array_search('database_native', $option['user']) !== false
            ) {
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

    if (isset($_GET['theme'])) {
        $themeManager = new Theme();
        $themeManager->processing();
    } else if (!isset($_POST['access']) && isset($_GET['uploadprocess'])) {
        $fileUploader = new FileUploader();
        $fileUploader->processInfo();
    } else if (!isset($_POST['access']) && isset($_GET['media'])) {
        $dbProxyInstance = new DB\Proxy();
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
        if (IMUtil::guessFileUploadError()) {
            $fileUploader->processingAsError($datasource, $options, $dbspecification, $debug);
        } else {
            $fileUploader->processing($datasource, $options, $dbspecification, $debug);
        }
    } else if (!isset($_POST['access']) && !isset($_GET['media'])) {
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

        $generator = new GenerateJSCode();
        $generator->generateInitialJSCode($datasource, $options, $dbspecification, $debug);
    } else {
        $dbInstance = new DB\Proxy();
        if (!$dbInstance->initialize($datasource, $options, $dbspecification, $debug)) {
            $dbInstance->finishCommunication(true);
        } else {
            $util = new IMUtil();
            if ($util->protectCSRF() === TRUE) {
                $dbInstance->processingRequest();
                $dbInstance->finishCommunication(false);
            } else {
                $dbInstance->addOutputData('debugMessages', 'Invalid Request Error.');
                $dbInstance->addOutputData('errorMessages', array('Invalid Request Error.'));
            }
        }
        $dbInstance->exportOutputDataAsJSON();
    }
}
