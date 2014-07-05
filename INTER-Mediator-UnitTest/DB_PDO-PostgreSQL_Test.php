<?php
/*
 * Created by JetBrains PhpStorm.
 * User: msyk
 * Date: 11/12/14
 * Time: 14:21
 * Unit Test by PHPUnit (http://phpunit.de)
 *
 */

require_once('DB_PDO_Test_Common.php');

class DB_PDO_PostgreSQL_Test extends DB_PDO_Test_Common
{
    function setUp()
    {
        mb_internal_encoding('UTF-8');
        date_default_timezone_set('Asia/Tokyo');

    }

    function dbProxySetupForAccess($contextName, $maxRecord)
    {
        $this->schemaName = "im_sample.";
        $seqName = ($contextName == "person") ? "im_sample.person_id_seq" : "im_sample.serial";
        $contexts = array(
            array(
                'records' => $maxRecord,
                'name' => $contextName,
                'view' => "{$this->schemaName}{$contextName}",
                'table' => "{$this->schemaName}{$contextName}",
                'key' => 'id',
                'sort' => array(
                    array('field' => 'id', 'direction' => 'asc'),
                ),
                'sequence' => $seqName,
            )
        );
        $options = null;
        $dbSettings = array(
            'db-class' => 'PDO',
            'dsn' => 'pgsql:host=localhost;port=5432;dbname=test_db',
            'user' => 'web',
            'password' => 'password',
        );
        $this->db_proxy = new DB_Proxy(true);
        $this->db_proxy->initialize($contexts, $options, $dbSettings, 2, $contextName);
    }

    function dbProxySetupForAuth()
    {
        $this->db_proxy = new DB_Proxy(true);
        $this->db_proxy->initialize(
            array(
                array(
                    'records' => 1,
                    'paging' => true,
                    'name' => 'person',
                    'key' => 'id',
                    'query' => array( /* array( 'field'=>'id', 'value'=>'5', 'operator'=>'eq' ),*/),
                    'sort' => array(array('field' => 'id', 'direction' => 'asc'),),
                    'sequence' => 'im_sample.person_id_seq',
                )
            ),
            array(
                'authentication' => array( // table only, for all operations
                    'user' => array('user1'), // Itemize permitted users
                    'group' => array('group2'), // Itemize permitted groups
                    'privilege' => array(), // Itemize permitted privileges
                    'user-table' => 'im_sample.authuser', // Default value
                    'group-table' => 'im_sample.authgroup',
                    'corresponding-table' => 'im_sample.authcor',
                    'challenge-table' => 'im_sample.issuedhash',
                    'authexpired' => '300', // Set as seconds.
                    'storing' => 'cookie-domainwide', // 'cookie'(default), 'cookie-domainwide', 'none'
                ),
            ),
            array(
                'db-class' => 'PDO',
                'dsn' => 'pgsql:host=localhost;port=5432;dbname=test_db',
                'user' => 'web',
                'password' => 'password',
            ),
            2);
    }
}