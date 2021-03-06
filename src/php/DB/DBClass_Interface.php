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

namespace INTERMediator\DB;

interface DBClass_Interface
{
    public function setupConnection();
    public function setupHandlers($dsn = false);
    public function readFromDB();         // former getFromDB
    public function countQueryResult();
    public function getTotalCount();
    public function updateDB($bypassAuth);           // former setToDB
    public function createInDB($isReplace = false);  // former newToDB
    public function deleteFromDB();
    public function copyInDB();
    public function normalizedCondition($condition);
    public function softDeleteActivate($field, $value);
    public function requireUpdatedRecord($value);
    public function getFieldInfo($dataSourceName);
    public function updatedRecord();
    public function setUpdatedRecord($field, $value, $index = 0);
    public function queryForTest($table, $conditions = null);
    public function deleteForTest($table, $conditions = null);
}
