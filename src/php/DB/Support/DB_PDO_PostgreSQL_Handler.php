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

namespace INTERMediator\DB\Support;

use Exception;
use PDO;

class DB_PDO_PostgreSQL_Handler extends DB_PDO_Handler
{
    protected $tableInfo = array();
    protected $fieldNameForField = 'column_name';
    protected $fieldNameForType = 'data_type';
    protected $fieldNameForNullable = 'is_nullable';
    protected $numericFieldTypes = array('smallint', 'integer', 'bigint', 'decimal', 'numeric',
        'real', 'double precision', 'smallserial', 'serial', 'bigserial', 'money',);
    protected $timeFieldTypes = ['datetime', 'time', 'timestamp'];
    protected $booleanFieldTypes = ['boolean'];

    public function sqlSELECTCommand()
    {
        return "SELECT ";
    }

    public function sqlLimitCommand($param)
    {
        return "LIMIT {$param}";
    }

    public function sqlOffsetCommand($param)
    {
        return "OFFSET {$param}";
    }

    public function sqlDELETECommand()
    {
        return "DELETE FROM ";
    }

    public function sqlUPDATECommand()
    {
        return "UPDATE ";
    }

    public function sqlINSERTCommand($tableRef, $setClause)
    {
        return "INSERT INTO {$tableRef} {$setClause}";
    }

    public function sqlSETClause($tableName, $setColumnNames, $keyField, $setValues)
    {
        [$setNames, $setValuesConv] = $this->sqlSETClauseData($tableName, $setColumnNames, $setValues);
        return (count($setColumnNames) == 0) ? "DEFAULT VALUES" :
            '(' . implode(',', $setNames) . ') VALUES(' . implode(',', $setValuesConv) . ')';
    }

    public function getNullableFields($tableName)
    {
        try {
            $result = $this->getTableInfo($tableName);
        } catch (Exception $ex) {
            throw $ex;
        }
        $fieldArray = [];
        foreach ($result as $row) {
            if ($row[$this->fieldNameForNullable] == "YES") {
                $fieldArray[] = $row[$this->fieldNameForField];
            }
        }
        return $fieldArray;
    }

    protected function getAutoIncrementField($tableName)
    {
        try {
            $result = $this->getTableInfo($tableName);
        } catch (Exception $ex) {
            throw $ex;
        }
        foreach ($result as $row) {
            if (strpos($row["column_default"], "nextval(") !== false) {
                return $row["column_name"];;
            }
        }
        return null;
    }

    protected function getTalbeInfoSQL($tableName)
    {
        if (strpos($tableName, ".") !== false) {
            $tName = substr($tableName, strpos($tableName, ".") + 1);
            $schemaName = substr($tableName, 0, strpos($tableName, "."));
            $sql = "SELECT column_name, column_default, is_nullable, data_type, character_maximum_length, "
                . "numeric_precision, numeric_scale FROM information_schema.columns "
                . "WHERE table_schema=" . $this->dbClassObj->link->quote($schemaName)
                . " AND table_name=" . $this->dbClassObj->link->quote($tName);
        } else {
            $sql = "SELECT column_name, column_default, is_nullable, data_type, character_maximum_length, "
                . "numeric_precision, numeric_scale FROM information_schema.columns "
                . "WHERE table_name=" . $this->dbClassObj->link->quote($tableName);
        }
        return $sql;
    }
    /*
# SELECT column_name, column_default, is_nullable, data_type, character_maximum_length,numeric_precision, numeric_scale FROM information_schema.columns WHERE table_schema='im_sample' AND table_name='testtable';
 column_name |                   column_default                   | is_nullable |          data_type          | character_maximum_length | numeric_precision | numeric_scale
-------------+----------------------------------------------------+-------------+-----------------------------+--------------------------+-------------------+---------------
 id          | nextval('im_sample.testtable_id_seq'::regclass)    | NO          | integer                     |                          |                32 |             0
 num1        | 0                                                  | NO          | integer                     |                          |                32 |             0
 num2        |                                                    | YES         | integer                     |                          |                32 |             0
 num3        |                                                    | YES         | integer                     |                          |                32 |             0
 dt1         | CURRENT_TIMESTAMP                                  | NO          | timestamp without time zone |                          |                   |
 dt2         |                                                    | YES         | timestamp without time zone |                          |                   |
 dt3         |                                                    | YES         | timestamp without time zone |                          |                   |
 date1       | CURRENT_TIMESTAMP                                  | NO          | date                        |                          |                   |
 date2       |                                                    | YES         | date                        |                          |                   |
 time1       | CURRENT_TIMESTAMP                                  | NO          | time without time zone      |                          |                   |
 time2       |                                                    | YES         | time without time zone      |                          |                   |
 ts1         | CURRENT_TIMESTAMP                                  | NO          | timestamp without time zone |                          |                   |
 ts2         | '2001-01-01 00:00:00'::timestamp without time zone | YES         | timestamp without time zone |                          |                   |
 vc1         | ''::character varying                              | NO          | character varying           |                      100 |                   |
 vc2         |                                                    | YES         | character varying           |                      100 |                   |
 vc3         |                                                    | YES         | character varying           |                      100 |                   |
 text1       | ''::text                                           | NO          | text                        |                          |                   |
 text2       |                                                    | YES         | text                        |                          |                   |
(18 rows)
 */


    protected function getFieldListsForCopy($tableName, $keyField, $assocField, $assocValue, $defaultValues)
    {
        try {
            $result = $this->getTableInfo($tableName);
        } catch (Exception $ex) {
            throw $ex;
        }
        $fieldArray = array();
        $listArray = array();
        foreach ($result as $row) {
            if ($keyField === $row['column_name'] || !is_null($row['column_default'])) {

            } else if ($assocField === $row['column_name']) {
                $fieldArray[] = $this->quotedEntityName($row['column_name']);
                $listArray[] = $this->setValue($assocValue, $row);
            } else if (isset($defaultValues[$row['column_name']])) {
                $fieldArray[] = $this->quotedEntityName($row['column_name']);
                $listArray[] = $this->setValue($defaultValues[$row['column_name']], $row);
            } else {
                $fieldArray[] = $this->quotedEntityName($row['column_name']);
                $listArray[] = $this->quotedEntityName($row['column_name']);
            }
        }
        return array(implode(',', $fieldArray), implode(',', $listArray));
    }

    protected function setValue($value, $row)
    {
        if ($row['is_nullable'] && $value == '') {
            return 'NULL';
        }
        return $this->dbClassObj->link->quote($value);
    }

    public function quotedEntityName($entityName)
    {
        $q = '"';
        if (strpos($entityName, ".") !== false) {
            $components = explode(".", $entityName);
            $quotedName = array();
            foreach ($components as $item) {
                $quotedName[] = $q . str_replace($q, $q . $q, $item ?? "") . $q;
            }
            return implode(".", $quotedName);
        }
        return $q . str_replace($q, $q . $q, $entityName ?? "") . $q;

    }

    public function optionalOperationInSetup()
    {
    }


    public function authSupportCanMigrateSHA256Hash($userTable, $hashTable)  // authuser, issuedhash
    {
        $checkFieldDefinition = function ($type, $len, $min) {
            $fDef = strtolower($type);
            if ($fDef != 'text' && $fDef == 'character varying') {
                if ($len < $min) {
                    return false;
                }
            }
            return true;
        };

        $infoAuthUser = $this->getTableInfo($userTable);
        $infoIssuedHash = $this->getTableInfo($hashTable);
        $returnValue = [];
        if ($infoAuthUser) {
            foreach ($infoAuthUser as $fieldInfo) {
                if (isset($fieldInfo['column_name'])
                    && $fieldInfo['column_name'] == 'hashedpasswd'
                    && !$checkFieldDefinition($fieldInfo['data_type'], $fieldInfo['character_maximum_length'], 72)) {
                    $returnValue[] = "The hashedpassword field of the authuser table has to be longer than 72 characters.";
                }
            }
        }
        if ($infoIssuedHash) {
            foreach ($infoIssuedHash as $fieldInfo) {
                if (isset($fieldInfo['column_name'])
                    && $fieldInfo['column_name'] == 'clienthost'
                    && !$checkFieldDefinition($fieldInfo['data_type'], $fieldInfo['character_maximum_length'], 64)) {
                    $returnValue[] = "The clienthost field of the issuedhash table has to be longer than 64 characters.";
                }
                if (isset($fieldInfo['column_name'])
                    && $fieldInfo['column_name'] == 'hash'
                    && !$checkFieldDefinition($fieldInfo['data_type'], $fieldInfo['character_maximum_length'], 64)) {
                    $returnValue[] = "The hash field of the issuedhash table has to be longer than 64 characters.";
                }
            }
        }
        return $returnValue;
    }
}
