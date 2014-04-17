<?php
/*
 * INTER-Mediator Ver.@@@@2@@@@ Released @@@@1@@@@
 * 
 *   by Masayuki Nii  msyk@msyk.net Copyright (c) 2010-2014 Masayuki Nii, All rights reserved.
 * 
 *   This project started at the end of 2009.
 *   INTER-Mediator is supplied under MIT License.
 */

/**
 * Class INTERMediator_Lib
 */
class INTERMediator_Lib
{
    /**
     * load message class
     * @return message class of INTER-Mediator
     */
    public function loadMessageClass()
    {
        $currentDir = dirname(__FILE__) . DIRECTORY_SEPARATOR;

        $messageClass = null;
        if (isset($_SERVER["HTTP_ACCEPT_LANGUAGE"])) {
            $clientLangArray = explode(',', $_SERVER["HTTP_ACCEPT_LANGUAGE"]);
            foreach ($clientLangArray as $oneLanguage) {
                $langCountry = explode(';', $oneLanguage);
                if (strlen($langCountry[0]) > 0) {
                    $clientLang = explode('-', $langCountry[0]);
                    if ($clientLang[0] == 'en') {
                        $messageClass = 'MessageStrings';
                    } else {
                        $messageClass = 'MessageStrings_' . $clientLang[0];
                    }
                    if (file_exists($currentDir . $messageClass . '.php')) {
                        require_once($currentDir . $messageClass . '.php');
                        $messageClass = new $messageClass();
                        break;
                    }
                }
            }
        }
        if ($messageClass == null) {
            require_once($currentDir . 'MessageStrings.php');
            $messageClass = new MessageStrings();
        }
        
        return $messageClass;
    }
    
    /**
     * Output login panel
     * @return HTML for login page
     */
    public function getLoginPage()
    {
        $currentDir = dirname(__FILE__) . DIRECTORY_SEPARATOR;
        $currentDirParam = $currentDir . 'params.php';
        $parentDirParam = dirname(dirname(__FILE__)) . DIRECTORY_SEPARATOR . 'params.php';
        if (file_exists($parentDirParam)) {
            include($parentDirParam);
        } else if (file_exists($currentDirParam)) {
            include($currentDirParam);
        }
        
        $pageTitle = '';
        try {
            $path = $_SERVER['DOCUMENT_ROOT'] . $_SERVER['SCRIPT_NAME'];
            if (file_exists($path)) {
                $body = file_get_contents($path);
                $doc = new DOMDocument();
                $doc->loadHTML($body);
                $xpath = new DOMXPath($doc);
                $node = $doc->getElementsByTagName('title');
                if ($node) {
                    $pageTitle = $node->item(0)->textContent . ' : ';
                }
            }
        } catch (Exception $e) {
        }
        
        $messageClass = $this->loadMessageClass();
        $htmlSource = '<!DOCTYPE html>' . "\n" . '<html><head><meta charset="UTF-8"><title>' . $pageTitle . $messageClass->getMessageAs(2004, array()) . '</title></head><body>';
        if (!isset($customLoginPanel) || is_null($customLoginPanel) || empty($customLoginPanel)) {
            $htmlSource .= '<form action="' . $_SERVER['SCRIPT_NAME'] . '" method="post"><div id="_im_authpanel" style="width: 450px; background-color: rgb(51, 51, 51); color: rgb(221, 221, 170); margin: 50px auto 0px; padding: 20px; border-radius: 10px 10px 10px 10px; position: relative;"><label><span style="width: 200px; text-align: right; float: left;" class="_im_authlabel">' . $messageClass->getMessageAs(2002, array()) . '</span><input type="text" id="_im_username" name="_im_username" size="24" autocapitalize="off"></label><br clear="all"><label><span style="min-width: 200px; text-align: right; float: left;" class="_im_authlabel">' . $messageClass->getMessageAs(2003, array()) . '</span><input type="password" id="_im_password" name="_im_password" size="24"></label><button>' . $messageClass->getMessageAs(2004, array()) . '</button><br clear="all"><hr><label><span style="min-width: 200px; text-align: right; float: left; font-size: 0.7em; padding-top: 4px;" class="_im_authlabel">' . $messageClass->getMessageAs(2006, array()) . '</span><input type="password" id="_im_newpassword" size="12"></label><button>' . $messageClass->getMessageAs(2005, array()) . '</button><div style="text-align: center; color: rgb(153, 68, 51);"></div></div>';
        } else {
            $htmlSource .= $customLoginPanel;
        }
        
        $htmlSource .= '</body></html>';
        
        return $htmlSource;
    }
}
