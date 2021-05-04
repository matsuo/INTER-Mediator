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

use INTERMediator\DB\Proxy;
use SimpleSAML\Auth\Simple;

class SAMLAuth
{
    private $authSimple;
    public function __construct()
    {
        $this->authSimple = new Simple('default-sp');
    }

    public function samlLoginCheck()
    {
        $this->authSimple->requireAuth();
        return true;
//        $name=$as->getAuthData("saml:sp:NameID");
//        $attributes=$as->getAttributes();
//        print_r($attributes);
//        echo ($attributes["uid"][0]);

    }
}