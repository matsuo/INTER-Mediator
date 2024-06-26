<?php

use INTERMediator\DB\Proxy;

require_once(dirname(__FILE__) . '/../DB_Proxy_Test_Common.php');

class DB_Proxy_PostgreSQL_Test extends DB_Proxy_Test_Common
{

    function setUp(): void
    {
        parent::setUp();
        $dsn = 'pgsql:host=localhost;port=5432;dbname=test_db';
        $this->dbSpec = array(
            'db-class' => 'PDO',
            'dsn' => $dsn,
            'user' => 'web',
            'password' => 'password',
        );
        $this->schemaName = "im_sample.";
    }

    function dbProxySetupForAccess(string $contextName, int $maxRecord, int $hasExtend = 0): void
    {
        $this->schemaName = "im_sample.";
        $this->dataSource = [
            [
                'records' => $maxRecord,
                'paging' => true,
                'name' => $contextName,
                'view' => "{$this->schemaName}{$contextName}",
                'table' => "{$this->schemaName}{$contextName}",
                'key' => 'id',
                'query' => [['field' => 'id', 'value' => '3', 'operator' => '='],],
                'sort' => [['field' => 'id', 'direction' => 'asc'],],
            ],
        ];
        if ($hasExtend == 1) {
            $this->dataSource[0]['extending-class'] = 'AdvisorSample';
        } else if ($hasExtend == 2) {
            $this->dataSource[0]['extending-class'] = 'AdvisorSampleNew';
        }
        $this->options = null;
        $this->db_proxy = new Proxy(true);
        $resultInit = $this->db_proxy->initialize($this->dataSource, $this->options, $this->dbSpec, 2, $contextName);
        $this->assertNotFalse($resultInit, 'Proxy::initialize must return true.');
    }

    function dbProxySetupForAuthAccess(string $contextName, int $maxRecord, $subContextName = null): void
    {
        $this->schemaName = "im_sample.";
        $this->dataSource = [
            [
                'records' => $maxRecord,
                'paging' => true,
                'name' => $contextName,
                'view' => "{$this->schemaName}{$contextName}",
                'table' => "{$this->schemaName}{$contextName}",
                'key' => 'id',
                'query' => [['field' => 'id', 'value' => '3', 'operator' => '='],],
                'sort' => [['field' => 'id', 'direction' => 'asc'],],
                'repeat-control' => 'insert delete',
                'authentication' => [
                    'read' => [ /* load, update, new, delete*/
                        'user' => [],
                        'group' => ["group1", "group2"],
                    ],
                    'update' => [
                        'user' => [],
                        'group' => ["group2",],
                    ],
                ],
                //'extending-class' => 'AdvisorSample',
            ],
        ];
        $this->options = array(
            'authentication' => array( // table only, for all operations
                'user' => array('user1'), // Itemize permitted users
                'group' => array('group2'), // Itemize permitted groups
                'user-table' => 'authuser', // Default value
                'group-table' => 'authgroup',
                'corresponding-table' => 'authcor',
                'challenge-table' => 'issuedhash',
                'authexpired' => '300', // Set as seconds.
                'storing' => 'credential', // 'cookie'(default), 'cookie-domainwide', 'none'
                'is-required-2FA' => false,
            ),
        );
        $this->db_proxy = new Proxy(true);
        $resultInit = $this->db_proxy->initialize($this->dataSource, $this->options, $this->dbSpec, 2, $contextName);
        $this->assertNotFalse($resultInit, 'Proxy::initialize must return true.');
    }
}
