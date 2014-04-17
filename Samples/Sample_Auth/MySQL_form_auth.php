<?php
$g_serverSideCall = true;
require_once(dirname(__FILE__) . '/MySQL_definitions.php');
/*
 * INTER-Mediator Ver.@@@@2@@@@ Released @@@@1@@@@
 * 
 *   by Masayuki Nii  msyk@msyk.net Copyright (c) 2010-2014 Masayuki Nii, All rights reserved.
 * 
 *   This project started at the end of 2009.
 *   INTER-Mediator is supplied under MIT License.
 */
?><!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="stylesheet" type="text/css" href="../sample.css"/>
    <title>INTER-Mediator - Sample - Form Style/MySQL</title>
    <script src="MySQL_definitions.php"></script>
    <script type="text/javascript"></script>
</head>
<body onload="if(INTERMediatorOnPage.INTERMediatorCheckBrowser()){INTERMediator.construct(true)}">
<h1 style="font-weight:bold;color:green">Contact Information Management System</h1>

<div id="IM_NAVIGATOR">Navigation Controls by INTER-Mediator</div>
<table border="1">
    <tbody>
    <tr>
        <th>id</th>
        <td>
            <div data-im="person@id"></div>
        </td>
        <th>category</th>
        <td>
            <select data-im="person@category">
                <option value="101">Family</option>
                <option value="102">ClassMate</option>
                <option value="103">Collegue</option>
            </select>
        </td>
        <th>check</th>
        <td><input type="checkbox" title="person@checking" value="1"/></td>
    </tr>
    <tr>
        <th>name</th>
        <td colspan="5"><input type="text" data-im="person@name" value=""/></td>
    </tr>
    <tr>
        <th>mail</th>
        <td colspan="5"><input type="text" data-im="person@mail" value=""/></td>
    </tr>
    <tr>
        <th>location</th>
        <td colspan="5">
            <input type="radio" name="radio1" title="person@location" value="201"/>Domestic
            <input type="radio" name="radio1" title="person@location" value="202"/>International
            <input type="radio" name="radio1" title="person@location" value="203"/>Neightbor
            <input type="radio" name="radio1" title="person@location" value="204"/>Space
        </td>
    </tr>
    <tr>
        <th>memo</th>
        <td colspan="5"><textarea title="person@address"></textarea></td>
    </tr>
    <tr>
        <td colspan="6">
            <table border="1">
                <thead>
                <tr>
                    <th>datetime</th>
                    <th>summary</th>
                    <th>important</th>
                    <th>way</th>
                    <th>kind</th>
                    <th>description</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><input type="text" data-im="contact@datetime"/></td>
                    <td><input type="text" data-im="contact@summary"/></td>
                    <td><input type="checkbox" data-im="contact@important" value="1"/></td>
                    <td>
                        <select data-im="contact@way">
                            <option data-im="contact_way@id@value|contact_way@name@innerHTML"></option>
                        </select>
                    </td>
                    <td>
                        <select data-im="contact@kind">
                            <option data-im="kindid|kindname"></option>
                        </select>
                    </td>
                    <td><textarea data-im="contact@description@innerHTML"></textarea></td>
                </tr>
                </tbody>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="6">
            <ul>
                <li>
                    <hr/>
                    <input type="text" title="history@startdate"/></li>
                <li><input type="text" title="history@enddate"/></li>
                <li><input type="text" title="history@description"/></li>
            </ul>
        </td>
    </tr>
    </tbody>
</table>
</body>
</html>