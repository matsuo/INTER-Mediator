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

class DB_Spec_Handler_SQLite extends DB_Spec_Handler_PDO
{
    public static function defaultKey(): string
    {
        return "id";
    }

    public function getDefaultKey(): string
    {
        return "id";
    }

    public function isSupportAggregation(): bool
    {
        return true;
    }

    public function isContainingFieldName(string $fname, array $fieldnames): bool
    {
        return in_array($fname, $fieldnames);
    }

    public function isNullAcceptable(): bool
    {
        return true;
    }

    public function isPossibleOperator(string $operator): bool
    {
        return in_array(strtoupper($operator), array(
            '||',
            '*', '/', '%',
            '+', '-',
            '<<', '>>', '&', '|',
            '<', '<=', '>', '>=',
            '=', '==', '!=', '<>', 'IS', 'IS NOT', 'IN', 'LIKE', 'GLOB', 'MATCH', 'REGEXP',
            'AND',
            'IS NULL', //NULL value test
            'OR',
            'IN',
            '-', '+', '~', 'NOT',
            'IS NOT NULL', //	NOT NULL value test
        ));
    }

    public function isPossibleOrderSpecifier(string $specifier): bool
    {
        return in_array(strtoupper($specifier), array('ASC', 'DESC'));
    }
}
