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
            'name' => 'person',
            'view' => 'im_sample.person',
            'table' => 'im_sample.person',
            'key' => 'id',
            'query' => array( /* array( 'field'=>'id', 'value'=>'5', 'operator'=>'eq' ),*/),
            'sort' => array(array('field' => 'id', 'direction' => 'asc'),),
            'repeat-control' => 'insert delete',
            'sequence' => 'im_sample.person_id_seq',
        ),
        array(
            'name' => 'contact',
            'view' => 'im_sample.contact',
            'table' => 'im_sample.contact',
            'key' => 'id',
            'relation' => array(
                array('foreign-key' => 'person_id', 'join-field' => 'id', 'operator' => '=')
            ),
            'repeat-control' => 'insert delete',
            'sequence' => 'im_sample.serial',
        ),
        array(
            'name' => 'contact_way',
            'view' => 'im_sample.contact_way',
            'table' => 'im_sample.contact_way',
            'key' => 'id',
            'sequence' => 'im_sample.serial',
        ),
        array(
            'name' => 'cor_way_kindname',
            'view' => 'im_sample.cor_way_kindname',
            'table' => 'im_sample.cor_way_kindname',
            'key' => 'id',
            'relation' => array(
                array('foreign-key' => 'way_id', 'join-field' => 'way', 'operator' => '=')
            ),
            'sequence' => 'im_sample.serial',
        ),
        array(
            'name' => 'history',
            'view' => 'im_sample.history',
            'table' => 'im_sample.history',
            'key' => 'id',
            'relation' => array(
                array('foreign-key' => 'person_id', 'join-field' => 'id', 'operator' => '=')
            ),
            'repeat-control' => 'insert delete',
            'sequence' => 'im_sample.serial',
        ),
    ),
    array(
        'formatter' => array(),
        'aliases' => array(
            'kindid' => 'cor_way_kindname@kind_id@value',
            'kindname' => 'cor_way_kindname@name_kind@innerHTML',
        ),
    ),
    array(
        'db-class' => 'PDO',
        'dsn' => 'pgsql:host=localhost;port=5432;dbname=test_db',
    ),
    false
);
