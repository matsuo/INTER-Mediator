<?php
/*
 * INTER-Mediator Ver.@@@@2@@@@ Released @@@@1@@@@
 *
 *   by Masayuki Nii  msyk@msyk.net Copyright (c) 2010-2014 Masayuki Nii, All rights reserved.
 *
 *   This project started at the end of 2009.
 *   INTER-Mediator is supplied under MIT License.
 */
require_once(dirname(__FILE__) . '/../../INTER-Mediator.php');

IM_Entry(
    array(
        array(
            'records' => 1,
            'paging' => true,
            'name' => 'person_layout',
            'repeat-control' => 'confirm-delete confirm-insert',
            'query' => array( /* array( 'field'=>'id', 'value'=>'5', 'operator'=>'eq' ),*/),
            'sort' => array(
                array('field' => 'id', 'direction' => 'ascend'
                ),
            ),
        ),
        array(
            'name' => 'contact_to',  // related table occurrence name
            'view' => 'person_layout',
            'repeat-control' => 'confirm-delete insert',
            'relation' => array(
                array('foreign-key' => 'person_id', 'join-field' => 'id', 'operator' => 'eq', 'portal' => true),
            ),
            //'default-values' => array(
            //    array('field'=>'summary', 'value'=> 'test'),
            //),
        ),
        array(
            'name' => 'contact_way',
            'key' => 'id',
        ),
        array(
            'name' => 'cor_way_kind',
            'key' => 'id',
            'relation' => array(
                array('foreign-key' => 'way_id', 'join-field' => 'contact_to::way', 'operator' => 'eq')
            ),
        ),
        array(
            'name' => 'history_to',
            'key' => 'id',
            'repeat-control' => 'delete insert',
            'relation' => array(
                array('foreign-key' => 'person_id', 'join-field' => 'id', 'operator' => 'eq')
            ),
        ),
    ),
    array(
        'formatter' => array(
            array('field' => 'history_to@startdate', 'converter-class' => 'FMDateTime'),
            array('field' => 'contact_to@contact_to::datetime', 'converter-class' => 'FMDateTime'),
            array('field' => 'history_to@enddate', 'converter-class' => 'FMDateTime'),
        ),
    ),
    array('db-class' => 'FileMaker_FX'),
    2
);
