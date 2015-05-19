<?php
/**
 * INTER-Mediator Ver.@@@@2@@@@ Released @@@@1@@@@
 *
 *   Copyright (c) 2010-2015 INTER-Mediator Directive Committee, All rights reserved.
 *
 *   This project started at the end of 2009 by Masayuki Nii  msyk@msyk.net.
 *   INTER-Mediator is supplied under MIT License.
 *
 * @copyright     Copyright (c) INTER-Mediator Directive Committee (http://inter-mediator.org)
 * @license       http://www.opensource.org/licenses/mit-license.php MIT License
 */
require_once(dirname(__FILE__) . '/../../INTER-Mediator.php');

IM_Entry(
    array(
        array(
            'records' => 100000000,
            'name' => 'chat',
            'key' => 'id',
            'sort' => array(
                array('field' => 'postdt', 'direction' => 'desc'),
            ),
            'default-values' => array(
                array('field' => 'postdt', 'value' => date('Y-m-d H:i:s')),
            ),
            // Three definitions below will NOT be specified simultaneously. Here is a demo. Try with commented any lines.
            'post-reconstruct' => true,
            'post-dismiss-message' => '送信完了',
            // 'post-move-url' => 'http://inter-mediator.com/',
            'extending-class' => 'MailSending',
            'validation' => array(
                array(
                    'field' => 'message',
                    'rule' => " value !='' ",
                    'message' => '空欄にしないでください',
                    'notify' => 'inline',
                ),
            ),
        ),
    ),
    array(
        'formatter' => array(
            array('field' => 'chat@postdt', 'converter-class' => 'FMDateTime'),
        ),
    ),
    array('db-class' => 'FileMaker_FX'),
    false
);
