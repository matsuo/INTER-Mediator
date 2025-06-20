/*
 * INTER-Mediator
 * Copyright (c) INTER-Mediator Directive Committee (http://inter-mediator.org)
 * This project started at the end of 2009 by Masayuki Nii msyk@msyk.net.
 *
 * INTER-Mediator is supplied under MIT License.
 * Please see the full license for details:
 * https://github.com/INTER-Mediator/INTER-Mediator/blob/master/dist-docs/License.txt

This schema file is for the sample of INTER-Mediator using MySQL, encoded by UTF-8.

Example:
$ mysql -u root -p < sample_schema_mysql.sql
Enter password:

*/
SET NAMES 'utf8mb4';
# Create db user.
DROP USER IF EXISTS 'web'@'localhost';
CREATE USER IF NOT EXISTS 'web'@'localhost' IDENTIFIED BY 'password';

# Grant to All operations for all objects with web account.
GRANT SELECT, INSERT, DELETE, UPDATE ON TABLE test_db.* TO 'web'@'localhost';
GRANT SHOW VIEW ON TABLE test_db.* TO 'web'@'localhost';
# For mysqldump, the SHOW VIEW privilege is just required, and use options --single-transaction and --no-tablespaces.
# GRANT RELOAD, PROCESS ON *.* TO 'webuser'@'localhost'; # For mysqldump

DROP DATABASE IF EXISTS test_db;
CREATE DATABASE test_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE test_db;

#  The schema for the "Sample_form" and "Sample_Auth" sample set.

CREATE TABLE person
(
    id       INT AUTO_INCREMENT,
    name     VARCHAR(20),
    address  VARCHAR(40),
    mail     VARCHAR(40),
    category INT,
    checking BOOLEAN,
    location INT,
    memo     TEXT,
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

INSERT person
SET id=1,
    `name`='Masayuki Nii',
    address='Saitama, Japan',
    mail='msyk@msyk.net';
INSERT person
SET id=2,
    `name`='Someone',
    address='Tokyo, Japan',
    mail='msyk@msyk.net';
INSERT person
SET id=3,
    `name`='Anyone',
    address='Osaka, Japan',
    mail='msyk@msyk.net';

CREATE TABLE contact
(
    id          INT AUTO_INCREMENT,
    person_id   INT,
    description TEXT,
    datetime    DATETIME,
    summary     VARCHAR(50),
    important   INT,
    way         INT default 4,
    kind        INT,
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;
CREATE INDEX contact_person_id ON contact (person_id);

INSERT contact
SET person_id=1,
    datetime='2009-12-1 15:23:00',
    summary='Telephone',
    way=4,
    kind=4;
INSERT contact
SET person_id=1,
    datetime='2009-12-2 15:23:00',
    summary='Meeting',
    important=1,
    way=4,
    kind=7;
INSERT contact
SET person_id=1,
    datetime='2009-12-3 15:23:00',
    summary='Mail',
    way=5,
    kind=8;
INSERT contact
SET person_id=2,
    datetime='2009-12-4 15:23:00',
    summary='Calling',
    way=6,
    kind=12;
INSERT contact
SET person_id=2,
    datetime='2009-12-1 15:23:00',
    summary='Telephone',
    way=4,
    kind=4;
INSERT contact
SET person_id=3,
    datetime='2009-12-2 15:23:00',
    summary='Meeting',
    important=1,
    way=4,
    kind=7;
INSERT contact
SET person_id=3,
    datetime='2009-12-3 15:23:00',
    summary='Mail',
    way=5,
    kind=8;

CREATE TABLE contact_way
(
    id   INT AUTO_INCREMENT,
    name VARCHAR(50),
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

INSERT contact_way
SET id=4,
    `name`='Direct';
INSERT contact_way
SET id=5,
    `name`='Indirect';
INSERT contact_way
SET id=6,
    `name`='Others';

CREATE TABLE contact_kind
(
    id   INT AUTO_INCREMENT,
    name VARCHAR(50),
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

INSERT contact_kind
SET id=4,
    `name`='Talk';
INSERT contact_kind
SET id=5,
    `name`='Meet';
INSERT contact_kind
SET id=6,
    `name`='Calling';
INSERT contact_kind
SET id=7,
    `name`='Meeting';
INSERT contact_kind
SET id=8,
    `name`='Mail';
INSERT contact_kind
SET id=9,
    `name`='Email';
INSERT contact_kind
SET id=10,
    `name`='See on Web';
INSERT contact_kind
SET id=11,
    `name`='See on Chat';
INSERT contact_kind
SET id=12,
    `name`='Twitter';
INSERT contact_kind
SET id=13,
    `name`='Conference';

CREATE TABLE cor_way_kind
(
    id      INT AUTO_INCREMENT,
    way_id  INT,
    kind_id INT,
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;
CREATE INDEX cor_way_id ON cor_way_kind (way_id);
CREATE INDEX cor_kind_id ON cor_way_kind (way_id);

# CREATE VIEW cor_way_kindname AS SELECT cor_way_kind.*,contact_kind.name as name_kind
# FROM cor_way_kind, contact_kind
# WHERE cor_way_kind.kind_id = contact_kind.id;

INSERT cor_way_kind
SET way_id=4,
    kind_id=4;
INSERT cor_way_kind
SET way_id=4,
    kind_id=5;
INSERT cor_way_kind
SET way_id=5,
    kind_id=6;
INSERT cor_way_kind
SET way_id=4,
    kind_id=7;
INSERT cor_way_kind
SET way_id=5,
    kind_id=8;
INSERT cor_way_kind
SET way_id=5,
    kind_id=9;
INSERT cor_way_kind
SET way_id=6,
    kind_id=10;
INSERT cor_way_kind
SET way_id=5,
    kind_id=11;
INSERT cor_way_kind
SET way_id=6,
    kind_id=12;
INSERT cor_way_kind
SET way_id=5,
    kind_id=12;
INSERT cor_way_kind
SET way_id=6,
    kind_id=13;

CREATE TABLE history
(
    id          INT AUTO_INCREMENT,
    person_id   INT,
    description VARCHAR(50),
    startdate   DATE,
    enddate     DATE,
    username    VARCHAR(20),
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;
CREATE INDEX history_person_id ON history (person_id);

INSERT history
SET person_id=1,
    startdate='2001-4-1',
    enddate='2003-3-31',
    description='Hight School';
INSERT history
SET person_id=1,
    startdate='2003-4-1',
    enddate='2007-3-31',
    description='University';

# The schema for the "Sample_search" sample set.
#
#

CREATE TABLE postalcode
(
    id   INT AUTO_INCREMENT,
    f3   VARCHAR(20),
    f7   VARCHAR(40),
    f8   VARCHAR(15),
    f9   VARCHAR(40),
    memo VARCHAR(200),
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;
CREATE INDEX postalcode_f3 ON postalcode (f3);
CREATE INDEX postalcode_f8 ON postalcode (f8);

# The schema for the "Sample_products" sample set.
#
# The sample data for these table, invoice, item and products is another part of this file.
# Please scroll down to check it.

CREATE TABLE invoice
(
    id        INT AUTO_INCREMENT,
    issued    DATE,
    title     VARCHAR(30),
    authuser  VARCHAR(30),
    authgroup VARCHAR(30),
    authpriv  VARCHAR(30),
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

CREATE TABLE item
(
    id                INT AUTO_INCREMENT,
    invoice_id        INT,
    category_id       INT,
    product_id        INT,
    qty               INT,
    product_unitprice FLOAT,
    product_name      TEXT,
    product_taxrate   FLOAT,
    user_id           INT,
    group_id          INT,
    priv_id           INT,
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

CREATE TABLE product
(
    id              INT AUTO_INCREMENT,
    category_id     INT,
    unitprice       FLOAT,
    name            VARCHAR(20),
    taxrate         FLOAT(4, 2),
    photofile       VARCHAR(20),
    acknowledgement VARCHAR(100),
    ack_link        VARCHAR(100),
    memo            VARCHAR(120),
    user            VARCHAR(16),
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

#  The schema for the "Sample_Asset" sample set.
#
#

DROP TABLE IF EXISTS asset;
CREATE TABLE asset
(
    asset_id    INT AUTO_INCREMENT,
    name        VARCHAR(20),
    category    VARCHAR(20),
    manifacture VARCHAR(20),
    productinfo VARCHAR(20),
    purchase    DATE,
    discard     DATE,
    memo        TEXT,
    PRIMARY KEY (asset_id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;
CREATE INDEX asset_purchase ON asset (purchase);
CREATE INDEX asset_discard ON asset (discard);

DROP TABLE IF EXISTS rent;
CREATE TABLE rent
(
    rent_id  INT AUTO_INCREMENT,
    asset_id INT,
    staff_id INT,
    rentdate DATE,
    backdate DATE,
    memo     TEXT,
    PRIMARY KEY (rent_id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;
CREATE INDEX rent_rentdate ON rent (rentdate);
CREATE INDEX rent_backdate ON rent (backdate);
CREATE INDEX rent_asset_id ON rent (asset_id);
CREATE INDEX rent_staff_id ON rent (staff_id);

DROP TABLE IF EXISTS staff;
CREATE TABLE staff
(
    staff_id INT AUTO_INCREMENT,
    name     VARCHAR(20),
    section  VARCHAR(20),
    memo     TEXT,
    PRIMARY KEY (staff_id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

DROP TABLE IF EXISTS category;
CREATE TABLE category
(
    category_id INT AUTO_INCREMENT,
    name        VARCHAR(20),
    PRIMARY KEY (category_id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

INSERT asset
SET asset_id=11,
    category='個人用',
    `name`='MacBook Air[1]',
    manifacture='Apple',
    productinfo='2012/250GB/4GB',
    purchase='2012-8-1',
    discard='1904-01-01';
INSERT asset
SET asset_id=12,
    category='個人用',
    `name`='MacBook Air[2]',
    manifacture='Apple',
    productinfo='2012/250GB/4GB',
    purchase='2012-8-1',
    discard='1904-01-01';
INSERT asset
SET asset_id=13,
    category='個人用',
    `name`='MacBook Air[3]',
    manifacture='Apple',
    productinfo='2012/250GB/4GB',
    purchase='2012-8-1',
    discard='1904-01-01';
INSERT asset
SET asset_id=14,
    category='個人用',
    `name`='VAIO type A[1]',
    manifacture='ソニー',
    productinfo='VGN-AR85S',
    purchase='2008-6-12',
    discard='2012-2-2';
INSERT asset
SET asset_id=15,
    category='個人用',
    `name`='VAIO type A[2]',
    manifacture='ソニー',
    productinfo='VGN-AR85S',
    purchase='2008-6-12',
    discard='1904-01-01';
INSERT asset
SET asset_id=16,
    category='共用',
    `name`='プロジェクタ',
    manifacture='エプソン',
    productinfo='EB-460T',
    purchase='2010-11-23',
    discard='1904-01-01';
INSERT asset
SET asset_id=17,
    category='共用',
    `name`='ホワイトボード[1]',
    manifacture='不明',
    productinfo='不明',
    purchase=NULL,
    discard='2005-3-22';
INSERT asset
SET asset_id=18,
    category='共用',
    `name`='ホワイトボード[2]',
    manifacture='不明',
    productinfo='不明',
    purchase=NULL,
    discard='2005-3-22';
INSERT asset
SET asset_id=19,
    category='共用',
    `name`='加湿器',
    manifacture='シャープ',
    productinfo='プラズマクラスター加湿器',
    purchase='2011-12-2',
    discard='1904-01-01';
INSERT asset
SET asset_id=20,
    category='共用',
    `name`='事務室エアコン',
    manifacture='',
    productinfo='',
    purchase=NULL,
    discard='1904-01-01';
INSERT asset
SET asset_id=21,
    category='共用',
    `name`='会議室エアコン',
    manifacture='',
    productinfo='',
    purchase=NULL,
    discard='1904-01-01';
INSERT asset
SET asset_id=22,
    category='共用',
    `name`='携帯電話ドコモ',
    manifacture='京セラ',
    productinfo='P904i',
    purchase='2010-4-4',
    discard='2012-3-3';
INSERT asset
SET asset_id=23,
    category='個人用',
    `name`='携帯電話au',
    manifacture='シャープ',
    productinfo='SH001',
    purchase='2012-3-3',
    discard='2012-10-1';
INSERT asset
SET asset_id=24,
    category='個人用',
    `name`='携帯電話Softbank[1]',
    manifacture='Apple',
    productinfo='iPhone 5',
    purchase='2012-10-1',
    discard='1904-01-01';
INSERT asset
SET asset_id=25,
    category='個人用',
    `name`='携帯電話Softbank[2]',
    manifacture='Apple',
    productinfo='iPhone 5',
    purchase='2012-10-1',
    discard='1904-01-01';
INSERT asset
SET asset_id=26,
    category='個人用',
    `name`='携帯電話Softbank[3]',
    manifacture='Apple',
    productinfo='iPhone 5',
    purchase='2012-10-1',
    discard='1904-01-01';
INSERT asset
SET asset_id=27,
    category='個人用',
    `name`='携帯電話Softbank[4]',
    manifacture='Apple',
    productinfo='iPhone 5',
    purchase='2012-10-1',
    discard='1904-01-01';
INSERT asset
SET asset_id=28,
    category='個人用',
    `name`='携帯電話Softbank[5]',
    manifacture='Apple',
    productinfo='iPhone 5',
    purchase='2012-10-1',
    discard='1904-01-01';
INSERT asset
SET asset_id=29,
    category='個人用',
    `name`='携帯電話Softbank[6]',
    manifacture='Apple',
    productinfo='iPhone 5',
    purchase='2012-10-1',
    discard='1904-01-01';

INSERT staff
SET staff_id=101,
    `name`='田中次郎',
    section='代表取締役社長';
INSERT staff
SET staff_id=102,
    `name`='山本三郎',
    section='専務取締役';
INSERT staff
SET staff_id=103,
    `name`='北野六郎',
    section='営業部長';
INSERT staff
SET staff_id=104,
    `name`='東原七海',
    section='営業部';
INSERT staff
SET staff_id=105,
    `name`='内村久郎',
    section='営業部';
INSERT staff
SET staff_id=106,
    `name`='菅沼健一郎',
    section='開発部長';
INSERT staff
SET staff_id=107,
    `name`='西森裕太',
    section='開発部';
INSERT staff
SET staff_id=108,
    `name`='野村顕昭',
    section='開発部';
INSERT staff
SET staff_id=109,
    `name`='辻野均',
    section='開発部';

INSERT rent
SET asset_id=22,
    staff_id=101,
    rentdate='2010-4-4',
    backdate='2012-3-3';
INSERT rent
SET asset_id=23,
    staff_id=101,
    rentdate='2012-3-3',
    backdate='2012-10-1';
INSERT rent
SET asset_id=24,
    staff_id=101,
    rentdate='2012-10-1',
    backdate=NULL;
INSERT rent
SET asset_id=25,
    staff_id=102,
    rentdate='2012-10-1',
    backdate=NULL;
INSERT rent
SET asset_id=26,
    staff_id=103,
    rentdate='2012-10-1',
    backdate=NULL;
INSERT rent
SET asset_id=27,
    staff_id=106,
    rentdate='2012-10-1',
    backdate=NULL;
INSERT rent
SET asset_id=28,
    staff_id=107,
    rentdate='2012-10-1',
    backdate=NULL;
INSERT rent
SET asset_id=29,
    staff_id=108,
    rentdate='2012-10-1',
    backdate=NULL;
INSERT rent
SET asset_id=14,
    staff_id=106,
    rentdate='2008-6-12',
    backdate='2012-2-2';
INSERT rent
SET asset_id=15,
    staff_id=106,
    rentdate='2008-6-12',
    backdate='2011-3-31';
INSERT rent
SET asset_id=15,
    staff_id=109,
    rentdate='2011-4-6',
    backdate=NULL;
INSERT rent
SET asset_id=11,
    staff_id=107,
    rentdate='2012-8-1',
    backdate=NULL;
INSERT rent
SET asset_id=12,
    staff_id=108,
    rentdate='2012-8-1',
    backdate=NULL;
INSERT rent
SET asset_id=13,
    staff_id=109,
    rentdate='2012-8-1',
    backdate=NULL;
INSERT rent
SET asset_id=16,
    staff_id=109,
    rentdate='2010-11-29',
    backdate='2010-11-29';
INSERT rent
SET asset_id=16,
    staff_id=105,
    rentdate='2010-12-29',
    backdate='2010-12-29';
INSERT rent
SET asset_id=16,
    staff_id=103,
    rentdate='2011-2-28',
    backdate='2011-3-29';
INSERT rent
SET asset_id=16,
    staff_id=104,
    rentdate='2011-5-29',
    backdate='2011-6-3';
INSERT rent
SET asset_id=16,
    staff_id=109,
    rentdate='2011-8-9',
    backdate='2011-8-31';
INSERT rent
SET asset_id=16,
    staff_id=102,
    rentdate='2011-9-29',
    backdate='2011-9-30';
INSERT rent
SET asset_id=16,
    staff_id=101,
    rentdate='2011-12-2',
    backdate='2011-12-9';
INSERT rent
SET asset_id=16,
    staff_id=108,
    rentdate='2012-1-29',
    backdate='2012-1-31';
INSERT rent
SET asset_id=16,
    staff_id=108,
    rentdate='2012-4-29',
    backdate='2012-5-10';
INSERT rent
SET asset_id=16,
    staff_id=109,
    rentdate='2012-6-29',
    backdate='2012-7-29';

INSERT category
SET category_id=1,
    `name`='個人用';
INSERT category
SET category_id=2,
    `name`='共用';

#  The schema for the "Sample_Auth" sample set.
#
#

CREATE TABLE chat
(
    id        INT AUTO_INCREMENT,
    user      VARCHAR(64),
    groupname VARCHAR(64),
    postdt    DATETIME,
    message   VARCHAR(800),
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;


CREATE TABLE fileupload
(
    id   INT AUTO_INCREMENT,
    f_id INT,
    path VARCHAR(1000),
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

#
# This 'survey' table is for a demonstration.
#

CREATE TABLE survey
(
    id INT AUTO_INCREMENT,
    Q1 TEXT,
    Q2 TEXT,
    Q3 TEXT,
    Q4 TEXT,
    Q5 TEXT,
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

#
#

CREATE TABLE registeredcontext
(
    id           INT AUTO_INCREMENT,
    clientid     TEXT,
    entity       TEXT,
    conditions   TEXT,
    registereddt DATETIME,
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;


CREATE TABLE registeredpks
(
    context_id INT,
    pk         INT,
    PRIMARY KEY (context_id, pk),
    FOREIGN KEY (context_id) REFERENCES registeredcontext (id) ON DELETE CASCADE
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

#
#
#

CREATE TABLE authuser
(
    id              INT AUTO_INCREMENT,
    username        VARCHAR(64),
    hashedpasswd    VARCHAR(72),
    realname        VARCHAR(100),
    email           VARCHAR(100),
    address         VARCHAR(200),
    birthdate       CHAR(8),
    gender          CHAR(1),
    sub             VARCHAR(255),
    limitdt         DATETIME,
    initialPassword VARCHAR(30),
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

CREATE INDEX authuser_username
    ON authuser (username);
CREATE INDEX authuser_email
    ON authuser (email);
CREATE INDEX authuser_limitdt
    ON authuser (limitdt);

INSERT authuser
SET id=1,
    `username`='user1',
    hashedpasswd='d83eefa0a9bd7190c94e7911688503737a99db0154455354',
    email='user1@msyk.net';
INSERT authuser
SET id=2,
    `username`='user2',
    hashedpasswd='5115aba773983066bcf4a8655ddac8525c1d3c6354455354',
    email='user2@msyk.net';
INSERT authuser
SET id=3,
    `username`='user3',
    hashedpasswd='d1a7981108a73e9fbd570e23ecca87c2c5cb967554455354',
    email='user3@msyk.net';
INSERT authuser
SET id=4,
    `username`='user4',
    hashedpasswd='8c1b394577d0191417e8d962c5f6e3ca15068f8254455354',
    email='user4@msyk.net';
INSERT authuser
SET id=5,
    `username`='user5',
    hashedpasswd='ee403ef2642f2e63dca12af72856620e6a24102d54455354',
    email='user5@msyk.net';
INSERT authuser
SET id=6,
    `username`='mig2m',
    hashedpasswd='cd85a299c154c4714b23ce4b63618527289296ba6642c2685651ad8b9f20ce02285d7b34',
    email='mig2m@msyk.net';
INSERT authuser
SET id=7,
    `username`='mig2',
    hashedpasswd='b7d863d29021fc96de261da6a5dfb6c4c28d3d43c75ad5ddddea4ec8716bdaf074675473',
    email='mig2@msyk.net';

# The user1 has the password 'user1'. It's salted with the string 'TEXT'.
# All users have the password the same as user name. All are salted with 'TEXT'
# The following command lines are used to generate above hashed-hexed-password.
#
#  $ echo -n 'user1TEST' | openssl sha1 -sha1
#  d83eefa0a9bd7190c94e7911688503737a99db01
#  echo -n 'TEST' | xxd -ps
#  54455354
#  - combine above two results:
#  d83eefa0a9bd7190c94e7911688503737a99db0154455354

# The user mig2 has SHA-256 hashed password with 5000 times. There is no way to simple hash generating commands.
# The script dist-docs/passwdgen.sh can generate longer hash. The below shows how to calculate it from a password.
#
# % dist-docs/passwdgen.sh '--password=mig2'
# '','mig2','b7d863d29021fc96de261da6a5dfb6c4c28d3d43c75ad5ddddea4ec8716bdaf074675473'
#
# The dist-docs/passwdgen2.sh is quite faster than above and shows 3 kinds of hashes.
#
# % dist-docs/passwdgen2.sh 123456
# Input Values: password = 123456 , salt = ^N_* (5e4e5f2a) -- random salt generated
# Version 1 Hash Value = bc3bcf676e96ea16e888e31829e4920d2c079b2d5e4e5f2a
# Version 2m Hash Value = 9191796213a1e16448e1e43ef17340e73a5738c55ac5abf0c2d60c10b7d4ad2d5e4e5f2a
# Version 2 Hash Value = 013c325a6fddd183146d3acf6a490012f2de8609ea73f94d2ad7df9d9918913a5e4e5f2a


# The user mig2m is originally SHA-1 hashed password with password 'mig2m' and salt 'HASH' as like first line.
# The SHA-1 hash value converted with the same salt and re-hashed with SHA-256 as like third line.
# This means SHA-1 based hash value can change to the SHA-256 based one, and INTER-Mediator supports this style
# hash too to migrate SHA-256 from an SHA-1 account in the authuser table.

CREATE TABLE authgroup
(
    id        INT AUTO_INCREMENT,
    groupname VARCHAR(48),
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

INSERT authgroup
SET id=1,
    `groupname`='group1';
INSERT authgroup
SET id=2,
    `groupname`='group2';
INSERT authgroup
SET id=3,
    `groupname`='group3';

CREATE TABLE authcor
(
    id            INT AUTO_INCREMENT,
    user_id       INT,
    group_id      INT,
    dest_group_id INT,
    privname      VARCHAR(48),
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

CREATE INDEX authcor_user_id
    ON authcor (user_id);
CREATE INDEX authcor_group_id
    ON authcor (group_id);
CREATE INDEX authcor_dest_group_id
    ON authcor (dest_group_id);

INSERT authcor
SET user_id=1,
    dest_group_id=1;
INSERT authcor
SET user_id=2,
    dest_group_id=1;
# INSERT authcor
# SET user_id=3,
#     dest_group_id=1;
INSERT authcor
SET user_id=6,
    dest_group_id=1;
INSERT authcor
SET user_id=7,
    dest_group_id=1;
INSERT authcor
SET user_id=4,
    dest_group_id=2;
INSERT authcor
SET user_id=5,
    dest_group_id=2;
INSERT authcor
SET user_id=4,
    dest_group_id=3;
INSERT authcor
SET user_id=5,
    dest_group_id=3;
INSERT authcor
SET group_id=1,
    dest_group_id=3;

CREATE TABLE issuedhash
(
    id         INT AUTO_INCREMENT,
    user_id    INT,
    clienthost VARCHAR(64),
    hash       VARCHAR(100),
    expired    DateTime,
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

CREATE INDEX issuedhash_user_id
    ON issuedhash (user_id);
CREATE INDEX issuedhash_expired
    ON issuedhash (expired);
CREATE INDEX issuedhash_clienthost
    ON issuedhash (clienthost);
CREATE INDEX issuedhash_user_id_clienthost
    ON issuedhash (user_id, clienthost);

# Mail Template
CREATE TABLE mailtemplate
(
    id         INT AUTO_INCREMENT,
    to_field   TEXT,
    bcc_field  TEXT,
    cc_field   TEXT,
    from_field TEXT,
    subject    TEXT,
    body       TEXT,
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

INSERT INTO mailtemplate(id, to_field, bcc_field, cc_field, from_field, subject, body)
VALUES (1, '@@Q2@@', '', '', 'msyk@msyk.net', 'ご意見承りました',
        'ご意見を投稿していただき、ありがとうございます。伺った内容は以下の通りです。よろしくお願いします。\n\nお名前：@@Q1@@\nメールアドレス：@@Q2@@\nご意見：@@Q3@@\n\n====\nINTER-Mediator本部事務局');

INSERT INTO mailtemplate(id, to_field, bcc_field, cc_field, from_field, subject, body)
VALUES (2, '@@mail@@', 'msyk@msyk.net', 'nii@msyk.net', 'msyk@msyk.net', 'テストメール2',
        'テストメールです。@@name@@様宛で、送信先は@@mail@@です。');

INSERT INTO mailtemplate(id, to_field, bcc_field, cc_field, from_field, subject, body)
VALUES (991, '@@email@@', 'msyk@msyk.net', 'nii@msyk.net', 'msyk@msyk.net', 'ユーザ登録の確認', CONCAT(
        '@@realname@@ 様（@@email@@）\n\nユーザ登録を受け付けました。1時間以内に、以下のリンクのサイトに接続してください。\n\n',
        '接続後にアカウントを発行してご指定のメールアドレスに送付します。\n\n<< Path to the script >>/confirm.php?c=@@hash@@\n\n',
        '___________________________________\ninfo@msyk.net - Masayuki Nii'));

INSERT INTO mailtemplate(id, to_field, bcc_field, cc_field, from_field, subject, body)
VALUES (992, '@@email@@', 'msyk@msyk.net', 'nii@msyk.net', 'msyk@msyk.net', 'ユーザ登録の完了', CONCAT(
        '@@realname@@ 様（@@email@@）\n\nユーザ登録が完了しました。こちらのページにログインできるようになりました。',
        'ログインページ：\n<< URL to any page >>\n\nユーザ名： @@username@@\n初期パスワード： @@initialPassword@@\n\n',
        '※ 初期パスワードは極力早めに変更してください。\n',
        '___________________________________\ninfo@msyk.net - Masayuki Nii'));

INSERT INTO mailtemplate(id, to_field, bcc_field, cc_field, from_field, subject, body)
VALUES (993, '@@email@@', 'msyk@msyk.net', 'nii@msyk.net', 'msyk@msyk.net', 'パスワードのリセットを受け付けました',
        CONCAT(
                'パスワードのリセットを受け付けました。\n\nメールアドレス：@@email@@\n\n',
                '以下のリンクをクリックし、新しいパスワードをご入力ください。\n\n',
                '<< Path to the script >>/resetpassword.html?c=@@hash@@\n\n',
                '___________________________________\ninfo@msyk.net - Masayuki Nii'));

INSERT INTO mailtemplate(id, to_field, bcc_field, cc_field, from_field, subject, body)
VALUES (994, '@@email@@', 'msyk@msyk.net', 'nii@msyk.net', 'msyk@msyk.net', 'パスワードをリセットしました', CONCAT(
        '以下のアカウントのパスワードをリセットしました。\n\nアカウント（メールアドレス）：@@email@@\n\n',
        '以下のリンクをクリックし、新しいパスワードでマイページにログインしてください。\n\n<< Path to any page >>\n\n',
        '___________________________________\ninfo@msyk.net - Masayuki Nii'));

INSERT INTO mailtemplate(id, to_field, bcc_field, cc_field, from_field, subject, body)
VALUES (995, '@@mail@@', 'msyk@msyk.net', null, 'msyk@msyk.net', '認証コードを送付します', CONCAT(
        'ユーザ名とパスワードによるログインが成功したので、メールの内容と照らし合わせての再度の認証を行います。\n\n',
        'メールアドレス：@@mail@@\n認証コード：@@code@@\n\n',
        'ログインを行った画面に入力可能なパネルが表示されています。上記の認証コードを入力してください。\n\n',
        '___________________________________\ninfo@msyk.net - Masayuki Nii'));

INSERT INTO mailtemplate(id, to_field, bcc_field, cc_field, from_field, subject, body)
VALUES (1301, '@@email@@', null, null, 'info@msyk.net', 'テストメールです', CONCAT(
        'テストメールです。\n\n宛先：@@email@@\n\n',
        '___________________________________\ninfo@msyk.net - Masayuki Nii'));

INSERT INTO mailtemplate(id, to_field, bcc_field, cc_field, from_field, subject, body)
VALUES (1302, 'msyk@msyk.net', null, null, 'msyk@msyk.net', 'テストメールです', CONCAT(
        'AWS SMS/SMTPからのテストメールです。\n\n宛先：msyk@msyk.net\n\n',
        '___________________________________\ninfo@msyk.net - Masayuki Nii'));

INSERT INTO mailtemplate(id, to_field, bcc_field, cc_field, from_field, subject, body)
VALUES (1303, 'msyk@msyk.net', null, null, 'msyk@msyk.net', 'テストメールです', CONCAT(
        'AWS SMS/APIからのテストメールです。\n\n宛先：msyk@msyk.net\n\n',
        '___________________________________\ninfo@msyk.net - Masayuki Nii'));

INSERT INTO mailtemplate(id, to_field, bcc_field, cc_field, from_field, subject, body)
VALUES (1304, 'msyk.nii83@gmail.com', null, null, 'msyk.nii83@gmail.com', 'テストメールです', CONCAT(
        'Gmailからのテストメールです。\n\n宛先：msyk@msyk.net\n\n',
        '___________________________________\ninfo@msyk.net - Masayuki Nii'));

# Storing Sent Mail
CREATE TABLE maillog
(
    id         INT AUTO_INCREMENT,
    to_field   TEXT,
    bcc_field  TEXT,
    cc_field   TEXT,
    from_field TEXT,
    subject    TEXT,
    body       TEXT,
    errors     TEXT,
    dt         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    foreign_id INT,
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

# Operation Log Store
CREATE TABLE operationlog
(
    id            INT AUTO_INCREMENT,
    dt            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user          VARCHAR(48),
    client_id_in  VARCHAR(48),
    client_id_out VARCHAR(48),
    require_auth  BIT(1),
    set_auth      BIT(1),
    client_ip     VARCHAR(60),
    path          VARCHAR(256),
    access        VARCHAR(20),
    context       VARCHAR(50),
    get_data      TEXT,
    post_data     TEXT,
    result        TEXT,
    error         TEXT,
    condition0    VARCHAR(50),
    condition1    VARCHAR(50),
    condition2    VARCHAR(50),
    condition3    VARCHAR(50),
    condition4    VARCHAR(50),
    field0        TEXT,
    field1        TEXT,
    field2        TEXT,
    field3        TEXT,
    field4        TEXT,
    field5        TEXT,
    field6        TEXT,
    field7        TEXT,
    field8        TEXT,
    field9        TEXT,
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;
# In case of real deployment, some indices are required for quick operations.

CREATE TABLE testtable
(
    id      INT AUTO_INCREMENT,
    num1    INT          NOT NULL DEFAULT 0,
    num2    INT,
    num3    INT,
    dt1     DateTime     NOT NULL DEFAULT '2001-01-01 00:00:00',
    dt2     DateTime,
    dt3     DateTime,
    date1   Date         NOT NULL DEFAULT '2001-01-01',
    date2   Date,
    time1   Time         NOT NULL DEFAULT '00:00:00',
    time2   Time,
    ts1     Timestamp    NOT NULL DEFAULT '2001-01-01 00:00:00',
    ts2     Timestamp             DEFAULT '2001-01-01 00:00:00', # Required default value
    vc1     VARCHAR(100) NOT NULL DEFAULT '',
    vc2     VARCHAR(100),
    vc3     VARCHAR(100),
    text1   TEXT,
    text2   TEXT,
    float1  FLOAT        NOT NULL DEFAULT 0,
    float2  FLOAT,
    double1 DOUBLE       NOT NULL DEFAULT 0,
    double2 DOUBLE,
    bool1   BOOLEAN      NOT NULL DEFAULT FALSE,
    bool2   BOOLEAN,
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

CREATE TABLE information
(
    id          INT AUTO_INCREMENT,
    lastupdated DATE,
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

# Sample Data
INSERT product
SET `name`='Apple',
    id=1,
    `user`='user1',
    category_id=1,
    unitprice=340,
    taxrate=0.08,
    photofile='mela-verde.png',
    acknowledgement='Image: djcodrin / FreeDigitalPhotos.net',
    ack_link='http://www.freedigitalphotos.net/images/view_photog.php?photogid=982';
INSERT product
SET `name`='Orange',
    id=2,
    `user`='user2',
    category_id=1,
    unitprice=1540,
    taxrate=0.08,
    photofile='orange_1.png',
    acknowledgement='Image: Suat Eman / FreeDigitalPhotos.net',
    ack_link='http://www.freedigitalphotos.net/images/view_photog.php?photogid=151';
INSERT product
SET `name`='Melon',
    id=3,
    `user`='user1',
    category_id=1,
    unitprice=3840,
    taxrate=0.1,
    photofile='galia-melon.png',
    acknowledgement='Image: FreeDigitalPhotos.net',
    ack_link='http://www.freedigitalphotos.net';
INSERT product
SET `name`='Tomato',
    id=4,
    `user`='user2',
    category_id=2,
    unitprice=2440,
    taxrate=0.1,
    photofile='tomatos.png',
    acknowledgement='Image: Tina Phillips / FreeDigitalPhotos.net',
    ack_link='http://www.freedigitalphotos.net/images/view_photog.php?photogid=503';
INSERT product
SET `name`='Onion',
    id=5,
    `user`='user1',
    category_id=2,
    unitprice=21340,
    taxrate=0.1,
    photofile='onion2.png',
    acknowledgement='Image: FreeDigitalPhotos.net',
    ack_link='http://www.freedigitalphotos.net';

INSERT invoice
SET id=1,
    issued='2010-2-4',
    title='Invoice';
INSERT invoice
SET id=2,
    issued='2010-2-6',
    title='Invoice';
INSERT invoice
SET id=3,
    issued='2010-2-14',
    title='Invoice';

INSERT item
SET invoice_id=1,
    product_id=1,
    qty=5;
INSERT item
SET invoice_id=1,
    product_id=2,
    qty=5,
    product_unitprice=1340;
INSERT item
SET invoice_id=1,
    product_id=3,
    qty=10;
INSERT item
SET invoice_id=2,
    product_id=4,
    qty=3;
INSERT item
SET invoice_id=2,
    product_id=5,
    qty=3;
INSERT item
SET invoice_id=3,
    product_id=3,
    qty=20;

/* The following view used for an exercise in the training book */
CREATE VIEW item_display AS
SELECT item.id,
       item.invoice_id,
       item.product_id,
       item.category_id,
       product.name,
       item.qty,
       product.unitprice       as unitprice,
       qty * product.unitprice AS amount
FROM item,
     product
WHERE item.product_id = product.id;

# mysql> select * from item_display;
# +----+------------+------------+-------------+--------+------+-----------+------------------+--------+
# | id | invoice_id | product_id | category_id | name   | qty  | unitprice | unitprice_master | amount |
# +----+------------+------------+-------------+--------+------+-----------+------------------+--------+
# |  1 |          1 |          1 |        NULL | Apple  |   12 |      NULL |              340 |   4080 |
# |  2 |          1 |          2 |        NULL | Orange |   12 |      1340 |             1540 |  16080 |
# |  3 |          1 |          3 |        NULL | Melon  |   12 |      NULL |             3840 |  46080 |
# |  6 |          3 |          3 |        NULL | Melon  |   12 |      NULL |             3840 |  46080 |
# |  4 |          2 |          4 |        NULL | Tomato |   12 |      NULL |             2440 |  29280 |
# |  5 |          2 |          5 |        NULL | Onion  |   12 |      NULL |            21340 | 256080 |
# +----+------------+------------+-------------+--------+------+-----------+------------------+--------+
# 6 rows in set (0.00 sec)

/*
The following is the postalcode for Tokyo Pref at Jan 2009.
These are come from JP, and JP doesn't claim the copyright for postalcode data.
http://www.post.japanpost.jp/zipcode/download.html
*/
INSERT postalcode
SET f3='1000000',
    f7='東京都',
    f8='千代田区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1020072',
    f7='東京都',
    f8='千代田区',
    f9='飯田橋';
INSERT postalcode
SET f3='1020082',
    f7='東京都',
    f8='千代田区',
    f9='一番町';
INSERT postalcode
SET f3='1010032',
    f7='東京都',
    f8='千代田区',
    f9='岩本町';
INSERT postalcode
SET f3='1010047',
    f7='東京都',
    f8='千代田区',
    f9='内神田';
INSERT postalcode
SET f3='1000011',
    f7='東京都',
    f8='千代田区',
    f9='内幸町';
INSERT postalcode
SET f3='1000004',
    f7='東京都',
    f8='千代田区',
    f9='大手町（次のビルを除く）';
INSERT postalcode
SET f3='1006890',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（地階・階層不明）';
INSERT postalcode
SET f3='1006801',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（１階）';
INSERT postalcode
SET f3='1006802',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（２階）';
INSERT postalcode
SET f3='1006803',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（３階）';
INSERT postalcode
SET f3='1006804',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（４階）';
INSERT postalcode
SET f3='1006805',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（５階）';
INSERT postalcode
SET f3='1006806',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（６階）';
INSERT postalcode
SET f3='1006807',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（７階）';
INSERT postalcode
SET f3='1006808',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（８階）';
INSERT postalcode
SET f3='1006809',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（９階）';
INSERT postalcode
SET f3='1006810',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（１０階）';
INSERT postalcode
SET f3='1006811',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（１１階）';
INSERT postalcode
SET f3='1006812',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（１２階）';
INSERT postalcode
SET f3='1006813',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（１３階）';
INSERT postalcode
SET f3='1006814',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（１４階）';
INSERT postalcode
SET f3='1006815',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（１５階）';
INSERT postalcode
SET f3='1006816',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（１６階）';
INSERT postalcode
SET f3='1006817',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（１７階）';
INSERT postalcode
SET f3='1006818',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（１８階）';
INSERT postalcode
SET f3='1006819',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（１９階）';
INSERT postalcode
SET f3='1006820',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（２０階）';
INSERT postalcode
SET f3='1006821',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（２１階）';
INSERT postalcode
SET f3='1006822',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（２２階）';
INSERT postalcode
SET f3='1006823',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（２３階）';
INSERT postalcode
SET f3='1006824',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（２４階）';
INSERT postalcode
SET f3='1006825',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（２５階）';
INSERT postalcode
SET f3='1006826',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（２６階）';
INSERT postalcode
SET f3='1006827',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（２７階）';
INSERT postalcode
SET f3='1006828',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（２８階）';
INSERT postalcode
SET f3='1006829',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（２９階）';
INSERT postalcode
SET f3='1006830',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（３０階）';
INSERT postalcode
SET f3='1006831',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（３１階）';
INSERT postalcode
SET f3='1006832',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（３２階）';
INSERT postalcode
SET f3='1006833',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（３３階）';
INSERT postalcode
SET f3='1006834',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（３４階）';
INSERT postalcode
SET f3='1006835',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（３５階）';
INSERT postalcode
SET f3='1006836',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（３６階）';
INSERT postalcode
SET f3='1006837',
    f7='東京都',
    f8='千代田区',
    f9='大手町ＪＡビル（３７階）';
INSERT postalcode
SET f3='1010044',
    f7='東京都',
    f8='千代田区',
    f9='鍛冶町';
INSERT postalcode
SET f3='1000013',
    f7='東京都',
    f8='千代田区',
    f9='霞が関（次のビルを除く）';
INSERT postalcode
SET f3='1006090',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（地階・階層不明）';
INSERT postalcode
SET f3='1006001',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（１階）';
INSERT postalcode
SET f3='1006002',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（２階）';
INSERT postalcode
SET f3='1006003',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（３階）';
INSERT postalcode
SET f3='1006004',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（４階）';
INSERT postalcode
SET f3='1006005',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（５階）';
INSERT postalcode
SET f3='1006006',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（６階）';
INSERT postalcode
SET f3='1006007',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（７階）';
INSERT postalcode
SET f3='1006008',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（８階）';
INSERT postalcode
SET f3='1006009',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（９階）';
INSERT postalcode
SET f3='1006010',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（１０階）';
INSERT postalcode
SET f3='1006011',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（１１階）';
INSERT postalcode
SET f3='1006012',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（１２階）';
INSERT postalcode
SET f3='1006013',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（１３階）';
INSERT postalcode
SET f3='1006014',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（１４階）';
INSERT postalcode
SET f3='1006015',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（１５階）';
INSERT postalcode
SET f3='1006016',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（１６階）';
INSERT postalcode
SET f3='1006017',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（１７階）';
INSERT postalcode
SET f3='1006018',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（１８階）';
INSERT postalcode
SET f3='1006019',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（１９階）';
INSERT postalcode
SET f3='1006020',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（２０階）';
INSERT postalcode
SET f3='1006021',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（２１階）';
INSERT postalcode
SET f3='1006022',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（２２階）';
INSERT postalcode
SET f3='1006023',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（２３階）';
INSERT postalcode
SET f3='1006024',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（２４階）';
INSERT postalcode
SET f3='1006025',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（２５階）';
INSERT postalcode
SET f3='1006026',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（２６階）';
INSERT postalcode
SET f3='1006027',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（２７階）';
INSERT postalcode
SET f3='1006028',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（２８階）';
INSERT postalcode
SET f3='1006029',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（２９階）';
INSERT postalcode
SET f3='1006030',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（３０階）';
INSERT postalcode
SET f3='1006031',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（３１階）';
INSERT postalcode
SET f3='1006032',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（３２階）';
INSERT postalcode
SET f3='1006033',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（３３階）';
INSERT postalcode
SET f3='1006034',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（３４階）';
INSERT postalcode
SET f3='1006035',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（３５階）';
INSERT postalcode
SET f3='1006036',
    f7='東京都',
    f8='千代田区',
    f9='霞が関霞が関ビル（３６階）';
INSERT postalcode
SET f3='1010029',
    f7='東京都',
    f8='千代田区',
    f9='神田相生町';
INSERT postalcode
SET f3='1010063',
    f7='東京都',
    f8='千代田区',
    f9='神田淡路町';
INSERT postalcode
SET f3='1010024',
    f7='東京都',
    f8='千代田区',
    f9='神田和泉町';
INSERT postalcode
SET f3='1010033',
    f7='東京都',
    f8='千代田区',
    f9='神田岩本町';
INSERT postalcode
SET f3='1010052',
    f7='東京都',
    f8='千代田区',
    f9='神田小川町';
INSERT postalcode
SET f3='1010045',
    f7='東京都',
    f8='千代田区',
    f9='神田鍛冶町';
INSERT postalcode
SET f3='1010036',
    f7='東京都',
    f8='千代田区',
    f9='神田北乗物町';
INSERT postalcode
SET f3='1010035',
    f7='東京都',
    f8='千代田区',
    f9='神田紺屋町';
INSERT postalcode
SET f3='1010026',
    f7='東京都',
    f8='千代田区',
    f9='神田佐久間河岸';
INSERT postalcode
SET f3='1010025',
    f7='東京都',
    f8='千代田区',
    f9='神田佐久間町';
INSERT postalcode
SET f3='1010051',
    f7='東京都',
    f8='千代田区',
    f9='神田神保町';
INSERT postalcode
SET f3='1010041',
    f7='東京都',
    f8='千代田区',
    f9='神田須田町';
INSERT postalcode
SET f3='1010062',
    f7='東京都',
    f8='千代田区',
    f9='神田駿河台';
INSERT postalcode
SET f3='1010046',
    f7='東京都',
    f8='千代田区',
    f9='神田多町';
INSERT postalcode
SET f3='1010048',
    f7='東京都',
    f8='千代田区',
    f9='神田司町';
INSERT postalcode
SET f3='1010043',
    f7='東京都',
    f8='千代田区',
    f9='神田富山町';
INSERT postalcode
SET f3='1010054',
    f7='東京都',
    f8='千代田区',
    f9='神田錦町';
INSERT postalcode
SET f3='1010037',
    f7='東京都',
    f8='千代田区',
    f9='神田西福田町';
INSERT postalcode
SET f3='1010022',
    f7='東京都',
    f8='千代田区',
    f9='神田練塀町';
INSERT postalcode
SET f3='1010028',
    f7='東京都',
    f8='千代田区',
    f9='神田花岡町';
INSERT postalcode
SET f3='1010034',
    f7='東京都',
    f8='千代田区',
    f9='神田東紺屋町';
INSERT postalcode
SET f3='1010042',
    f7='東京都',
    f8='千代田区',
    f9='神田東松下町';
INSERT postalcode
SET f3='1010027',
    f7='東京都',
    f8='千代田区',
    f9='神田平河町';
INSERT postalcode
SET f3='1010023',
    f7='東京都',
    f8='千代田区',
    f9='神田松永町';
INSERT postalcode
SET f3='1010038',
    f7='東京都',
    f8='千代田区',
    f9='神田美倉町';
INSERT postalcode
SET f3='1010053',
    f7='東京都',
    f8='千代田区',
    f9='神田美土代町';
INSERT postalcode
SET f3='1020094',
    f7='東京都',
    f8='千代田区',
    f9='紀尾井町';
INSERT postalcode
SET f3='1020091',
    f7='東京都',
    f8='千代田区',
    f9='北の丸公園';
INSERT postalcode
SET f3='1020074',
    f7='東京都',
    f8='千代田区',
    f9='九段南';
INSERT postalcode
SET f3='1020073',
    f7='東京都',
    f8='千代田区',
    f9='九段北';
INSERT postalcode
SET f3='1000002',
    f7='東京都',
    f8='千代田区',
    f9='皇居外苑';
INSERT postalcode
SET f3='1020083',
    f7='東京都',
    f8='千代田区',
    f9='麹町';
INSERT postalcode
SET f3='1020076',
    f7='東京都',
    f8='千代田区',
    f9='五番町';
INSERT postalcode
SET f3='1010064',
    f7='東京都',
    f8='千代田区',
    f9='猿楽町';
INSERT postalcode
SET f3='1020075',
    f7='東京都',
    f8='千代田区',
    f9='三番町';
INSERT postalcode
SET f3='1010021',
    f7='東京都',
    f8='千代田区',
    f9='外神田';
INSERT postalcode
SET f3='1000001',
    f7='東京都',
    f8='千代田区',
    f9='千代田';
INSERT postalcode
SET f3='1000014',
    f7='東京都',
    f8='千代田区',
    f9='永田町（次のビルを除く）';
INSERT postalcode
SET f3='1006190',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（地階・階層不明）';
INSERT postalcode
SET f3='1006101',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（１階）';
INSERT postalcode
SET f3='1006102',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（２階）';
INSERT postalcode
SET f3='1006103',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（３階）';
INSERT postalcode
SET f3='1006104',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（４階）';
INSERT postalcode
SET f3='1006105',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（５階）';
INSERT postalcode
SET f3='1006106',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（６階）';
INSERT postalcode
SET f3='1006107',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（７階）';
INSERT postalcode
SET f3='1006108',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（８階）';
INSERT postalcode
SET f3='1006109',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（９階）';
INSERT postalcode
SET f3='1006110',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（１０階）';
INSERT postalcode
SET f3='1006111',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（１１階）';
INSERT postalcode
SET f3='1006112',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（１２階）';
INSERT postalcode
SET f3='1006113',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（１３階）';
INSERT postalcode
SET f3='1006114',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（１４階）';
INSERT postalcode
SET f3='1006115',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（１５階）';
INSERT postalcode
SET f3='1006116',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（１６階）';
INSERT postalcode
SET f3='1006117',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（１７階）';
INSERT postalcode
SET f3='1006118',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（１８階）';
INSERT postalcode
SET f3='1006119',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（１９階）';
INSERT postalcode
SET f3='1006120',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（２０階）';
INSERT postalcode
SET f3='1006121',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（２１階）';
INSERT postalcode
SET f3='1006122',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（２２階）';
INSERT postalcode
SET f3='1006123',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（２３階）';
INSERT postalcode
SET f3='1006124',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（２４階）';
INSERT postalcode
SET f3='1006125',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（２５階）';
INSERT postalcode
SET f3='1006126',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（２６階）';
INSERT postalcode
SET f3='1006127',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（２７階）';
INSERT postalcode
SET f3='1006128',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（２８階）';
INSERT postalcode
SET f3='1006129',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（２９階）';
INSERT postalcode
SET f3='1006130',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（３０階）';
INSERT postalcode
SET f3='1006131',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（３１階）';
INSERT postalcode
SET f3='1006132',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（３２階）';
INSERT postalcode
SET f3='1006133',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（３３階）';
INSERT postalcode
SET f3='1006134',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（３４階）';
INSERT postalcode
SET f3='1006135',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（３５階）';
INSERT postalcode
SET f3='1006136',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（３６階）';
INSERT postalcode
SET f3='1006137',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（３７階）';
INSERT postalcode
SET f3='1006138',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（３８階）';
INSERT postalcode
SET f3='1006139',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（３９階）';
INSERT postalcode
SET f3='1006140',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（４０階）';
INSERT postalcode
SET f3='1006141',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（４１階）';
INSERT postalcode
SET f3='1006142',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（４２階）';
INSERT postalcode
SET f3='1006143',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（４３階）';
INSERT postalcode
SET f3='1006144',
    f7='東京都',
    f8='千代田区',
    f9='永田町山王パークタワー（４４階）';
INSERT postalcode
SET f3='1010065',
    f7='東京都',
    f8='千代田区',
    f9='西神田';
INSERT postalcode
SET f3='1020084',
    f7='東京都',
    f8='千代田区',
    f9='二番町';
INSERT postalcode
SET f3='1020092',
    f7='東京都',
    f8='千代田区',
    f9='隼町';
INSERT postalcode
SET f3='1010031',
    f7='東京都',
    f8='千代田区',
    f9='東神田';
INSERT postalcode
SET f3='1000003',
    f7='東京都',
    f8='千代田区',
    f9='一ツ橋（１丁目）';
INSERT postalcode
SET f3='1010003',
    f7='東京都',
    f8='千代田区',
    f9='一ツ橋（２丁目）';
INSERT postalcode
SET f3='1000012',
    f7='東京都',
    f8='千代田区',
    f9='日比谷公園';
INSERT postalcode
SET f3='1020093',
    f7='東京都',
    f8='千代田区',
    f9='平河町';
INSERT postalcode
SET f3='1020071',
    f7='東京都',
    f8='千代田区',
    f9='富士見';
INSERT postalcode
SET f3='1000005',
    f7='東京都',
    f8='千代田区',
    f9='丸の内（次のビルを除く）';
INSERT postalcode
SET f3='1006690',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（地階・階層不明）';
INSERT postalcode
SET f3='1006601',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（１階）';
INSERT postalcode
SET f3='1006602',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（２階）';
INSERT postalcode
SET f3='1006603',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（３階）';
INSERT postalcode
SET f3='1006604',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（４階）';
INSERT postalcode
SET f3='1006605',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（５階）';
INSERT postalcode
SET f3='1006606',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（６階）';
INSERT postalcode
SET f3='1006607',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（７階）';
INSERT postalcode
SET f3='1006608',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（８階）';
INSERT postalcode
SET f3='1006609',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（９階）';
INSERT postalcode
SET f3='1006610',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（１０階）';
INSERT postalcode
SET f3='1006611',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（１１階）';
INSERT postalcode
SET f3='1006612',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（１２階）';
INSERT postalcode
SET f3='1006613',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（１３階）';
INSERT postalcode
SET f3='1006614',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（１４階）';
INSERT postalcode
SET f3='1006615',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（１５階）';
INSERT postalcode
SET f3='1006616',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（１６階）';
INSERT postalcode
SET f3='1006617',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（１７階）';
INSERT postalcode
SET f3='1006618',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（１８階）';
INSERT postalcode
SET f3='1006619',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（１９階）';
INSERT postalcode
SET f3='1006620',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（２０階）';
INSERT postalcode
SET f3='1006621',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（２１階）';
INSERT postalcode
SET f3='1006622',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（２２階）';
INSERT postalcode
SET f3='1006623',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（２３階）';
INSERT postalcode
SET f3='1006624',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（２４階）';
INSERT postalcode
SET f3='1006625',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（２５階）';
INSERT postalcode
SET f3='1006626',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（２６階）';
INSERT postalcode
SET f3='1006627',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（２７階）';
INSERT postalcode
SET f3='1006628',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（２８階）';
INSERT postalcode
SET f3='1006629',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（２９階）';
INSERT postalcode
SET f3='1006630',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（３０階）';
INSERT postalcode
SET f3='1006631',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（３１階）';
INSERT postalcode
SET f3='1006632',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（３２階）';
INSERT postalcode
SET f3='1006633',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（３３階）';
INSERT postalcode
SET f3='1006634',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（３４階）';
INSERT postalcode
SET f3='1006635',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（３５階）';
INSERT postalcode
SET f3='1006636',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（３６階）';
INSERT postalcode
SET f3='1006637',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（３７階）';
INSERT postalcode
SET f3='1006638',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（３８階）';
INSERT postalcode
SET f3='1006639',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（３９階）';
INSERT postalcode
SET f3='1006640',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（４０階）';
INSERT postalcode
SET f3='1006641',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（４１階）';
INSERT postalcode
SET f3='1006642',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウサウスタワー（４２階）';
INSERT postalcode
SET f3='1006790',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（地階・階層不明）';
INSERT postalcode
SET f3='1006701',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（１階）';
INSERT postalcode
SET f3='1006702',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（２階）';
INSERT postalcode
SET f3='1006703',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（３階）';
INSERT postalcode
SET f3='1006704',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（４階）';
INSERT postalcode
SET f3='1006705',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（５階）';
INSERT postalcode
SET f3='1006706',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（６階）';
INSERT postalcode
SET f3='1006707',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（７階）';
INSERT postalcode
SET f3='1006708',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（８階）';
INSERT postalcode
SET f3='1006709',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（９階）';
INSERT postalcode
SET f3='1006710',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（１０階）';
INSERT postalcode
SET f3='1006711',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（１１階）';
INSERT postalcode
SET f3='1006712',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（１２階）';
INSERT postalcode
SET f3='1006713',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（１３階）';
INSERT postalcode
SET f3='1006714',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（１４階）';
INSERT postalcode
SET f3='1006715',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（１５階）';
INSERT postalcode
SET f3='1006716',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（１６階）';
INSERT postalcode
SET f3='1006717',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（１７階）';
INSERT postalcode
SET f3='1006718',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（１８階）';
INSERT postalcode
SET f3='1006719',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（１９階）';
INSERT postalcode
SET f3='1006720',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（２０階）';
INSERT postalcode
SET f3='1006721',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（２１階）';
INSERT postalcode
SET f3='1006722',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（２２階）';
INSERT postalcode
SET f3='1006723',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（２３階）';
INSERT postalcode
SET f3='1006724',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（２４階）';
INSERT postalcode
SET f3='1006725',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（２５階）';
INSERT postalcode
SET f3='1006726',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（２６階）';
INSERT postalcode
SET f3='1006727',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（２７階）';
INSERT postalcode
SET f3='1006728',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（２８階）';
INSERT postalcode
SET f3='1006729',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（２９階）';
INSERT postalcode
SET f3='1006730',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（３０階）';
INSERT postalcode
SET f3='1006731',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（３１階）';
INSERT postalcode
SET f3='1006732',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（３２階）';
INSERT postalcode
SET f3='1006733',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（３３階）';
INSERT postalcode
SET f3='1006734',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（３４階）';
INSERT postalcode
SET f3='1006735',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（３５階）';
INSERT postalcode
SET f3='1006736',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（３６階）';
INSERT postalcode
SET f3='1006737',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（３７階）';
INSERT postalcode
SET f3='1006738',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（３８階）';
INSERT postalcode
SET f3='1006739',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（３９階）';
INSERT postalcode
SET f3='1006740',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（４０階）';
INSERT postalcode
SET f3='1006741',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（４１階）';
INSERT postalcode
SET f3='1006742',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（４２階）';
INSERT postalcode
SET f3='1006743',
    f7='東京都',
    f8='千代田区',
    f9='丸の内グラントウキョウノースタワー（４３階）';
INSERT postalcode
SET f3='1006590',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（地階・階層不明）';
INSERT postalcode
SET f3='1006501',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（１階）';
INSERT postalcode
SET f3='1006502',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（２階）';
INSERT postalcode
SET f3='1006503',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（３階）';
INSERT postalcode
SET f3='1006504',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（４階）';
INSERT postalcode
SET f3='1006505',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（５階）';
INSERT postalcode
SET f3='1006506',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（６階）';
INSERT postalcode
SET f3='1006507',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（７階）';
INSERT postalcode
SET f3='1006508',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（８階）';
INSERT postalcode
SET f3='1006509',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（９階）';
INSERT postalcode
SET f3='1006510',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（１０階）';
INSERT postalcode
SET f3='1006511',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（１１階）';
INSERT postalcode
SET f3='1006512',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（１２階）';
INSERT postalcode
SET f3='1006513',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（１３階）';
INSERT postalcode
SET f3='1006514',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（１４階）';
INSERT postalcode
SET f3='1006515',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（１５階）';
INSERT postalcode
SET f3='1006516',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（１６階）';
INSERT postalcode
SET f3='1006517',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（１７階）';
INSERT postalcode
SET f3='1006518',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（１８階）';
INSERT postalcode
SET f3='1006519',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（１９階）';
INSERT postalcode
SET f3='1006520',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（２０階）';
INSERT postalcode
SET f3='1006521',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（２１階）';
INSERT postalcode
SET f3='1006522',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（２２階）';
INSERT postalcode
SET f3='1006523',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（２３階）';
INSERT postalcode
SET f3='1006524',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（２４階）';
INSERT postalcode
SET f3='1006525',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（２５階）';
INSERT postalcode
SET f3='1006526',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（２６階）';
INSERT postalcode
SET f3='1006527',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（２７階）';
INSERT postalcode
SET f3='1006528',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（２８階）';
INSERT postalcode
SET f3='1006529',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（２９階）';
INSERT postalcode
SET f3='1006530',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（３０階）';
INSERT postalcode
SET f3='1006531',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（３１階）';
INSERT postalcode
SET f3='1006532',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（３２階）';
INSERT postalcode
SET f3='1006533',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（３３階）';
INSERT postalcode
SET f3='1006534',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（３４階）';
INSERT postalcode
SET f3='1006535',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（３５階）';
INSERT postalcode
SET f3='1006536',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（３６階）';
INSERT postalcode
SET f3='1006537',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（３７階）';
INSERT postalcode
SET f3='1006538',
    f7='東京都',
    f8='千代田区',
    f9='丸の内新丸の内ビルディング（３８階）';
INSERT postalcode
SET f3='1006490',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（地階・階層不明）';
INSERT postalcode
SET f3='1006401',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（１階）';
INSERT postalcode
SET f3='1006402',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（２階）';
INSERT postalcode
SET f3='1006403',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（３階）';
INSERT postalcode
SET f3='1006404',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（４階）';
INSERT postalcode
SET f3='1006405',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（５階）';
INSERT postalcode
SET f3='1006406',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（６階）';
INSERT postalcode
SET f3='1006407',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（７階）';
INSERT postalcode
SET f3='1006408',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（８階）';
INSERT postalcode
SET f3='1006409',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（９階）';
INSERT postalcode
SET f3='1006410',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（１０階）';
INSERT postalcode
SET f3='1006411',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（１１階）';
INSERT postalcode
SET f3='1006412',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（１２階）';
INSERT postalcode
SET f3='1006413',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（１３階）';
INSERT postalcode
SET f3='1006414',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（１４階）';
INSERT postalcode
SET f3='1006415',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（１５階）';
INSERT postalcode
SET f3='1006416',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（１６階）';
INSERT postalcode
SET f3='1006417',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（１７階）';
INSERT postalcode
SET f3='1006418',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（１８階）';
INSERT postalcode
SET f3='1006419',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（１９階）';
INSERT postalcode
SET f3='1006420',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（２０階）';
INSERT postalcode
SET f3='1006421',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（２１階）';
INSERT postalcode
SET f3='1006422',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（２２階）';
INSERT postalcode
SET f3='1006423',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（２３階）';
INSERT postalcode
SET f3='1006424',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（２４階）';
INSERT postalcode
SET f3='1006425',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（２５階）';
INSERT postalcode
SET f3='1006426',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（２６階）';
INSERT postalcode
SET f3='1006427',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（２７階）';
INSERT postalcode
SET f3='1006428',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（２８階）';
INSERT postalcode
SET f3='1006429',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（２９階）';
INSERT postalcode
SET f3='1006430',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（３０階）';
INSERT postalcode
SET f3='1006431',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（３１階）';
INSERT postalcode
SET f3='1006432',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（３２階）';
INSERT postalcode
SET f3='1006433',
    f7='東京都',
    f8='千代田区',
    f9='丸の内東京ビルディング（３３階）';
INSERT postalcode
SET f3='1006290',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（地階・階層不明）';
INSERT postalcode
SET f3='1006201',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（１階）';
INSERT postalcode
SET f3='1006202',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（２階）';
INSERT postalcode
SET f3='1006203',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（３階）';
INSERT postalcode
SET f3='1006204',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（４階）';
INSERT postalcode
SET f3='1006205',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（５階）';
INSERT postalcode
SET f3='1006206',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（６階）';
INSERT postalcode
SET f3='1006207',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（７階）';
INSERT postalcode
SET f3='1006208',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（８階）';
INSERT postalcode
SET f3='1006209',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（９階）';
INSERT postalcode
SET f3='1006210',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（１０階）';
INSERT postalcode
SET f3='1006211',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（１１階）';
INSERT postalcode
SET f3='1006212',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（１２階）';
INSERT postalcode
SET f3='1006213',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（１３階）';
INSERT postalcode
SET f3='1006214',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（１４階）';
INSERT postalcode
SET f3='1006215',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（１５階）';
INSERT postalcode
SET f3='1006216',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（１６階）';
INSERT postalcode
SET f3='1006217',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（１７階）';
INSERT postalcode
SET f3='1006218',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（１８階）';
INSERT postalcode
SET f3='1006219',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（１９階）';
INSERT postalcode
SET f3='1006220',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（２０階）';
INSERT postalcode
SET f3='1006221',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（２１階）';
INSERT postalcode
SET f3='1006222',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（２２階）';
INSERT postalcode
SET f3='1006223',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（２３階）';
INSERT postalcode
SET f3='1006224',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（２４階）';
INSERT postalcode
SET f3='1006225',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（２５階）';
INSERT postalcode
SET f3='1006226',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（２６階）';
INSERT postalcode
SET f3='1006227',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（２７階）';
INSERT postalcode
SET f3='1006228',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（２８階）';
INSERT postalcode
SET f3='1006229',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（２９階）';
INSERT postalcode
SET f3='1006230',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（３０階）';
INSERT postalcode
SET f3='1006231',
    f7='東京都',
    f8='千代田区',
    f9='丸の内パシフィックセンチュリープレイス丸の内（３１階）';
INSERT postalcode
SET f3='1006990',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（地階・階層不明）';
INSERT postalcode
SET f3='1006901',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（１階）';
INSERT postalcode
SET f3='1006902',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（２階）';
INSERT postalcode
SET f3='1006903',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（３階）';
INSERT postalcode
SET f3='1006904',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（４階）';
INSERT postalcode
SET f3='1006905',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（５階）';
INSERT postalcode
SET f3='1006906',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（６階）';
INSERT postalcode
SET f3='1006907',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（７階）';
INSERT postalcode
SET f3='1006908',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（８階）';
INSERT postalcode
SET f3='1006909',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（９階）';
INSERT postalcode
SET f3='1006910',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（１０階）';
INSERT postalcode
SET f3='1006911',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（１１階）';
INSERT postalcode
SET f3='1006912',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（１２階）';
INSERT postalcode
SET f3='1006913',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（１３階）';
INSERT postalcode
SET f3='1006914',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（１４階）';
INSERT postalcode
SET f3='1006915',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（１５階）';
INSERT postalcode
SET f3='1006916',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（１６階）';
INSERT postalcode
SET f3='1006917',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（１７階）';
INSERT postalcode
SET f3='1006918',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（１８階）';
INSERT postalcode
SET f3='1006919',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（１９階）';
INSERT postalcode
SET f3='1006920',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（２０階）';
INSERT postalcode
SET f3='1006921',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（２１階）';
INSERT postalcode
SET f3='1006922',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（２２階）';
INSERT postalcode
SET f3='1006923',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（２３階）';
INSERT postalcode
SET f3='1006924',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（２４階）';
INSERT postalcode
SET f3='1006925',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（２５階）';
INSERT postalcode
SET f3='1006926',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（２６階）';
INSERT postalcode
SET f3='1006927',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（２７階）';
INSERT postalcode
SET f3='1006928',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（２８階）';
INSERT postalcode
SET f3='1006929',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（２９階）';
INSERT postalcode
SET f3='1006930',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（３０階）';
INSERT postalcode
SET f3='1006931',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（３１階）';
INSERT postalcode
SET f3='1006932',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（３２階）';
INSERT postalcode
SET f3='1006933',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（３３階）';
INSERT postalcode
SET f3='1006934',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内パークビルディング（３４階）';
INSERT postalcode
SET f3='1006390',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（地階・階層不明）';
INSERT postalcode
SET f3='1006301',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（１階）';
INSERT postalcode
SET f3='1006302',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（２階）';
INSERT postalcode
SET f3='1006303',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（３階）';
INSERT postalcode
SET f3='1006304',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（４階）';
INSERT postalcode
SET f3='1006305',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（５階）';
INSERT postalcode
SET f3='1006306',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（６階）';
INSERT postalcode
SET f3='1006307',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（７階）';
INSERT postalcode
SET f3='1006308',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（８階）';
INSERT postalcode
SET f3='1006309',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（９階）';
INSERT postalcode
SET f3='1006310',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（１０階）';
INSERT postalcode
SET f3='1006311',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（１１階）';
INSERT postalcode
SET f3='1006312',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（１２階）';
INSERT postalcode
SET f3='1006313',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（１３階）';
INSERT postalcode
SET f3='1006314',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（１４階）';
INSERT postalcode
SET f3='1006315',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（１５階）';
INSERT postalcode
SET f3='1006316',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（１６階）';
INSERT postalcode
SET f3='1006317',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（１７階）';
INSERT postalcode
SET f3='1006318',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（１８階）';
INSERT postalcode
SET f3='1006319',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（１９階）';
INSERT postalcode
SET f3='1006320',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（２０階）';
INSERT postalcode
SET f3='1006321',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（２１階）';
INSERT postalcode
SET f3='1006322',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（２２階）';
INSERT postalcode
SET f3='1006323',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（２３階）';
INSERT postalcode
SET f3='1006324',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（２４階）';
INSERT postalcode
SET f3='1006325',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（２５階）';
INSERT postalcode
SET f3='1006326',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（２６階）';
INSERT postalcode
SET f3='1006327',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（２７階）';
INSERT postalcode
SET f3='1006328',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（２８階）';
INSERT postalcode
SET f3='1006329',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（２９階）';
INSERT postalcode
SET f3='1006330',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（３０階）';
INSERT postalcode
SET f3='1006331',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（３１階）';
INSERT postalcode
SET f3='1006332',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（３２階）';
INSERT postalcode
SET f3='1006333',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（３３階）';
INSERT postalcode
SET f3='1006334',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（３４階）';
INSERT postalcode
SET f3='1006335',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（３５階）';
INSERT postalcode
SET f3='1006336',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（３６階）';
INSERT postalcode
SET f3='1006337',
    f7='東京都',
    f8='千代田区',
    f9='丸の内丸の内ビルディング（３７階）';
INSERT postalcode
SET f3='1010061',
    f7='東京都',
    f8='千代田区',
    f9='三崎町';
INSERT postalcode
SET f3='1000006',
    f7='東京都',
    f8='千代田区',
    f9='有楽町';
INSERT postalcode
SET f3='1020081',
    f7='東京都',
    f8='千代田区',
    f9='四番町';
INSERT postalcode
SET f3='1020085',
    f7='東京都',
    f8='千代田区',
    f9='六番町';
INSERT postalcode
SET f3='1030000',
    f7='東京都',
    f8='中央区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1040044',
    f7='東京都',
    f8='中央区',
    f9='明石町';
INSERT postalcode
SET f3='1040042',
    f7='東京都',
    f8='中央区',
    f9='入船';
INSERT postalcode
SET f3='1040054',
    f7='東京都',
    f8='中央区',
    f9='勝どき';
INSERT postalcode
SET f3='1040031',
    f7='東京都',
    f8='中央区',
    f9='京橋';
INSERT postalcode
SET f3='1040061',
    f7='東京都',
    f8='中央区',
    f9='銀座';
INSERT postalcode
SET f3='1040033',
    f7='東京都',
    f8='中央区',
    f9='新川';
INSERT postalcode
SET f3='1040041',
    f7='東京都',
    f8='中央区',
    f9='新富';
INSERT postalcode
SET f3='1040052',
    f7='東京都',
    f8='中央区',
    f9='月島';
INSERT postalcode
SET f3='1040045',
    f7='東京都',
    f8='中央区',
    f9='築地';
INSERT postalcode
SET f3='1040051',
    f7='東京都',
    f8='中央区',
    f9='佃';
INSERT postalcode
SET f3='1040055',
    f7='東京都',
    f8='中央区',
    f9='豊海町';
INSERT postalcode
SET f3='1030027',
    f7='東京都',
    f8='中央区',
    f9='日本橋';
INSERT postalcode
SET f3='1030011',
    f7='東京都',
    f8='中央区',
    f9='日本橋大伝馬町';
INSERT postalcode
SET f3='1030014',
    f7='東京都',
    f8='中央区',
    f9='日本橋蛎殻町';
INSERT postalcode
SET f3='1030026',
    f7='東京都',
    f8='中央区',
    f9='日本橋兜町';
INSERT postalcode
SET f3='1030025',
    f7='東京都',
    f8='中央区',
    f9='日本橋茅場町';
INSERT postalcode
SET f3='1030016',
    f7='東京都',
    f8='中央区',
    f9='日本橋小網町';
INSERT postalcode
SET f3='1030001',
    f7='東京都',
    f8='中央区',
    f9='日本橋小伝馬町';
INSERT postalcode
SET f3='1030024',
    f7='東京都',
    f8='中央区',
    f9='日本橋小舟町';
INSERT postalcode
SET f3='1030006',
    f7='東京都',
    f8='中央区',
    f9='日本橋富沢町';
INSERT postalcode
SET f3='1030008',
    f7='東京都',
    f8='中央区',
    f9='日本橋中洲';
INSERT postalcode
SET f3='1030013',
    f7='東京都',
    f8='中央区',
    f9='日本橋人形町';
INSERT postalcode
SET f3='1030015',
    f7='東京都',
    f8='中央区',
    f9='日本橋箱崎町';
INSERT postalcode
SET f3='1030007',
    f7='東京都',
    f8='中央区',
    f9='日本橋浜町';
INSERT postalcode
SET f3='1030002',
    f7='東京都',
    f8='中央区',
    f9='日本橋馬喰町';
INSERT postalcode
SET f3='1030005',
    f7='東京都',
    f8='中央区',
    f9='日本橋久松町';
INSERT postalcode
SET f3='1030012',
    f7='東京都',
    f8='中央区',
    f9='日本橋堀留町';
INSERT postalcode
SET f3='1030021',
    f7='東京都',
    f8='中央区',
    f9='日本橋本石町';
INSERT postalcode
SET f3='1030023',
    f7='東京都',
    f8='中央区',
    f9='日本橋本町';
INSERT postalcode
SET f3='1030022',
    f7='東京都',
    f8='中央区',
    f9='日本橋室町';
INSERT postalcode
SET f3='1030003',
    f7='東京都',
    f8='中央区',
    f9='日本橋横山町';
INSERT postalcode
SET f3='1040032',
    f7='東京都',
    f8='中央区',
    f9='八丁堀';
INSERT postalcode
SET f3='1040046',
    f7='東京都',
    f8='中央区',
    f9='浜離宮庭園';
INSERT postalcode
SET f3='1040053',
    f7='東京都',
    f8='中央区',
    f9='晴海（次のビルを除く）';
INSERT postalcode
SET f3='1046090',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（地階・階層不明）';
INSERT postalcode
SET f3='1046001',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（１階）';
INSERT postalcode
SET f3='1046002',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（２階）';
INSERT postalcode
SET f3='1046003',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（３階）';
INSERT postalcode
SET f3='1046004',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（４階）';
INSERT postalcode
SET f3='1046005',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（５階）';
INSERT postalcode
SET f3='1046006',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（６階）';
INSERT postalcode
SET f3='1046007',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（７階）';
INSERT postalcode
SET f3='1046008',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（８階）';
INSERT postalcode
SET f3='1046009',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（９階）';
INSERT postalcode
SET f3='1046010',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（１０階）';
INSERT postalcode
SET f3='1046011',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（１１階）';
INSERT postalcode
SET f3='1046012',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（１２階）';
INSERT postalcode
SET f3='1046013',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（１３階）';
INSERT postalcode
SET f3='1046014',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（１４階）';
INSERT postalcode
SET f3='1046015',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（１５階）';
INSERT postalcode
SET f3='1046016',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（１６階）';
INSERT postalcode
SET f3='1046017',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（１７階）';
INSERT postalcode
SET f3='1046018',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（１８階）';
INSERT postalcode
SET f3='1046019',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（１９階）';
INSERT postalcode
SET f3='1046020',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（２０階）';
INSERT postalcode
SET f3='1046021',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（２１階）';
INSERT postalcode
SET f3='1046022',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（２２階）';
INSERT postalcode
SET f3='1046023',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（２３階）';
INSERT postalcode
SET f3='1046024',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（２４階）';
INSERT postalcode
SET f3='1046025',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（２５階）';
INSERT postalcode
SET f3='1046026',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（２６階）';
INSERT postalcode
SET f3='1046027',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（２７階）';
INSERT postalcode
SET f3='1046028',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（２８階）';
INSERT postalcode
SET f3='1046029',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（２９階）';
INSERT postalcode
SET f3='1046030',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（３０階）';
INSERT postalcode
SET f3='1046031',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（３１階）';
INSERT postalcode
SET f3='1046032',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（３２階）';
INSERT postalcode
SET f3='1046033',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（３３階）';
INSERT postalcode
SET f3='1046034',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（３４階）';
INSERT postalcode
SET f3='1046035',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（３５階）';
INSERT postalcode
SET f3='1046036',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（３６階）';
INSERT postalcode
SET f3='1046037',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（３７階）';
INSERT postalcode
SET f3='1046038',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（３８階）';
INSERT postalcode
SET f3='1046039',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（３９階）';
INSERT postalcode
SET f3='1046040',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（４０階）';
INSERT postalcode
SET f3='1046041',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（４１階）';
INSERT postalcode
SET f3='1046042',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（４２階）';
INSERT postalcode
SET f3='1046043',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（４３階）';
INSERT postalcode
SET f3='1046044',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＸ（４４階）';
INSERT postalcode
SET f3='1046190',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（地階・階層不明）';
INSERT postalcode
SET f3='1046101',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（１階）';
INSERT postalcode
SET f3='1046102',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（２階）';
INSERT postalcode
SET f3='1046103',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（３階）';
INSERT postalcode
SET f3='1046104',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（４階）';
INSERT postalcode
SET f3='1046105',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（５階）';
INSERT postalcode
SET f3='1046106',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（６階）';
INSERT postalcode
SET f3='1046107',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（７階）';
INSERT postalcode
SET f3='1046108',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（８階）';
INSERT postalcode
SET f3='1046109',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（９階）';
INSERT postalcode
SET f3='1046110',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（１０階）';
INSERT postalcode
SET f3='1046111',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（１１階）';
INSERT postalcode
SET f3='1046112',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（１２階）';
INSERT postalcode
SET f3='1046113',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（１３階）';
INSERT postalcode
SET f3='1046114',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（１４階）';
INSERT postalcode
SET f3='1046115',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（１５階）';
INSERT postalcode
SET f3='1046116',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（１６階）';
INSERT postalcode
SET f3='1046117',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（１７階）';
INSERT postalcode
SET f3='1046118',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（１８階）';
INSERT postalcode
SET f3='1046119',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（１９階）';
INSERT postalcode
SET f3='1046120',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（２０階）';
INSERT postalcode
SET f3='1046121',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（２１階）';
INSERT postalcode
SET f3='1046122',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（２２階）';
INSERT postalcode
SET f3='1046123',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（２３階）';
INSERT postalcode
SET f3='1046124',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（２４階）';
INSERT postalcode
SET f3='1046125',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（２５階）';
INSERT postalcode
SET f3='1046126',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（２６階）';
INSERT postalcode
SET f3='1046127',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（２７階）';
INSERT postalcode
SET f3='1046128',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（２８階）';
INSERT postalcode
SET f3='1046129',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（２９階）';
INSERT postalcode
SET f3='1046130',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（３０階）';
INSERT postalcode
SET f3='1046131',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（３１階）';
INSERT postalcode
SET f3='1046132',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（３２階）';
INSERT postalcode
SET f3='1046133',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（３３階）';
INSERT postalcode
SET f3='1046134',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（３４階）';
INSERT postalcode
SET f3='1046135',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（３５階）';
INSERT postalcode
SET f3='1046136',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（３６階）';
INSERT postalcode
SET f3='1046137',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（３７階）';
INSERT postalcode
SET f3='1046138',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（３８階）';
INSERT postalcode
SET f3='1046139',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＹ（３９階）';
INSERT postalcode
SET f3='1046290',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（地階・階層不明）';
INSERT postalcode
SET f3='1046201',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（１階）';
INSERT postalcode
SET f3='1046202',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（２階）';
INSERT postalcode
SET f3='1046203',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（３階）';
INSERT postalcode
SET f3='1046204',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（４階）';
INSERT postalcode
SET f3='1046205',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（５階）';
INSERT postalcode
SET f3='1046206',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（６階）';
INSERT postalcode
SET f3='1046207',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（７階）';
INSERT postalcode
SET f3='1046208',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（８階）';
INSERT postalcode
SET f3='1046209',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（９階）';
INSERT postalcode
SET f3='1046210',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（１０階）';
INSERT postalcode
SET f3='1046211',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（１１階）';
INSERT postalcode
SET f3='1046212',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（１２階）';
INSERT postalcode
SET f3='1046213',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（１３階）';
INSERT postalcode
SET f3='1046214',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（１４階）';
INSERT postalcode
SET f3='1046215',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（１５階）';
INSERT postalcode
SET f3='1046216',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（１６階）';
INSERT postalcode
SET f3='1046217',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（１７階）';
INSERT postalcode
SET f3='1046218',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（１８階）';
INSERT postalcode
SET f3='1046219',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（１９階）';
INSERT postalcode
SET f3='1046220',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（２０階）';
INSERT postalcode
SET f3='1046221',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（２１階）';
INSERT postalcode
SET f3='1046222',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（２２階）';
INSERT postalcode
SET f3='1046223',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（２３階）';
INSERT postalcode
SET f3='1046224',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（２４階）';
INSERT postalcode
SET f3='1046225',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（２５階）';
INSERT postalcode
SET f3='1046226',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（２６階）';
INSERT postalcode
SET f3='1046227',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（２７階）';
INSERT postalcode
SET f3='1046228',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（２８階）';
INSERT postalcode
SET f3='1046229',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（２９階）';
INSERT postalcode
SET f3='1046230',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（３０階）';
INSERT postalcode
SET f3='1046231',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（３１階）';
INSERT postalcode
SET f3='1046232',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（３２階）';
INSERT postalcode
SET f3='1046233',
    f7='東京都',
    f8='中央区',
    f9='晴海オフィスタワーＺ（３３階）';
INSERT postalcode
SET f3='1030004',
    f7='東京都',
    f8='中央区',
    f9='東日本橋';
INSERT postalcode
SET f3='1040043',
    f7='東京都',
    f8='中央区',
    f9='湊';
INSERT postalcode
SET f3='1030028',
    f7='東京都',
    f8='中央区',
    f9='八重洲（１丁目）';
INSERT postalcode
SET f3='1040028',
    f7='東京都',
    f8='中央区',
    f9='八重洲（２丁目）';
INSERT postalcode
SET f3='1050000',
    f7='東京都',
    f8='港区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1070052',
    f7='東京都',
    f8='港区',
    f9='赤坂（次のビルを除く）';
INSERT postalcode
SET f3='1076090',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（地階・階層不明）';
INSERT postalcode
SET f3='1076001',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（１階）';
INSERT postalcode
SET f3='1076002',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（２階）';
INSERT postalcode
SET f3='1076003',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（３階）';
INSERT postalcode
SET f3='1076004',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（４階）';
INSERT postalcode
SET f3='1076005',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（５階）';
INSERT postalcode
SET f3='1076006',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（６階）';
INSERT postalcode
SET f3='1076007',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（７階）';
INSERT postalcode
SET f3='1076008',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（８階）';
INSERT postalcode
SET f3='1076009',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（９階）';
INSERT postalcode
SET f3='1076010',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（１０階）';
INSERT postalcode
SET f3='1076011',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（１１階）';
INSERT postalcode
SET f3='1076012',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（１２階）';
INSERT postalcode
SET f3='1076013',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（１３階）';
INSERT postalcode
SET f3='1076014',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（１４階）';
INSERT postalcode
SET f3='1076015',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（１５階）';
INSERT postalcode
SET f3='1076016',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（１６階）';
INSERT postalcode
SET f3='1076017',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（１７階）';
INSERT postalcode
SET f3='1076018',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（１８階）';
INSERT postalcode
SET f3='1076019',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（１９階）';
INSERT postalcode
SET f3='1076020',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（２０階）';
INSERT postalcode
SET f3='1076021',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（２１階）';
INSERT postalcode
SET f3='1076022',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（２２階）';
INSERT postalcode
SET f3='1076023',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（２３階）';
INSERT postalcode
SET f3='1076024',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（２４階）';
INSERT postalcode
SET f3='1076025',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（２５階）';
INSERT postalcode
SET f3='1076026',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（２６階）';
INSERT postalcode
SET f3='1076027',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（２７階）';
INSERT postalcode
SET f3='1076028',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（２８階）';
INSERT postalcode
SET f3='1076029',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（２９階）';
INSERT postalcode
SET f3='1076030',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（３０階）';
INSERT postalcode
SET f3='1076031',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（３１階）';
INSERT postalcode
SET f3='1076032',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（３２階）';
INSERT postalcode
SET f3='1076033',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（３３階）';
INSERT postalcode
SET f3='1076034',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（３４階）';
INSERT postalcode
SET f3='1076035',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（３５階）';
INSERT postalcode
SET f3='1076036',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（３６階）';
INSERT postalcode
SET f3='1076037',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂アークヒルズ・アーク森ビル（３７階）';
INSERT postalcode
SET f3='1076190',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（地階・階層不明）';
INSERT postalcode
SET f3='1076101',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（１階）';
INSERT postalcode
SET f3='1076102',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（２階）';
INSERT postalcode
SET f3='1076103',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（３階）';
INSERT postalcode
SET f3='1076104',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（４階）';
INSERT postalcode
SET f3='1076105',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（５階）';
INSERT postalcode
SET f3='1076106',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（６階）';
INSERT postalcode
SET f3='1076107',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（７階）';
INSERT postalcode
SET f3='1076108',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（８階）';
INSERT postalcode
SET f3='1076109',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（９階）';
INSERT postalcode
SET f3='1076110',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（１０階）';
INSERT postalcode
SET f3='1076111',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（１１階）';
INSERT postalcode
SET f3='1076112',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（１２階）';
INSERT postalcode
SET f3='1076113',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（１３階）';
INSERT postalcode
SET f3='1076114',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（１４階）';
INSERT postalcode
SET f3='1076115',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（１５階）';
INSERT postalcode
SET f3='1076116',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（１６階）';
INSERT postalcode
SET f3='1076117',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（１７階）';
INSERT postalcode
SET f3='1076118',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（１８階）';
INSERT postalcode
SET f3='1076119',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（１９階）';
INSERT postalcode
SET f3='1076120',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（２０階）';
INSERT postalcode
SET f3='1076121',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（２１階）';
INSERT postalcode
SET f3='1076122',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（２２階）';
INSERT postalcode
SET f3='1076123',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（２３階）';
INSERT postalcode
SET f3='1076124',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（２４階）';
INSERT postalcode
SET f3='1076125',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（２５階）';
INSERT postalcode
SET f3='1076126',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（２６階）';
INSERT postalcode
SET f3='1076127',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（２７階）';
INSERT postalcode
SET f3='1076128',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（２８階）';
INSERT postalcode
SET f3='1076129',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（２９階）';
INSERT postalcode
SET f3='1076130',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂パークビル（３０階）';
INSERT postalcode
SET f3='1076390',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（地階・階層不明）';
INSERT postalcode
SET f3='1076301',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（１階）';
INSERT postalcode
SET f3='1076302',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（２階）';
INSERT postalcode
SET f3='1076303',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（３階）';
INSERT postalcode
SET f3='1076304',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（４階）';
INSERT postalcode
SET f3='1076305',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（５階）';
INSERT postalcode
SET f3='1076306',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（６階）';
INSERT postalcode
SET f3='1076307',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（７階）';
INSERT postalcode
SET f3='1076308',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（８階）';
INSERT postalcode
SET f3='1076309',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（９階）';
INSERT postalcode
SET f3='1076310',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（１０階）';
INSERT postalcode
SET f3='1076311',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（１１階）';
INSERT postalcode
SET f3='1076312',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（１２階）';
INSERT postalcode
SET f3='1076313',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（１３階）';
INSERT postalcode
SET f3='1076314',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（１４階）';
INSERT postalcode
SET f3='1076315',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（１５階）';
INSERT postalcode
SET f3='1076316',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（１６階）';
INSERT postalcode
SET f3='1076317',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（１７階）';
INSERT postalcode
SET f3='1076318',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（１８階）';
INSERT postalcode
SET f3='1076319',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（１９階）';
INSERT postalcode
SET f3='1076320',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（２０階）';
INSERT postalcode
SET f3='1076321',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（２１階）';
INSERT postalcode
SET f3='1076322',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（２２階）';
INSERT postalcode
SET f3='1076323',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（２３階）';
INSERT postalcode
SET f3='1076324',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（２４階）';
INSERT postalcode
SET f3='1076325',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（２５階）';
INSERT postalcode
SET f3='1076326',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（２６階）';
INSERT postalcode
SET f3='1076327',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（２７階）';
INSERT postalcode
SET f3='1076328',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（２８階）';
INSERT postalcode
SET f3='1076329',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（２９階）';
INSERT postalcode
SET f3='1076330',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（３０階）';
INSERT postalcode
SET f3='1076331',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（３１階）';
INSERT postalcode
SET f3='1076332',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（３２階）';
INSERT postalcode
SET f3='1076333',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（３３階）';
INSERT postalcode
SET f3='1076334',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（３４階）';
INSERT postalcode
SET f3='1076335',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（３５階）';
INSERT postalcode
SET f3='1076336',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（３６階）';
INSERT postalcode
SET f3='1076337',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（３７階）';
INSERT postalcode
SET f3='1076338',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（３８階）';
INSERT postalcode
SET f3='1076339',
    f7='東京都',
    f8='港区',
    f9='赤坂赤坂Ｂｉｚタワー（３９階）';
INSERT postalcode
SET f3='1076290',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（地階・階層不明）';
INSERT postalcode
SET f3='1076201',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（１階）';
INSERT postalcode
SET f3='1076202',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（２階）';
INSERT postalcode
SET f3='1076203',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（３階）';
INSERT postalcode
SET f3='1076204',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（４階）';
INSERT postalcode
SET f3='1076205',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（５階）';
INSERT postalcode
SET f3='1076206',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（６階）';
INSERT postalcode
SET f3='1076207',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（７階）';
INSERT postalcode
SET f3='1076208',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（８階）';
INSERT postalcode
SET f3='1076209',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（９階）';
INSERT postalcode
SET f3='1076210',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（１０階）';
INSERT postalcode
SET f3='1076211',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（１１階）';
INSERT postalcode
SET f3='1076212',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（１２階）';
INSERT postalcode
SET f3='1076213',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（１３階）';
INSERT postalcode
SET f3='1076214',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（１４階）';
INSERT postalcode
SET f3='1076215',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（１５階）';
INSERT postalcode
SET f3='1076216',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（１６階）';
INSERT postalcode
SET f3='1076217',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（１７階）';
INSERT postalcode
SET f3='1076218',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（１８階）';
INSERT postalcode
SET f3='1076219',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（１９階）';
INSERT postalcode
SET f3='1076220',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（２０階）';
INSERT postalcode
SET f3='1076221',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（２１階）';
INSERT postalcode
SET f3='1076222',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（２２階）';
INSERT postalcode
SET f3='1076223',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（２３階）';
INSERT postalcode
SET f3='1076224',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（２４階）';
INSERT postalcode
SET f3='1076225',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（２５階）';
INSERT postalcode
SET f3='1076226',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（２６階）';
INSERT postalcode
SET f3='1076227',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（２７階）';
INSERT postalcode
SET f3='1076228',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（２８階）';
INSERT postalcode
SET f3='1076229',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（２９階）';
INSERT postalcode
SET f3='1076230',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（３０階）';
INSERT postalcode
SET f3='1076231',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（３１階）';
INSERT postalcode
SET f3='1076232',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（３２階）';
INSERT postalcode
SET f3='1076233',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（３３階）';
INSERT postalcode
SET f3='1076234',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（３４階）';
INSERT postalcode
SET f3='1076235',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（３５階）';
INSERT postalcode
SET f3='1076236',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（３６階）';
INSERT postalcode
SET f3='1076237',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（３７階）';
INSERT postalcode
SET f3='1076238',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（３８階）';
INSERT postalcode
SET f3='1076239',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（３９階）';
INSERT postalcode
SET f3='1076240',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（４０階）';
INSERT postalcode
SET f3='1076241',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（４１階）';
INSERT postalcode
SET f3='1076242',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（４２階）';
INSERT postalcode
SET f3='1076243',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（４３階）';
INSERT postalcode
SET f3='1076244',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（４４階）';
INSERT postalcode
SET f3='1076245',
    f7='東京都',
    f8='港区',
    f9='赤坂ミッドタウン・タワー（４５階）';
INSERT postalcode
SET f3='1060045',
    f7='東京都',
    f8='港区',
    f9='麻布十番';
INSERT postalcode
SET f3='1060041',
    f7='東京都',
    f8='港区',
    f9='麻布台';
INSERT postalcode
SET f3='1060043',
    f7='東京都',
    f8='港区',
    f9='麻布永坂町';
INSERT postalcode
SET f3='1060042',
    f7='東京都',
    f8='港区',
    f9='麻布狸穴町';
INSERT postalcode
SET f3='1050002',
    f7='東京都',
    f8='港区',
    f9='愛宕（次のビルを除く）';
INSERT postalcode
SET f3='1056290',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（地階・階層不明）';
INSERT postalcode
SET f3='1056201',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（１階）';
INSERT postalcode
SET f3='1056202',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（２階）';
INSERT postalcode
SET f3='1056203',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（３階）';
INSERT postalcode
SET f3='1056204',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（４階）';
INSERT postalcode
SET f3='1056205',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（５階）';
INSERT postalcode
SET f3='1056206',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（６階）';
INSERT postalcode
SET f3='1056207',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（７階）';
INSERT postalcode
SET f3='1056208',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（８階）';
INSERT postalcode
SET f3='1056209',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（９階）';
INSERT postalcode
SET f3='1056210',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（１０階）';
INSERT postalcode
SET f3='1056211',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（１１階）';
INSERT postalcode
SET f3='1056212',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（１２階）';
INSERT postalcode
SET f3='1056213',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（１３階）';
INSERT postalcode
SET f3='1056214',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（１４階）';
INSERT postalcode
SET f3='1056215',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（１５階）';
INSERT postalcode
SET f3='1056216',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（１６階）';
INSERT postalcode
SET f3='1056217',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（１７階）';
INSERT postalcode
SET f3='1056218',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（１８階）';
INSERT postalcode
SET f3='1056219',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（１９階）';
INSERT postalcode
SET f3='1056220',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（２０階）';
INSERT postalcode
SET f3='1056221',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（２１階）';
INSERT postalcode
SET f3='1056222',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（２２階）';
INSERT postalcode
SET f3='1056223',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（２３階）';
INSERT postalcode
SET f3='1056224',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（２４階）';
INSERT postalcode
SET f3='1056225',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（２５階）';
INSERT postalcode
SET f3='1056226',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（２６階）';
INSERT postalcode
SET f3='1056227',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（２７階）';
INSERT postalcode
SET f3='1056228',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（２８階）';
INSERT postalcode
SET f3='1056229',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（２９階）';
INSERT postalcode
SET f3='1056230',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（３０階）';
INSERT postalcode
SET f3='1056231',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（３１階）';
INSERT postalcode
SET f3='1056232',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（３２階）';
INSERT postalcode
SET f3='1056233',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（３３階）';
INSERT postalcode
SET f3='1056234',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（３４階）';
INSERT postalcode
SET f3='1056235',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（３５階）';
INSERT postalcode
SET f3='1056236',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（３６階）';
INSERT postalcode
SET f3='1056237',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（３７階）';
INSERT postalcode
SET f3='1056238',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（３８階）';
INSERT postalcode
SET f3='1056239',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（３９階）';
INSERT postalcode
SET f3='1056240',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（４０階）';
INSERT postalcode
SET f3='1056241',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（４１階）';
INSERT postalcode
SET f3='1056242',
    f7='東京都',
    f8='港区',
    f9='愛宕愛宕グリーンヒルズＭＯＲＩタワー（４２階）';
INSERT postalcode
SET f3='1050022',
    f7='東京都',
    f8='港区',
    f9='海岸（１、２丁目）';
INSERT postalcode
SET f3='1080022',
    f7='東京都',
    f8='港区',
    f9='海岸（３丁目）';
INSERT postalcode
SET f3='1070061',
    f7='東京都',
    f8='港区',
    f9='北青山';
INSERT postalcode
SET f3='1080075',
    f7='東京都',
    f8='港区',
    f9='港南（次のビルを除く）';
INSERT postalcode
SET f3='1086090',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（地階・階層不明）';
INSERT postalcode
SET f3='1086001',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（１階）';
INSERT postalcode
SET f3='1086002',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（２階）';
INSERT postalcode
SET f3='1086003',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（３階）';
INSERT postalcode
SET f3='1086004',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（４階）';
INSERT postalcode
SET f3='1086005',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（５階）';
INSERT postalcode
SET f3='1086006',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（６階）';
INSERT postalcode
SET f3='1086007',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（７階）';
INSERT postalcode
SET f3='1086008',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（８階）';
INSERT postalcode
SET f3='1086009',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（９階）';
INSERT postalcode
SET f3='1086010',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（１０階）';
INSERT postalcode
SET f3='1086011',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（１１階）';
INSERT postalcode
SET f3='1086012',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（１２階）';
INSERT postalcode
SET f3='1086013',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（１３階）';
INSERT postalcode
SET f3='1086014',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（１４階）';
INSERT postalcode
SET f3='1086015',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（１５階）';
INSERT postalcode
SET f3='1086016',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（１６階）';
INSERT postalcode
SET f3='1086017',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（１７階）';
INSERT postalcode
SET f3='1086018',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（１８階）';
INSERT postalcode
SET f3='1086019',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（１９階）';
INSERT postalcode
SET f3='1086020',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（２０階）';
INSERT postalcode
SET f3='1086021',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（２１階）';
INSERT postalcode
SET f3='1086022',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（２２階）';
INSERT postalcode
SET f3='1086023',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（２３階）';
INSERT postalcode
SET f3='1086024',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（２４階）';
INSERT postalcode
SET f3='1086025',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（２５階）';
INSERT postalcode
SET f3='1086026',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（２６階）';
INSERT postalcode
SET f3='1086027',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（２７階）';
INSERT postalcode
SET f3='1086028',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（２８階）';
INSERT postalcode
SET f3='1086029',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（２９階）';
INSERT postalcode
SET f3='1086030',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（３０階）';
INSERT postalcode
SET f3='1086031',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（３１階）';
INSERT postalcode
SET f3='1086032',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＡ棟（３２階）';
INSERT postalcode
SET f3='1086190',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（地階・階層不明）';
INSERT postalcode
SET f3='1086101',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（１階）';
INSERT postalcode
SET f3='1086102',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（２階）';
INSERT postalcode
SET f3='1086103',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（３階）';
INSERT postalcode
SET f3='1086104',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（４階）';
INSERT postalcode
SET f3='1086105',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（５階）';
INSERT postalcode
SET f3='1086106',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（６階）';
INSERT postalcode
SET f3='1086107',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（７階）';
INSERT postalcode
SET f3='1086108',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（８階）';
INSERT postalcode
SET f3='1086109',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（９階）';
INSERT postalcode
SET f3='1086110',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（１０階）';
INSERT postalcode
SET f3='1086111',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（１１階）';
INSERT postalcode
SET f3='1086112',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（１２階）';
INSERT postalcode
SET f3='1086113',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（１３階）';
INSERT postalcode
SET f3='1086114',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（１４階）';
INSERT postalcode
SET f3='1086115',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（１５階）';
INSERT postalcode
SET f3='1086116',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（１６階）';
INSERT postalcode
SET f3='1086117',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（１７階）';
INSERT postalcode
SET f3='1086118',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（１８階）';
INSERT postalcode
SET f3='1086119',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（１９階）';
INSERT postalcode
SET f3='1086120',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（２０階）';
INSERT postalcode
SET f3='1086121',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（２１階）';
INSERT postalcode
SET f3='1086122',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（２２階）';
INSERT postalcode
SET f3='1086123',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（２３階）';
INSERT postalcode
SET f3='1086124',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（２４階）';
INSERT postalcode
SET f3='1086125',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（２５階）';
INSERT postalcode
SET f3='1086126',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（２６階）';
INSERT postalcode
SET f3='1086127',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（２７階）';
INSERT postalcode
SET f3='1086128',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（２８階）';
INSERT postalcode
SET f3='1086129',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（２９階）';
INSERT postalcode
SET f3='1086130',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（３０階）';
INSERT postalcode
SET f3='1086131',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＢ棟（３１階）';
INSERT postalcode
SET f3='1086290',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（地階・階層不明）';
INSERT postalcode
SET f3='1086201',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（１階）';
INSERT postalcode
SET f3='1086202',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（２階）';
INSERT postalcode
SET f3='1086203',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（３階）';
INSERT postalcode
SET f3='1086204',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（４階）';
INSERT postalcode
SET f3='1086205',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（５階）';
INSERT postalcode
SET f3='1086206',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（６階）';
INSERT postalcode
SET f3='1086207',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（７階）';
INSERT postalcode
SET f3='1086208',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（８階）';
INSERT postalcode
SET f3='1086209',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（９階）';
INSERT postalcode
SET f3='1086210',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（１０階）';
INSERT postalcode
SET f3='1086211',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（１１階）';
INSERT postalcode
SET f3='1086212',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（１２階）';
INSERT postalcode
SET f3='1086213',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（１３階）';
INSERT postalcode
SET f3='1086214',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（１４階）';
INSERT postalcode
SET f3='1086215',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（１５階）';
INSERT postalcode
SET f3='1086216',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（１６階）';
INSERT postalcode
SET f3='1086217',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（１７階）';
INSERT postalcode
SET f3='1086218',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（１８階）';
INSERT postalcode
SET f3='1086219',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（１９階）';
INSERT postalcode
SET f3='1086220',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（２０階）';
INSERT postalcode
SET f3='1086221',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（２１階）';
INSERT postalcode
SET f3='1086222',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（２２階）';
INSERT postalcode
SET f3='1086223',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（２３階）';
INSERT postalcode
SET f3='1086224',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（２４階）';
INSERT postalcode
SET f3='1086225',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（２５階）';
INSERT postalcode
SET f3='1086226',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（２６階）';
INSERT postalcode
SET f3='1086227',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（２７階）';
INSERT postalcode
SET f3='1086228',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（２８階）';
INSERT postalcode
SET f3='1086229',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（２９階）';
INSERT postalcode
SET f3='1086230',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（３０階）';
INSERT postalcode
SET f3='1086231',
    f7='東京都',
    f8='港区',
    f9='港南品川インターシティＣ棟（３１階）';
INSERT postalcode
SET f3='1050014',
    f7='東京都',
    f8='港区',
    f9='芝（１〜３丁目）';
INSERT postalcode
SET f3='1080014',
    f7='東京都',
    f8='港区',
    f9='芝（４、５丁目）';
INSERT postalcode
SET f3='1050023',
    f7='東京都',
    f8='港区',
    f9='芝浦（１丁目）';
INSERT postalcode
SET f3='1080023',
    f7='東京都',
    f8='港区',
    f9='芝浦（２〜４丁目）';
INSERT postalcode
SET f3='1050011',
    f7='東京都',
    f8='港区',
    f9='芝公園';
INSERT postalcode
SET f3='1050012',
    f7='東京都',
    f8='港区',
    f9='芝大門';
INSERT postalcode
SET f3='1080072',
    f7='東京都',
    f8='港区',
    f9='白金';
INSERT postalcode
SET f3='1080071',
    f7='東京都',
    f8='港区',
    f9='白金台';
INSERT postalcode
SET f3='1050004',
    f7='東京都',
    f8='港区',
    f9='新橋';
INSERT postalcode
SET f3='1350091',
    f7='東京都',
    f8='港区',
    f9='台場';
INSERT postalcode
SET f3='1080074',
    f7='東京都',
    f8='港区',
    f9='高輪';
INSERT postalcode
SET f3='1050001',
    f7='東京都',
    f8='港区',
    f9='虎ノ門（次のビルを除く）';
INSERT postalcode
SET f3='1056090',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（地階・階層不明）';
INSERT postalcode
SET f3='1056001',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（１階）';
INSERT postalcode
SET f3='1056002',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（２階）';
INSERT postalcode
SET f3='1056003',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（３階）';
INSERT postalcode
SET f3='1056004',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（４階）';
INSERT postalcode
SET f3='1056005',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（５階）';
INSERT postalcode
SET f3='1056006',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（６階）';
INSERT postalcode
SET f3='1056007',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（７階）';
INSERT postalcode
SET f3='1056008',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（８階）';
INSERT postalcode
SET f3='1056009',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（９階）';
INSERT postalcode
SET f3='1056010',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（１０階）';
INSERT postalcode
SET f3='1056011',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（１１階）';
INSERT postalcode
SET f3='1056012',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（１２階）';
INSERT postalcode
SET f3='1056013',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（１３階）';
INSERT postalcode
SET f3='1056014',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（１４階）';
INSERT postalcode
SET f3='1056015',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（１５階）';
INSERT postalcode
SET f3='1056016',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（１６階）';
INSERT postalcode
SET f3='1056017',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（１７階）';
INSERT postalcode
SET f3='1056018',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（１８階）';
INSERT postalcode
SET f3='1056019',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（１９階）';
INSERT postalcode
SET f3='1056020',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（２０階）';
INSERT postalcode
SET f3='1056021',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（２１階）';
INSERT postalcode
SET f3='1056022',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（２２階）';
INSERT postalcode
SET f3='1056023',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（２３階）';
INSERT postalcode
SET f3='1056024',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（２４階）';
INSERT postalcode
SET f3='1056025',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（２５階）';
INSERT postalcode
SET f3='1056026',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（２６階）';
INSERT postalcode
SET f3='1056027',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（２７階）';
INSERT postalcode
SET f3='1056028',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（２８階）';
INSERT postalcode
SET f3='1056029',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（２９階）';
INSERT postalcode
SET f3='1056030',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（３０階）';
INSERT postalcode
SET f3='1056031',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（３１階）';
INSERT postalcode
SET f3='1056032',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（３２階）';
INSERT postalcode
SET f3='1056033',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（３３階）';
INSERT postalcode
SET f3='1056034',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（３４階）';
INSERT postalcode
SET f3='1056035',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（３５階）';
INSERT postalcode
SET f3='1056036',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（３６階）';
INSERT postalcode
SET f3='1056037',
    f7='東京都',
    f8='港区',
    f9='虎ノ門城山トラストタワー（３７階）';
INSERT postalcode
SET f3='1060031',
    f7='東京都',
    f8='港区',
    f9='西麻布';
INSERT postalcode
SET f3='1050003',
    f7='東京都',
    f8='港区',
    f9='西新橋';
INSERT postalcode
SET f3='1050013',
    f7='東京都',
    f8='港区',
    f9='浜松町（次のビルを除く）';
INSERT postalcode
SET f3='1056190',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（地階・階層不明）';
INSERT postalcode
SET f3='1056101',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（１階）';
INSERT postalcode
SET f3='1056102',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（２階）';
INSERT postalcode
SET f3='1056103',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（３階）';
INSERT postalcode
SET f3='1056104',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（４階）';
INSERT postalcode
SET f3='1056105',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（５階）';
INSERT postalcode
SET f3='1056106',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（６階）';
INSERT postalcode
SET f3='1056107',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（７階）';
INSERT postalcode
SET f3='1056108',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（８階）';
INSERT postalcode
SET f3='1056109',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（９階）';
INSERT postalcode
SET f3='1056110',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（１０階）';
INSERT postalcode
SET f3='1056111',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（１１階）';
INSERT postalcode
SET f3='1056112',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（１２階）';
INSERT postalcode
SET f3='1056113',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（１３階）';
INSERT postalcode
SET f3='1056114',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（１４階）';
INSERT postalcode
SET f3='1056115',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（１５階）';
INSERT postalcode
SET f3='1056116',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（１６階）';
INSERT postalcode
SET f3='1056117',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（１７階）';
INSERT postalcode
SET f3='1056118',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（１８階）';
INSERT postalcode
SET f3='1056119',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（１９階）';
INSERT postalcode
SET f3='1056120',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（２０階）';
INSERT postalcode
SET f3='1056121',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（２１階）';
INSERT postalcode
SET f3='1056122',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（２２階）';
INSERT postalcode
SET f3='1056123',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（２３階）';
INSERT postalcode
SET f3='1056124',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（２４階）';
INSERT postalcode
SET f3='1056125',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（２５階）';
INSERT postalcode
SET f3='1056126',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（２６階）';
INSERT postalcode
SET f3='1056127',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（２７階）';
INSERT postalcode
SET f3='1056128',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（２８階）';
INSERT postalcode
SET f3='1056129',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（２９階）';
INSERT postalcode
SET f3='1056130',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（３０階）';
INSERT postalcode
SET f3='1056131',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（３１階）';
INSERT postalcode
SET f3='1056132',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（３２階）';
INSERT postalcode
SET f3='1056133',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（３３階）';
INSERT postalcode
SET f3='1056134',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（３４階）';
INSERT postalcode
SET f3='1056135',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（３５階）';
INSERT postalcode
SET f3='1056136',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（３６階）';
INSERT postalcode
SET f3='1056137',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（３７階）';
INSERT postalcode
SET f3='1056138',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（３８階）';
INSERT postalcode
SET f3='1056139',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（３９階）';
INSERT postalcode
SET f3='1056140',
    f7='東京都',
    f8='港区',
    f9='浜松町世界貿易センタービル（４０階）';
INSERT postalcode
SET f3='1060044',
    f7='東京都',
    f8='港区',
    f9='東麻布';
INSERT postalcode
SET f3='1050021',
    f7='東京都',
    f8='港区',
    f9='東新橋（次のビルを除く）';
INSERT postalcode
SET f3='1057190',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（地階・階層不明）';
INSERT postalcode
SET f3='1057101',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（１階）';
INSERT postalcode
SET f3='1057102',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（２階）';
INSERT postalcode
SET f3='1057103',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（３階）';
INSERT postalcode
SET f3='1057104',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（４階）';
INSERT postalcode
SET f3='1057105',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（５階）';
INSERT postalcode
SET f3='1057106',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（６階）';
INSERT postalcode
SET f3='1057107',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（７階）';
INSERT postalcode
SET f3='1057108',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（８階）';
INSERT postalcode
SET f3='1057109',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（９階）';
INSERT postalcode
SET f3='1057110',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（１０階）';
INSERT postalcode
SET f3='1057111',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（１１階）';
INSERT postalcode
SET f3='1057112',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（１２階）';
INSERT postalcode
SET f3='1057113',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（１３階）';
INSERT postalcode
SET f3='1057114',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（１４階）';
INSERT postalcode
SET f3='1057115',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（１５階）';
INSERT postalcode
SET f3='1057116',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（１６階）';
INSERT postalcode
SET f3='1057117',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（１７階）';
INSERT postalcode
SET f3='1057118',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（１８階）';
INSERT postalcode
SET f3='1057119',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（１９階）';
INSERT postalcode
SET f3='1057120',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（２０階）';
INSERT postalcode
SET f3='1057121',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（２１階）';
INSERT postalcode
SET f3='1057122',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（２２階）';
INSERT postalcode
SET f3='1057123',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（２３階）';
INSERT postalcode
SET f3='1057124',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（２４階）';
INSERT postalcode
SET f3='1057125',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（２５階）';
INSERT postalcode
SET f3='1057126',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（２６階）';
INSERT postalcode
SET f3='1057127',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（２７階）';
INSERT postalcode
SET f3='1057128',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（２８階）';
INSERT postalcode
SET f3='1057129',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（２９階）';
INSERT postalcode
SET f3='1057130',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（３０階）';
INSERT postalcode
SET f3='1057131',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（３１階）';
INSERT postalcode
SET f3='1057132',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（３２階）';
INSERT postalcode
SET f3='1057133',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（３３階）';
INSERT postalcode
SET f3='1057134',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（３４階）';
INSERT postalcode
SET f3='1057135',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（３５階）';
INSERT postalcode
SET f3='1057136',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（３６階）';
INSERT postalcode
SET f3='1057137',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（３７階）';
INSERT postalcode
SET f3='1057138',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（３８階）';
INSERT postalcode
SET f3='1057139',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（３９階）';
INSERT postalcode
SET f3='1057140',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（４０階）';
INSERT postalcode
SET f3='1057141',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（４１階）';
INSERT postalcode
SET f3='1057142',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（４２階）';
INSERT postalcode
SET f3='1057143',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留シティセンター（４３階）';
INSERT postalcode
SET f3='1057290',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（地階・階層不明）';
INSERT postalcode
SET f3='1057201',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（１階）';
INSERT postalcode
SET f3='1057202',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（２階）';
INSERT postalcode
SET f3='1057203',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（３階）';
INSERT postalcode
SET f3='1057204',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（４階）';
INSERT postalcode
SET f3='1057205',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（５階）';
INSERT postalcode
SET f3='1057206',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（６階）';
INSERT postalcode
SET f3='1057207',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（７階）';
INSERT postalcode
SET f3='1057208',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（８階）';
INSERT postalcode
SET f3='1057209',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（９階）';
INSERT postalcode
SET f3='1057210',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（１０階）';
INSERT postalcode
SET f3='1057211',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（１１階）';
INSERT postalcode
SET f3='1057212',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（１２階）';
INSERT postalcode
SET f3='1057213',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（１３階）';
INSERT postalcode
SET f3='1057214',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（１４階）';
INSERT postalcode
SET f3='1057215',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（１５階）';
INSERT postalcode
SET f3='1057216',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（１６階）';
INSERT postalcode
SET f3='1057217',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（１７階）';
INSERT postalcode
SET f3='1057218',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（１８階）';
INSERT postalcode
SET f3='1057219',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（１９階）';
INSERT postalcode
SET f3='1057220',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（２０階）';
INSERT postalcode
SET f3='1057221',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（２１階）';
INSERT postalcode
SET f3='1057222',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（２２階）';
INSERT postalcode
SET f3='1057223',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（２３階）';
INSERT postalcode
SET f3='1057224',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（２４階）';
INSERT postalcode
SET f3='1057225',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（２５階）';
INSERT postalcode
SET f3='1057226',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（２６階）';
INSERT postalcode
SET f3='1057227',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（２７階）';
INSERT postalcode
SET f3='1057228',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（２８階）';
INSERT postalcode
SET f3='1057229',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（２９階）';
INSERT postalcode
SET f3='1057230',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（３０階）';
INSERT postalcode
SET f3='1057231',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（３１階）';
INSERT postalcode
SET f3='1057232',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（３２階）';
INSERT postalcode
SET f3='1057233',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（３３階）';
INSERT postalcode
SET f3='1057234',
    f7='東京都',
    f8='港区',
    f9='東新橋汐留メディアタワー（３４階）';
INSERT postalcode
SET f3='1057090',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（地階・階層不明）';
INSERT postalcode
SET f3='1057001',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（１階）';
INSERT postalcode
SET f3='1057002',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（２階）';
INSERT postalcode
SET f3='1057003',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（３階）';
INSERT postalcode
SET f3='1057004',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（４階）';
INSERT postalcode
SET f3='1057005',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（５階）';
INSERT postalcode
SET f3='1057006',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（６階）';
INSERT postalcode
SET f3='1057007',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（７階）';
INSERT postalcode
SET f3='1057008',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（８階）';
INSERT postalcode
SET f3='1057009',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（９階）';
INSERT postalcode
SET f3='1057010',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（１０階）';
INSERT postalcode
SET f3='1057011',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（１１階）';
INSERT postalcode
SET f3='1057012',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（１２階）';
INSERT postalcode
SET f3='1057013',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（１３階）';
INSERT postalcode
SET f3='1057014',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（１４階）';
INSERT postalcode
SET f3='1057015',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（１５階）';
INSERT postalcode
SET f3='1057016',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（１６階）';
INSERT postalcode
SET f3='1057017',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（１７階）';
INSERT postalcode
SET f3='1057018',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（１８階）';
INSERT postalcode
SET f3='1057019',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（１９階）';
INSERT postalcode
SET f3='1057020',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（２０階）';
INSERT postalcode
SET f3='1057021',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（２１階）';
INSERT postalcode
SET f3='1057022',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（２２階）';
INSERT postalcode
SET f3='1057023',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（２３階）';
INSERT postalcode
SET f3='1057024',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（２４階）';
INSERT postalcode
SET f3='1057025',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（２５階）';
INSERT postalcode
SET f3='1057026',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（２６階）';
INSERT postalcode
SET f3='1057027',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（２７階）';
INSERT postalcode
SET f3='1057028',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（２８階）';
INSERT postalcode
SET f3='1057029',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（２９階）';
INSERT postalcode
SET f3='1057030',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（３０階）';
INSERT postalcode
SET f3='1057031',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（３１階）';
INSERT postalcode
SET f3='1057032',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（３２階）';
INSERT postalcode
SET f3='1057033',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（３３階）';
INSERT postalcode
SET f3='1057034',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（３４階）';
INSERT postalcode
SET f3='1057035',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（３５階）';
INSERT postalcode
SET f3='1057036',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（３６階）';
INSERT postalcode
SET f3='1057037',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（３７階）';
INSERT postalcode
SET f3='1057038',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（３８階）';
INSERT postalcode
SET f3='1057039',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（３９階）';
INSERT postalcode
SET f3='1057040',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（４０階）';
INSERT postalcode
SET f3='1057041',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（４１階）';
INSERT postalcode
SET f3='1057042',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（４２階）';
INSERT postalcode
SET f3='1057043',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（４３階）';
INSERT postalcode
SET f3='1057044',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（４４階）';
INSERT postalcode
SET f3='1057045',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（４５階）';
INSERT postalcode
SET f3='1057046',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（４６階）';
INSERT postalcode
SET f3='1057047',
    f7='東京都',
    f8='港区',
    f9='東新橋電通本社ビル（４７階）';
INSERT postalcode
SET f3='1057390',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（地階・階層不明）';
INSERT postalcode
SET f3='1057301',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（１階）';
INSERT postalcode
SET f3='1057302',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（２階）';
INSERT postalcode
SET f3='1057303',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（３階）';
INSERT postalcode
SET f3='1057304',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（４階）';
INSERT postalcode
SET f3='1057305',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（５階）';
INSERT postalcode
SET f3='1057306',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（６階）';
INSERT postalcode
SET f3='1057307',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（７階）';
INSERT postalcode
SET f3='1057308',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（８階）';
INSERT postalcode
SET f3='1057309',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（９階）';
INSERT postalcode
SET f3='1057310',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（１０階）';
INSERT postalcode
SET f3='1057311',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（１１階）';
INSERT postalcode
SET f3='1057312',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（１２階）';
INSERT postalcode
SET f3='1057313',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（１３階）';
INSERT postalcode
SET f3='1057314',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（１４階）';
INSERT postalcode
SET f3='1057315',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（１５階）';
INSERT postalcode
SET f3='1057316',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（１６階）';
INSERT postalcode
SET f3='1057317',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（１７階）';
INSERT postalcode
SET f3='1057318',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（１８階）';
INSERT postalcode
SET f3='1057319',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（１９階）';
INSERT postalcode
SET f3='1057320',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（２０階）';
INSERT postalcode
SET f3='1057321',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（２１階）';
INSERT postalcode
SET f3='1057322',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（２２階）';
INSERT postalcode
SET f3='1057323',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（２３階）';
INSERT postalcode
SET f3='1057324',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（２４階）';
INSERT postalcode
SET f3='1057325',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（２５階）';
INSERT postalcode
SET f3='1057326',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（２６階）';
INSERT postalcode
SET f3='1057327',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（２７階）';
INSERT postalcode
SET f3='1057328',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（２８階）';
INSERT postalcode
SET f3='1057329',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（２９階）';
INSERT postalcode
SET f3='1057330',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（３０階）';
INSERT postalcode
SET f3='1057331',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（３１階）';
INSERT postalcode
SET f3='1057332',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（３２階）';
INSERT postalcode
SET f3='1057333',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（３３階）';
INSERT postalcode
SET f3='1057334',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（３４階）';
INSERT postalcode
SET f3='1057335',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（３５階）';
INSERT postalcode
SET f3='1057336',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（３６階）';
INSERT postalcode
SET f3='1057337',
    f7='東京都',
    f8='港区',
    f9='東新橋東京汐留ビルディング（３７階）';
INSERT postalcode
SET f3='1057490',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（地階・階層不明）';
INSERT postalcode
SET f3='1057401',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（１階）';
INSERT postalcode
SET f3='1057402',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（２階）';
INSERT postalcode
SET f3='1057403',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（３階）';
INSERT postalcode
SET f3='1057404',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（４階）';
INSERT postalcode
SET f3='1057405',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（５階）';
INSERT postalcode
SET f3='1057406',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（６階）';
INSERT postalcode
SET f3='1057407',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（７階）';
INSERT postalcode
SET f3='1057408',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（８階）';
INSERT postalcode
SET f3='1057409',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（９階）';
INSERT postalcode
SET f3='1057410',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（１０階）';
INSERT postalcode
SET f3='1057411',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（１１階）';
INSERT postalcode
SET f3='1057412',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（１２階）';
INSERT postalcode
SET f3='1057413',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（１３階）';
INSERT postalcode
SET f3='1057414',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（１４階）';
INSERT postalcode
SET f3='1057415',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（１５階）';
INSERT postalcode
SET f3='1057416',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（１６階）';
INSERT postalcode
SET f3='1057417',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（１７階）';
INSERT postalcode
SET f3='1057418',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（１８階）';
INSERT postalcode
SET f3='1057419',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（１９階）';
INSERT postalcode
SET f3='1057420',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（２０階）';
INSERT postalcode
SET f3='1057421',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（２１階）';
INSERT postalcode
SET f3='1057422',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（２２階）';
INSERT postalcode
SET f3='1057423',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（２３階）';
INSERT postalcode
SET f3='1057424',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（２４階）';
INSERT postalcode
SET f3='1057425',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（２５階）';
INSERT postalcode
SET f3='1057426',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（２６階）';
INSERT postalcode
SET f3='1057427',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（２７階）';
INSERT postalcode
SET f3='1057428',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（２８階）';
INSERT postalcode
SET f3='1057429',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（２９階）';
INSERT postalcode
SET f3='1057430',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（３０階）';
INSERT postalcode
SET f3='1057431',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（３１階）';
INSERT postalcode
SET f3='1057432',
    f7='東京都',
    f8='港区',
    f9='東新橋日本テレビタワー（３２階）';
INSERT postalcode
SET f3='1080073',
    f7='東京都',
    f8='港区',
    f9='三田（次のビルを除く）';
INSERT postalcode
SET f3='1086390',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（地階・階層不明）';
INSERT postalcode
SET f3='1086301',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（１階）';
INSERT postalcode
SET f3='1086302',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（２階）';
INSERT postalcode
SET f3='1086303',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（３階）';
INSERT postalcode
SET f3='1086304',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（４階）';
INSERT postalcode
SET f3='1086305',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（５階）';
INSERT postalcode
SET f3='1086306',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（６階）';
INSERT postalcode
SET f3='1086307',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（７階）';
INSERT postalcode
SET f3='1086308',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（８階）';
INSERT postalcode
SET f3='1086309',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（９階）';
INSERT postalcode
SET f3='1086310',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（１０階）';
INSERT postalcode
SET f3='1086311',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（１１階）';
INSERT postalcode
SET f3='1086312',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（１２階）';
INSERT postalcode
SET f3='1086313',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（１３階）';
INSERT postalcode
SET f3='1086314',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（１４階）';
INSERT postalcode
SET f3='1086315',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（１５階）';
INSERT postalcode
SET f3='1086316',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（１６階）';
INSERT postalcode
SET f3='1086317',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（１７階）';
INSERT postalcode
SET f3='1086318',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（１８階）';
INSERT postalcode
SET f3='1086319',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（１９階）';
INSERT postalcode
SET f3='1086320',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（２０階）';
INSERT postalcode
SET f3='1086321',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（２１階）';
INSERT postalcode
SET f3='1086322',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（２２階）';
INSERT postalcode
SET f3='1086323',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（２３階）';
INSERT postalcode
SET f3='1086324',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（２４階）';
INSERT postalcode
SET f3='1086325',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（２５階）';
INSERT postalcode
SET f3='1086326',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（２６階）';
INSERT postalcode
SET f3='1086327',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（２７階）';
INSERT postalcode
SET f3='1086328',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（２８階）';
INSERT postalcode
SET f3='1086329',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（２９階）';
INSERT postalcode
SET f3='1086330',
    f7='東京都',
    f8='港区',
    f9='三田住友不動産三田ツインビル西館（３０階）';
INSERT postalcode
SET f3='1070062',
    f7='東京都',
    f8='港区',
    f9='南青山';
INSERT postalcode
SET f3='1060047',
    f7='東京都',
    f8='港区',
    f9='南麻布';
INSERT postalcode
SET f3='1070051',
    f7='東京都',
    f8='港区',
    f9='元赤坂';
INSERT postalcode
SET f3='1060046',
    f7='東京都',
    f8='港区',
    f9='元麻布';
INSERT postalcode
SET f3='1060032',
    f7='東京都',
    f8='港区',
    f9='六本木（次のビルを除く）';
INSERT postalcode
SET f3='1066090',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（地階・階層不明）';
INSERT postalcode
SET f3='1066001',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（１階）';
INSERT postalcode
SET f3='1066002',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（２階）';
INSERT postalcode
SET f3='1066003',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（３階）';
INSERT postalcode
SET f3='1066004',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（４階）';
INSERT postalcode
SET f3='1066005',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（５階）';
INSERT postalcode
SET f3='1066006',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（６階）';
INSERT postalcode
SET f3='1066007',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（７階）';
INSERT postalcode
SET f3='1066008',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（８階）';
INSERT postalcode
SET f3='1066009',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（９階）';
INSERT postalcode
SET f3='1066010',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（１０階）';
INSERT postalcode
SET f3='1066011',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（１１階）';
INSERT postalcode
SET f3='1066012',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（１２階）';
INSERT postalcode
SET f3='1066013',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（１３階）';
INSERT postalcode
SET f3='1066014',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（１４階）';
INSERT postalcode
SET f3='1066015',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（１５階）';
INSERT postalcode
SET f3='1066016',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（１６階）';
INSERT postalcode
SET f3='1066017',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（１７階）';
INSERT postalcode
SET f3='1066018',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（１８階）';
INSERT postalcode
SET f3='1066019',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（１９階）';
INSERT postalcode
SET f3='1066020',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（２０階）';
INSERT postalcode
SET f3='1066021',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（２１階）';
INSERT postalcode
SET f3='1066022',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（２２階）';
INSERT postalcode
SET f3='1066023',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（２３階）';
INSERT postalcode
SET f3='1066024',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（２４階）';
INSERT postalcode
SET f3='1066025',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（２５階）';
INSERT postalcode
SET f3='1066026',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（２６階）';
INSERT postalcode
SET f3='1066027',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（２７階）';
INSERT postalcode
SET f3='1066028',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（２８階）';
INSERT postalcode
SET f3='1066029',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（２９階）';
INSERT postalcode
SET f3='1066030',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（３０階）';
INSERT postalcode
SET f3='1066031',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（３１階）';
INSERT postalcode
SET f3='1066032',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（３２階）';
INSERT postalcode
SET f3='1066033',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（３３階）';
INSERT postalcode
SET f3='1066034',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（３４階）';
INSERT postalcode
SET f3='1066035',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（３５階）';
INSERT postalcode
SET f3='1066036',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（３６階）';
INSERT postalcode
SET f3='1066037',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（３７階）';
INSERT postalcode
SET f3='1066038',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（３８階）';
INSERT postalcode
SET f3='1066039',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（３９階）';
INSERT postalcode
SET f3='1066040',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（４０階）';
INSERT postalcode
SET f3='1066041',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（４１階）';
INSERT postalcode
SET f3='1066042',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（４２階）';
INSERT postalcode
SET f3='1066043',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（４３階）';
INSERT postalcode
SET f3='1066044',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（４４階）';
INSERT postalcode
SET f3='1066045',
    f7='東京都',
    f8='港区',
    f9='六本木泉ガーデンタワー（４５階）';
INSERT postalcode
SET f3='1066190',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（地階・階層不明）';
INSERT postalcode
SET f3='1066101',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（１階）';
INSERT postalcode
SET f3='1066102',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（２階）';
INSERT postalcode
SET f3='1066103',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（３階）';
INSERT postalcode
SET f3='1066104',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（４階）';
INSERT postalcode
SET f3='1066105',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（５階）';
INSERT postalcode
SET f3='1066106',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（６階）';
INSERT postalcode
SET f3='1066107',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（７階）';
INSERT postalcode
SET f3='1066108',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（８階）';
INSERT postalcode
SET f3='1066109',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（９階）';
INSERT postalcode
SET f3='1066110',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（１０階）';
INSERT postalcode
SET f3='1066111',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（１１階）';
INSERT postalcode
SET f3='1066112',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（１２階）';
INSERT postalcode
SET f3='1066113',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（１３階）';
INSERT postalcode
SET f3='1066114',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（１４階）';
INSERT postalcode
SET f3='1066115',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（１５階）';
INSERT postalcode
SET f3='1066116',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（１６階）';
INSERT postalcode
SET f3='1066117',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（１７階）';
INSERT postalcode
SET f3='1066118',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（１８階）';
INSERT postalcode
SET f3='1066119',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（１９階）';
INSERT postalcode
SET f3='1066120',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（２０階）';
INSERT postalcode
SET f3='1066121',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（２１階）';
INSERT postalcode
SET f3='1066122',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（２２階）';
INSERT postalcode
SET f3='1066123',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（２３階）';
INSERT postalcode
SET f3='1066124',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（２４階）';
INSERT postalcode
SET f3='1066125',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（２５階）';
INSERT postalcode
SET f3='1066126',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（２６階）';
INSERT postalcode
SET f3='1066127',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（２７階）';
INSERT postalcode
SET f3='1066128',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（２８階）';
INSERT postalcode
SET f3='1066129',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（２９階）';
INSERT postalcode
SET f3='1066130',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（３０階）';
INSERT postalcode
SET f3='1066131',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（３１階）';
INSERT postalcode
SET f3='1066132',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（３２階）';
INSERT postalcode
SET f3='1066133',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（３３階）';
INSERT postalcode
SET f3='1066134',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（３４階）';
INSERT postalcode
SET f3='1066135',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（３５階）';
INSERT postalcode
SET f3='1066136',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（３６階）';
INSERT postalcode
SET f3='1066137',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（３７階）';
INSERT postalcode
SET f3='1066138',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（３８階）';
INSERT postalcode
SET f3='1066139',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（３９階）';
INSERT postalcode
SET f3='1066140',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（４０階）';
INSERT postalcode
SET f3='1066141',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（４１階）';
INSERT postalcode
SET f3='1066142',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（４２階）';
INSERT postalcode
SET f3='1066143',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（４３階）';
INSERT postalcode
SET f3='1066144',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（４４階）';
INSERT postalcode
SET f3='1066145',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（４５階）';
INSERT postalcode
SET f3='1066146',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（４６階）';
INSERT postalcode
SET f3='1066147',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（４７階）';
INSERT postalcode
SET f3='1066148',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（４８階）';
INSERT postalcode
SET f3='1066149',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（４９階）';
INSERT postalcode
SET f3='1066150',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（５０階）';
INSERT postalcode
SET f3='1066151',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（５１階）';
INSERT postalcode
SET f3='1066152',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（５２階）';
INSERT postalcode
SET f3='1066153',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（５３階）';
INSERT postalcode
SET f3='1066154',
    f7='東京都',
    f8='港区',
    f9='六本木六本木ヒルズ森タワー（５４階）';
INSERT postalcode
SET f3='1600000',
    f7='東京都',
    f8='新宿区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1600005',
    f7='東京都',
    f8='新宿区',
    f9='愛住町';
INSERT postalcode
SET f3='1620803',
    f7='東京都',
    f8='新宿区',
    f9='赤城下町';
INSERT postalcode
SET f3='1620817',
    f7='東京都',
    f8='新宿区',
    f9='赤城元町';
INSERT postalcode
SET f3='1620824',
    f7='東京都',
    f8='新宿区',
    f9='揚場町';
INSERT postalcode
SET f3='1600007',
    f7='東京都',
    f8='新宿区',
    f9='荒木町';
INSERT postalcode
SET f3='1620062',
    f7='東京都',
    f8='新宿区',
    f9='市谷加賀町';
INSERT postalcode
SET f3='1620856',
    f7='東京都',
    f8='新宿区',
    f9='市谷甲良町';
INSERT postalcode
SET f3='1620842',
    f7='東京都',
    f8='新宿区',
    f9='市谷砂土原町';
INSERT postalcode
SET f3='1620846',
    f7='東京都',
    f8='新宿区',
    f9='市谷左内町';
INSERT postalcode
SET f3='1620848',
    f7='東京都',
    f8='新宿区',
    f9='市谷鷹匠町';
INSERT postalcode
SET f3='1620843',
    f7='東京都',
    f8='新宿区',
    f9='市谷田町';
INSERT postalcode
SET f3='1620066',
    f7='東京都',
    f8='新宿区',
    f9='市谷台町';
INSERT postalcode
SET f3='1620847',
    f7='東京都',
    f8='新宿区',
    f9='市谷長延寺町';
INSERT postalcode
SET f3='1620064',
    f7='東京都',
    f8='新宿区',
    f9='市谷仲之町';
INSERT postalcode
SET f3='1620844',
    f7='東京都',
    f8='新宿区',
    f9='市谷八幡町';
INSERT postalcode
SET f3='1620826',
    f7='東京都',
    f8='新宿区',
    f9='市谷船河原町';
INSERT postalcode
SET f3='1620845',
    f7='東京都',
    f8='新宿区',
    f9='市谷本村町';
INSERT postalcode
SET f3='1620063',
    f7='東京都',
    f8='新宿区',
    f9='市谷薬王寺町';
INSERT postalcode
SET f3='1620061',
    f7='東京都',
    f8='新宿区',
    f9='市谷柳町';
INSERT postalcode
SET f3='1620857',
    f7='東京都',
    f8='新宿区',
    f9='市谷山伏町';
INSERT postalcode
SET f3='1620832',
    f7='東京都',
    f8='新宿区',
    f9='岩戸町';
INSERT postalcode
SET f3='1620806',
    f7='東京都',
    f8='新宿区',
    f9='榎町';
INSERT postalcode
SET f3='1690072',
    f7='東京都',
    f8='新宿区',
    f9='大久保';
INSERT postalcode
SET f3='1620802',
    f7='東京都',
    f8='新宿区',
    f9='改代町';
INSERT postalcode
SET f3='1620823',
    f7='東京都',
    f8='新宿区',
    f9='神楽河岸';
INSERT postalcode
SET f3='1620825',
    f7='東京都',
    f8='新宿区',
    f9='神楽坂';
INSERT postalcode
SET f3='1600013',
    f7='東京都',
    f8='新宿区',
    f9='霞ケ丘町';
INSERT postalcode
SET f3='1600001',
    f7='東京都',
    f8='新宿区',
    f9='片町';
INSERT postalcode
SET f3='1600021',
    f7='東京都',
    f8='新宿区',
    f9='歌舞伎町';
INSERT postalcode
SET f3='1610034',
    f7='東京都',
    f8='新宿区',
    f9='上落合';
INSERT postalcode
SET f3='1620054',
    f7='東京都',
    f8='新宿区',
    f9='河田町';
INSERT postalcode
SET f3='1620044',
    f7='東京都',
    f8='新宿区',
    f9='喜久井町';
INSERT postalcode
SET f3='1690074',
    f7='東京都',
    f8='新宿区',
    f9='北新宿';
INSERT postalcode
SET f3='1620834',
    f7='東京都',
    f8='新宿区',
    f9='北町';
INSERT postalcode
SET f3='1620853',
    f7='東京都',
    f8='新宿区',
    f9='北山伏町';
INSERT postalcode
SET f3='1620838',
    f7='東京都',
    f8='新宿区',
    f9='細工町';
INSERT postalcode
SET f3='1600002',
    f7='東京都',
    f8='新宿区',
    f9='坂町';
INSERT postalcode
SET f3='1600017',
    f7='東京都',
    f8='新宿区',
    f9='左門町';
INSERT postalcode
SET f3='1600008',
    f7='東京都',
    f8='新宿区',
    f9='三栄町';
INSERT postalcode
SET f3='1600016',
    f7='東京都',
    f8='新宿区',
    f9='信濃町';
INSERT postalcode
SET f3='1610033',
    f7='東京都',
    f8='新宿区',
    f9='下落合';
INSERT postalcode
SET f3='1620822',
    f7='東京都',
    f8='新宿区',
    f9='下宮比町';
INSERT postalcode
SET f3='1620816',
    f7='東京都',
    f8='新宿区',
    f9='白銀町';
INSERT postalcode
SET f3='1620814',
    f7='東京都',
    f8='新宿区',
    f9='新小川町';
INSERT postalcode
SET f3='1600022',
    f7='東京都',
    f8='新宿区',
    f9='新宿';
INSERT postalcode
SET f3='1620811',
    f7='東京都',
    f8='新宿区',
    f9='水道町';
INSERT postalcode
SET f3='1600018',
    f7='東京都',
    f8='新宿区',
    f9='須賀町';
INSERT postalcode
SET f3='1620065',
    f7='東京都',
    f8='新宿区',
    f9='住吉町';
INSERT postalcode
SET f3='1600015',
    f7='東京都',
    f8='新宿区',
    f9='大京町';
INSERT postalcode
SET f3='1690075',
    f7='東京都',
    f8='新宿区',
    f9='高田馬場';
INSERT postalcode
SET f3='1620833',
    f7='東京都',
    f8='新宿区',
    f9='箪笥町';
INSERT postalcode
SET f3='1620818',
    f7='東京都',
    f8='新宿区',
    f9='築地町';
INSERT postalcode
SET f3='1620821',
    f7='東京都',
    f8='新宿区',
    f9='津久戸町';
INSERT postalcode
SET f3='1620815',
    f7='東京都',
    f8='新宿区',
    f9='筑土八幡町';
INSERT postalcode
SET f3='1620808',
    f7='東京都',
    f8='新宿区',
    f9='天神町';
INSERT postalcode
SET f3='1690071',
    f7='東京都',
    f8='新宿区',
    f9='戸塚町';
INSERT postalcode
SET f3='1620067',
    f7='東京都',
    f8='新宿区',
    f9='富久町';
INSERT postalcode
SET f3='1690052',
    f7='東京都',
    f8='新宿区',
    f9='戸山（３丁目１８・２１番）';
INSERT postalcode
SET f3='1620052',
    f7='東京都',
    f8='新宿区',
    f9='戸山（その他）';
INSERT postalcode
SET f3='1600014',
    f7='東京都',
    f8='新宿区',
    f9='内藤町';
INSERT postalcode
SET f3='1610035',
    f7='東京都',
    f8='新宿区',
    f9='中井';
INSERT postalcode
SET f3='1610032',
    f7='東京都',
    f8='新宿区',
    f9='中落合';
INSERT postalcode
SET f3='1620804',
    f7='東京都',
    f8='新宿区',
    f9='中里町';
INSERT postalcode
SET f3='1620835',
    f7='東京都',
    f8='新宿区',
    f9='中町';
INSERT postalcode
SET f3='1620837',
    f7='東京都',
    f8='新宿区',
    f9='納戸町';
INSERT postalcode
SET f3='1610031',
    f7='東京都',
    f8='新宿区',
    f9='西落合';
INSERT postalcode
SET f3='1620812',
    f7='東京都',
    f8='新宿区',
    f9='西五軒町';
INSERT postalcode
SET f3='1600023',
    f7='東京都',
    f8='新宿区',
    f9='西新宿（次のビルを除く）';
INSERT postalcode
SET f3='1631390',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（地階・階層不明）';
INSERT postalcode
SET f3='1631301',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（１階）';
INSERT postalcode
SET f3='1631302',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（２階）';
INSERT postalcode
SET f3='1631303',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（３階）';
INSERT postalcode
SET f3='1631304',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（４階）';
INSERT postalcode
SET f3='1631305',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（５階）';
INSERT postalcode
SET f3='1631306',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（６階）';
INSERT postalcode
SET f3='1631307',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（７階）';
INSERT postalcode
SET f3='1631308',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（８階）';
INSERT postalcode
SET f3='1631309',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（９階）';
INSERT postalcode
SET f3='1631310',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（１０階）';
INSERT postalcode
SET f3='1631311',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（１１階）';
INSERT postalcode
SET f3='1631312',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（１２階）';
INSERT postalcode
SET f3='1631313',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（１３階）';
INSERT postalcode
SET f3='1631314',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（１４階）';
INSERT postalcode
SET f3='1631315',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（１５階）';
INSERT postalcode
SET f3='1631316',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（１６階）';
INSERT postalcode
SET f3='1631317',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（１７階）';
INSERT postalcode
SET f3='1631318',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（１８階）';
INSERT postalcode
SET f3='1631319',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（１９階）';
INSERT postalcode
SET f3='1631320',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（２０階）';
INSERT postalcode
SET f3='1631321',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（２１階）';
INSERT postalcode
SET f3='1631322',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（２２階）';
INSERT postalcode
SET f3='1631323',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（２３階）';
INSERT postalcode
SET f3='1631324',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（２４階）';
INSERT postalcode
SET f3='1631325',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（２５階）';
INSERT postalcode
SET f3='1631326',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（２６階）';
INSERT postalcode
SET f3='1631327',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（２７階）';
INSERT postalcode
SET f3='1631328',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（２８階）';
INSERT postalcode
SET f3='1631329',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（２９階）';
INSERT postalcode
SET f3='1631330',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（３０階）';
INSERT postalcode
SET f3='1631331',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（３１階）';
INSERT postalcode
SET f3='1631332',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（３２階）';
INSERT postalcode
SET f3='1631333',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（３３階）';
INSERT postalcode
SET f3='1631334',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（３４階）';
INSERT postalcode
SET f3='1631335',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（３５階）';
INSERT postalcode
SET f3='1631336',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（３６階）';
INSERT postalcode
SET f3='1631337',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（３７階）';
INSERT postalcode
SET f3='1631338',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（３８階）';
INSERT postalcode
SET f3='1631339',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（３９階）';
INSERT postalcode
SET f3='1631340',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（４０階）';
INSERT postalcode
SET f3='1631341',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（４１階）';
INSERT postalcode
SET f3='1631342',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（４２階）';
INSERT postalcode
SET f3='1631343',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（４３階）';
INSERT postalcode
SET f3='1631344',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿アイランドタワー（４４階）';
INSERT postalcode
SET f3='1630890',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（地階・階層不明）';
INSERT postalcode
SET f3='1630801',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（１階）';
INSERT postalcode
SET f3='1630802',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（２階）';
INSERT postalcode
SET f3='1630803',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（３階）';
INSERT postalcode
SET f3='1630804',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（４階）';
INSERT postalcode
SET f3='1630805',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（５階）';
INSERT postalcode
SET f3='1630806',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（６階）';
INSERT postalcode
SET f3='1630807',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（７階）';
INSERT postalcode
SET f3='1630808',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（８階）';
INSERT postalcode
SET f3='1630809',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（９階）';
INSERT postalcode
SET f3='1630810',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（１０階）';
INSERT postalcode
SET f3='1630811',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（１１階）';
INSERT postalcode
SET f3='1630812',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（１２階）';
INSERT postalcode
SET f3='1630813',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（１３階）';
INSERT postalcode
SET f3='1630814',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（１４階）';
INSERT postalcode
SET f3='1630815',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（１５階）';
INSERT postalcode
SET f3='1630816',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（１６階）';
INSERT postalcode
SET f3='1630817',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（１７階）';
INSERT postalcode
SET f3='1630818',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（１８階）';
INSERT postalcode
SET f3='1630819',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（１９階）';
INSERT postalcode
SET f3='1630820',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（２０階）';
INSERT postalcode
SET f3='1630821',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（２１階）';
INSERT postalcode
SET f3='1630822',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（２２階）';
INSERT postalcode
SET f3='1630823',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（２３階）';
INSERT postalcode
SET f3='1630824',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（２４階）';
INSERT postalcode
SET f3='1630825',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（２５階）';
INSERT postalcode
SET f3='1630826',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（２６階）';
INSERT postalcode
SET f3='1630827',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（２７階）';
INSERT postalcode
SET f3='1630828',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（２８階）';
INSERT postalcode
SET f3='1630829',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（２９階）';
INSERT postalcode
SET f3='1630830',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿ＮＳビル（３０階）';
INSERT postalcode
SET f3='1631590',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（地階・階層不明）';
INSERT postalcode
SET f3='1631501',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（１階）';
INSERT postalcode
SET f3='1631502',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（２階）';
INSERT postalcode
SET f3='1631503',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（３階）';
INSERT postalcode
SET f3='1631504',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（４階）';
INSERT postalcode
SET f3='1631505',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（５階）';
INSERT postalcode
SET f3='1631506',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（６階）';
INSERT postalcode
SET f3='1631507',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（７階）';
INSERT postalcode
SET f3='1631508',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（８階）';
INSERT postalcode
SET f3='1631509',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（９階）';
INSERT postalcode
SET f3='1631510',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（１０階）';
INSERT postalcode
SET f3='1631511',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（１１階）';
INSERT postalcode
SET f3='1631512',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（１２階）';
INSERT postalcode
SET f3='1631513',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（１３階）';
INSERT postalcode
SET f3='1631514',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（１４階）';
INSERT postalcode
SET f3='1631515',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（１５階）';
INSERT postalcode
SET f3='1631516',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（１６階）';
INSERT postalcode
SET f3='1631517',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（１７階）';
INSERT postalcode
SET f3='1631518',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（１８階）';
INSERT postalcode
SET f3='1631519',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（１９階）';
INSERT postalcode
SET f3='1631520',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（２０階）';
INSERT postalcode
SET f3='1631521',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（２１階）';
INSERT postalcode
SET f3='1631522',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（２２階）';
INSERT postalcode
SET f3='1631523',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（２３階）';
INSERT postalcode
SET f3='1631524',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（２４階）';
INSERT postalcode
SET f3='1631525',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（２５階）';
INSERT postalcode
SET f3='1631526',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（２６階）';
INSERT postalcode
SET f3='1631527',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（２７階）';
INSERT postalcode
SET f3='1631528',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（２８階）';
INSERT postalcode
SET f3='1631529',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（２９階）';
INSERT postalcode
SET f3='1631530',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（３０階）';
INSERT postalcode
SET f3='1631531',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿エルタワー（３１階）';
INSERT postalcode
SET f3='1631190',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（地階・階層不明）';
INSERT postalcode
SET f3='1631101',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（１階）';
INSERT postalcode
SET f3='1631102',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（２階）';
INSERT postalcode
SET f3='1631103',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（３階）';
INSERT postalcode
SET f3='1631104',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（４階）';
INSERT postalcode
SET f3='1631105',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（５階）';
INSERT postalcode
SET f3='1631106',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（６階）';
INSERT postalcode
SET f3='1631107',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（７階）';
INSERT postalcode
SET f3='1631108',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（８階）';
INSERT postalcode
SET f3='1631109',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（９階）';
INSERT postalcode
SET f3='1631110',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（１０階）';
INSERT postalcode
SET f3='1631111',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（１１階）';
INSERT postalcode
SET f3='1631112',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（１２階）';
INSERT postalcode
SET f3='1631113',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（１３階）';
INSERT postalcode
SET f3='1631114',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（１４階）';
INSERT postalcode
SET f3='1631115',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（１５階）';
INSERT postalcode
SET f3='1631116',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（１６階）';
INSERT postalcode
SET f3='1631117',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（１７階）';
INSERT postalcode
SET f3='1631118',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（１８階）';
INSERT postalcode
SET f3='1631119',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（１９階）';
INSERT postalcode
SET f3='1631120',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（２０階）';
INSERT postalcode
SET f3='1631121',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（２１階）';
INSERT postalcode
SET f3='1631122',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（２２階）';
INSERT postalcode
SET f3='1631123',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（２３階）';
INSERT postalcode
SET f3='1631124',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（２４階）';
INSERT postalcode
SET f3='1631125',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（２５階）';
INSERT postalcode
SET f3='1631126',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（２６階）';
INSERT postalcode
SET f3='1631127',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（２７階）';
INSERT postalcode
SET f3='1631128',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（２８階）';
INSERT postalcode
SET f3='1631129',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（２９階）';
INSERT postalcode
SET f3='1631130',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿スクエアタワー（３０階）';
INSERT postalcode
SET f3='1630290',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（地階・階層不明）';
INSERT postalcode
SET f3='1630201',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（１階）';
INSERT postalcode
SET f3='1630202',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（２階）';
INSERT postalcode
SET f3='1630203',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（３階）';
INSERT postalcode
SET f3='1630204',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（４階）';
INSERT postalcode
SET f3='1630205',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（５階）';
INSERT postalcode
SET f3='1630206',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（６階）';
INSERT postalcode
SET f3='1630207',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（７階）';
INSERT postalcode
SET f3='1630208',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（８階）';
INSERT postalcode
SET f3='1630209',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（９階）';
INSERT postalcode
SET f3='1630210',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（１０階）';
INSERT postalcode
SET f3='1630211',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（１１階）';
INSERT postalcode
SET f3='1630212',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（１２階）';
INSERT postalcode
SET f3='1630213',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（１３階）';
INSERT postalcode
SET f3='1630214',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（１４階）';
INSERT postalcode
SET f3='1630215',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（１５階）';
INSERT postalcode
SET f3='1630216',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（１６階）';
INSERT postalcode
SET f3='1630217',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（１７階）';
INSERT postalcode
SET f3='1630218',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（１８階）';
INSERT postalcode
SET f3='1630219',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（１９階）';
INSERT postalcode
SET f3='1630220',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（２０階）';
INSERT postalcode
SET f3='1630221',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（２１階）';
INSERT postalcode
SET f3='1630222',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（２２階）';
INSERT postalcode
SET f3='1630223',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（２３階）';
INSERT postalcode
SET f3='1630224',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（２４階）';
INSERT postalcode
SET f3='1630225',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（２５階）';
INSERT postalcode
SET f3='1630226',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（２６階）';
INSERT postalcode
SET f3='1630227',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（２７階）';
INSERT postalcode
SET f3='1630228',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（２８階）';
INSERT postalcode
SET f3='1630229',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（２９階）';
INSERT postalcode
SET f3='1630230',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（３０階）';
INSERT postalcode
SET f3='1630231',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（３１階）';
INSERT postalcode
SET f3='1630232',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（３２階）';
INSERT postalcode
SET f3='1630233',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（３３階）';
INSERT postalcode
SET f3='1630234',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（３４階）';
INSERT postalcode
SET f3='1630235',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（３５階）';
INSERT postalcode
SET f3='1630236',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（３６階）';
INSERT postalcode
SET f3='1630237',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（３７階）';
INSERT postalcode
SET f3='1630238',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（３８階）';
INSERT postalcode
SET f3='1630239',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（３９階）';
INSERT postalcode
SET f3='1630240',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（４０階）';
INSERT postalcode
SET f3='1630241',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（４１階）';
INSERT postalcode
SET f3='1630242',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（４２階）';
INSERT postalcode
SET f3='1630243',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（４３階）';
INSERT postalcode
SET f3='1630244',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（４４階）';
INSERT postalcode
SET f3='1630245',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（４５階）';
INSERT postalcode
SET f3='1630246',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（４６階）';
INSERT postalcode
SET f3='1630247',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（４７階）';
INSERT postalcode
SET f3='1630248',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（４８階）';
INSERT postalcode
SET f3='1630249',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（４９階）';
INSERT postalcode
SET f3='1630250',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（５０階）';
INSERT postalcode
SET f3='1630251',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（５１階）';
INSERT postalcode
SET f3='1630252',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿住友ビル（５２階）';
INSERT postalcode
SET f3='1630690',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（地階・階層不明）';
INSERT postalcode
SET f3='1630601',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（１階）';
INSERT postalcode
SET f3='1630602',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（２階）';
INSERT postalcode
SET f3='1630603',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（３階）';
INSERT postalcode
SET f3='1630604',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（４階）';
INSERT postalcode
SET f3='1630605',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（５階）';
INSERT postalcode
SET f3='1630606',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（６階）';
INSERT postalcode
SET f3='1630607',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（７階）';
INSERT postalcode
SET f3='1630608',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（８階）';
INSERT postalcode
SET f3='1630609',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（９階）';
INSERT postalcode
SET f3='1630610',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（１０階）';
INSERT postalcode
SET f3='1630611',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（１１階）';
INSERT postalcode
SET f3='1630612',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（１２階）';
INSERT postalcode
SET f3='1630613',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（１３階）';
INSERT postalcode
SET f3='1630614',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（１４階）';
INSERT postalcode
SET f3='1630615',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（１５階）';
INSERT postalcode
SET f3='1630616',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（１６階）';
INSERT postalcode
SET f3='1630617',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（１７階）';
INSERT postalcode
SET f3='1630618',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（１８階）';
INSERT postalcode
SET f3='1630619',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（１９階）';
INSERT postalcode
SET f3='1630620',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（２０階）';
INSERT postalcode
SET f3='1630621',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（２１階）';
INSERT postalcode
SET f3='1630622',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（２２階）';
INSERT postalcode
SET f3='1630623',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（２３階）';
INSERT postalcode
SET f3='1630624',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（２４階）';
INSERT postalcode
SET f3='1630625',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（２５階）';
INSERT postalcode
SET f3='1630626',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（２６階）';
INSERT postalcode
SET f3='1630627',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（２７階）';
INSERT postalcode
SET f3='1630628',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（２８階）';
INSERT postalcode
SET f3='1630629',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（２９階）';
INSERT postalcode
SET f3='1630630',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（３０階）';
INSERT postalcode
SET f3='1630631',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（３１階）';
INSERT postalcode
SET f3='1630632',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（３２階）';
INSERT postalcode
SET f3='1630633',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（３３階）';
INSERT postalcode
SET f3='1630634',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（３４階）';
INSERT postalcode
SET f3='1630635',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（３５階）';
INSERT postalcode
SET f3='1630636',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（３６階）';
INSERT postalcode
SET f3='1630637',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（３７階）';
INSERT postalcode
SET f3='1630638',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（３８階）';
INSERT postalcode
SET f3='1630639',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（３９階）';
INSERT postalcode
SET f3='1630640',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（４０階）';
INSERT postalcode
SET f3='1630641',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（４１階）';
INSERT postalcode
SET f3='1630642',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（４２階）';
INSERT postalcode
SET f3='1630643',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（４３階）';
INSERT postalcode
SET f3='1630644',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（４４階）';
INSERT postalcode
SET f3='1630645',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（４５階）';
INSERT postalcode
SET f3='1630646',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（４６階）';
INSERT postalcode
SET f3='1630647',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（４７階）';
INSERT postalcode
SET f3='1630648',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（４８階）';
INSERT postalcode
SET f3='1630649',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（４９階）';
INSERT postalcode
SET f3='1630650',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（５０階）';
INSERT postalcode
SET f3='1630651',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（５１階）';
INSERT postalcode
SET f3='1630652',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（５２階）';
INSERT postalcode
SET f3='1630653',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（５３階）';
INSERT postalcode
SET f3='1630654',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿センタービル（５４階）';
INSERT postalcode
SET f3='1630790',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（地階・階層不明）';
INSERT postalcode
SET f3='1630701',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（１階）';
INSERT postalcode
SET f3='1630702',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（２階）';
INSERT postalcode
SET f3='1630703',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（３階）';
INSERT postalcode
SET f3='1630704',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（４階）';
INSERT postalcode
SET f3='1630705',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（５階）';
INSERT postalcode
SET f3='1630706',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（６階）';
INSERT postalcode
SET f3='1630707',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（７階）';
INSERT postalcode
SET f3='1630708',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（８階）';
INSERT postalcode
SET f3='1630709',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（９階）';
INSERT postalcode
SET f3='1630710',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（１０階）';
INSERT postalcode
SET f3='1630711',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（１１階）';
INSERT postalcode
SET f3='1630712',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（１２階）';
INSERT postalcode
SET f3='1630713',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（１３階）';
INSERT postalcode
SET f3='1630714',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（１４階）';
INSERT postalcode
SET f3='1630715',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（１５階）';
INSERT postalcode
SET f3='1630716',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（１６階）';
INSERT postalcode
SET f3='1630717',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（１７階）';
INSERT postalcode
SET f3='1630718',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（１８階）';
INSERT postalcode
SET f3='1630719',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（１９階）';
INSERT postalcode
SET f3='1630720',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（２０階）';
INSERT postalcode
SET f3='1630721',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（２１階）';
INSERT postalcode
SET f3='1630722',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（２２階）';
INSERT postalcode
SET f3='1630723',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（２３階）';
INSERT postalcode
SET f3='1630724',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（２４階）';
INSERT postalcode
SET f3='1630725',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（２５階）';
INSERT postalcode
SET f3='1630726',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿第一生命ビル（２６階）';
INSERT postalcode
SET f3='1630590',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（地階・階層不明）';
INSERT postalcode
SET f3='1630501',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（１階）';
INSERT postalcode
SET f3='1630502',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（２階）';
INSERT postalcode
SET f3='1630503',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（３階）';
INSERT postalcode
SET f3='1630504',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（４階）';
INSERT postalcode
SET f3='1630505',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（５階）';
INSERT postalcode
SET f3='1630506',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（６階）';
INSERT postalcode
SET f3='1630507',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（７階）';
INSERT postalcode
SET f3='1630508',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（８階）';
INSERT postalcode
SET f3='1630509',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（９階）';
INSERT postalcode
SET f3='1630510',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（１０階）';
INSERT postalcode
SET f3='1630511',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（１１階）';
INSERT postalcode
SET f3='1630512',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（１２階）';
INSERT postalcode
SET f3='1630513',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（１３階）';
INSERT postalcode
SET f3='1630514',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（１４階）';
INSERT postalcode
SET f3='1630515',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（１５階）';
INSERT postalcode
SET f3='1630516',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（１６階）';
INSERT postalcode
SET f3='1630517',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（１７階）';
INSERT postalcode
SET f3='1630518',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（１８階）';
INSERT postalcode
SET f3='1630519',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（１９階）';
INSERT postalcode
SET f3='1630520',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（２０階）';
INSERT postalcode
SET f3='1630521',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（２１階）';
INSERT postalcode
SET f3='1630522',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（２２階）';
INSERT postalcode
SET f3='1630523',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（２３階）';
INSERT postalcode
SET f3='1630524',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（２４階）';
INSERT postalcode
SET f3='1630525',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（２５階）';
INSERT postalcode
SET f3='1630526',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（２６階）';
INSERT postalcode
SET f3='1630527',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（２７階）';
INSERT postalcode
SET f3='1630528',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（２８階）';
INSERT postalcode
SET f3='1630529',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（２９階）';
INSERT postalcode
SET f3='1630530',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（３０階）';
INSERT postalcode
SET f3='1630531',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（３１階）';
INSERT postalcode
SET f3='1630532',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（３２階）';
INSERT postalcode
SET f3='1630533',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（３３階）';
INSERT postalcode
SET f3='1630534',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（３４階）';
INSERT postalcode
SET f3='1630535',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（３５階）';
INSERT postalcode
SET f3='1630536',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（３６階）';
INSERT postalcode
SET f3='1630537',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（３７階）';
INSERT postalcode
SET f3='1630538',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（３８階）';
INSERT postalcode
SET f3='1630539',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（３９階）';
INSERT postalcode
SET f3='1630540',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（４０階）';
INSERT postalcode
SET f3='1630541',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（４１階）';
INSERT postalcode
SET f3='1630542',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（４２階）';
INSERT postalcode
SET f3='1630543',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（４３階）';
INSERT postalcode
SET f3='1630544',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（４４階）';
INSERT postalcode
SET f3='1630545',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（４５階）';
INSERT postalcode
SET f3='1630546',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（４６階）';
INSERT postalcode
SET f3='1630547',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（４７階）';
INSERT postalcode
SET f3='1630548',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（４８階）';
INSERT postalcode
SET f3='1630549',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（４９階）';
INSERT postalcode
SET f3='1630550',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿野村ビル（５０階）';
INSERT postalcode
SET f3='1631090',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（地階・階層不明）';
INSERT postalcode
SET f3='1631001',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（１階）';
INSERT postalcode
SET f3='1631002',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（２階）';
INSERT postalcode
SET f3='1631003',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（３階）';
INSERT postalcode
SET f3='1631004',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（４階）';
INSERT postalcode
SET f3='1631005',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（５階）';
INSERT postalcode
SET f3='1631006',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（６階）';
INSERT postalcode
SET f3='1631007',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（７階）';
INSERT postalcode
SET f3='1631008',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（８階）';
INSERT postalcode
SET f3='1631009',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（９階）';
INSERT postalcode
SET f3='1631010',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（１０階）';
INSERT postalcode
SET f3='1631011',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（１１階）';
INSERT postalcode
SET f3='1631012',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（１２階）';
INSERT postalcode
SET f3='1631013',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（１３階）';
INSERT postalcode
SET f3='1631014',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（１４階）';
INSERT postalcode
SET f3='1631015',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（１５階）';
INSERT postalcode
SET f3='1631016',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（１６階）';
INSERT postalcode
SET f3='1631017',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（１７階）';
INSERT postalcode
SET f3='1631018',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（１８階）';
INSERT postalcode
SET f3='1631019',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（１９階）';
INSERT postalcode
SET f3='1631020',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（２０階）';
INSERT postalcode
SET f3='1631021',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（２１階）';
INSERT postalcode
SET f3='1631022',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（２２階）';
INSERT postalcode
SET f3='1631023',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（２３階）';
INSERT postalcode
SET f3='1631024',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（２４階）';
INSERT postalcode
SET f3='1631025',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（２５階）';
INSERT postalcode
SET f3='1631026',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（２６階）';
INSERT postalcode
SET f3='1631027',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（２７階）';
INSERT postalcode
SET f3='1631028',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（２８階）';
INSERT postalcode
SET f3='1631029',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（２９階）';
INSERT postalcode
SET f3='1631030',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（３０階）';
INSERT postalcode
SET f3='1631031',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（３１階）';
INSERT postalcode
SET f3='1631032',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（３２階）';
INSERT postalcode
SET f3='1631033',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（３３階）';
INSERT postalcode
SET f3='1631034',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（３４階）';
INSERT postalcode
SET f3='1631035',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（３５階）';
INSERT postalcode
SET f3='1631036',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（３６階）';
INSERT postalcode
SET f3='1631037',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（３７階）';
INSERT postalcode
SET f3='1631038',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（３８階）';
INSERT postalcode
SET f3='1631039',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（３９階）';
INSERT postalcode
SET f3='1631040',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（４０階）';
INSERT postalcode
SET f3='1631041',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（４１階）';
INSERT postalcode
SET f3='1631042',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（４２階）';
INSERT postalcode
SET f3='1631043',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（４３階）';
INSERT postalcode
SET f3='1631044',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（４４階）';
INSERT postalcode
SET f3='1631045',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（４５階）';
INSERT postalcode
SET f3='1631046',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（４６階）';
INSERT postalcode
SET f3='1631047',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（４７階）';
INSERT postalcode
SET f3='1631048',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（４８階）';
INSERT postalcode
SET f3='1631049',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（４９階）';
INSERT postalcode
SET f3='1631050',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（５０階）';
INSERT postalcode
SET f3='1631051',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（５１階）';
INSERT postalcode
SET f3='1631052',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿パークタワー（５２階）';
INSERT postalcode
SET f3='1630490',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（地階・階層不明）';
INSERT postalcode
SET f3='1630401',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（１階）';
INSERT postalcode
SET f3='1630402',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（２階）';
INSERT postalcode
SET f3='1630403',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（３階）';
INSERT postalcode
SET f3='1630404',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（４階）';
INSERT postalcode
SET f3='1630405',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（５階）';
INSERT postalcode
SET f3='1630406',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（６階）';
INSERT postalcode
SET f3='1630407',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（７階）';
INSERT postalcode
SET f3='1630408',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（８階）';
INSERT postalcode
SET f3='1630409',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（９階）';
INSERT postalcode
SET f3='1630410',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（１０階）';
INSERT postalcode
SET f3='1630411',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（１１階）';
INSERT postalcode
SET f3='1630412',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（１２階）';
INSERT postalcode
SET f3='1630413',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（１３階）';
INSERT postalcode
SET f3='1630414',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（１４階）';
INSERT postalcode
SET f3='1630415',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（１５階）';
INSERT postalcode
SET f3='1630416',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（１６階）';
INSERT postalcode
SET f3='1630417',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（１７階）';
INSERT postalcode
SET f3='1630418',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（１８階）';
INSERT postalcode
SET f3='1630419',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（１９階）';
INSERT postalcode
SET f3='1630420',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（２０階）';
INSERT postalcode
SET f3='1630421',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（２１階）';
INSERT postalcode
SET f3='1630422',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（２２階）';
INSERT postalcode
SET f3='1630423',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（２３階）';
INSERT postalcode
SET f3='1630424',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（２４階）';
INSERT postalcode
SET f3='1630425',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（２５階）';
INSERT postalcode
SET f3='1630426',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（２６階）';
INSERT postalcode
SET f3='1630427',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（２７階）';
INSERT postalcode
SET f3='1630428',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（２８階）';
INSERT postalcode
SET f3='1630429',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（２９階）';
INSERT postalcode
SET f3='1630430',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（３０階）';
INSERT postalcode
SET f3='1630431',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（３１階）';
INSERT postalcode
SET f3='1630432',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（３２階）';
INSERT postalcode
SET f3='1630433',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（３３階）';
INSERT postalcode
SET f3='1630434',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（３４階）';
INSERT postalcode
SET f3='1630435',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（３５階）';
INSERT postalcode
SET f3='1630436',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（３６階）';
INSERT postalcode
SET f3='1630437',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（３７階）';
INSERT postalcode
SET f3='1630438',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（３８階）';
INSERT postalcode
SET f3='1630439',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（３９階）';
INSERT postalcode
SET f3='1630440',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（４０階）';
INSERT postalcode
SET f3='1630441',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（４１階）';
INSERT postalcode
SET f3='1630442',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（４２階）';
INSERT postalcode
SET f3='1630443',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（４３階）';
INSERT postalcode
SET f3='1630444',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（４４階）';
INSERT postalcode
SET f3='1630445',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（４５階）';
INSERT postalcode
SET f3='1630446',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（４６階）';
INSERT postalcode
SET f3='1630447',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（４７階）';
INSERT postalcode
SET f3='1630448',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（４８階）';
INSERT postalcode
SET f3='1630449',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（４９階）';
INSERT postalcode
SET f3='1630450',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（５０階）';
INSERT postalcode
SET f3='1630451',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（５１階）';
INSERT postalcode
SET f3='1630452',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（５２階）';
INSERT postalcode
SET f3='1630453',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（５３階）';
INSERT postalcode
SET f3='1630454',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（５４階）';
INSERT postalcode
SET f3='1630455',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿三井ビル（５５階）';
INSERT postalcode
SET f3='1630990',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（地階・階層不明）';
INSERT postalcode
SET f3='1630901',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（１階）';
INSERT postalcode
SET f3='1630902',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（２階）';
INSERT postalcode
SET f3='1630903',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（３階）';
INSERT postalcode
SET f3='1630904',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（４階）';
INSERT postalcode
SET f3='1630905',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（５階）';
INSERT postalcode
SET f3='1630906',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（６階）';
INSERT postalcode
SET f3='1630907',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（７階）';
INSERT postalcode
SET f3='1630908',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（８階）';
INSERT postalcode
SET f3='1630909',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（９階）';
INSERT postalcode
SET f3='1630910',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（１０階）';
INSERT postalcode
SET f3='1630911',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（１１階）';
INSERT postalcode
SET f3='1630912',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（１２階）';
INSERT postalcode
SET f3='1630913',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（１３階）';
INSERT postalcode
SET f3='1630914',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（１４階）';
INSERT postalcode
SET f3='1630915',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（１５階）';
INSERT postalcode
SET f3='1630916',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（１６階）';
INSERT postalcode
SET f3='1630917',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（１７階）';
INSERT postalcode
SET f3='1630918',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（１８階）';
INSERT postalcode
SET f3='1630919',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（１９階）';
INSERT postalcode
SET f3='1630920',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（２０階）';
INSERT postalcode
SET f3='1630921',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（２１階）';
INSERT postalcode
SET f3='1630922',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（２２階）';
INSERT postalcode
SET f3='1630923',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（２３階）';
INSERT postalcode
SET f3='1630924',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（２４階）';
INSERT postalcode
SET f3='1630925',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（２５階）';
INSERT postalcode
SET f3='1630926',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（２６階）';
INSERT postalcode
SET f3='1630927',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（２７階）';
INSERT postalcode
SET f3='1630928',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（２８階）';
INSERT postalcode
SET f3='1630929',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（２９階）';
INSERT postalcode
SET f3='1630930',
    f7='東京都',
    f8='新宿区',
    f9='西新宿新宿モノリス（３０階）';
INSERT postalcode
SET f3='1636090',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（地階・階層不明）';
INSERT postalcode
SET f3='1636001',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（１階）';
INSERT postalcode
SET f3='1636002',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（２階）';
INSERT postalcode
SET f3='1636003',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（３階）';
INSERT postalcode
SET f3='1636004',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（４階）';
INSERT postalcode
SET f3='1636005',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（５階）';
INSERT postalcode
SET f3='1636006',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（６階）';
INSERT postalcode
SET f3='1636007',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（７階）';
INSERT postalcode
SET f3='1636008',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（８階）';
INSERT postalcode
SET f3='1636009',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（９階）';
INSERT postalcode
SET f3='1636010',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（１０階）';
INSERT postalcode
SET f3='1636011',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（１１階）';
INSERT postalcode
SET f3='1636012',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（１２階）';
INSERT postalcode
SET f3='1636013',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（１３階）';
INSERT postalcode
SET f3='1636014',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（１４階）';
INSERT postalcode
SET f3='1636015',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（１５階）';
INSERT postalcode
SET f3='1636016',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（１６階）';
INSERT postalcode
SET f3='1636017',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（１７階）';
INSERT postalcode
SET f3='1636018',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（１８階）';
INSERT postalcode
SET f3='1636019',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（１９階）';
INSERT postalcode
SET f3='1636020',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（２０階）';
INSERT postalcode
SET f3='1636021',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（２１階）';
INSERT postalcode
SET f3='1636022',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（２２階）';
INSERT postalcode
SET f3='1636023',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（２３階）';
INSERT postalcode
SET f3='1636024',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（２４階）';
INSERT postalcode
SET f3='1636025',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（２５階）';
INSERT postalcode
SET f3='1636026',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（２６階）';
INSERT postalcode
SET f3='1636027',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（２７階）';
INSERT postalcode
SET f3='1636028',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（２８階）';
INSERT postalcode
SET f3='1636029',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（２９階）';
INSERT postalcode
SET f3='1636030',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（３０階）';
INSERT postalcode
SET f3='1636031',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（３１階）';
INSERT postalcode
SET f3='1636032',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（３２階）';
INSERT postalcode
SET f3='1636033',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（３３階）';
INSERT postalcode
SET f3='1636034',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（３４階）';
INSERT postalcode
SET f3='1636035',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（３５階）';
INSERT postalcode
SET f3='1636036',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（３６階）';
INSERT postalcode
SET f3='1636037',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（３７階）';
INSERT postalcode
SET f3='1636038',
    f7='東京都',
    f8='新宿区',
    f9='西新宿住友不動産新宿オークタワー（３８階）';
INSERT postalcode
SET f3='1631490',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（地階・階層不明）';
INSERT postalcode
SET f3='1631401',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（１階）';
INSERT postalcode
SET f3='1631402',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（２階）';
INSERT postalcode
SET f3='1631403',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（３階）';
INSERT postalcode
SET f3='1631404',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（４階）';
INSERT postalcode
SET f3='1631405',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（５階）';
INSERT postalcode
SET f3='1631406',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（６階）';
INSERT postalcode
SET f3='1631407',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（７階）';
INSERT postalcode
SET f3='1631408',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（８階）';
INSERT postalcode
SET f3='1631409',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（９階）';
INSERT postalcode
SET f3='1631410',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（１０階）';
INSERT postalcode
SET f3='1631411',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（１１階）';
INSERT postalcode
SET f3='1631412',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（１２階）';
INSERT postalcode
SET f3='1631413',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（１３階）';
INSERT postalcode
SET f3='1631414',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（１４階）';
INSERT postalcode
SET f3='1631415',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（１５階）';
INSERT postalcode
SET f3='1631416',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（１６階）';
INSERT postalcode
SET f3='1631417',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（１７階）';
INSERT postalcode
SET f3='1631418',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（１８階）';
INSERT postalcode
SET f3='1631419',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（１９階）';
INSERT postalcode
SET f3='1631420',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（２０階）';
INSERT postalcode
SET f3='1631421',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（２１階）';
INSERT postalcode
SET f3='1631422',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（２２階）';
INSERT postalcode
SET f3='1631423',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（２３階）';
INSERT postalcode
SET f3='1631424',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（２４階）';
INSERT postalcode
SET f3='1631425',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（２５階）';
INSERT postalcode
SET f3='1631426',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（２６階）';
INSERT postalcode
SET f3='1631427',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（２７階）';
INSERT postalcode
SET f3='1631428',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（２８階）';
INSERT postalcode
SET f3='1631429',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（２９階）';
INSERT postalcode
SET f3='1631430',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（３０階）';
INSERT postalcode
SET f3='1631431',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（３１階）';
INSERT postalcode
SET f3='1631432',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（３２階）';
INSERT postalcode
SET f3='1631433',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（３３階）';
INSERT postalcode
SET f3='1631434',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（３４階）';
INSERT postalcode
SET f3='1631435',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（３５階）';
INSERT postalcode
SET f3='1631436',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（３６階）';
INSERT postalcode
SET f3='1631437',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（３７階）';
INSERT postalcode
SET f3='1631438',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（３８階）';
INSERT postalcode
SET f3='1631439',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（３９階）';
INSERT postalcode
SET f3='1631440',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（４０階）';
INSERT postalcode
SET f3='1631441',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（４１階）';
INSERT postalcode
SET f3='1631442',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（４２階）';
INSERT postalcode
SET f3='1631443',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（４３階）';
INSERT postalcode
SET f3='1631444',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（４４階）';
INSERT postalcode
SET f3='1631445',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（４５階）';
INSERT postalcode
SET f3='1631446',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（４６階）';
INSERT postalcode
SET f3='1631447',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（４７階）';
INSERT postalcode
SET f3='1631448',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（４８階）';
INSERT postalcode
SET f3='1631449',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（４９階）';
INSERT postalcode
SET f3='1631450',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（５０階）';
INSERT postalcode
SET f3='1631451',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（５１階）';
INSERT postalcode
SET f3='1631452',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（５２階）';
INSERT postalcode
SET f3='1631453',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（５３階）';
INSERT postalcode
SET f3='1631454',
    f7='東京都',
    f8='新宿区',
    f9='西新宿東京オペラシティ（５４階）';
INSERT postalcode
SET f3='1620051',
    f7='東京都',
    f8='新宿区',
    f9='西早稲田（２丁目１番１〜２３号、２番）';
INSERT postalcode
SET f3='1690051',
    f7='東京都',
    f8='新宿区',
    f9='西早稲田（その他）';
INSERT postalcode
SET f3='1620855',
    f7='東京都',
    f8='新宿区',
    f9='二十騎町';
INSERT postalcode
SET f3='1620045',
    f7='東京都',
    f8='新宿区',
    f9='馬場下町';
INSERT postalcode
SET f3='1620841',
    f7='東京都',
    f8='新宿区',
    f9='払方町';
INSERT postalcode
SET f3='1620053',
    f7='東京都',
    f8='新宿区',
    f9='原町';
INSERT postalcode
SET f3='1620807',
    f7='東京都',
    f8='新宿区',
    f9='東榎町';
INSERT postalcode
SET f3='1620813',
    f7='東京都',
    f8='新宿区',
    f9='東五軒町';
INSERT postalcode
SET f3='1690073',
    f7='東京都',
    f8='新宿区',
    f9='百人町';
INSERT postalcode
SET f3='1620828',
    f7='東京都',
    f8='新宿区',
    f9='袋町';
INSERT postalcode
SET f3='1600006',
    f7='東京都',
    f8='新宿区',
    f9='舟町';
INSERT postalcode
SET f3='1620851',
    f7='東京都',
    f8='新宿区',
    f9='弁天町';
INSERT postalcode
SET f3='1600003',
    f7='東京都',
    f8='新宿区',
    f9='本塩町';
INSERT postalcode
SET f3='1620852',
    f7='東京都',
    f8='新宿区',
    f9='南榎町';
INSERT postalcode
SET f3='1620836',
    f7='東京都',
    f8='新宿区',
    f9='南町';
INSERT postalcode
SET f3='1600012',
    f7='東京都',
    f8='新宿区',
    f9='南元町';
INSERT postalcode
SET f3='1620854',
    f7='東京都',
    f8='新宿区',
    f9='南山伏町';
INSERT postalcode
SET f3='1620801',
    f7='東京都',
    f8='新宿区',
    f9='山吹町';
INSERT postalcode
SET f3='1620805',
    f7='東京都',
    f8='新宿区',
    f9='矢来町';
INSERT postalcode
SET f3='1620831',
    f7='東京都',
    f8='新宿区',
    f9='横寺町';
INSERT postalcode
SET f3='1620055',
    f7='東京都',
    f8='新宿区',
    f9='余丁町';
INSERT postalcode
SET f3='1600004',
    f7='東京都',
    f8='新宿区',
    f9='四谷';
INSERT postalcode
SET f3='1600011',
    f7='東京都',
    f8='新宿区',
    f9='若葉';
INSERT postalcode
SET f3='1620056',
    f7='東京都',
    f8='新宿区',
    f9='若松町';
INSERT postalcode
SET f3='1620827',
    f7='東京都',
    f8='新宿区',
    f9='若宮町';
INSERT postalcode
SET f3='1620041',
    f7='東京都',
    f8='新宿区',
    f9='早稲田鶴巻町';
INSERT postalcode
SET f3='1620043',
    f7='東京都',
    f8='新宿区',
    f9='早稲田南町';
INSERT postalcode
SET f3='1620042',
    f7='東京都',
    f8='新宿区',
    f9='早稲田町';
INSERT postalcode
SET f3='1120000',
    f7='東京都',
    f8='文京区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1120012',
    f7='東京都',
    f8='文京区',
    f9='大塚';
INSERT postalcode
SET f3='1120013',
    f7='東京都',
    f8='文京区',
    f9='音羽';
INSERT postalcode
SET f3='1120003',
    f7='東京都',
    f8='文京区',
    f9='春日';
INSERT postalcode
SET f3='1120002',
    f7='東京都',
    f8='文京区',
    f9='小石川';
INSERT postalcode
SET f3='1120004',
    f7='東京都',
    f8='文京区',
    f9='後楽';
INSERT postalcode
SET f3='1120006',
    f7='東京都',
    f8='文京区',
    f9='小日向';
INSERT postalcode
SET f3='1120005',
    f7='東京都',
    f8='文京区',
    f9='水道';
INSERT postalcode
SET f3='1120014',
    f7='東京都',
    f8='文京区',
    f9='関口';
INSERT postalcode
SET f3='1120011',
    f7='東京都',
    f8='文京区',
    f9='千石';
INSERT postalcode
SET f3='1130022',
    f7='東京都',
    f8='文京区',
    f9='千駄木';
INSERT postalcode
SET f3='1130024',
    f7='東京都',
    f8='文京区',
    f9='西片';
INSERT postalcode
SET f3='1130031',
    f7='東京都',
    f8='文京区',
    f9='根津';
INSERT postalcode
SET f3='1130001',
    f7='東京都',
    f8='文京区',
    f9='白山（１丁目）';
INSERT postalcode
SET f3='1120001',
    f7='東京都',
    f8='文京区',
    f9='白山（２〜５丁目）';
INSERT postalcode
SET f3='1130021',
    f7='東京都',
    f8='文京区',
    f9='本駒込';
INSERT postalcode
SET f3='1130033',
    f7='東京都',
    f8='文京区',
    f9='本郷';
INSERT postalcode
SET f3='1130023',
    f7='東京都',
    f8='文京区',
    f9='向丘';
INSERT postalcode
SET f3='1120015',
    f7='東京都',
    f8='文京区',
    f9='目白台';
INSERT postalcode
SET f3='1130032',
    f7='東京都',
    f8='文京区',
    f9='弥生';
INSERT postalcode
SET f3='1130034',
    f7='東京都',
    f8='文京区',
    f9='湯島';
INSERT postalcode
SET f3='1100000',
    f7='東京都',
    f8='台東区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1100006',
    f7='東京都',
    f8='台東区',
    f9='秋葉原';
INSERT postalcode
SET f3='1110032',
    f7='東京都',
    f8='台東区',
    f9='浅草';
INSERT postalcode
SET f3='1110053',
    f7='東京都',
    f8='台東区',
    f9='浅草橋';
INSERT postalcode
SET f3='1100008',
    f7='東京都',
    f8='台東区',
    f9='池之端';
INSERT postalcode
SET f3='1110024',
    f7='東京都',
    f8='台東区',
    f9='今戸';
INSERT postalcode
SET f3='1100013',
    f7='東京都',
    f8='台東区',
    f9='入谷';
INSERT postalcode
SET f3='1100005',
    f7='東京都',
    f8='台東区',
    f9='上野';
INSERT postalcode
SET f3='1100007',
    f7='東京都',
    f8='台東区',
    f9='上野公園';
INSERT postalcode
SET f3='1100002',
    f7='東京都',
    f8='台東区',
    f9='上野桜木';
INSERT postalcode
SET f3='1110034',
    f7='東京都',
    f8='台東区',
    f9='雷門';
INSERT postalcode
SET f3='1100014',
    f7='東京都',
    f8='台東区',
    f9='北上野';
INSERT postalcode
SET f3='1110022',
    f7='東京都',
    f8='台東区',
    f9='清川';
INSERT postalcode
SET f3='1110051',
    f7='東京都',
    f8='台東区',
    f9='蔵前';
INSERT postalcode
SET f3='1110056',
    f7='東京都',
    f8='台東区',
    f9='小島';
INSERT postalcode
SET f3='1110042',
    f7='東京都',
    f8='台東区',
    f9='寿';
INSERT postalcode
SET f3='1110043',
    f7='東京都',
    f8='台東区',
    f9='駒形';
INSERT postalcode
SET f3='1100004',
    f7='東京都',
    f8='台東区',
    f9='下谷';
INSERT postalcode
SET f3='1110031',
    f7='東京都',
    f8='台東区',
    f9='千束';
INSERT postalcode
SET f3='1100016',
    f7='東京都',
    f8='台東区',
    f9='台東';
INSERT postalcode
SET f3='1110054',
    f7='東京都',
    f8='台東区',
    f9='鳥越';
INSERT postalcode
SET f3='1110035',
    f7='東京都',
    f8='台東区',
    f9='西浅草';
INSERT postalcode
SET f3='1110021',
    f7='東京都',
    f8='台東区',
    f9='日本堤';
INSERT postalcode
SET f3='1100003',
    f7='東京都',
    f8='台東区',
    f9='根岸';
INSERT postalcode
SET f3='1110023',
    f7='東京都',
    f8='台東区',
    f9='橋場';
INSERT postalcode
SET f3='1110033',
    f7='東京都',
    f8='台東区',
    f9='花川戸';
INSERT postalcode
SET f3='1110025',
    f7='東京都',
    f8='台東区',
    f9='東浅草';
INSERT postalcode
SET f3='1100015',
    f7='東京都',
    f8='台東区',
    f9='東上野';
INSERT postalcode
SET f3='1110036',
    f7='東京都',
    f8='台東区',
    f9='松が谷';
INSERT postalcode
SET f3='1110055',
    f7='東京都',
    f8='台東区',
    f9='三筋';
INSERT postalcode
SET f3='1100011',
    f7='東京都',
    f8='台東区',
    f9='三ノ輪';
INSERT postalcode
SET f3='1110041',
    f7='東京都',
    f8='台東区',
    f9='元浅草';
INSERT postalcode
SET f3='1100001',
    f7='東京都',
    f8='台東区',
    f9='谷中';
INSERT postalcode
SET f3='1110052',
    f7='東京都',
    f8='台東区',
    f9='柳橋';
INSERT postalcode
SET f3='1100012',
    f7='東京都',
    f8='台東区',
    f9='竜泉';
INSERT postalcode
SET f3='1300000',
    f7='東京都',
    f8='墨田区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1300001',
    f7='東京都',
    f8='墨田区',
    f9='吾妻橋';
INSERT postalcode
SET f3='1300011',
    f7='東京都',
    f8='墨田区',
    f9='石原';
INSERT postalcode
SET f3='1310045',
    f7='東京都',
    f8='墨田区',
    f9='押上';
INSERT postalcode
SET f3='1300014',
    f7='東京都',
    f8='墨田区',
    f9='亀沢';
INSERT postalcode
SET f3='1300024',
    f7='東京都',
    f8='墨田区',
    f9='菊川';
INSERT postalcode
SET f3='1310046',
    f7='東京都',
    f8='墨田区',
    f9='京島';
INSERT postalcode
SET f3='1300013',
    f7='東京都',
    f8='墨田区',
    f9='錦糸';
INSERT postalcode
SET f3='1300022',
    f7='東京都',
    f8='墨田区',
    f9='江東橋';
INSERT postalcode
SET f3='1310031',
    f7='東京都',
    f8='墨田区',
    f9='墨田';
INSERT postalcode
SET f3='1300012',
    f7='東京都',
    f8='墨田区',
    f9='太平';
INSERT postalcode
SET f3='1310043',
    f7='東京都',
    f8='墨田区',
    f9='立花';
INSERT postalcode
SET f3='1300023',
    f7='東京都',
    f8='墨田区',
    f9='立川';
INSERT postalcode
SET f3='1300025',
    f7='東京都',
    f8='墨田区',
    f9='千歳';
INSERT postalcode
SET f3='1310034',
    f7='東京都',
    f8='墨田区',
    f9='堤通';
INSERT postalcode
SET f3='1300002',
    f7='東京都',
    f8='墨田区',
    f9='業平';
INSERT postalcode
SET f3='1300005',
    f7='東京都',
    f8='墨田区',
    f9='東駒形';
INSERT postalcode
SET f3='1310042',
    f7='東京都',
    f8='墨田区',
    f9='東墨田';
INSERT postalcode
SET f3='1310032',
    f7='東京都',
    f8='墨田区',
    f9='東向島';
INSERT postalcode
SET f3='1310044',
    f7='東京都',
    f8='墨田区',
    f9='文花';
INSERT postalcode
SET f3='1300004',
    f7='東京都',
    f8='墨田区',
    f9='本所';
INSERT postalcode
SET f3='1300021',
    f7='東京都',
    f8='墨田区',
    f9='緑';
INSERT postalcode
SET f3='1310033',
    f7='東京都',
    f8='墨田区',
    f9='向島';
INSERT postalcode
SET f3='1310041',
    f7='東京都',
    f8='墨田区',
    f9='八広';
INSERT postalcode
SET f3='1300015',
    f7='東京都',
    f8='墨田区',
    f9='横網';
INSERT postalcode
SET f3='1300003',
    f7='東京都',
    f8='墨田区',
    f9='横川';
INSERT postalcode
SET f3='1300026',
    f7='東京都',
    f8='墨田区',
    f9='両国';
INSERT postalcode
SET f3='1350000',
    f7='東京都',
    f8='江東区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1350064',
    f7='東京都',
    f8='江東区',
    f9='青海';
INSERT postalcode
SET f3='1350063',
    f7='東京都',
    f8='江東区',
    f9='有明';
INSERT postalcode
SET f3='1350014',
    f7='東京都',
    f8='江東区',
    f9='石島';
INSERT postalcode
SET f3='1350012',
    f7='東京都',
    f8='江東区',
    f9='海辺';
INSERT postalcode
SET f3='1350034',
    f7='東京都',
    f8='江東区',
    f9='永代';
INSERT postalcode
SET f3='1350051',
    f7='東京都',
    f8='江東区',
    f9='枝川';
INSERT postalcode
SET f3='1350044',
    f7='東京都',
    f8='江東区',
    f9='越中島';
INSERT postalcode
SET f3='1350011',
    f7='東京都',
    f8='江東区',
    f9='扇橋';
INSERT postalcode
SET f3='1360072',
    f7='東京都',
    f8='江東区',
    f9='大島';
INSERT postalcode
SET f3='1360071',
    f7='東京都',
    f8='江東区',
    f9='亀戸';
INSERT postalcode
SET f3='1360073',
    f7='東京都',
    f8='江東区',
    f9='北砂';
INSERT postalcode
SET f3='1350042',
    f7='東京都',
    f8='江東区',
    f9='木場';
INSERT postalcode
SET f3='1350024',
    f7='東京都',
    f8='江東区',
    f9='清澄';
INSERT postalcode
SET f3='1350031',
    f7='東京都',
    f8='江東区',
    f9='佐賀';
INSERT postalcode
SET f3='1350003',
    f7='東京都',
    f8='江東区',
    f9='猿江';
INSERT postalcode
SET f3='1350043',
    f7='東京都',
    f8='江東区',
    f9='塩浜';
INSERT postalcode
SET f3='1350052',
    f7='東京都',
    f8='江東区',
    f9='潮見';
INSERT postalcode
SET f3='1350062',
    f7='東京都',
    f8='江東区',
    f9='東雲';
INSERT postalcode
SET f3='1350021',
    f7='東京都',
    f8='江東区',
    f9='白河';
INSERT postalcode
SET f3='1350007',
    f7='東京都',
    f8='江東区',
    f9='新大橋';
INSERT postalcode
SET f3='1360082',
    f7='東京都',
    f8='江東区',
    f9='新木場';
INSERT postalcode
SET f3='1360075',
    f7='東京都',
    f8='江東区',
    f9='新砂';
INSERT postalcode
SET f3='1350002',
    f7='東京都',
    f8='江東区',
    f9='住吉';
INSERT postalcode
SET f3='1350015',
    f7='東京都',
    f8='江東区',
    f9='千石';
INSERT postalcode
SET f3='1350013',
    f7='東京都',
    f8='江東区',
    f9='千田';
INSERT postalcode
SET f3='1350005',
    f7='東京都',
    f8='江東区',
    f9='高橋';
INSERT postalcode
SET f3='1350053',
    f7='東京都',
    f8='江東区',
    f9='辰巳';
INSERT postalcode
SET f3='1350065',
    f7='東京都',
    f8='江東区',
    f9='中央防波堤';
INSERT postalcode
SET f3='1350016',
    f7='東京都',
    f8='江東区',
    f9='東陽';
INSERT postalcode
SET f3='1350006',
    f7='東京都',
    f8='江東区',
    f9='常盤';
INSERT postalcode
SET f3='1350047',
    f7='東京都',
    f8='江東区',
    f9='富岡';
INSERT postalcode
SET f3='1350061',
    f7='東京都',
    f8='江東区',
    f9='豊洲（次のビルを除く）';
INSERT postalcode
SET f3='1356090',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（地階・階層不明）';
INSERT postalcode
SET f3='1356001',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（１階）';
INSERT postalcode
SET f3='1356002',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（２階）';
INSERT postalcode
SET f3='1356003',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（３階）';
INSERT postalcode
SET f3='1356004',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（４階）';
INSERT postalcode
SET f3='1356005',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（５階）';
INSERT postalcode
SET f3='1356006',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（６階）';
INSERT postalcode
SET f3='1356007',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（７階）';
INSERT postalcode
SET f3='1356008',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（８階）';
INSERT postalcode
SET f3='1356009',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（９階）';
INSERT postalcode
SET f3='1356010',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（１０階）';
INSERT postalcode
SET f3='1356011',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（１１階）';
INSERT postalcode
SET f3='1356012',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（１２階）';
INSERT postalcode
SET f3='1356013',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（１３階）';
INSERT postalcode
SET f3='1356014',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（１４階）';
INSERT postalcode
SET f3='1356015',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（１５階）';
INSERT postalcode
SET f3='1356016',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（１６階）';
INSERT postalcode
SET f3='1356017',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（１７階）';
INSERT postalcode
SET f3='1356018',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（１８階）';
INSERT postalcode
SET f3='1356019',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（１９階）';
INSERT postalcode
SET f3='1356020',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（２０階）';
INSERT postalcode
SET f3='1356021',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（２１階）';
INSERT postalcode
SET f3='1356022',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（２２階）';
INSERT postalcode
SET f3='1356023',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（２３階）';
INSERT postalcode
SET f3='1356024',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（２４階）';
INSERT postalcode
SET f3='1356025',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（２５階）';
INSERT postalcode
SET f3='1356026',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（２６階）';
INSERT postalcode
SET f3='1356027',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（２７階）';
INSERT postalcode
SET f3='1356028',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（２８階）';
INSERT postalcode
SET f3='1356029',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（２９階）';
INSERT postalcode
SET f3='1356030',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（３０階）';
INSERT postalcode
SET f3='1356031',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（３１階）';
INSERT postalcode
SET f3='1356032',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（３２階）';
INSERT postalcode
SET f3='1356033',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（３３階）';
INSERT postalcode
SET f3='1356034',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（３４階）';
INSERT postalcode
SET f3='1356035',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（３５階）';
INSERT postalcode
SET f3='1356036',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（３６階）';
INSERT postalcode
SET f3='1356037',
    f7='東京都',
    f8='江東区',
    f9='豊洲豊洲センタービル（３７階）';
INSERT postalcode
SET f3='1360074',
    f7='東京都',
    f8='江東区',
    f9='東砂';
INSERT postalcode
SET f3='1350023',
    f7='東京都',
    f8='江東区',
    f9='平野';
INSERT postalcode
SET f3='1350033',
    f7='東京都',
    f8='江東区',
    f9='深川';
INSERT postalcode
SET f3='1350032',
    f7='東京都',
    f8='江東区',
    f9='福住';
INSERT postalcode
SET f3='1350041',
    f7='東京都',
    f8='江東区',
    f9='冬木';
INSERT postalcode
SET f3='1350045',
    f7='東京都',
    f8='江東区',
    f9='古石場';
INSERT postalcode
SET f3='1350046',
    f7='東京都',
    f8='江東区',
    f9='牡丹';
INSERT postalcode
SET f3='1360076',
    f7='東京都',
    f8='江東区',
    f9='南砂';
INSERT postalcode
SET f3='1350022',
    f7='東京都',
    f8='江東区',
    f9='三好';
INSERT postalcode
SET f3='1350001',
    f7='東京都',
    f8='江東区',
    f9='毛利';
INSERT postalcode
SET f3='1350004',
    f7='東京都',
    f8='江東区',
    f9='森下';
INSERT postalcode
SET f3='1350048',
    f7='東京都',
    f8='江東区',
    f9='門前仲町';
INSERT postalcode
SET f3='1360081',
    f7='東京都',
    f8='江東区',
    f9='夢の島';
INSERT postalcode
SET f3='1360083',
    f7='東京都',
    f8='江東区',
    f9='若洲';
INSERT postalcode
SET f3='1400000',
    f7='東京都',
    f8='品川区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1420063',
    f7='東京都',
    f8='品川区',
    f9='荏原';
INSERT postalcode
SET f3='1400014',
    f7='東京都',
    f8='品川区',
    f9='大井';
INSERT postalcode
SET f3='1410032',
    f7='東京都',
    f8='品川区',
    f9='大崎（次のビルを除く）';
INSERT postalcode
SET f3='1416090',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（地階・階層不明）';
INSERT postalcode
SET f3='1416001',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（１階）';
INSERT postalcode
SET f3='1416002',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（２階）';
INSERT postalcode
SET f3='1416003',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（３階）';
INSERT postalcode
SET f3='1416004',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（４階）';
INSERT postalcode
SET f3='1416005',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（５階）';
INSERT postalcode
SET f3='1416006',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（６階）';
INSERT postalcode
SET f3='1416007',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（７階）';
INSERT postalcode
SET f3='1416008',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（８階）';
INSERT postalcode
SET f3='1416009',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（９階）';
INSERT postalcode
SET f3='1416010',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（１０階）';
INSERT postalcode
SET f3='1416011',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（１１階）';
INSERT postalcode
SET f3='1416012',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（１２階）';
INSERT postalcode
SET f3='1416013',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（１３階）';
INSERT postalcode
SET f3='1416014',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（１４階）';
INSERT postalcode
SET f3='1416015',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（１５階）';
INSERT postalcode
SET f3='1416016',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（１６階）';
INSERT postalcode
SET f3='1416017',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（１７階）';
INSERT postalcode
SET f3='1416018',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（１８階）';
INSERT postalcode
SET f3='1416019',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（１９階）';
INSERT postalcode
SET f3='1416020',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（２０階）';
INSERT postalcode
SET f3='1416021',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（２１階）';
INSERT postalcode
SET f3='1416022',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（２２階）';
INSERT postalcode
SET f3='1416023',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（２３階）';
INSERT postalcode
SET f3='1416024',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（２４階）';
INSERT postalcode
SET f3='1416025',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（２５階）';
INSERT postalcode
SET f3='1416026',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（２６階）';
INSERT postalcode
SET f3='1416027',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（２７階）';
INSERT postalcode
SET f3='1416028',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（２８階）';
INSERT postalcode
SET f3='1416029',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（２９階）';
INSERT postalcode
SET f3='1416030',
    f7='東京都',
    f8='品川区',
    f9='大崎ＴｈｉｎｋＰａｒｋＴｏｗｅｒ（３０階）';
INSERT postalcode
SET f3='1400012',
    f7='東京都',
    f8='品川区',
    f9='勝島';
INSERT postalcode
SET f3='1410021',
    f7='東京都',
    f8='品川区',
    f9='上大崎';
INSERT postalcode
SET f3='1400001',
    f7='東京都',
    f8='品川区',
    f9='北品川（１〜４丁目）';
INSERT postalcode
SET f3='1410001',
    f7='東京都',
    f8='品川区',
    f9='北品川（５、６丁目）';
INSERT postalcode
SET f3='1420062',
    f7='東京都',
    f8='品川区',
    f9='小山';
INSERT postalcode
SET f3='1420061',
    f7='東京都',
    f8='品川区',
    f9='小山台';
INSERT postalcode
SET f3='1420041',
    f7='東京都',
    f8='品川区',
    f9='戸越';
INSERT postalcode
SET f3='1420053',
    f7='東京都',
    f8='品川区',
    f9='中延';
INSERT postalcode
SET f3='1400015',
    f7='東京都',
    f8='品川区',
    f9='西大井';
INSERT postalcode
SET f3='1410031',
    f7='東京都',
    f8='品川区',
    f9='西五反田';
INSERT postalcode
SET f3='1410033',
    f7='東京都',
    f8='品川区',
    f9='西品川';
INSERT postalcode
SET f3='1420054',
    f7='東京都',
    f8='品川区',
    f9='西中延';
INSERT postalcode
SET f3='1420064',
    f7='東京都',
    f8='品川区',
    f9='旗の台';
INSERT postalcode
SET f3='1400011',
    f7='東京都',
    f8='品川区',
    f9='東大井';
INSERT postalcode
SET f3='1410022',
    f7='東京都',
    f8='品川区',
    f9='東五反田';
INSERT postalcode
SET f3='1400002',
    f7='東京都',
    f8='品川区',
    f9='東品川';
INSERT postalcode
SET f3='1420052',
    f7='東京都',
    f8='品川区',
    f9='東中延';
INSERT postalcode
SET f3='1350092',
    f7='東京都',
    f8='品川区',
    f9='東八潮';
INSERT postalcode
SET f3='1420051',
    f7='東京都',
    f8='品川区',
    f9='平塚';
INSERT postalcode
SET f3='1400005',
    f7='東京都',
    f8='品川区',
    f9='広町';
INSERT postalcode
SET f3='1420043',
    f7='東京都',
    f8='品川区',
    f9='二葉';
INSERT postalcode
SET f3='1400013',
    f7='東京都',
    f8='品川区',
    f9='南大井';
INSERT postalcode
SET f3='1400004',
    f7='東京都',
    f8='品川区',
    f9='南品川';
INSERT postalcode
SET f3='1400003',
    f7='東京都',
    f8='品川区',
    f9='八潮';
INSERT postalcode
SET f3='1420042',
    f7='東京都',
    f8='品川区',
    f9='豊町';
INSERT postalcode
SET f3='1520000',
    f7='東京都',
    f8='目黒区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1530042',
    f7='東京都',
    f8='目黒区',
    f9='青葉台';
INSERT postalcode
SET f3='1520033',
    f7='東京都',
    f8='目黒区',
    f9='大岡山';
INSERT postalcode
SET f3='1530044',
    f7='東京都',
    f8='目黒区',
    f9='大橋';
INSERT postalcode
SET f3='1520022',
    f7='東京都',
    f8='目黒区',
    f9='柿の木坂';
INSERT postalcode
SET f3='1530051',
    f7='東京都',
    f8='目黒区',
    f9='上目黒';
INSERT postalcode
SET f3='1530053',
    f7='東京都',
    f8='目黒区',
    f9='五本木';
INSERT postalcode
SET f3='1530041',
    f7='東京都',
    f8='目黒区',
    f9='駒場';
INSERT postalcode
SET f3='1530064',
    f7='東京都',
    f8='目黒区',
    f9='下目黒';
INSERT postalcode
SET f3='1520035',
    f7='東京都',
    f8='目黒区',
    f9='自由が丘';
INSERT postalcode
SET f3='1520012',
    f7='東京都',
    f8='目黒区',
    f9='洗足';
INSERT postalcode
SET f3='1520032',
    f7='東京都',
    f8='目黒区',
    f9='平町';
INSERT postalcode
SET f3='1520004',
    f7='東京都',
    f8='目黒区',
    f9='鷹番';
INSERT postalcode
SET f3='1520001',
    f7='東京都',
    f8='目黒区',
    f9='中央町';
INSERT postalcode
SET f3='1530065',
    f7='東京都',
    f8='目黒区',
    f9='中町';
INSERT postalcode
SET f3='1520031',
    f7='東京都',
    f8='目黒区',
    f9='中根';
INSERT postalcode
SET f3='1530061',
    f7='東京都',
    f8='目黒区',
    f9='中目黒';
INSERT postalcode
SET f3='1520011',
    f7='東京都',
    f8='目黒区',
    f9='原町';
INSERT postalcode
SET f3='1520021',
    f7='東京都',
    f8='目黒区',
    f9='東が丘';
INSERT postalcode
SET f3='1530043',
    f7='東京都',
    f8='目黒区',
    f9='東山';
INSERT postalcode
SET f3='1520003',
    f7='東京都',
    f8='目黒区',
    f9='碑文谷';
INSERT postalcode
SET f3='1530062',
    f7='東京都',
    f8='目黒区',
    f9='三田';
INSERT postalcode
SET f3='1520034',
    f7='東京都',
    f8='目黒区',
    f9='緑が丘';
INSERT postalcode
SET f3='1520013',
    f7='東京都',
    f8='目黒区',
    f9='南';
INSERT postalcode
SET f3='1530063',
    f7='東京都',
    f8='目黒区',
    f9='目黒';
INSERT postalcode
SET f3='1520002',
    f7='東京都',
    f8='目黒区',
    f9='目黒本町';
INSERT postalcode
SET f3='1520023',
    f7='東京都',
    f8='目黒区',
    f9='八雲';
INSERT postalcode
SET f3='1530052',
    f7='東京都',
    f8='目黒区',
    f9='祐天寺';
INSERT postalcode
SET f3='1440000',
    f7='東京都',
    f8='大田区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1460082',
    f7='東京都',
    f8='大田区',
    f9='池上';
INSERT postalcode
SET f3='1450061',
    f7='東京都',
    f8='大田区',
    f9='石川町';
INSERT postalcode
SET f3='1460091',
    f7='東京都',
    f8='大田区',
    f9='鵜の木';
INSERT postalcode
SET f3='1430014',
    f7='東京都',
    f8='大田区',
    f9='大森中';
INSERT postalcode
SET f3='1430011',
    f7='東京都',
    f8='大田区',
    f9='大森本町';
INSERT postalcode
SET f3='1430012',
    f7='東京都',
    f8='大田区',
    f9='大森東';
INSERT postalcode
SET f3='1430015',
    f7='東京都',
    f8='大田区',
    f9='大森西';
INSERT postalcode
SET f3='1430013',
    f7='東京都',
    f8='大田区',
    f9='大森南';
INSERT postalcode
SET f3='1430016',
    f7='東京都',
    f8='大田区',
    f9='大森北';
INSERT postalcode
SET f3='1440052',
    f7='東京都',
    f8='大田区',
    f9='蒲田';
INSERT postalcode
SET f3='1440053',
    f7='東京都',
    f8='大田区',
    f9='蒲田本町';
INSERT postalcode
SET f3='1450064',
    f7='東京都',
    f8='大田区',
    f9='上池台';
INSERT postalcode
SET f3='1440032',
    f7='東京都',
    f8='大田区',
    f9='北糀谷';
INSERT postalcode
SET f3='1450062',
    f7='東京都',
    f8='大田区',
    f9='北千束';
INSERT postalcode
SET f3='1430021',
    f7='東京都',
    f8='大田区',
    f9='北馬込';
INSERT postalcode
SET f3='1450073',
    f7='東京都',
    f8='大田区',
    f9='北嶺町';
INSERT postalcode
SET f3='1460085',
    f7='東京都',
    f8='大田区',
    f9='久が原';
INSERT postalcode
SET f3='1430003',
    f7='東京都',
    f8='大田区',
    f9='京浜島';
INSERT postalcode
SET f3='1430023',
    f7='東京都',
    f8='大田区',
    f9='山王';
INSERT postalcode
SET f3='1460092',
    f7='東京都',
    f8='大田区',
    f9='下丸子';
INSERT postalcode
SET f3='1430002',
    f7='東京都',
    f8='大田区',
    f9='城南島';
INSERT postalcode
SET f3='1430004',
    f7='東京都',
    f8='大田区',
    f9='昭和島';
INSERT postalcode
SET f3='1440054',
    f7='東京都',
    f8='大田区',
    f9='新蒲田';
INSERT postalcode
SET f3='1460095',
    f7='東京都',
    f8='大田区',
    f9='多摩川';
INSERT postalcode
SET f3='1460083',
    f7='東京都',
    f8='大田区',
    f9='千鳥';
INSERT postalcode
SET f3='1430024',
    f7='東京都',
    f8='大田区',
    f9='中央';
INSERT postalcode
SET f3='1450071',
    f7='東京都',
    f8='大田区',
    f9='田園調布';
INSERT postalcode
SET f3='1450072',
    f7='東京都',
    f8='大田区',
    f9='田園調布本町';
INSERT postalcode
SET f3='1450076',
    f7='東京都',
    f8='大田区',
    f9='田園調布南';
INSERT postalcode
SET f3='1430001',
    f7='東京都',
    f8='大田区',
    f9='東海';
INSERT postalcode
SET f3='1460081',
    f7='東京都',
    f8='大田区',
    f9='仲池上';
INSERT postalcode
SET f3='1430027',
    f7='東京都',
    f8='大田区',
    f9='中馬込';
INSERT postalcode
SET f3='1440055',
    f7='東京都',
    f8='大田区',
    f9='仲六郷';
INSERT postalcode
SET f3='1440051',
    f7='東京都',
    f8='大田区',
    f9='西蒲田';
INSERT postalcode
SET f3='1440034',
    f7='東京都',
    f8='大田区',
    f9='西糀谷';
INSERT postalcode
SET f3='1430026',
    f7='東京都',
    f8='大田区',
    f9='西馬込';
INSERT postalcode
SET f3='1450075',
    f7='東京都',
    f8='大田区',
    f9='西嶺町';
INSERT postalcode
SET f3='1440056',
    f7='東京都',
    f8='大田区',
    f9='西六郷';
INSERT postalcode
SET f3='1440047',
    f7='東京都',
    f8='大田区',
    f9='萩中';
INSERT postalcode
SET f3='1440043',
    f7='東京都',
    f8='大田区',
    f9='羽田';
INSERT postalcode
SET f3='1440042',
    f7='東京都',
    f8='大田区',
    f9='羽田旭町';
INSERT postalcode
SET f3='1440041',
    f7='東京都',
    f8='大田区',
    f9='羽田空港';
INSERT postalcode
SET f3='1440031',
    f7='東京都',
    f8='大田区',
    f9='東蒲田';
INSERT postalcode
SET f3='1440033',
    f7='東京都',
    f8='大田区',
    f9='東糀谷';
INSERT postalcode
SET f3='1430022',
    f7='東京都',
    f8='大田区',
    f9='東馬込';
INSERT postalcode
SET f3='1450074',
    f7='東京都',
    f8='大田区',
    f9='東嶺町';
INSERT postalcode
SET f3='1460094',
    f7='東京都',
    f8='大田区',
    f9='東矢口';
INSERT postalcode
SET f3='1450065',
    f7='東京都',
    f8='大田区',
    f9='東雪谷';
INSERT postalcode
SET f3='1440046',
    f7='東京都',
    f8='大田区',
    f9='東六郷';
INSERT postalcode
SET f3='1430007',
    f7='東京都',
    f8='大田区',
    f9='ふるさとの浜辺公園';
INSERT postalcode
SET f3='1430006',
    f7='東京都',
    f8='大田区',
    f9='平和島';
INSERT postalcode
SET f3='1430005',
    f7='東京都',
    f8='大田区',
    f9='平和の森公園';
INSERT postalcode
SET f3='1440044',
    f7='東京都',
    f8='大田区',
    f9='本羽田';
INSERT postalcode
SET f3='1440035',
    f7='東京都',
    f8='大田区',
    f9='南蒲田';
INSERT postalcode
SET f3='1460084',
    f7='東京都',
    f8='大田区',
    f9='南久が原';
INSERT postalcode
SET f3='1450063',
    f7='東京都',
    f8='大田区',
    f9='南千束';
INSERT postalcode
SET f3='1430025',
    f7='東京都',
    f8='大田区',
    f9='南馬込';
INSERT postalcode
SET f3='1450066',
    f7='東京都',
    f8='大田区',
    f9='南雪谷';
INSERT postalcode
SET f3='1440045',
    f7='東京都',
    f8='大田区',
    f9='南六郷';
INSERT postalcode
SET f3='1460093',
    f7='東京都',
    f8='大田区',
    f9='矢口';
INSERT postalcode
SET f3='1450067',
    f7='東京都',
    f8='大田区',
    f9='雪谷大塚町';
INSERT postalcode
SET f3='1540000',
    f7='東京都',
    f8='世田谷区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1560044',
    f7='東京都',
    f8='世田谷区',
    f9='赤堤';
INSERT postalcode
SET f3='1540001',
    f7='東京都',
    f8='世田谷区',
    f9='池尻';
INSERT postalcode
SET f3='1570068',
    f7='東京都',
    f8='世田谷区',
    f9='宇奈根';
INSERT postalcode
SET f3='1540022',
    f7='東京都',
    f8='世田谷区',
    f9='梅丘';
INSERT postalcode
SET f3='1570074',
    f7='東京都',
    f8='世田谷区',
    f9='大蔵';
INSERT postalcode
SET f3='1560041',
    f7='東京都',
    f8='世田谷区',
    f9='大原';
INSERT postalcode
SET f3='1570076',
    f7='東京都',
    f8='世田谷区',
    f9='岡本';
INSERT postalcode
SET f3='1580083',
    f7='東京都',
    f8='世田谷区',
    f9='奥沢';
INSERT postalcode
SET f3='1580086',
    f7='東京都',
    f8='世田谷区',
    f9='尾山台';
INSERT postalcode
SET f3='1570063',
    f7='東京都',
    f8='世田谷区',
    f9='粕谷';
INSERT postalcode
SET f3='1570077',
    f7='東京都',
    f8='世田谷区',
    f9='鎌田';
INSERT postalcode
SET f3='1540011',
    f7='東京都',
    f8='世田谷区',
    f9='上馬';
INSERT postalcode
SET f3='1560057',
    f7='東京都',
    f8='世田谷区',
    f9='上北沢';
INSERT postalcode
SET f3='1570065',
    f7='東京都',
    f8='世田谷区',
    f9='上祖師谷';
INSERT postalcode
SET f3='1580093',
    f7='東京都',
    f8='世田谷区',
    f9='上野毛';
INSERT postalcode
SET f3='1580098',
    f7='東京都',
    f8='世田谷区',
    f9='上用賀';
INSERT postalcode
SET f3='1570061',
    f7='東京都',
    f8='世田谷区',
    f9='北烏山';
INSERT postalcode
SET f3='1550031',
    f7='東京都',
    f8='世田谷区',
    f9='北沢';
INSERT postalcode
SET f3='1570067',
    f7='東京都',
    f8='世田谷区',
    f9='喜多見';
INSERT postalcode
SET f3='1570073',
    f7='東京都',
    f8='世田谷区',
    f9='砧';
INSERT postalcode
SET f3='1570075',
    f7='東京都',
    f8='世田谷区',
    f9='砧公園';
INSERT postalcode
SET f3='1570064',
    f7='東京都',
    f8='世田谷区',
    f9='給田';
INSERT postalcode
SET f3='1560052',
    f7='東京都',
    f8='世田谷区',
    f9='経堂';
INSERT postalcode
SET f3='1540021',
    f7='東京都',
    f8='世田谷区',
    f9='豪徳寺';
INSERT postalcode
SET f3='1540012',
    f7='東京都',
    f8='世田谷区',
    f9='駒沢';
INSERT postalcode
SET f3='1540013',
    f7='東京都',
    f8='世田谷区',
    f9='駒沢公園';
INSERT postalcode
SET f3='1560053',
    f7='東京都',
    f8='世田谷区',
    f9='桜';
INSERT postalcode
SET f3='1560054',
    f7='東京都',
    f8='世田谷区',
    f9='桜丘';
INSERT postalcode
SET f3='1540015',
    f7='東京都',
    f8='世田谷区',
    f9='桜新町';
INSERT postalcode
SET f3='1560045',
    f7='東京都',
    f8='世田谷区',
    f9='桜上水';
INSERT postalcode
SET f3='1540024',
    f7='東京都',
    f8='世田谷区',
    f9='三軒茶屋';
INSERT postalcode
SET f3='1540002',
    f7='東京都',
    f8='世田谷区',
    f9='下馬';
INSERT postalcode
SET f3='1540014',
    f7='東京都',
    f8='世田谷区',
    f9='新町';
INSERT postalcode
SET f3='1570066',
    f7='東京都',
    f8='世田谷区',
    f9='成城';
INSERT postalcode
SET f3='1580095',
    f7='東京都',
    f8='世田谷区',
    f9='瀬田';
INSERT postalcode
SET f3='1540017',
    f7='東京都',
    f8='世田谷区',
    f9='世田谷';
INSERT postalcode
SET f3='1570072',
    f7='東京都',
    f8='世田谷区',
    f9='祖師谷';
INSERT postalcode
SET f3='1540004',
    f7='東京都',
    f8='世田谷区',
    f9='太子堂';
INSERT postalcode
SET f3='1550032',
    f7='東京都',
    f8='世田谷区',
    f9='代沢';
INSERT postalcode
SET f3='1550033',
    f7='東京都',
    f8='世田谷区',
    f9='代田';
INSERT postalcode
SET f3='1580094',
    f7='東京都',
    f8='世田谷区',
    f9='玉川';
INSERT postalcode
SET f3='1580096',
    f7='東京都',
    f8='世田谷区',
    f9='玉川台';
INSERT postalcode
SET f3='1580085',
    f7='東京都',
    f8='世田谷区',
    f9='玉川田園調布';
INSERT postalcode
SET f3='1580087',
    f7='東京都',
    f8='世田谷区',
    f9='玉堤';
INSERT postalcode
SET f3='1570071',
    f7='東京都',
    f8='世田谷区',
    f9='千歳台';
INSERT postalcode
SET f3='1540016',
    f7='東京都',
    f8='世田谷区',
    f9='弦巻';
INSERT postalcode
SET f3='1580082',
    f7='東京都',
    f8='世田谷区',
    f9='等々力';
INSERT postalcode
SET f3='1580091',
    f7='東京都',
    f8='世田谷区',
    f9='中町';
INSERT postalcode
SET f3='1580092',
    f7='東京都',
    f8='世田谷区',
    f9='野毛';
INSERT postalcode
SET f3='1540003',
    f7='東京都',
    f8='世田谷区',
    f9='野沢';
INSERT postalcode
SET f3='1560056',
    f7='東京都',
    f8='世田谷区',
    f9='八幡山';
INSERT postalcode
SET f3='1560042',
    f7='東京都',
    f8='世田谷区',
    f9='羽根木';
INSERT postalcode
SET f3='1580084',
    f7='東京都',
    f8='世田谷区',
    f9='東玉川';
INSERT postalcode
SET f3='1580081',
    f7='東京都',
    f8='世田谷区',
    f9='深沢';
INSERT postalcode
SET f3='1560055',
    f7='東京都',
    f8='世田谷区',
    f9='船橋';
INSERT postalcode
SET f3='1560043',
    f7='東京都',
    f8='世田谷区',
    f9='松原';
INSERT postalcode
SET f3='1540005',
    f7='東京都',
    f8='世田谷区',
    f9='三宿';
INSERT postalcode
SET f3='1570062',
    f7='東京都',
    f8='世田谷区',
    f9='南烏山';
INSERT postalcode
SET f3='1560051',
    f7='東京都',
    f8='世田谷区',
    f9='宮坂';
INSERT postalcode
SET f3='1580097',
    f7='東京都',
    f8='世田谷区',
    f9='用賀';
INSERT postalcode
SET f3='1540023',
    f7='東京都',
    f8='世田谷区',
    f9='若林';
INSERT postalcode
SET f3='1500000',
    f7='東京都',
    f8='渋谷区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1510064',
    f7='東京都',
    f8='渋谷区',
    f9='上原';
INSERT postalcode
SET f3='1500032',
    f7='東京都',
    f8='渋谷区',
    f9='鶯谷町';
INSERT postalcode
SET f3='1500042',
    f7='東京都',
    f8='渋谷区',
    f9='宇田川町';
INSERT postalcode
SET f3='1500013',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿（次のビルを除く）';
INSERT postalcode
SET f3='1506090',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（地階・階層不明）';
INSERT postalcode
SET f3='1506001',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（１階）';
INSERT postalcode
SET f3='1506002',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（２階）';
INSERT postalcode
SET f3='1506003',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（３階）';
INSERT postalcode
SET f3='1506004',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（４階）';
INSERT postalcode
SET f3='1506005',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（５階）';
INSERT postalcode
SET f3='1506006',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（６階）';
INSERT postalcode
SET f3='1506007',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（７階）';
INSERT postalcode
SET f3='1506008',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（８階）';
INSERT postalcode
SET f3='1506009',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（９階）';
INSERT postalcode
SET f3='1506010',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（１０階）';
INSERT postalcode
SET f3='1506011',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（１１階）';
INSERT postalcode
SET f3='1506012',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（１２階）';
INSERT postalcode
SET f3='1506013',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（１３階）';
INSERT postalcode
SET f3='1506014',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（１４階）';
INSERT postalcode
SET f3='1506015',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（１５階）';
INSERT postalcode
SET f3='1506016',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（１６階）';
INSERT postalcode
SET f3='1506017',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（１７階）';
INSERT postalcode
SET f3='1506018',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（１８階）';
INSERT postalcode
SET f3='1506019',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（１９階）';
INSERT postalcode
SET f3='1506020',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（２０階）';
INSERT postalcode
SET f3='1506021',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（２１階）';
INSERT postalcode
SET f3='1506022',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（２２階）';
INSERT postalcode
SET f3='1506023',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（２３階）';
INSERT postalcode
SET f3='1506024',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（２４階）';
INSERT postalcode
SET f3='1506025',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（２５階）';
INSERT postalcode
SET f3='1506026',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（２６階）';
INSERT postalcode
SET f3='1506027',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（２７階）';
INSERT postalcode
SET f3='1506028',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（２８階）';
INSERT postalcode
SET f3='1506029',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（２９階）';
INSERT postalcode
SET f3='1506030',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（３０階）';
INSERT postalcode
SET f3='1506031',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（３１階）';
INSERT postalcode
SET f3='1506032',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（３２階）';
INSERT postalcode
SET f3='1506033',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（３３階）';
INSERT postalcode
SET f3='1506034',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（３４階）';
INSERT postalcode
SET f3='1506035',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（３５階）';
INSERT postalcode
SET f3='1506036',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（３６階）';
INSERT postalcode
SET f3='1506037',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（３７階）';
INSERT postalcode
SET f3='1506038',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（３８階）';
INSERT postalcode
SET f3='1506039',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿恵比寿ガーデンプレイス（３９階）';
INSERT postalcode
SET f3='1500021',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿西';
INSERT postalcode
SET f3='1500022',
    f7='東京都',
    f8='渋谷区',
    f9='恵比寿南';
INSERT postalcode
SET f3='1510065',
    f7='東京都',
    f8='渋谷区',
    f9='大山町';
INSERT postalcode
SET f3='1500047',
    f7='東京都',
    f8='渋谷区',
    f9='神山町';
INSERT postalcode
SET f3='1500031',
    f7='東京都',
    f8='渋谷区',
    f9='桜丘町';
INSERT postalcode
SET f3='1510073',
    f7='東京都',
    f8='渋谷区',
    f9='笹塚';
INSERT postalcode
SET f3='1500033',
    f7='東京都',
    f8='渋谷区',
    f9='猿楽町';
INSERT postalcode
SET f3='1500002',
    f7='東京都',
    f8='渋谷区',
    f9='渋谷';
INSERT postalcode
SET f3='1500046',
    f7='東京都',
    f8='渋谷区',
    f9='松濤';
INSERT postalcode
SET f3='1500001',
    f7='東京都',
    f8='渋谷区',
    f9='神宮前';
INSERT postalcode
SET f3='1500045',
    f7='東京都',
    f8='渋谷区',
    f9='神泉町';
INSERT postalcode
SET f3='1500041',
    f7='東京都',
    f8='渋谷区',
    f9='神南';
INSERT postalcode
SET f3='1510051',
    f7='東京都',
    f8='渋谷区',
    f9='千駄ヶ谷';
INSERT postalcode
SET f3='1500034',
    f7='東京都',
    f8='渋谷区',
    f9='代官山町';
INSERT postalcode
SET f3='1500043',
    f7='東京都',
    f8='渋谷区',
    f9='道玄坂';
INSERT postalcode
SET f3='1510063',
    f7='東京都',
    f8='渋谷区',
    f9='富ヶ谷';
INSERT postalcode
SET f3='1500036',
    f7='東京都',
    f8='渋谷区',
    f9='南平台町';
INSERT postalcode
SET f3='1510066',
    f7='東京都',
    f8='渋谷区',
    f9='西原';
INSERT postalcode
SET f3='1510072',
    f7='東京都',
    f8='渋谷区',
    f9='幡ヶ谷';
INSERT postalcode
SET f3='1500035',
    f7='東京都',
    f8='渋谷区',
    f9='鉢山町';
INSERT postalcode
SET f3='1510061',
    f7='東京都',
    f8='渋谷区',
    f9='初台';
INSERT postalcode
SET f3='1500011',
    f7='東京都',
    f8='渋谷区',
    f9='東';
INSERT postalcode
SET f3='1500012',
    f7='東京都',
    f8='渋谷区',
    f9='広尾';
INSERT postalcode
SET f3='1510071',
    f7='東京都',
    f8='渋谷区',
    f9='本町';
INSERT postalcode
SET f3='1500044',
    f7='東京都',
    f8='渋谷区',
    f9='円山町';
INSERT postalcode
SET f3='1510062',
    f7='東京都',
    f8='渋谷区',
    f9='元代々木町';
INSERT postalcode
SET f3='1510053',
    f7='東京都',
    f8='渋谷区',
    f9='代々木';
INSERT postalcode
SET f3='1510052',
    f7='東京都',
    f8='渋谷区',
    f9='代々木神園町';
INSERT postalcode
SET f3='1640000',
    f7='東京都',
    f8='中野区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1650026',
    f7='東京都',
    f8='中野区',
    f9='新井';
INSERT postalcode
SET f3='1650022',
    f7='東京都',
    f8='中野区',
    f9='江古田';
INSERT postalcode
SET f3='1650023',
    f7='東京都',
    f8='中野区',
    f9='江原町';
INSERT postalcode
SET f3='1650031',
    f7='東京都',
    f8='中野区',
    f9='上鷺宮';
INSERT postalcode
SET f3='1640002',
    f7='東京都',
    f8='中野区',
    f9='上高田';
INSERT postalcode
SET f3='1650032',
    f7='東京都',
    f8='中野区',
    f9='鷺宮';
INSERT postalcode
SET f3='1650035',
    f7='東京都',
    f8='中野区',
    f9='白鷺';
INSERT postalcode
SET f3='1640011',
    f7='東京都',
    f8='中野区',
    f9='中央';
INSERT postalcode
SET f3='1640001',
    f7='東京都',
    f8='中野区',
    f9='中野';
INSERT postalcode
SET f3='1650025',
    f7='東京都',
    f8='中野区',
    f9='沼袋';
INSERT postalcode
SET f3='1650027',
    f7='東京都',
    f8='中野区',
    f9='野方';
INSERT postalcode
SET f3='1640003',
    f7='東京都',
    f8='中野区',
    f9='東中野';
INSERT postalcode
SET f3='1640012',
    f7='東京都',
    f8='中野区',
    f9='本町';
INSERT postalcode
SET f3='1650024',
    f7='東京都',
    f8='中野区',
    f9='松が丘';
INSERT postalcode
SET f3='1650021',
    f7='東京都',
    f8='中野区',
    f9='丸山';
INSERT postalcode
SET f3='1640014',
    f7='東京都',
    f8='中野区',
    f9='南台';
INSERT postalcode
SET f3='1650034',
    f7='東京都',
    f8='中野区',
    f9='大和町';
INSERT postalcode
SET f3='1640013',
    f7='東京都',
    f8='中野区',
    f9='弥生町';
INSERT postalcode
SET f3='1650033',
    f7='東京都',
    f8='中野区',
    f9='若宮';
INSERT postalcode
SET f3='1660000',
    f7='東京都',
    f8='杉並区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1660004',
    f7='東京都',
    f8='杉並区',
    f9='阿佐谷南';
INSERT postalcode
SET f3='1660001',
    f7='東京都',
    f8='杉並区',
    f9='阿佐谷北';
INSERT postalcode
SET f3='1670032',
    f7='東京都',
    f8='杉並区',
    f9='天沼';
INSERT postalcode
SET f3='1670021',
    f7='東京都',
    f8='杉並区',
    f9='井草';
INSERT postalcode
SET f3='1680063',
    f7='東京都',
    f8='杉並区',
    f9='和泉';
INSERT postalcode
SET f3='1670035',
    f7='東京都',
    f8='杉並区',
    f9='今川';
INSERT postalcode
SET f3='1660011',
    f7='東京都',
    f8='杉並区',
    f9='梅里';
INSERT postalcode
SET f3='1680064',
    f7='東京都',
    f8='杉並区',
    f9='永福';
INSERT postalcode
SET f3='1680061',
    f7='東京都',
    f8='杉並区',
    f9='大宮';
INSERT postalcode
SET f3='1670051',
    f7='東京都',
    f8='杉並区',
    f9='荻窪';
INSERT postalcode
SET f3='1670023',
    f7='東京都',
    f8='杉並区',
    f9='上井草';
INSERT postalcode
SET f3='1670043',
    f7='東京都',
    f8='杉並区',
    f9='上荻';
INSERT postalcode
SET f3='1680074',
    f7='東京都',
    f8='杉並区',
    f9='上高井戸';
INSERT postalcode
SET f3='1680082',
    f7='東京都',
    f8='杉並区',
    f9='久我山';
INSERT postalcode
SET f3='1660003',
    f7='東京都',
    f8='杉並区',
    f9='高円寺南';
INSERT postalcode
SET f3='1660002',
    f7='東京都',
    f8='杉並区',
    f9='高円寺北';
INSERT postalcode
SET f3='1670033',
    f7='東京都',
    f8='杉並区',
    f9='清水';
INSERT postalcode
SET f3='1670022',
    f7='東京都',
    f8='杉並区',
    f9='下井草';
INSERT postalcode
SET f3='1680073',
    f7='東京都',
    f8='杉並区',
    f9='下高井戸';
INSERT postalcode
SET f3='1670054',
    f7='東京都',
    f8='杉並区',
    f9='松庵';
INSERT postalcode
SET f3='1670041',
    f7='東京都',
    f8='杉並区',
    f9='善福寺';
INSERT postalcode
SET f3='1680072',
    f7='東京都',
    f8='杉並区',
    f9='高井戸東';
INSERT postalcode
SET f3='1680071',
    f7='東京都',
    f8='杉並区',
    f9='高井戸西';
INSERT postalcode
SET f3='1660015',
    f7='東京都',
    f8='杉並区',
    f9='成田東';
INSERT postalcode
SET f3='1660016',
    f7='東京都',
    f8='杉並区',
    f9='成田西';
INSERT postalcode
SET f3='1670053',
    f7='東京都',
    f8='杉並区',
    f9='西荻南';
INSERT postalcode
SET f3='1670042',
    f7='東京都',
    f8='杉並区',
    f9='西荻北';
INSERT postalcode
SET f3='1680065',
    f7='東京都',
    f8='杉並区',
    f9='浜田山';
INSERT postalcode
SET f3='1680062',
    f7='東京都',
    f8='杉並区',
    f9='方南';
INSERT postalcode
SET f3='1660013',
    f7='東京都',
    f8='杉並区',
    f9='堀ノ内';
INSERT postalcode
SET f3='1670031',
    f7='東京都',
    f8='杉並区',
    f9='本天沼';
INSERT postalcode
SET f3='1660014',
    f7='東京都',
    f8='杉並区',
    f9='松ノ木';
INSERT postalcode
SET f3='1670052',
    f7='東京都',
    f8='杉並区',
    f9='南荻窪';
INSERT postalcode
SET f3='1680081',
    f7='東京都',
    f8='杉並区',
    f9='宮前';
INSERT postalcode
SET f3='1670034',
    f7='東京都',
    f8='杉並区',
    f9='桃井';
INSERT postalcode
SET f3='1660012',
    f7='東京都',
    f8='杉並区',
    f9='和田';
INSERT postalcode
SET f3='1700000',
    f7='東京都',
    f8='豊島区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1700014',
    f7='東京都',
    f8='豊島区',
    f9='池袋（１丁目）';
INSERT postalcode
SET f3='1710014',
    f7='東京都',
    f8='豊島区',
    f9='池袋（２〜４丁目）';
INSERT postalcode
SET f3='1700011',
    f7='東京都',
    f8='豊島区',
    f9='池袋本町';
INSERT postalcode
SET f3='1710043',
    f7='東京都',
    f8='豊島区',
    f9='要町';
INSERT postalcode
SET f3='1700012',
    f7='東京都',
    f8='豊島区',
    f9='上池袋';
INSERT postalcode
SET f3='1700004',
    f7='東京都',
    f8='豊島区',
    f9='北大塚';
INSERT postalcode
SET f3='1700003',
    f7='東京都',
    f8='豊島区',
    f9='駒込';
INSERT postalcode
SET f3='1700002',
    f7='東京都',
    f8='豊島区',
    f9='巣鴨';
INSERT postalcode
SET f3='1710041',
    f7='東京都',
    f8='豊島区',
    f9='千川';
INSERT postalcode
SET f3='1710032',
    f7='東京都',
    f8='豊島区',
    f9='雑司が谷';
INSERT postalcode
SET f3='1710033',
    f7='東京都',
    f8='豊島区',
    f9='高田';
INSERT postalcode
SET f3='1710042',
    f7='東京都',
    f8='豊島区',
    f9='高松';
INSERT postalcode
SET f3='1710044',
    f7='東京都',
    f8='豊島区',
    f9='千早';
INSERT postalcode
SET f3='1710051',
    f7='東京都',
    f8='豊島区',
    f9='長崎';
INSERT postalcode
SET f3='1710021',
    f7='東京都',
    f8='豊島区',
    f9='西池袋';
INSERT postalcode
SET f3='1700001',
    f7='東京都',
    f8='豊島区',
    f9='西巣鴨';
INSERT postalcode
SET f3='1700013',
    f7='東京都',
    f8='豊島区',
    f9='東池袋（次のビルを除く）';
INSERT postalcode
SET f3='1706090',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（地階・階層不明）';
INSERT postalcode
SET f3='1706001',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（１階）';
INSERT postalcode
SET f3='1706002',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（２階）';
INSERT postalcode
SET f3='1706003',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（３階）';
INSERT postalcode
SET f3='1706004',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（４階）';
INSERT postalcode
SET f3='1706005',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（５階）';
INSERT postalcode
SET f3='1706006',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（６階）';
INSERT postalcode
SET f3='1706007',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（７階）';
INSERT postalcode
SET f3='1706008',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（８階）';
INSERT postalcode
SET f3='1706009',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（９階）';
INSERT postalcode
SET f3='1706010',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（１０階）';
INSERT postalcode
SET f3='1706011',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（１１階）';
INSERT postalcode
SET f3='1706012',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（１２階）';
INSERT postalcode
SET f3='1706013',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（１３階）';
INSERT postalcode
SET f3='1706014',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（１４階）';
INSERT postalcode
SET f3='1706015',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（１５階）';
INSERT postalcode
SET f3='1706016',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（１６階）';
INSERT postalcode
SET f3='1706017',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（１７階）';
INSERT postalcode
SET f3='1706018',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（１８階）';
INSERT postalcode
SET f3='1706019',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（１９階）';
INSERT postalcode
SET f3='1706020',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（２０階）';
INSERT postalcode
SET f3='1706021',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（２１階）';
INSERT postalcode
SET f3='1706022',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（２２階）';
INSERT postalcode
SET f3='1706023',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（２３階）';
INSERT postalcode
SET f3='1706024',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（２４階）';
INSERT postalcode
SET f3='1706025',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（２５階）';
INSERT postalcode
SET f3='1706026',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（２６階）';
INSERT postalcode
SET f3='1706027',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（２７階）';
INSERT postalcode
SET f3='1706028',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（２８階）';
INSERT postalcode
SET f3='1706029',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（２９階）';
INSERT postalcode
SET f3='1706030',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（３０階）';
INSERT postalcode
SET f3='1706031',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（３１階）';
INSERT postalcode
SET f3='1706032',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（３２階）';
INSERT postalcode
SET f3='1706033',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（３３階）';
INSERT postalcode
SET f3='1706034',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（３４階）';
INSERT postalcode
SET f3='1706035',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（３５階）';
INSERT postalcode
SET f3='1706036',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（３６階）';
INSERT postalcode
SET f3='1706037',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（３７階）';
INSERT postalcode
SET f3='1706038',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（３８階）';
INSERT postalcode
SET f3='1706039',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（３９階）';
INSERT postalcode
SET f3='1706040',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（４０階）';
INSERT postalcode
SET f3='1706041',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（４１階）';
INSERT postalcode
SET f3='1706042',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（４２階）';
INSERT postalcode
SET f3='1706043',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（４３階）';
INSERT postalcode
SET f3='1706044',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（４４階）';
INSERT postalcode
SET f3='1706045',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（４５階）';
INSERT postalcode
SET f3='1706046',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（４６階）';
INSERT postalcode
SET f3='1706047',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（４７階）';
INSERT postalcode
SET f3='1706048',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（４８階）';
INSERT postalcode
SET f3='1706049',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（４９階）';
INSERT postalcode
SET f3='1706050',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（５０階）';
INSERT postalcode
SET f3='1706051',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（５１階）';
INSERT postalcode
SET f3='1706052',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（５２階）';
INSERT postalcode
SET f3='1706053',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（５３階）';
INSERT postalcode
SET f3='1706054',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（５４階）';
INSERT postalcode
SET f3='1706055',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（５５階）';
INSERT postalcode
SET f3='1706056',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（５６階）';
INSERT postalcode
SET f3='1706057',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（５７階）';
INSERT postalcode
SET f3='1706058',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（５８階）';
INSERT postalcode
SET f3='1706059',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（５９階）';
INSERT postalcode
SET f3='1706060',
    f7='東京都',
    f8='豊島区',
    f9='東池袋サンシャイン６０（６０階）';
INSERT postalcode
SET f3='1710022',
    f7='東京都',
    f8='豊島区',
    f9='南池袋';
INSERT postalcode
SET f3='1700005',
    f7='東京都',
    f8='豊島区',
    f9='南大塚';
INSERT postalcode
SET f3='1710052',
    f7='東京都',
    f8='豊島区',
    f9='南長崎';
INSERT postalcode
SET f3='1710031',
    f7='東京都',
    f8='豊島区',
    f9='目白';
INSERT postalcode
SET f3='1140000',
    f7='東京都',
    f8='北区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1150045',
    f7='東京都',
    f8='北区',
    f9='赤羽';
INSERT postalcode
SET f3='1150053',
    f7='東京都',
    f8='北区',
    f9='赤羽台';
INSERT postalcode
SET f3='1150055',
    f7='東京都',
    f8='北区',
    f9='赤羽西';
INSERT postalcode
SET f3='1150044',
    f7='東京都',
    f8='北区',
    f9='赤羽南';
INSERT postalcode
SET f3='1150052',
    f7='東京都',
    f8='北区',
    f9='赤羽北';
INSERT postalcode
SET f3='1150041',
    f7='東京都',
    f8='北区',
    f9='岩淵町';
INSERT postalcode
SET f3='1150051',
    f7='東京都',
    f8='北区',
    f9='浮間';
INSERT postalcode
SET f3='1140002',
    f7='東京都',
    f8='北区',
    f9='王子';
INSERT postalcode
SET f3='1140022',
    f7='東京都',
    f8='北区',
    f9='王子本町';
INSERT postalcode
SET f3='1140034',
    f7='東京都',
    f8='北区',
    f9='上十条';
INSERT postalcode
SET f3='1140016',
    f7='東京都',
    f8='北区',
    f9='上中里';
INSERT postalcode
SET f3='1150043',
    f7='東京都',
    f8='北区',
    f9='神谷';
INSERT postalcode
SET f3='1140021',
    f7='東京都',
    f8='北区',
    f9='岸町';
INSERT postalcode
SET f3='1150054',
    f7='東京都',
    f8='北区',
    f9='桐ケ丘';
INSERT postalcode
SET f3='1140005',
    f7='東京都',
    f8='北区',
    f9='栄町';
INSERT postalcode
SET f3='1150042',
    f7='東京都',
    f8='北区',
    f9='志茂';
INSERT postalcode
SET f3='1140033',
    f7='東京都',
    f8='北区',
    f9='十条台';
INSERT postalcode
SET f3='1140031',
    f7='東京都',
    f8='北区',
    f9='十条仲原';
INSERT postalcode
SET f3='1140011',
    f7='東京都',
    f8='北区',
    f9='昭和町';
INSERT postalcode
SET f3='1140023',
    f7='東京都',
    f8='北区',
    f9='滝野川';
INSERT postalcode
SET f3='1140014',
    f7='東京都',
    f8='北区',
    f9='田端';
INSERT postalcode
SET f3='1140012',
    f7='東京都',
    f8='北区',
    f9='田端新町';
INSERT postalcode
SET f3='1140003',
    f7='東京都',
    f8='北区',
    f9='豊島';
INSERT postalcode
SET f3='1140015',
    f7='東京都',
    f8='北区',
    f9='中里';
INSERT postalcode
SET f3='1140032',
    f7='東京都',
    f8='北区',
    f9='中十条';
INSERT postalcode
SET f3='1150056',
    f7='東京都',
    f8='北区',
    f9='西が丘';
INSERT postalcode
SET f3='1140024',
    f7='東京都',
    f8='北区',
    f9='西ケ原';
INSERT postalcode
SET f3='1140001',
    f7='東京都',
    f8='北区',
    f9='東十条';
INSERT postalcode
SET f3='1140013',
    f7='東京都',
    f8='北区',
    f9='東田端';
INSERT postalcode
SET f3='1140004',
    f7='東京都',
    f8='北区',
    f9='堀船';
INSERT postalcode
SET f3='1160000',
    f7='東京都',
    f8='荒川区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1160002',
    f7='東京都',
    f8='荒川区',
    f9='荒川';
INSERT postalcode
SET f3='1160011',
    f7='東京都',
    f8='荒川区',
    f9='西尾久';
INSERT postalcode
SET f3='1160013',
    f7='東京都',
    f8='荒川区',
    f9='西日暮里';
INSERT postalcode
SET f3='1160012',
    f7='東京都',
    f8='荒川区',
    f9='東尾久';
INSERT postalcode
SET f3='1160014',
    f7='東京都',
    f8='荒川区',
    f9='東日暮里';
INSERT postalcode
SET f3='1160001',
    f7='東京都',
    f8='荒川区',
    f9='町屋';
INSERT postalcode
SET f3='1160003',
    f7='東京都',
    f8='荒川区',
    f9='南千住';
INSERT postalcode
SET f3='1740000',
    f7='東京都',
    f8='板橋区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1740044',
    f7='東京都',
    f8='板橋区',
    f9='相生町';
INSERT postalcode
SET f3='1750092',
    f7='東京都',
    f8='板橋区',
    f9='赤塚';
INSERT postalcode
SET f3='1750093',
    f7='東京都',
    f8='板橋区',
    f9='赤塚新町';
INSERT postalcode
SET f3='1740051',
    f7='東京都',
    f8='板橋区',
    f9='小豆沢';
INSERT postalcode
SET f3='1740055',
    f7='東京都',
    f8='板橋区',
    f9='泉町';
INSERT postalcode
SET f3='1730004',
    f7='東京都',
    f8='板橋区',
    f9='板橋';
INSERT postalcode
SET f3='1730002',
    f7='東京都',
    f8='板橋区',
    f9='稲荷台';
INSERT postalcode
SET f3='1740061',
    f7='東京都',
    f8='板橋区',
    f9='大原町';
INSERT postalcode
SET f3='1730035',
    f7='東京都',
    f8='板橋区',
    f9='大谷口';
INSERT postalcode
SET f3='1730032',
    f7='東京都',
    f8='板橋区',
    f9='大谷口上町';
INSERT postalcode
SET f3='1730031',
    f7='東京都',
    f8='板橋区',
    f9='大谷口北町';
INSERT postalcode
SET f3='1730024',
    f7='東京都',
    f8='板橋区',
    f9='大山金井町';
INSERT postalcode
SET f3='1730014',
    f7='東京都',
    f8='板橋区',
    f9='大山東町';
INSERT postalcode
SET f3='1730033',
    f7='東京都',
    f8='板橋区',
    f9='大山西町';
INSERT postalcode
SET f3='1730023',
    f7='東京都',
    f8='板橋区',
    f9='大山町';
INSERT postalcode
SET f3='1730003',
    f7='東京都',
    f8='板橋区',
    f9='加賀';
INSERT postalcode
SET f3='1740076',
    f7='東京都',
    f8='板橋区',
    f9='上板橋';
INSERT postalcode
SET f3='1730025',
    f7='東京都',
    f8='板橋区',
    f9='熊野町';
INSERT postalcode
SET f3='1730037',
    f7='東京都',
    f8='板橋区',
    f9='小茂根';
INSERT postalcode
SET f3='1730034',
    f7='東京都',
    f8='板橋区',
    f9='幸町';
INSERT postalcode
SET f3='1730015',
    f7='東京都',
    f8='板橋区',
    f9='栄町';
INSERT postalcode
SET f3='1740043',
    f7='東京都',
    f8='板橋区',
    f9='坂下';
INSERT postalcode
SET f3='1740075',
    f7='東京都',
    f8='板橋区',
    f9='桜川';
INSERT postalcode
SET f3='1740053',
    f7='東京都',
    f8='板橋区',
    f9='清水町';
INSERT postalcode
SET f3='1740056',
    f7='東京都',
    f8='板橋区',
    f9='志村';
INSERT postalcode
SET f3='1750081',
    f7='東京都',
    f8='板橋区',
    f9='新河岸';
INSERT postalcode
SET f3='1750085',
    f7='東京都',
    f8='板橋区',
    f9='大門';
INSERT postalcode
SET f3='1750082',
    f7='東京都',
    f8='板橋区',
    f9='高島平';
INSERT postalcode
SET f3='1740074',
    f7='東京都',
    f8='板橋区',
    f9='東新町';
INSERT postalcode
SET f3='1740071',
    f7='東京都',
    f8='板橋区',
    f9='常盤台';
INSERT postalcode
SET f3='1750083',
    f7='東京都',
    f8='板橋区',
    f9='徳丸';
INSERT postalcode
SET f3='1730016',
    f7='東京都',
    f8='板橋区',
    f9='中板橋';
INSERT postalcode
SET f3='1730005',
    f7='東京都',
    f8='板橋区',
    f9='仲宿';
INSERT postalcode
SET f3='1740064',
    f7='東京都',
    f8='板橋区',
    f9='中台';
INSERT postalcode
SET f3='1730022',
    f7='東京都',
    f8='板橋区',
    f9='仲町';
INSERT postalcode
SET f3='1730026',
    f7='東京都',
    f8='板橋区',
    f9='中丸町';
INSERT postalcode
SET f3='1750094',
    f7='東京都',
    f8='板橋区',
    f9='成増';
INSERT postalcode
SET f3='1740045',
    f7='東京都',
    f8='板橋区',
    f9='西台（１丁目）';
INSERT postalcode
SET f3='1750045',
    f7='東京都',
    f8='板橋区',
    f9='西台（２〜４丁目）';
INSERT postalcode
SET f3='1740052',
    f7='東京都',
    f8='板橋区',
    f9='蓮沼町';
INSERT postalcode
SET f3='1740046',
    f7='東京都',
    f8='板橋区',
    f9='蓮根';
INSERT postalcode
SET f3='1730013',
    f7='東京都',
    f8='板橋区',
    f9='氷川町';
INSERT postalcode
SET f3='1740042',
    f7='東京都',
    f8='板橋区',
    f9='東坂下';
INSERT postalcode
SET f3='1740073',
    f7='東京都',
    f8='板橋区',
    f9='東山町';
INSERT postalcode
SET f3='1740062',
    f7='東京都',
    f8='板橋区',
    f9='富士見町';
INSERT postalcode
SET f3='1730011',
    f7='東京都',
    f8='板橋区',
    f9='双葉町';
INSERT postalcode
SET f3='1740041',
    f7='東京都',
    f8='板橋区',
    f9='舟渡';
INSERT postalcode
SET f3='1730001',
    f7='東京都',
    f8='板橋区',
    f9='本町';
INSERT postalcode
SET f3='1740063',
    f7='東京都',
    f8='板橋区',
    f9='前野町';
INSERT postalcode
SET f3='1750091',
    f7='東京都',
    f8='板橋区',
    f9='三園';
INSERT postalcode
SET f3='1730027',
    f7='東京都',
    f8='板橋区',
    f9='南町';
INSERT postalcode
SET f3='1740072',
    f7='東京都',
    f8='板橋区',
    f9='南常盤台';
INSERT postalcode
SET f3='1740054',
    f7='東京都',
    f8='板橋区',
    f9='宮本町';
INSERT postalcode
SET f3='1730036',
    f7='東京都',
    f8='板橋区',
    f9='向原';
INSERT postalcode
SET f3='1730012',
    f7='東京都',
    f8='板橋区',
    f9='大和町';
INSERT postalcode
SET f3='1730021',
    f7='東京都',
    f8='板橋区',
    f9='弥生町';
INSERT postalcode
SET f3='1750084',
    f7='東京都',
    f8='板橋区',
    f9='四葉';
INSERT postalcode
SET f3='1740065',
    f7='東京都',
    f8='板橋区',
    f9='若木';
INSERT postalcode
SET f3='1760000',
    f7='東京都',
    f8='練馬区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1760005',
    f7='東京都',
    f8='練馬区',
    f9='旭丘';
INSERT postalcode
SET f3='1790071',
    f7='東京都',
    f8='練馬区',
    f9='旭町';
INSERT postalcode
SET f3='1780061',
    f7='東京都',
    f8='練馬区',
    f9='大泉学園町';
INSERT postalcode
SET f3='1780062',
    f7='東京都',
    f8='練馬区',
    f9='大泉町';
INSERT postalcode
SET f3='1790074',
    f7='東京都',
    f8='練馬区',
    f9='春日町';
INSERT postalcode
SET f3='1770044',
    f7='東京都',
    f8='練馬区',
    f9='上石神井';
INSERT postalcode
SET f3='1770043',
    f7='東京都',
    f8='練馬区',
    f9='上石神井南町';
INSERT postalcode
SET f3='1790081',
    f7='東京都',
    f8='練馬区',
    f9='北町';
INSERT postalcode
SET f3='1760022',
    f7='東京都',
    f8='練馬区',
    f9='向山';
INSERT postalcode
SET f3='1760004',
    f7='東京都',
    f8='練馬区',
    f9='小竹町';
INSERT postalcode
SET f3='1760006',
    f7='東京都',
    f8='練馬区',
    f9='栄町';
INSERT postalcode
SET f3='1760002',
    f7='東京都',
    f8='練馬区',
    f9='桜台';
INSERT postalcode
SET f3='1770042',
    f7='東京都',
    f8='練馬区',
    f9='下石神井';
INSERT postalcode
SET f3='1770045',
    f7='東京都',
    f8='練馬区',
    f9='石神井台';
INSERT postalcode
SET f3='1770041',
    f7='東京都',
    f8='練馬区',
    f9='石神井町';
INSERT postalcode
SET f3='1770052',
    f7='東京都',
    f8='練馬区',
    f9='関町東';
INSERT postalcode
SET f3='1770053',
    f7='東京都',
    f8='練馬区',
    f9='関町南';
INSERT postalcode
SET f3='1770051',
    f7='東京都',
    f8='練馬区',
    f9='関町北';
INSERT postalcode
SET f3='1770033',
    f7='東京都',
    f8='練馬区',
    f9='高野台';
INSERT postalcode
SET f3='1790075',
    f7='東京都',
    f8='練馬区',
    f9='高松';
INSERT postalcode
SET f3='1790073',
    f7='東京都',
    f8='練馬区',
    f9='田柄';
INSERT postalcode
SET f3='1770054',
    f7='東京都',
    f8='練馬区',
    f9='立野町';
INSERT postalcode
SET f3='1790076',
    f7='東京都',
    f8='練馬区',
    f9='土支田';
INSERT postalcode
SET f3='1760011',
    f7='東京都',
    f8='練馬区',
    f9='豊玉上';
INSERT postalcode
SET f3='1760013',
    f7='東京都',
    f8='練馬区',
    f9='豊玉中';
INSERT postalcode
SET f3='1760014',
    f7='東京都',
    f8='練馬区',
    f9='豊玉南';
INSERT postalcode
SET f3='1760012',
    f7='東京都',
    f8='練馬区',
    f9='豊玉北';
INSERT postalcode
SET f3='1760024',
    f7='東京都',
    f8='練馬区',
    f9='中村';
INSERT postalcode
SET f3='1760025',
    f7='東京都',
    f8='練馬区',
    f9='中村南';
INSERT postalcode
SET f3='1760023',
    f7='東京都',
    f8='練馬区',
    f9='中村北';
INSERT postalcode
SET f3='1780065',
    f7='東京都',
    f8='練馬区',
    f9='西大泉';
INSERT postalcode
SET f3='1780066',
    f7='東京都',
    f8='練馬区',
    f9='西大泉町';
INSERT postalcode
SET f3='1790082',
    f7='東京都',
    f8='練馬区',
    f9='錦';
INSERT postalcode
SET f3='1760021',
    f7='東京都',
    f8='練馬区',
    f9='貫井';
INSERT postalcode
SET f3='1760001',
    f7='東京都',
    f8='練馬区',
    f9='練馬';
INSERT postalcode
SET f3='1760003',
    f7='東京都',
    f8='練馬区',
    f9='羽沢';
INSERT postalcode
SET f3='1790085',
    f7='東京都',
    f8='練馬区',
    f9='早宮';
INSERT postalcode
SET f3='1790072',
    f7='東京都',
    f8='練馬区',
    f9='光が丘';
INSERT postalcode
SET f3='1790084',
    f7='東京都',
    f8='練馬区',
    f9='氷川台';
INSERT postalcode
SET f3='1780063',
    f7='東京都',
    f8='練馬区',
    f9='東大泉';
INSERT postalcode
SET f3='1770034',
    f7='東京都',
    f8='練馬区',
    f9='富士見台';
INSERT postalcode
SET f3='1790083',
    f7='東京都',
    f8='練馬区',
    f9='平和台';
INSERT postalcode
SET f3='1780064',
    f7='東京都',
    f8='練馬区',
    f9='南大泉';
INSERT postalcode
SET f3='1770035',
    f7='東京都',
    f8='練馬区',
    f9='南田中';
INSERT postalcode
SET f3='1770031',
    f7='東京都',
    f8='練馬区',
    f9='三原台';
INSERT postalcode
SET f3='1770032',
    f7='東京都',
    f8='練馬区',
    f9='谷原';
INSERT postalcode
SET f3='1200000',
    f7='東京都',
    f8='足立区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1200012',
    f7='東京都',
    f8='足立区',
    f9='青井（１〜３丁目）';
INSERT postalcode
SET f3='1210012',
    f7='東京都',
    f8='足立区',
    f9='青井（４〜６丁目）';
INSERT postalcode
SET f3='1200015',
    f7='東京都',
    f8='足立区',
    f9='足立';
INSERT postalcode
SET f3='1200005',
    f7='東京都',
    f8='足立区',
    f9='綾瀬';
INSERT postalcode
SET f3='1210823',
    f7='東京都',
    f8='足立区',
    f9='伊興';
INSERT postalcode
SET f3='1210807',
    f7='東京都',
    f8='足立区',
    f9='伊興本町';
INSERT postalcode
SET f3='1210836',
    f7='東京都',
    f8='足立区',
    f9='入谷';
INSERT postalcode
SET f3='1210834',
    f7='東京都',
    f8='足立区',
    f9='入谷町';
INSERT postalcode
SET f3='1210816',
    f7='東京都',
    f8='足立区',
    f9='梅島';
INSERT postalcode
SET f3='1230851',
    f7='東京都',
    f8='足立区',
    f9='梅田';
INSERT postalcode
SET f3='1230873',
    f7='東京都',
    f8='足立区',
    f9='扇';
INSERT postalcode
SET f3='1200001',
    f7='東京都',
    f8='足立区',
    f9='大谷田';
INSERT postalcode
SET f3='1230844',
    f7='東京都',
    f8='足立区',
    f9='興野';
INSERT postalcode
SET f3='1200046',
    f7='東京都',
    f8='足立区',
    f9='小台';
INSERT postalcode
SET f3='1230861',
    f7='東京都',
    f8='足立区',
    f9='加賀';
INSERT postalcode
SET f3='1210055',
    f7='東京都',
    f8='足立区',
    f9='加平';
INSERT postalcode
SET f3='1210056',
    f7='東京都',
    f8='足立区',
    f9='北加平町';
INSERT postalcode
SET f3='1230842',
    f7='東京都',
    f8='足立区',
    f9='栗原';
INSERT postalcode
SET f3='1200013',
    f7='東京都',
    f8='足立区',
    f9='弘道';
INSERT postalcode
SET f3='1230872',
    f7='東京都',
    f8='足立区',
    f9='江北';
INSERT postalcode
SET f3='1210833',
    f7='東京都',
    f8='足立区',
    f9='古千谷';
INSERT postalcode
SET f3='1210832',
    f7='東京都',
    f8='足立区',
    f9='古千谷本町';
INSERT postalcode
SET f3='1210053',
    f7='東京都',
    f8='足立区',
    f9='佐野';
INSERT postalcode
SET f3='1230862',
    f7='東京都',
    f8='足立区',
    f9='皿沼';
INSERT postalcode
SET f3='1230864',
    f7='東京都',
    f8='足立区',
    f9='鹿浜';
INSERT postalcode
SET f3='1210815',
    f7='東京都',
    f8='足立区',
    f9='島根';
INSERT postalcode
SET f3='1230865',
    f7='東京都',
    f8='足立区',
    f9='新田';
INSERT postalcode
SET f3='1210051',
    f7='東京都',
    f8='足立区',
    f9='神明';
INSERT postalcode
SET f3='1210057',
    f7='東京都',
    f8='足立区',
    f9='神明南';
INSERT postalcode
SET f3='1230852',
    f7='東京都',
    f8='足立区',
    f9='関原';
INSERT postalcode
SET f3='1200034',
    f7='東京都',
    f8='足立区',
    f9='千住';
INSERT postalcode
SET f3='1200023',
    f7='東京都',
    f8='足立区',
    f9='千住曙町';
INSERT postalcode
SET f3='1200026',
    f7='東京都',
    f8='足立区',
    f9='千住旭町';
INSERT postalcode
SET f3='1200025',
    f7='東京都',
    f8='足立区',
    f9='千住東';
INSERT postalcode
SET f3='1200031',
    f7='東京都',
    f8='足立区',
    f9='千住大川町';
INSERT postalcode
SET f3='1200037',
    f7='東京都',
    f8='足立区',
    f9='千住河原町';
INSERT postalcode
SET f3='1200033',
    f7='東京都',
    f8='足立区',
    f9='千住寿町';
INSERT postalcode
SET f3='1200045',
    f7='東京都',
    f8='足立区',
    f9='千住桜木';
INSERT postalcode
SET f3='1200024',
    f7='東京都',
    f8='足立区',
    f9='千住関屋町';
INSERT postalcode
SET f3='1200042',
    f7='東京都',
    f8='足立区',
    f9='千住龍田町';
INSERT postalcode
SET f3='1200035',
    f7='東京都',
    f8='足立区',
    f9='千住中居町';
INSERT postalcode
SET f3='1200036',
    f7='東京都',
    f8='足立区',
    f9='千住仲町';
INSERT postalcode
SET f3='1200038',
    f7='東京都',
    f8='足立区',
    f9='千住橋戸町';
INSERT postalcode
SET f3='1200044',
    f7='東京都',
    f8='足立区',
    f9='千住緑町';
INSERT postalcode
SET f3='1200043',
    f7='東京都',
    f8='足立区',
    f9='千住宮元町';
INSERT postalcode
SET f3='1200041',
    f7='東京都',
    f8='足立区',
    f9='千住元町';
INSERT postalcode
SET f3='1200032',
    f7='東京都',
    f8='足立区',
    f9='千住柳町';
INSERT postalcode
SET f3='1210813',
    f7='東京都',
    f8='足立区',
    f9='竹の塚';
INSERT postalcode
SET f3='1210054',
    f7='東京都',
    f8='足立区',
    f9='辰沼';
INSERT postalcode
SET f3='1200011',
    f7='東京都',
    f8='足立区',
    f9='中央本町（１、２丁目）';
INSERT postalcode
SET f3='1210011',
    f7='東京都',
    f8='足立区',
    f9='中央本町（３〜５丁目）';
INSERT postalcode
SET f3='1230871',
    f7='東京都',
    f8='足立区',
    f9='椿';
INSERT postalcode
SET f3='1200003',
    f7='東京都',
    f8='足立区',
    f9='東和';
INSERT postalcode
SET f3='1210831',
    f7='東京都',
    f8='足立区',
    f9='舎人';
INSERT postalcode
SET f3='1210837',
    f7='東京都',
    f8='足立区',
    f9='舎人公園';
INSERT postalcode
SET f3='1210835',
    f7='東京都',
    f8='足立区',
    f9='舎人町';
INSERT postalcode
SET f3='1200002',
    f7='東京都',
    f8='足立区',
    f9='中川';
INSERT postalcode
SET f3='1200014',
    f7='東京都',
    f8='足立区',
    f9='西綾瀬';
INSERT postalcode
SET f3='1230841',
    f7='東京都',
    f8='足立区',
    f9='西新井';
INSERT postalcode
SET f3='1230843',
    f7='東京都',
    f8='足立区',
    f9='西新井栄町';
INSERT postalcode
SET f3='1230845',
    f7='東京都',
    f8='足立区',
    f9='西新井本町';
INSERT postalcode
SET f3='1210824',
    f7='東京都',
    f8='足立区',
    f9='西伊興';
INSERT postalcode
SET f3='1210825',
    f7='東京都',
    f8='足立区',
    f9='西伊興町';
INSERT postalcode
SET f3='1210074',
    f7='東京都',
    f8='足立区',
    f9='西加平';
INSERT postalcode
SET f3='1210822',
    f7='東京都',
    f8='足立区',
    f9='西竹の塚';
INSERT postalcode
SET f3='1210812',
    f7='東京都',
    f8='足立区',
    f9='西保木間';
INSERT postalcode
SET f3='1210061',
    f7='東京都',
    f8='足立区',
    f9='花畑';
INSERT postalcode
SET f3='1200004',
    f7='東京都',
    f8='足立区',
    f9='東綾瀬';
INSERT postalcode
SET f3='1210801',
    f7='東京都',
    f8='足立区',
    f9='東伊興';
INSERT postalcode
SET f3='1210063',
    f7='東京都',
    f8='足立区',
    f9='東保木間';
INSERT postalcode
SET f3='1210071',
    f7='東京都',
    f8='足立区',
    f9='東六月町';
INSERT postalcode
SET f3='1210075',
    f7='東京都',
    f8='足立区',
    f9='一ツ家';
INSERT postalcode
SET f3='1200021',
    f7='東京都',
    f8='足立区',
    f9='日ノ出町';
INSERT postalcode
SET f3='1210076',
    f7='東京都',
    f8='足立区',
    f9='平野';
INSERT postalcode
SET f3='1210064',
    f7='東京都',
    f8='足立区',
    f9='保木間';
INSERT postalcode
SET f3='1210072',
    f7='東京都',
    f8='足立区',
    f9='保塚町';
INSERT postalcode
SET f3='1230874',
    f7='東京都',
    f8='足立区',
    f9='堀之内';
INSERT postalcode
SET f3='1210062',
    f7='東京都',
    f8='足立区',
    f9='南花畑';
INSERT postalcode
SET f3='1200047',
    f7='東京都',
    f8='足立区',
    f9='宮城';
INSERT postalcode
SET f3='1210052',
    f7='東京都',
    f8='足立区',
    f9='六木';
INSERT postalcode
SET f3='1230853',
    f7='東京都',
    f8='足立区',
    f9='本木';
INSERT postalcode
SET f3='1230854',
    f7='東京都',
    f8='足立区',
    f9='本木東町';
INSERT postalcode
SET f3='1230856',
    f7='東京都',
    f8='足立区',
    f9='本木西町';
INSERT postalcode
SET f3='1230855',
    f7='東京都',
    f8='足立区',
    f9='本木南町';
INSERT postalcode
SET f3='1230857',
    f7='東京都',
    f8='足立区',
    f9='本木北町';
INSERT postalcode
SET f3='1230863',
    f7='東京都',
    f8='足立区',
    f9='谷在家';
INSERT postalcode
SET f3='1200006',
    f7='東京都',
    f8='足立区',
    f9='谷中';
INSERT postalcode
SET f3='1200022',
    f7='東京都',
    f8='足立区',
    f9='柳原';
INSERT postalcode
SET f3='1210814',
    f7='東京都',
    f8='足立区',
    f9='六月';
INSERT postalcode
SET f3='1210073',
    f7='東京都',
    f8='足立区',
    f9='六町';
INSERT postalcode
SET f3='1240000',
    f7='東京都',
    f8='葛飾区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1250062',
    f7='東京都',
    f8='葛飾区',
    f9='青戸';
INSERT postalcode
SET f3='1240022',
    f7='東京都',
    f8='葛飾区',
    f9='奥戸';
INSERT postalcode
SET f3='1240003',
    f7='東京都',
    f8='葛飾区',
    f9='お花茶屋';
INSERT postalcode
SET f3='1250042',
    f7='東京都',
    f8='葛飾区',
    f9='金町';
INSERT postalcode
SET f3='1250043',
    f7='東京都',
    f8='葛飾区',
    f9='金町浄水場';
INSERT postalcode
SET f3='1250053',
    f7='東京都',
    f8='葛飾区',
    f9='鎌倉';
INSERT postalcode
SET f3='1250061',
    f7='東京都',
    f8='葛飾区',
    f9='亀有';
INSERT postalcode
SET f3='1240001',
    f7='東京都',
    f8='葛飾区',
    f9='小菅';
INSERT postalcode
SET f3='1250052',
    f7='東京都',
    f8='葛飾区',
    f9='柴又';
INSERT postalcode
SET f3='1250063',
    f7='東京都',
    f8='葛飾区',
    f9='白鳥';
INSERT postalcode
SET f3='1240024',
    f7='東京都',
    f8='葛飾区',
    f9='新小岩';
INSERT postalcode
SET f3='1250054',
    f7='東京都',
    f8='葛飾区',
    f9='高砂';
INSERT postalcode
SET f3='1240005',
    f7='東京都',
    f8='葛飾区',
    f9='宝町';
INSERT postalcode
SET f3='1240012',
    f7='東京都',
    f8='葛飾区',
    f9='立石';
INSERT postalcode
SET f3='1250051',
    f7='東京都',
    f8='葛飾区',
    f9='新宿';
INSERT postalcode
SET f3='1240002',
    f7='東京都',
    f8='葛飾区',
    f9='西亀有（１、２丁目）';
INSERT postalcode
SET f3='1250002',
    f7='東京都',
    f8='葛飾区',
    f9='西亀有（３、４丁目）';
INSERT postalcode
SET f3='1240025',
    f7='東京都',
    f8='葛飾区',
    f9='西新小岩';
INSERT postalcode
SET f3='1250031',
    f7='東京都',
    f8='葛飾区',
    f9='西水元';
INSERT postalcode
SET f3='1250041',
    f7='東京都',
    f8='葛飾区',
    f9='東金町';
INSERT postalcode
SET f3='1240023',
    f7='東京都',
    f8='葛飾区',
    f9='東新小岩';
INSERT postalcode
SET f3='1240013',
    f7='東京都',
    f8='葛飾区',
    f9='東立石';
INSERT postalcode
SET f3='1240004',
    f7='東京都',
    f8='葛飾区',
    f9='東堀切';
INSERT postalcode
SET f3='1250033',
    f7='東京都',
    f8='葛飾区',
    f9='東水元';
INSERT postalcode
SET f3='1240014',
    f7='東京都',
    f8='葛飾区',
    f9='東四つ木';
INSERT postalcode
SET f3='1240021',
    f7='東京都',
    f8='葛飾区',
    f9='細田';
INSERT postalcode
SET f3='1240006',
    f7='東京都',
    f8='葛飾区',
    f9='堀切';
INSERT postalcode
SET f3='1250032',
    f7='東京都',
    f8='葛飾区',
    f9='水元';
INSERT postalcode
SET f3='1250034',
    f7='東京都',
    f8='葛飾区',
    f9='水元公園';
INSERT postalcode
SET f3='1250035',
    f7='東京都',
    f8='葛飾区',
    f9='南水元';
INSERT postalcode
SET f3='1240011',
    f7='東京都',
    f8='葛飾区',
    f9='四つ木';
INSERT postalcode
SET f3='1320000',
    f7='東京都',
    f8='江戸川区',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1320024',
    f7='東京都',
    f8='江戸川区',
    f9='一之江';
INSERT postalcode
SET f3='1340092',
    f7='東京都',
    f8='江戸川区',
    f9='一之江町';
INSERT postalcode
SET f3='1340082',
    f7='東京都',
    f8='江戸川区',
    f9='宇喜田町';
INSERT postalcode
SET f3='1320013',
    f7='東京都',
    f8='江戸川区',
    f9='江戸川（１〜３丁目、４丁目１〜１４番）';
INSERT postalcode
SET f3='1340013',
    f7='東京都',
    f8='江戸川区',
    f9='江戸川（その他）';
INSERT postalcode
SET f3='1320022',
    f7='東京都',
    f8='江戸川区',
    f9='大杉';
INSERT postalcode
SET f3='1330042',
    f7='東京都',
    f8='江戸川区',
    f9='興宮町';
INSERT postalcode
SET f3='1330041',
    f7='東京都',
    f8='江戸川区',
    f9='上一色';
INSERT postalcode
SET f3='1330054',
    f7='東京都',
    f8='江戸川区',
    f9='上篠崎';
INSERT postalcode
SET f3='1340081',
    f7='東京都',
    f8='江戸川区',
    f9='北葛西';
INSERT postalcode
SET f3='1330051',
    f7='東京都',
    f8='江戸川区',
    f9='北小岩';
INSERT postalcode
SET f3='1330053',
    f7='東京都',
    f8='江戸川区',
    f9='北篠崎';
INSERT postalcode
SET f3='1320034',
    f7='東京都',
    f8='江戸川区',
    f9='小松川';
INSERT postalcode
SET f3='1330073',
    f7='東京都',
    f8='江戸川区',
    f9='鹿骨';
INSERT postalcode
SET f3='1330072',
    f7='東京都',
    f8='江戸川区',
    f9='鹿骨町';
INSERT postalcode
SET f3='1330061',
    f7='東京都',
    f8='江戸川区',
    f9='篠崎町';
INSERT postalcode
SET f3='1330064',
    f7='東京都',
    f8='江戸川区',
    f9='下篠崎町';
INSERT postalcode
SET f3='1340087',
    f7='東京都',
    f8='江戸川区',
    f9='清新町';
INSERT postalcode
SET f3='1320021',
    f7='東京都',
    f8='江戸川区',
    f9='中央';
INSERT postalcode
SET f3='1340083',
    f7='東京都',
    f8='江戸川区',
    f9='中葛西';
INSERT postalcode
SET f3='1320001',
    f7='東京都',
    f8='江戸川区',
    f9='新堀';
INSERT postalcode
SET f3='1320023',
    f7='東京都',
    f8='江戸川区',
    f9='西一之江';
INSERT postalcode
SET f3='1340088',
    f7='東京都',
    f8='江戸川区',
    f9='西葛西';
INSERT postalcode
SET f3='1330057',
    f7='東京都',
    f8='江戸川区',
    f9='西小岩';
INSERT postalcode
SET f3='1320032',
    f7='東京都',
    f8='江戸川区',
    f9='西小松川町';
INSERT postalcode
SET f3='1330055',
    f7='東京都',
    f8='江戸川区',
    f9='西篠崎';
INSERT postalcode
SET f3='1320015',
    f7='東京都',
    f8='江戸川区',
    f9='西瑞江（２〜３丁目、４丁目３〜９番）';
INSERT postalcode
SET f3='1340015',
    f7='東京都',
    f8='江戸川区',
    f9='西瑞江（４丁目１〜２番・１０〜２７番、５丁目）';
INSERT postalcode
SET f3='1340093',
    f7='東京都',
    f8='江戸川区',
    f9='二之江町';
INSERT postalcode
SET f3='1320003',
    f7='東京都',
    f8='江戸川区',
    f9='春江町（１〜３丁目）';
INSERT postalcode
SET f3='1340003',
    f7='東京都',
    f8='江戸川区',
    f9='春江町（４、５丁目）';
INSERT postalcode
SET f3='1340084',
    f7='東京都',
    f8='江戸川区',
    f9='東葛西';
INSERT postalcode
SET f3='1330052',
    f7='東京都',
    f8='江戸川区',
    f9='東小岩';
INSERT postalcode
SET f3='1320033',
    f7='東京都',
    f8='江戸川区',
    f9='東小松川';
INSERT postalcode
SET f3='1330063',
    f7='東京都',
    f8='江戸川区',
    f9='東篠崎';
INSERT postalcode
SET f3='1330062',
    f7='東京都',
    f8='江戸川区',
    f9='東篠崎町';
INSERT postalcode
SET f3='1330071',
    f7='東京都',
    f8='江戸川区',
    f9='東松本';
INSERT postalcode
SET f3='1320014',
    f7='東京都',
    f8='江戸川区',
    f9='東瑞江';
INSERT postalcode
SET f3='1320035',
    f7='東京都',
    f8='江戸川区',
    f9='平井';
INSERT postalcode
SET f3='1340091',
    f7='東京都',
    f8='江戸川区',
    f9='船堀';
INSERT postalcode
SET f3='1330044',
    f7='東京都',
    f8='江戸川区',
    f9='本一色';
INSERT postalcode
SET f3='1320025',
    f7='東京都',
    f8='江戸川区',
    f9='松江';
INSERT postalcode
SET f3='1320031',
    f7='東京都',
    f8='江戸川区',
    f9='松島';
INSERT postalcode
SET f3='1330043',
    f7='東京都',
    f8='江戸川区',
    f9='松本';
INSERT postalcode
SET f3='1320011',
    f7='東京都',
    f8='江戸川区',
    f9='瑞江';
INSERT postalcode
SET f3='1340085',
    f7='東京都',
    f8='江戸川区',
    f9='南葛西';
INSERT postalcode
SET f3='1330056',
    f7='東京都',
    f8='江戸川区',
    f9='南小岩';
INSERT postalcode
SET f3='1330065',
    f7='東京都',
    f8='江戸川区',
    f9='南篠崎町';
INSERT postalcode
SET f3='1320002',
    f7='東京都',
    f8='江戸川区',
    f9='谷河内（１丁目）';
INSERT postalcode
SET f3='1330002',
    f7='東京都',
    f8='江戸川区',
    f9='谷河内（２丁目）';
INSERT postalcode
SET f3='1340086',
    f7='東京都',
    f8='江戸川区',
    f9='臨海町';
INSERT postalcode
SET f3='1920000',
    f7='東京都',
    f8='八王子市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1920043',
    f7='東京都',
    f8='八王子市',
    f9='暁町';
INSERT postalcode
SET f3='1920083',
    f7='東京都',
    f8='八王子市',
    f9='旭町';
INSERT postalcode
SET f3='1920082',
    f7='東京都',
    f8='八王子市',
    f9='東町';
INSERT postalcode
SET f3='1920032',
    f7='東京都',
    f8='八王子市',
    f9='石川町';
INSERT postalcode
SET f3='1930814',
    f7='東京都',
    f8='八王子市',
    f9='泉町';
INSERT postalcode
SET f3='1930802',
    f7='東京都',
    f8='八王子市',
    f9='犬目町';
INSERT postalcode
SET f3='1920902',
    f7='東京都',
    f8='八王子市',
    f9='上野町';
INSERT postalcode
SET f3='1920911',
    f7='東京都',
    f8='八王子市',
    f9='打越町';
INSERT postalcode
SET f3='1920024',
    f7='東京都',
    f8='八王子市',
    f9='宇津木町';
INSERT postalcode
SET f3='1920915',
    f7='東京都',
    f8='八王子市',
    f9='宇津貫町';
INSERT postalcode
SET f3='1920013',
    f7='東京都',
    f8='八王子市',
    f9='梅坪町';
INSERT postalcode
SET f3='1930841',
    f7='東京都',
    f8='八王子市',
    f9='裏高尾町';
INSERT postalcode
SET f3='1920056',
    f7='東京都',
    f8='八王子市',
    f9='追分町';
INSERT postalcode
SET f3='1920352',
    f7='東京都',
    f8='八王子市',
    f9='大塚';
INSERT postalcode
SET f3='1930935',
    f7='東京都',
    f8='八王子市',
    f9='大船町';
INSERT postalcode
SET f3='1920034',
    f7='東京都',
    f8='八王子市',
    f9='大谷町';
INSERT postalcode
SET f3='1920062',
    f7='東京都',
    f8='八王子市',
    f9='大横町';
INSERT postalcode
SET f3='1920045',
    f7='東京都',
    f8='八王子市',
    f9='大和田町';
INSERT postalcode
SET f3='1920054',
    f7='東京都',
    f8='八王子市',
    f9='小門町';
INSERT postalcode
SET f3='1920025',
    f7='東京都',
    f8='八王子市',
    f9='尾崎町';
INSERT postalcode
SET f3='1920155',
    f7='東京都',
    f8='八王子市',
    f9='小津町';
INSERT postalcode
SET f3='1920353',
    f7='東京都',
    f8='八王子市',
    f9='鹿島';
INSERT postalcode
SET f3='1920004',
    f7='東京都',
    f8='八王子市',
    f9='加住町';
INSERT postalcode
SET f3='1920914',
    f7='東京都',
    f8='八王子市',
    f9='片倉町';
INSERT postalcode
SET f3='1930815',
    f7='東京都',
    f8='八王子市',
    f9='叶谷町';
INSERT postalcode
SET f3='1930811',
    f7='東京都',
    f8='八王子市',
    f9='上壱分方町';
INSERT postalcode
SET f3='1920156',
    f7='東京都',
    f8='八王子市',
    f9='上恩方町';
INSERT postalcode
SET f3='1920151',
    f7='東京都',
    f8='八王子市',
    f9='上川町';
INSERT postalcode
SET f3='1920373',
    f7='東京都',
    f8='八王子市',
    f9='上柚木';
INSERT postalcode
SET f3='1930801',
    f7='東京都',
    f8='八王子市',
    f9='川口町';
INSERT postalcode
SET f3='1930821',
    f7='東京都',
    f8='八王子市',
    f9='川町';
INSERT postalcode
SET f3='1920913',
    f7='東京都',
    f8='八王子市',
    f9='北野台';
INSERT postalcode
SET f3='1920906',
    f7='東京都',
    f8='八王子市',
    f9='北野町';
INSERT postalcode
SET f3='1920912',
    f7='東京都',
    f8='八王子市',
    f9='絹ケ丘';
INSERT postalcode
SET f3='1930804',
    f7='東京都',
    f8='八王子市',
    f9='清川町';
INSERT postalcode
SET f3='1930942',
    f7='東京都',
    f8='八王子市',
    f9='椚田町';
INSERT postalcode
SET f3='1920023',
    f7='東京都',
    f8='八王子市',
    f9='久保山町';
INSERT postalcode
SET f3='1920361',
    f7='東京都',
    f8='八王子市',
    f9='越野';
INSERT postalcode
SET f3='1930934',
    f7='東京都',
    f8='八王子市',
    f9='小比企町';
INSERT postalcode
SET f3='1920031',
    f7='東京都',
    f8='八王子市',
    f9='小宮町';
INSERT postalcode
SET f3='1920904',
    f7='東京都',
    f8='八王子市',
    f9='子安町';
INSERT postalcode
SET f3='1920012',
    f7='東京都',
    f8='八王子市',
    f9='左入町';
INSERT postalcode
SET f3='1930832',
    f7='東京都',
    f8='八王子市',
    f9='散田町';
INSERT postalcode
SET f3='1920154',
    f7='東京都',
    f8='八王子市',
    f9='下恩方町';
INSERT postalcode
SET f3='1920372',
    f7='東京都',
    f8='八王子市',
    f9='下柚木';
INSERT postalcode
SET f3='1930825',
    f7='東京都',
    f8='八王子市',
    f9='城山手';
INSERT postalcode
SET f3='1920065',
    f7='東京都',
    f8='八王子市',
    f9='新町';
INSERT postalcode
SET f3='1930812',
    f7='東京都',
    f8='八王子市',
    f9='諏訪町';
INSERT postalcode
SET f3='1930835',
    f7='東京都',
    f8='八王子市',
    f9='千人町';
INSERT postalcode
SET f3='1930931',
    f7='東京都',
    f8='八王子市',
    f9='台町';
INSERT postalcode
SET f3='1930816',
    f7='東京都',
    f8='八王子市',
    f9='大楽寺町';
INSERT postalcode
SET f3='1920022',
    f7='東京都',
    f8='八王子市',
    f9='平町';
INSERT postalcode
SET f3='1930844',
    f7='東京都',
    f8='八王子市',
    f9='高尾町';
INSERT postalcode
SET f3='1920033',
    f7='東京都',
    f8='八王子市',
    f9='高倉町';
INSERT postalcode
SET f3='1920002',
    f7='東京都',
    f8='八王子市',
    f9='高月町';
INSERT postalcode
SET f3='1920011',
    f7='東京都',
    f8='八王子市',
    f9='滝山町';
INSERT postalcode
SET f3='1930944',
    f7='東京都',
    f8='八王子市',
    f9='館町';
INSERT postalcode
SET f3='1920064',
    f7='東京都',
    f8='八王子市',
    f9='田町';
INSERT postalcode
SET f3='1920003',
    f7='東京都',
    f8='八王子市',
    f9='丹木町';
INSERT postalcode
SET f3='1930943',
    f7='東京都',
    f8='八王子市',
    f9='寺田町';
INSERT postalcode
SET f3='1920073',
    f7='東京都',
    f8='八王子市',
    f9='寺町';
INSERT postalcode
SET f3='1920074',
    f7='東京都',
    f8='八王子市',
    f9='天神町';
INSERT postalcode
SET f3='1930843',
    f7='東京都',
    f8='八王子市',
    f9='廿里町';
INSERT postalcode
SET f3='1920001',
    f7='東京都',
    f8='八王子市',
    f9='戸吹町';
INSERT postalcode
SET f3='1920085',
    f7='東京都',
    f8='八王子市',
    f9='中町';
INSERT postalcode
SET f3='1920041',
    f7='東京都',
    f8='八王子市',
    f9='中野上町';
INSERT postalcode
SET f3='1920042',
    f7='東京都',
    f8='八王子市',
    f9='中野山王';
INSERT postalcode
SET f3='1920015',
    f7='東京都',
    f8='八王子市',
    f9='中野町';
INSERT postalcode
SET f3='1920374',
    f7='東京都',
    f8='八王子市',
    f9='中山';
INSERT postalcode
SET f3='1920907',
    f7='東京都',
    f8='八王子市',
    f9='長沼町';
INSERT postalcode
SET f3='1930824',
    f7='東京都',
    f8='八王子市',
    f9='長房町';
INSERT postalcode
SET f3='1920919',
    f7='東京都',
    f8='八王子市',
    f9='七国';
INSERT postalcode
SET f3='1930831',
    f7='東京都',
    f8='八王子市',
    f9='並木町';
INSERT postalcode
SET f3='1930803',
    f7='東京都',
    f8='八王子市',
    f9='楢原町';
INSERT postalcode
SET f3='1920371',
    f7='東京都',
    f8='八王子市',
    f9='南陽台';
INSERT postalcode
SET f3='1930842',
    f7='東京都',
    f8='八王子市',
    f9='西浅川町';
INSERT postalcode
SET f3='1920917',
    f7='東京都',
    f8='八王子市',
    f9='西片倉';
INSERT postalcode
SET f3='1920153',
    f7='東京都',
    f8='八王子市',
    f9='西寺方町';
INSERT postalcode
SET f3='1930822',
    f7='東京都',
    f8='八王子市',
    f9='弐分方町';
INSERT postalcode
SET f3='1930941',
    f7='東京都',
    f8='八王子市',
    f9='狭間町';
INSERT postalcode
SET f3='1920053',
    f7='東京都',
    f8='八王子市',
    f9='八幡町';
INSERT postalcode
SET f3='1930845',
    f7='東京都',
    f8='八王子市',
    f9='初沢町';
INSERT postalcode
SET f3='1930834',
    f7='東京都',
    f8='八王子市',
    f9='東浅川町';
INSERT postalcode
SET f3='1920351',
    f7='東京都',
    f8='八王子市',
    f9='東中野';
INSERT postalcode
SET f3='1920918',
    f7='東京都',
    f8='八王子市',
    f9='兵衛';
INSERT postalcode
SET f3='1930836',
    f7='東京都',
    f8='八王子市',
    f9='日吉町';
INSERT postalcode
SET f3='1920061',
    f7='東京都',
    f8='八王子市',
    f9='平岡町';
INSERT postalcode
SET f3='1920044',
    f7='東京都',
    f8='八王子市',
    f9='富士見町';
INSERT postalcode
SET f3='1920363',
    f7='東京都',
    f8='八王子市',
    f9='別所';
INSERT postalcode
SET f3='1920355',
    f7='東京都',
    f8='八王子市',
    f9='堀之内';
INSERT postalcode
SET f3='1920052',
    f7='東京都',
    f8='八王子市',
    f9='本郷町';
INSERT postalcode
SET f3='1920066',
    f7='東京都',
    f8='八王子市',
    f9='本町';
INSERT postalcode
SET f3='1920354',
    f7='東京都',
    f8='八王子市',
    f9='松が谷';
INSERT postalcode
SET f3='1920362',
    f7='東京都',
    f8='八王子市',
    f9='松木';
INSERT postalcode
SET f3='1920021',
    f7='東京都',
    f8='八王子市',
    f9='丸山町';
INSERT postalcode
SET f3='1920084',
    f7='東京都',
    f8='八王子市',
    f9='三崎町';
INSERT postalcode
SET f3='1920014',
    f7='東京都',
    f8='八王子市',
    f9='みつい台';
INSERT postalcode
SET f3='1930932',
    f7='東京都',
    f8='八王子市',
    f9='緑町';
INSERT postalcode
SET f3='1930846',
    f7='東京都',
    f8='八王子市',
    f9='南浅川町';
INSERT postalcode
SET f3='1920364',
    f7='東京都',
    f8='八王子市',
    f9='南大沢';
INSERT postalcode
SET f3='1920075',
    f7='東京都',
    f8='八王子市',
    f9='南新町';
INSERT postalcode
SET f3='1920072',
    f7='東京都',
    f8='八王子市',
    f9='南町';
INSERT postalcode
SET f3='1920916',
    f7='東京都',
    f8='八王子市',
    f9='みなみ野';
INSERT postalcode
SET f3='1920005',
    f7='東京都',
    f8='八王子市',
    f9='宮下町';
INSERT postalcode
SET f3='1920152',
    f7='東京都',
    f8='八王子市',
    f9='美山町';
INSERT postalcode
SET f3='1920046',
    f7='東京都',
    f8='八王子市',
    f9='明神町';
INSERT postalcode
SET f3='1930833',
    f7='東京都',
    f8='八王子市',
    f9='めじろ台';
INSERT postalcode
SET f3='1930826',
    f7='東京都',
    f8='八王子市',
    f9='元八王子町';
INSERT postalcode
SET f3='1920051',
    f7='東京都',
    f8='八王子市',
    f9='元本郷町';
INSERT postalcode
SET f3='1920063',
    f7='東京都',
    f8='八王子市',
    f9='元横山町';
INSERT postalcode
SET f3='1920055',
    f7='東京都',
    f8='八王子市',
    f9='八木町';
INSERT postalcode
SET f3='1920016',
    f7='東京都',
    f8='八王子市',
    f9='谷野町';
INSERT postalcode
SET f3='1930933',
    f7='東京都',
    f8='八王子市',
    f9='山田町';
INSERT postalcode
SET f3='1920375',
    f7='東京都',
    f8='八王子市',
    f9='鑓水';
INSERT postalcode
SET f3='1920071',
    f7='東京都',
    f8='八王子市',
    f9='八日町';
INSERT postalcode
SET f3='1930823',
    f7='東京都',
    f8='八王子市',
    f9='横川町';
INSERT postalcode
SET f3='1920081',
    f7='東京都',
    f8='八王子市',
    f9='横山町';
INSERT postalcode
SET f3='1930813',
    f7='東京都',
    f8='八王子市',
    f9='四谷町';
INSERT postalcode
SET f3='1920903',
    f7='東京都',
    f8='八王子市',
    f9='万町';
INSERT postalcode
SET f3='1900000',
    f7='東京都',
    f8='立川市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1900012',
    f7='東京都',
    f8='立川市',
    f9='曙町';
INSERT postalcode
SET f3='1900015',
    f7='東京都',
    f8='立川市',
    f9='泉町';
INSERT postalcode
SET f3='1900033',
    f7='東京都',
    f8='立川市',
    f9='一番町';
INSERT postalcode
SET f3='1900004',
    f7='東京都',
    f8='立川市',
    f9='柏町';
INSERT postalcode
SET f3='1900032',
    f7='東京都',
    f8='立川市',
    f9='上砂町';
INSERT postalcode
SET f3='1900002',
    f7='東京都',
    f8='立川市',
    f9='幸町';
INSERT postalcode
SET f3='1900003',
    f7='東京都',
    f8='立川市',
    f9='栄町';
INSERT postalcode
SET f3='1900023',
    f7='東京都',
    f8='立川市',
    f9='柴崎町';
INSERT postalcode
SET f3='1900031',
    f7='東京都',
    f8='立川市',
    f9='砂川町';
INSERT postalcode
SET f3='1900011',
    f7='東京都',
    f8='立川市',
    f9='高松町';
INSERT postalcode
SET f3='1900022',
    f7='東京都',
    f8='立川市',
    f9='錦町';
INSERT postalcode
SET f3='1900034',
    f7='東京都',
    f8='立川市',
    f9='西砂町';
INSERT postalcode
SET f3='1900021',
    f7='東京都',
    f8='立川市',
    f9='羽衣町';
INSERT postalcode
SET f3='1900013',
    f7='東京都',
    f8='立川市',
    f9='富士見町';
INSERT postalcode
SET f3='1900014',
    f7='東京都',
    f8='立川市',
    f9='緑町';
INSERT postalcode
SET f3='1900001',
    f7='東京都',
    f8='立川市',
    f9='若葉町';
INSERT postalcode
SET f3='1800000',
    f7='東京都',
    f8='武蔵野市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1800004',
    f7='東京都',
    f8='武蔵野市',
    f9='吉祥寺本町';
INSERT postalcode
SET f3='1800002',
    f7='東京都',
    f8='武蔵野市',
    f9='吉祥寺東町';
INSERT postalcode
SET f3='1800003',
    f7='東京都',
    f8='武蔵野市',
    f9='吉祥寺南町';
INSERT postalcode
SET f3='1800001',
    f7='東京都',
    f8='武蔵野市',
    f9='吉祥寺北町';
INSERT postalcode
SET f3='1800023',
    f7='東京都',
    f8='武蔵野市',
    f9='境南町';
INSERT postalcode
SET f3='1800005',
    f7='東京都',
    f8='武蔵野市',
    f9='御殿山';
INSERT postalcode
SET f3='1800022',
    f7='東京都',
    f8='武蔵野市',
    f9='境';
INSERT postalcode
SET f3='1800021',
    f7='東京都',
    f8='武蔵野市',
    f9='桜堤';
INSERT postalcode
SET f3='1800014',
    f7='東京都',
    f8='武蔵野市',
    f9='関前';
INSERT postalcode
SET f3='1800006',
    f7='東京都',
    f8='武蔵野市',
    f9='中町';
INSERT postalcode
SET f3='1800013',
    f7='東京都',
    f8='武蔵野市',
    f9='西久保';
INSERT postalcode
SET f3='1800012',
    f7='東京都',
    f8='武蔵野市',
    f9='緑町';
INSERT postalcode
SET f3='1800011',
    f7='東京都',
    f8='武蔵野市',
    f9='八幡町';
INSERT postalcode
SET f3='1810000',
    f7='東京都',
    f8='三鷹市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1810011',
    f7='東京都',
    f8='三鷹市',
    f9='井口';
INSERT postalcode
SET f3='1810001',
    f7='東京都',
    f8='三鷹市',
    f9='井の頭';
INSERT postalcode
SET f3='1810015',
    f7='東京都',
    f8='三鷹市',
    f9='大沢';
INSERT postalcode
SET f3='1810012',
    f7='東京都',
    f8='三鷹市',
    f9='上連雀';
INSERT postalcode
SET f3='1810003',
    f7='東京都',
    f8='三鷹市',
    f9='北野';
INSERT postalcode
SET f3='1810013',
    f7='東京都',
    f8='三鷹市',
    f9='下連雀';
INSERT postalcode
SET f3='1810004',
    f7='東京都',
    f8='三鷹市',
    f9='新川';
INSERT postalcode
SET f3='1810016',
    f7='東京都',
    f8='三鷹市',
    f9='深大寺';
INSERT postalcode
SET f3='1810005',
    f7='東京都',
    f8='三鷹市',
    f9='中原';
INSERT postalcode
SET f3='1810014',
    f7='東京都',
    f8='三鷹市',
    f9='野崎';
INSERT postalcode
SET f3='1810002',
    f7='東京都',
    f8='三鷹市',
    f9='牟礼';
INSERT postalcode
SET f3='1980000',
    f7='東京都',
    f8='青梅市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1980087',
    f7='東京都',
    f8='青梅市',
    f9='天ケ瀬町';
INSERT postalcode
SET f3='1980023',
    f7='東京都',
    f8='青梅市',
    f9='今井';
INSERT postalcode
SET f3='1980021',
    f7='東京都',
    f8='青梅市',
    f9='今寺';
INSERT postalcode
SET f3='1980088',
    f7='東京都',
    f8='青梅市',
    f9='裏宿町';
INSERT postalcode
SET f3='1980086',
    f7='東京都',
    f8='青梅市',
    f9='大柳町';
INSERT postalcode
SET f3='1980003',
    f7='東京都',
    f8='青梅市',
    f9='小曾木';
INSERT postalcode
SET f3='1980041',
    f7='東京都',
    f8='青梅市',
    f9='勝沼';
INSERT postalcode
SET f3='1980036',
    f7='東京都',
    f8='青梅市',
    f9='河辺町';
INSERT postalcode
SET f3='1980081',
    f7='東京都',
    f8='青梅市',
    f9='上町';
INSERT postalcode
SET f3='1980013',
    f7='東京都',
    f8='青梅市',
    f9='木野下';
INSERT postalcode
SET f3='1980005',
    f7='東京都',
    f8='青梅市',
    f9='黒沢';
INSERT postalcode
SET f3='1980053',
    f7='東京都',
    f8='青梅市',
    f9='駒木町';
INSERT postalcode
SET f3='1980172',
    f7='東京都',
    f8='青梅市',
    f9='沢井';
INSERT postalcode
SET f3='1980011',
    f7='東京都',
    f8='青梅市',
    f9='塩船';
INSERT postalcode
SET f3='1980024',
    f7='東京都',
    f8='青梅市',
    f9='新町';
INSERT postalcode
SET f3='1980025',
    f7='東京都',
    f8='青梅市',
    f9='末広町';
INSERT postalcode
SET f3='1980084',
    f7='東京都',
    f8='青梅市',
    f9='住江町';
INSERT postalcode
SET f3='1980014',
    f7='東京都',
    f8='青梅市',
    f9='大門';
INSERT postalcode
SET f3='1980085',
    f7='東京都',
    f8='青梅市',
    f9='滝ノ上町';
INSERT postalcode
SET f3='1980043',
    f7='東京都',
    f8='青梅市',
    f9='千ケ瀬町';
INSERT postalcode
SET f3='1980002',
    f7='東京都',
    f8='青梅市',
    f9='富岡';
INSERT postalcode
SET f3='1980051',
    f7='東京都',
    f8='青梅市',
    f9='友田町';
INSERT postalcode
SET f3='1980082',
    f7='東京都',
    f8='青梅市',
    f9='仲町';
INSERT postalcode
SET f3='1980052',
    f7='東京都',
    f8='青梅市',
    f9='長淵';
INSERT postalcode
SET f3='1980001',
    f7='東京都',
    f8='青梅市',
    f9='成木';
INSERT postalcode
SET f3='1980044',
    f7='東京都',
    f8='青梅市',
    f9='西分町';
INSERT postalcode
SET f3='1980004',
    f7='東京都',
    f8='青梅市',
    f9='根ケ布';
INSERT postalcode
SET f3='1980032',
    f7='東京都',
    f8='青梅市',
    f9='野上町';
INSERT postalcode
SET f3='1980063',
    f7='東京都',
    f8='青梅市',
    f9='梅郷';
INSERT postalcode
SET f3='1980061',
    f7='東京都',
    f8='青梅市',
    f9='畑中';
INSERT postalcode
SET f3='1980042',
    f7='東京都',
    f8='青梅市',
    f9='東青梅';
INSERT postalcode
SET f3='1980046',
    f7='東京都',
    f8='青梅市',
    f9='日向和田';
INSERT postalcode
SET f3='1980015',
    f7='東京都',
    f8='青梅市',
    f9='吹上';
INSERT postalcode
SET f3='1980022',
    f7='東京都',
    f8='青梅市',
    f9='藤橋';
INSERT postalcode
SET f3='1980171',
    f7='東京都',
    f8='青梅市',
    f9='二俣尾';
INSERT postalcode
SET f3='1980083',
    f7='東京都',
    f8='青梅市',
    f9='本町';
INSERT postalcode
SET f3='1980174',
    f7='東京都',
    f8='青梅市',
    f9='御岳';
INSERT postalcode
SET f3='1980175',
    f7='東京都',
    f8='青梅市',
    f9='御岳山';
INSERT postalcode
SET f3='1980173',
    f7='東京都',
    f8='青梅市',
    f9='御岳本町';
INSERT postalcode
SET f3='1980089',
    f7='東京都',
    f8='青梅市',
    f9='森下町';
INSERT postalcode
SET f3='1980031',
    f7='東京都',
    f8='青梅市',
    f9='師岡町';
INSERT postalcode
SET f3='1980012',
    f7='東京都',
    f8='青梅市',
    f9='谷野';
INSERT postalcode
SET f3='1980064',
    f7='東京都',
    f8='青梅市',
    f9='柚木町';
INSERT postalcode
SET f3='1980062',
    f7='東京都',
    f8='青梅市',
    f9='和田町';
INSERT postalcode
SET f3='1830000',
    f7='東京都',
    f8='府中市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1830003',
    f7='東京都',
    f8='府中市',
    f9='朝日町';
INSERT postalcode
SET f3='1830012',
    f7='東京都',
    f8='府中市',
    f9='押立町';
INSERT postalcode
SET f3='1830021',
    f7='東京都',
    f8='府中市',
    f9='片町';
INSERT postalcode
SET f3='1830041',
    f7='東京都',
    f8='府中市',
    f9='北山町';
INSERT postalcode
SET f3='1830056',
    f7='東京都',
    f8='府中市',
    f9='寿町';
INSERT postalcode
SET f3='1830013',
    f7='東京都',
    f8='府中市',
    f9='小柳町';
INSERT postalcode
SET f3='1830014',
    f7='東京都',
    f8='府中市',
    f9='是政';
INSERT postalcode
SET f3='1830054',
    f7='東京都',
    f8='府中市',
    f9='幸町';
INSERT postalcode
SET f3='1830051',
    f7='東京都',
    f8='府中市',
    f9='栄町';
INSERT postalcode
SET f3='1830015',
    f7='東京都',
    f8='府中市',
    f9='清水が丘';
INSERT postalcode
SET f3='1830011',
    f7='東京都',
    f8='府中市',
    f9='白糸台';
INSERT postalcode
SET f3='1830052',
    f7='東京都',
    f8='府中市',
    f9='新町';
INSERT postalcode
SET f3='1830034',
    f7='東京都',
    f8='府中市',
    f9='住吉町';
INSERT postalcode
SET f3='1830001',
    f7='東京都',
    f8='府中市',
    f9='浅間町';
INSERT postalcode
SET f3='1830002',
    f7='東京都',
    f8='府中市',
    f9='多磨町';
INSERT postalcode
SET f3='1830053',
    f7='東京都',
    f8='府中市',
    f9='天神町';
INSERT postalcode
SET f3='1830043',
    f7='東京都',
    f8='府中市',
    f9='東芝町';
INSERT postalcode
SET f3='1830046',
    f7='東京都',
    f8='府中市',
    f9='西原町';
INSERT postalcode
SET f3='1830031',
    f7='東京都',
    f8='府中市',
    f9='西府町';
INSERT postalcode
SET f3='1830044',
    f7='東京都',
    f8='府中市',
    f9='日鋼町';
INSERT postalcode
SET f3='1830036',
    f7='東京都',
    f8='府中市',
    f9='日新町';
INSERT postalcode
SET f3='1830016',
    f7='東京都',
    f8='府中市',
    f9='八幡町';
INSERT postalcode
SET f3='1830057',
    f7='東京都',
    f8='府中市',
    f9='晴見町';
INSERT postalcode
SET f3='1830024',
    f7='東京都',
    f8='府中市',
    f9='日吉町';
INSERT postalcode
SET f3='1830055',
    f7='東京都',
    f8='府中市',
    f9='府中町';
INSERT postalcode
SET f3='1830033',
    f7='東京都',
    f8='府中市',
    f9='分梅町';
INSERT postalcode
SET f3='1830032',
    f7='東京都',
    f8='府中市',
    f9='本宿町';
INSERT postalcode
SET f3='1830027',
    f7='東京都',
    f8='府中市',
    f9='本町';
INSERT postalcode
SET f3='1830006',
    f7='東京都',
    f8='府中市',
    f9='緑町';
INSERT postalcode
SET f3='1830026',
    f7='東京都',
    f8='府中市',
    f9='南町';
INSERT postalcode
SET f3='1830022',
    f7='東京都',
    f8='府中市',
    f9='宮西町';
INSERT postalcode
SET f3='1830023',
    f7='東京都',
    f8='府中市',
    f9='宮町';
INSERT postalcode
SET f3='1830045',
    f7='東京都',
    f8='府中市',
    f9='美好町';
INSERT postalcode
SET f3='1830042',
    f7='東京都',
    f8='府中市',
    f9='武蔵台';
INSERT postalcode
SET f3='1830004',
    f7='東京都',
    f8='府中市',
    f9='紅葉丘';
INSERT postalcode
SET f3='1830025',
    f7='東京都',
    f8='府中市',
    f9='矢崎町';
INSERT postalcode
SET f3='1830035',
    f7='東京都',
    f8='府中市',
    f9='四谷';
INSERT postalcode
SET f3='1830005',
    f7='東京都',
    f8='府中市',
    f9='若松町';
INSERT postalcode
SET f3='1960000',
    f7='東京都',
    f8='昭島市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1960025',
    f7='東京都',
    f8='昭島市',
    f9='朝日町';
INSERT postalcode
SET f3='1960033',
    f7='東京都',
    f8='昭島市',
    f9='東町';
INSERT postalcode
SET f3='1960013',
    f7='東京都',
    f8='昭島市',
    f9='大神町';
INSERT postalcode
SET f3='1960032',
    f7='東京都',
    f8='昭島市',
    f9='郷地町';
INSERT postalcode
SET f3='1960011',
    f7='東京都',
    f8='昭島市',
    f9='上川原町';
INSERT postalcode
SET f3='1960015',
    f7='東京都',
    f8='昭島市',
    f9='昭和町';
INSERT postalcode
SET f3='1960014',
    f7='東京都',
    f8='昭島市',
    f9='田中町';
INSERT postalcode
SET f3='1960034',
    f7='東京都',
    f8='昭島市',
    f9='玉川町';
INSERT postalcode
SET f3='1960023',
    f7='東京都',
    f8='昭島市',
    f9='築地町';
INSERT postalcode
SET f3='1960012',
    f7='東京都',
    f8='昭島市',
    f9='つつじが丘';
INSERT postalcode
SET f3='1960022',
    f7='東京都',
    f8='昭島市',
    f9='中神町';
INSERT postalcode
SET f3='1960002',
    f7='東京都',
    f8='昭島市',
    f9='拝島町';
INSERT postalcode
SET f3='1960031',
    f7='東京都',
    f8='昭島市',
    f9='福島町';
INSERT postalcode
SET f3='1960003',
    f7='東京都',
    f8='昭島市',
    f9='松原町';
INSERT postalcode
SET f3='1960004',
    f7='東京都',
    f8='昭島市',
    f9='緑町';
INSERT postalcode
SET f3='1960001',
    f7='東京都',
    f8='昭島市',
    f9='美堀町';
INSERT postalcode
SET f3='1960024',
    f7='東京都',
    f8='昭島市',
    f9='宮沢町';
INSERT postalcode
SET f3='1960021',
    f7='東京都',
    f8='昭島市',
    f9='武蔵野';
INSERT postalcode
SET f3='1820000',
    f7='東京都',
    f8='調布市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1820004',
    f7='東京都',
    f8='調布市',
    f9='入間町';
INSERT postalcode
SET f3='1820035',
    f7='東京都',
    f8='調布市',
    f9='上石原';
INSERT postalcode
SET f3='1820007',
    f7='東京都',
    f8='調布市',
    f9='菊野台';
INSERT postalcode
SET f3='1820022',
    f7='東京都',
    f8='調布市',
    f9='国領町';
INSERT postalcode
SET f3='1820026',
    f7='東京都',
    f8='調布市',
    f9='小島町';
INSERT postalcode
SET f3='1820016',
    f7='東京都',
    f8='調布市',
    f9='佐須町';
INSERT postalcode
SET f3='1820014',
    f7='東京都',
    f8='調布市',
    f9='柴崎';
INSERT postalcode
SET f3='1820034',
    f7='東京都',
    f8='調布市',
    f9='下石原';
INSERT postalcode
SET f3='1820012',
    f7='東京都',
    f8='調布市',
    f9='深大寺東町';
INSERT postalcode
SET f3='1820013',
    f7='東京都',
    f8='調布市',
    f9='深大寺南町';
INSERT postalcode
SET f3='1820011',
    f7='東京都',
    f8='調布市',
    f9='深大寺北町';
INSERT postalcode
SET f3='1820017',
    f7='東京都',
    f8='調布市',
    f9='深大寺元町';
INSERT postalcode
SET f3='1820002',
    f7='東京都',
    f8='調布市',
    f9='仙川町';
INSERT postalcode
SET f3='1820023',
    f7='東京都',
    f8='調布市',
    f9='染地';
INSERT postalcode
SET f3='1820025',
    f7='東京都',
    f8='調布市',
    f9='多摩川';
INSERT postalcode
SET f3='1820021',
    f7='東京都',
    f8='調布市',
    f9='調布ケ丘';
INSERT postalcode
SET f3='1820036',
    f7='東京都',
    f8='調布市',
    f9='飛田給';
INSERT postalcode
SET f3='1820006',
    f7='東京都',
    f8='調布市',
    f9='西つつじケ丘';
INSERT postalcode
SET f3='1820032',
    f7='東京都',
    f8='調布市',
    f9='西町';
INSERT postalcode
SET f3='1820031',
    f7='東京都',
    f8='調布市',
    f9='野水';
INSERT postalcode
SET f3='1820005',
    f7='東京都',
    f8='調布市',
    f9='東つつじケ丘';
INSERT postalcode
SET f3='1820033',
    f7='東京都',
    f8='調布市',
    f9='富士見町';
INSERT postalcode
SET f3='1820024',
    f7='東京都',
    f8='調布市',
    f9='布田';
INSERT postalcode
SET f3='1820001',
    f7='東京都',
    f8='調布市',
    f9='緑ケ丘';
INSERT postalcode
SET f3='1820015',
    f7='東京都',
    f8='調布市',
    f9='八雲台';
INSERT postalcode
SET f3='1820003',
    f7='東京都',
    f8='調布市',
    f9='若葉町';
INSERT postalcode
SET f3='1940000',
    f7='東京都',
    f8='町田市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1940211',
    f7='東京都',
    f8='町田市',
    f9='相原町';
INSERT postalcode
SET f3='1940023',
    f7='東京都',
    f8='町田市',
    f9='旭町';
INSERT postalcode
SET f3='1950062',
    f7='東京都',
    f8='町田市',
    f9='大蔵町';
INSERT postalcode
SET f3='1940003',
    f7='東京都',
    f8='町田市',
    f9='小川';
INSERT postalcode
SET f3='1950064',
    f7='東京都',
    f8='町田市',
    f9='小野路町';
INSERT postalcode
SET f3='1940215',
    f7='東京都',
    f8='町田市',
    f9='小山ケ丘';
INSERT postalcode
SET f3='1940204',
    f7='東京都',
    f8='町田市',
    f9='小山田桜台';
INSERT postalcode
SET f3='1940212',
    f7='東京都',
    f8='町田市',
    f9='小山町';
INSERT postalcode
SET f3='1950072',
    f7='東京都',
    f8='町田市',
    f9='金井';
INSERT postalcode
SET f3='1950071',
    f7='東京都',
    f8='町田市',
    f9='金井町';
INSERT postalcode
SET f3='1940012',
    f7='東京都',
    f8='町田市',
    f9='金森';
INSERT postalcode
SET f3='1940201',
    f7='東京都',
    f8='町田市',
    f9='上小山田町';
INSERT postalcode
SET f3='1940037',
    f7='東京都',
    f8='町田市',
    f9='木曽西';
INSERT postalcode
SET f3='1940036',
    f7='東京都',
    f8='町田市',
    f9='木曽東';
INSERT postalcode
SET f3='1940033',
    f7='東京都',
    f8='町田市',
    f9='木曽町';
INSERT postalcode
SET f3='1940014',
    f7='東京都',
    f8='町田市',
    f9='高ケ坂';
INSERT postalcode
SET f3='1940202',
    f7='東京都',
    f8='町田市',
    f9='下小山田町';
INSERT postalcode
SET f3='1950057',
    f7='東京都',
    f8='町田市',
    f9='真光寺';
INSERT postalcode
SET f3='1950051',
    f7='東京都',
    f8='町田市',
    f9='真光寺町';
INSERT postalcode
SET f3='1940203',
    f7='東京都',
    f8='町田市',
    f9='図師町';
INSERT postalcode
SET f3='1940035',
    f7='東京都',
    f8='町田市',
    f9='忠生';
INSERT postalcode
SET f3='1940041',
    f7='東京都',
    f8='町田市',
    f9='玉川学園';
INSERT postalcode
SET f3='1940001',
    f7='東京都',
    f8='町田市',
    f9='つくし野';
INSERT postalcode
SET f3='1950061',
    f7='東京都',
    f8='町田市',
    f9='鶴川';
INSERT postalcode
SET f3='1940004',
    f7='東京都',
    f8='町田市',
    f9='鶴間';
INSERT postalcode
SET f3='1940213',
    f7='東京都',
    f8='町田市',
    f9='常盤町';
INSERT postalcode
SET f3='1940021',
    f7='東京都',
    f8='町田市',
    f9='中町';
INSERT postalcode
SET f3='1940044',
    f7='東京都',
    f8='町田市',
    f9='成瀬';
INSERT postalcode
SET f3='1940011',
    f7='東京都',
    f8='町田市',
    f9='成瀬が丘';
INSERT postalcode
SET f3='1940043',
    f7='東京都',
    f8='町田市',
    f9='成瀬台';
INSERT postalcode
SET f3='1940038',
    f7='東京都',
    f8='町田市',
    f9='根岸';
INSERT postalcode
SET f3='1940034',
    f7='東京都',
    f8='町田市',
    f9='根岸町';
INSERT postalcode
SET f3='1950053',
    f7='東京都',
    f8='町田市',
    f9='能ケ谷町';
INSERT postalcode
SET f3='1950063',
    f7='東京都',
    f8='町田市',
    f9='野津田町';
INSERT postalcode
SET f3='1940013',
    f7='東京都',
    f8='町田市',
    f9='原町田';
INSERT postalcode
SET f3='1940042',
    f7='東京都',
    f8='町田市',
    f9='東玉川学園';
INSERT postalcode
SET f3='1950056',
    f7='東京都',
    f8='町田市',
    f9='広袴';
INSERT postalcode
SET f3='1950052',
    f7='東京都',
    f8='町田市',
    f9='広袴町';
INSERT postalcode
SET f3='1940032',
    f7='東京都',
    f8='町田市',
    f9='本町田';
INSERT postalcode
SET f3='1940031',
    f7='東京都',
    f8='町田市',
    f9='南大谷';
INSERT postalcode
SET f3='1940002',
    f7='東京都',
    f8='町田市',
    f9='南つくし野';
INSERT postalcode
SET f3='1940045',
    f7='東京都',
    f8='町田市',
    f9='南成瀬';
INSERT postalcode
SET f3='1950054',
    f7='東京都',
    f8='町田市',
    f9='三輪町';
INSERT postalcode
SET f3='1950055',
    f7='東京都',
    f8='町田市',
    f9='三輪緑山';
INSERT postalcode
SET f3='1940022',
    f7='東京都',
    f8='町田市',
    f9='森野';
INSERT postalcode
SET f3='1950073',
    f7='東京都',
    f8='町田市',
    f9='薬師台';
INSERT postalcode
SET f3='1940214',
    f7='東京都',
    f8='町田市',
    f9='矢部町';
INSERT postalcode
SET f3='1950075',
    f7='東京都',
    f8='町田市',
    f9='山崎';
INSERT postalcode
SET f3='1950074',
    f7='東京都',
    f8='町田市',
    f9='山崎町';
INSERT postalcode
SET f3='1840000',
    f7='東京都',
    f8='小金井市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1840002',
    f7='東京都',
    f8='小金井市',
    f9='梶野町';
INSERT postalcode
SET f3='1840005',
    f7='東京都',
    f8='小金井市',
    f9='桜町';
INSERT postalcode
SET f3='1840001',
    f7='東京都',
    f8='小金井市',
    f9='関野町';
INSERT postalcode
SET f3='1840012',
    f7='東京都',
    f8='小金井市',
    f9='中町';
INSERT postalcode
SET f3='1840014',
    f7='東京都',
    f8='小金井市',
    f9='貫井南町';
INSERT postalcode
SET f3='1840015',
    f7='東京都',
    f8='小金井市',
    f9='貫井北町';
INSERT postalcode
SET f3='1840011',
    f7='東京都',
    f8='小金井市',
    f9='東町';
INSERT postalcode
SET f3='1840004',
    f7='東京都',
    f8='小金井市',
    f9='本町';
INSERT postalcode
SET f3='1840013',
    f7='東京都',
    f8='小金井市',
    f9='前原町';
INSERT postalcode
SET f3='1840003',
    f7='東京都',
    f8='小金井市',
    f9='緑町';
INSERT postalcode
SET f3='1870000',
    f7='東京都',
    f8='小平市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1870001',
    f7='東京都',
    f8='小平市',
    f9='大沼町';
INSERT postalcode
SET f3='1870031',
    f7='東京都',
    f8='小平市',
    f9='小川東町';
INSERT postalcode
SET f3='1870035',
    f7='東京都',
    f8='小平市',
    f9='小川西町';
INSERT postalcode
SET f3='1870032',
    f7='東京都',
    f8='小平市',
    f9='小川町';
INSERT postalcode
SET f3='1870043',
    f7='東京都',
    f8='小平市',
    f9='学園東町';
INSERT postalcode
SET f3='1870045',
    f7='東京都',
    f8='小平市',
    f9='学園西町';
INSERT postalcode
SET f3='1870044',
    f7='東京都',
    f8='小平市',
    f9='喜平町';
INSERT postalcode
SET f3='1870034',
    f7='東京都',
    f8='小平市',
    f9='栄町';
INSERT postalcode
SET f3='1870023',
    f7='東京都',
    f8='小平市',
    f9='上水新町';
INSERT postalcode
SET f3='1870022',
    f7='東京都',
    f8='小平市',
    f9='上水本町';
INSERT postalcode
SET f3='1870021',
    f7='東京都',
    f8='小平市',
    f9='上水南町';
INSERT postalcode
SET f3='1870011',
    f7='東京都',
    f8='小平市',
    f9='鈴木町';
INSERT postalcode
SET f3='1870024',
    f7='東京都',
    f8='小平市',
    f9='たかの台';
INSERT postalcode
SET f3='1870025',
    f7='東京都',
    f8='小平市',
    f9='津田町';
INSERT postalcode
SET f3='1870004',
    f7='東京都',
    f8='小平市',
    f9='天神町';
INSERT postalcode
SET f3='1870033',
    f7='東京都',
    f8='小平市',
    f9='中島町';
INSERT postalcode
SET f3='1870042',
    f7='東京都',
    f8='小平市',
    f9='仲町';
INSERT postalcode
SET f3='1870002',
    f7='東京都',
    f8='小平市',
    f9='花小金井';
INSERT postalcode
SET f3='1870003',
    f7='東京都',
    f8='小平市',
    f9='花小金井南町';
INSERT postalcode
SET f3='1870041',
    f7='東京都',
    f8='小平市',
    f9='美園町';
INSERT postalcode
SET f3='1870012',
    f7='東京都',
    f8='小平市',
    f9='御幸町';
INSERT postalcode
SET f3='1870013',
    f7='東京都',
    f8='小平市',
    f9='回田町';
INSERT postalcode
SET f3='1910000',
    f7='東京都',
    f8='日野市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1910065',
    f7='東京都',
    f8='日野市',
    f9='旭が丘';
INSERT postalcode
SET f3='1910022',
    f7='東京都',
    f8='日野市',
    f9='新井';
INSERT postalcode
SET f3='1910021',
    f7='東京都',
    f8='日野市',
    f9='石田';
INSERT postalcode
SET f3='1910061',
    f7='東京都',
    f8='日野市',
    f9='大坂上';
INSERT postalcode
SET f3='1910034',
    f7='東京都',
    f8='日野市',
    f9='落川';
INSERT postalcode
SET f3='1910014',
    f7='東京都',
    f8='日野市',
    f9='上田';
INSERT postalcode
SET f3='1910015',
    f7='東京都',
    f8='日野市',
    f9='川辺堀之内';
INSERT postalcode
SET f3='1910001',
    f7='東京都',
    f8='日野市',
    f9='栄町';
INSERT postalcode
SET f3='1910063',
    f7='東京都',
    f8='日野市',
    f9='さくら町';
INSERT postalcode
SET f3='1910023',
    f7='東京都',
    f8='日野市',
    f9='下田';
INSERT postalcode
SET f3='1910002',
    f7='東京都',
    f8='日野市',
    f9='新町';
INSERT postalcode
SET f3='1910016',
    f7='東京都',
    f8='日野市',
    f9='神明';
INSERT postalcode
SET f3='1910031',
    f7='東京都',
    f8='日野市',
    f9='高幡';
INSERT postalcode
SET f3='1910062',
    f7='東京都',
    f8='日野市',
    f9='多摩平';
INSERT postalcode
SET f3='1910051',
    f7='東京都',
    f8='日野市',
    f9='豊田（大字）';
INSERT postalcode
SET f3='1910053',
    f7='東京都',
    f8='日野市',
    f9='豊田（丁目）';
INSERT postalcode
SET f3='1910055',
    f7='東京都',
    f8='日野市',
    f9='西平山';
INSERT postalcode
SET f3='1910052',
    f7='東京都',
    f8='日野市',
    f9='東豊田';
INSERT postalcode
SET f3='1910054',
    f7='東京都',
    f8='日野市',
    f9='東平山';
INSERT postalcode
SET f3='1910012',
    f7='東京都',
    f8='日野市',
    f9='日野';
INSERT postalcode
SET f3='1910003',
    f7='東京都',
    f8='日野市',
    f9='日野台';
INSERT postalcode
SET f3='1910011',
    f7='東京都',
    f8='日野市',
    f9='日野本町';
INSERT postalcode
SET f3='1910043',
    f7='東京都',
    f8='日野市',
    f9='平山';
INSERT postalcode
SET f3='1910064',
    f7='東京都',
    f8='日野市',
    f9='富士町';
INSERT postalcode
SET f3='1910042',
    f7='東京都',
    f8='日野市',
    f9='程久保';
INSERT postalcode
SET f3='1910024',
    f7='東京都',
    f8='日野市',
    f9='万願寺';
INSERT postalcode
SET f3='1910032',
    f7='東京都',
    f8='日野市',
    f9='三沢';
INSERT postalcode
SET f3='1910041',
    f7='東京都',
    f8='日野市',
    f9='南平';
INSERT postalcode
SET f3='1910013',
    f7='東京都',
    f8='日野市',
    f9='宮';
INSERT postalcode
SET f3='1910033',
    f7='東京都',
    f8='日野市',
    f9='百草';
INSERT postalcode
SET f3='1890000',
    f7='東京都',
    f8='東村山市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1890002',
    f7='東京都',
    f8='東村山市',
    f9='青葉町';
INSERT postalcode
SET f3='1890001',
    f7='東京都',
    f8='東村山市',
    f9='秋津町';
INSERT postalcode
SET f3='1890011',
    f7='東京都',
    f8='東村山市',
    f9='恩多町';
INSERT postalcode
SET f3='1890003',
    f7='東京都',
    f8='東村山市',
    f9='久米川町';
INSERT postalcode
SET f3='1890013',
    f7='東京都',
    f8='東村山市',
    f9='栄町';
INSERT postalcode
SET f3='1890021',
    f7='東京都',
    f8='東村山市',
    f9='諏訪町';
INSERT postalcode
SET f3='1890026',
    f7='東京都',
    f8='東村山市',
    f9='多摩湖町';
INSERT postalcode
SET f3='1890022',
    f7='東京都',
    f8='東村山市',
    f9='野口町';
INSERT postalcode
SET f3='1890012',
    f7='東京都',
    f8='東村山市',
    f9='萩山町';
INSERT postalcode
SET f3='1890024',
    f7='東京都',
    f8='東村山市',
    f9='富士見町';
INSERT postalcode
SET f3='1890014',
    f7='東京都',
    f8='東村山市',
    f9='本町';
INSERT postalcode
SET f3='1890023',
    f7='東京都',
    f8='東村山市',
    f9='美住町';
INSERT postalcode
SET f3='1890025',
    f7='東京都',
    f8='東村山市',
    f9='廻田町';
INSERT postalcode
SET f3='1850000',
    f7='東京都',
    f8='国分寺市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1850024',
    f7='東京都',
    f8='国分寺市',
    f9='泉町';
INSERT postalcode
SET f3='1850001',
    f7='東京都',
    f8='国分寺市',
    f9='北町';
INSERT postalcode
SET f3='1850004',
    f7='東京都',
    f8='国分寺市',
    f9='新町';
INSERT postalcode
SET f3='1850036',
    f7='東京都',
    f8='国分寺市',
    f9='高木町';
INSERT postalcode
SET f3='1850003',
    f7='東京都',
    f8='国分寺市',
    f9='戸倉';
INSERT postalcode
SET f3='1850033',
    f7='東京都',
    f8='国分寺市',
    f9='内藤';
INSERT postalcode
SET f3='1850005',
    f7='東京都',
    f8='国分寺市',
    f9='並木町';
INSERT postalcode
SET f3='1850013',
    f7='東京都',
    f8='国分寺市',
    f9='西恋ケ窪';
INSERT postalcode
SET f3='1850035',
    f7='東京都',
    f8='国分寺市',
    f9='西町';
INSERT postalcode
SET f3='1850023',
    f7='東京都',
    f8='国分寺市',
    f9='西元町';
INSERT postalcode
SET f3='1850034',
    f7='東京都',
    f8='国分寺市',
    f9='光町';
INSERT postalcode
SET f3='1850014',
    f7='東京都',
    f8='国分寺市',
    f9='東恋ケ窪';
INSERT postalcode
SET f3='1850002',
    f7='東京都',
    f8='国分寺市',
    f9='東戸倉';
INSERT postalcode
SET f3='1850022',
    f7='東京都',
    f8='国分寺市',
    f9='東元町';
INSERT postalcode
SET f3='1850032',
    f7='東京都',
    f8='国分寺市',
    f9='日吉町';
INSERT postalcode
SET f3='1850031',
    f7='東京都',
    f8='国分寺市',
    f9='富士本';
INSERT postalcode
SET f3='1850011',
    f7='東京都',
    f8='国分寺市',
    f9='本多';
INSERT postalcode
SET f3='1850012',
    f7='東京都',
    f8='国分寺市',
    f9='本町';
INSERT postalcode
SET f3='1850021',
    f7='東京都',
    f8='国分寺市',
    f9='南町';
INSERT postalcode
SET f3='1860000',
    f7='東京都',
    f8='国立市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1860013',
    f7='東京都',
    f8='国立市',
    f9='青柳';
INSERT postalcode
SET f3='1860014',
    f7='東京都',
    f8='国立市',
    f9='石田';
INSERT postalcode
SET f3='1860012',
    f7='東京都',
    f8='国立市',
    f9='泉';
INSERT postalcode
SET f3='1860001',
    f7='東京都',
    f8='国立市',
    f9='北';
INSERT postalcode
SET f3='1860004',
    f7='東京都',
    f8='国立市',
    f9='中';
INSERT postalcode
SET f3='1860005',
    f7='東京都',
    f8='国立市',
    f9='西';
INSERT postalcode
SET f3='1860002',
    f7='東京都',
    f8='国立市',
    f9='東';
INSERT postalcode
SET f3='1860003',
    f7='東京都',
    f8='国立市',
    f9='富士見台';
INSERT postalcode
SET f3='1860015',
    f7='東京都',
    f8='国立市',
    f9='矢川';
INSERT postalcode
SET f3='1860011',
    f7='東京都',
    f8='国立市',
    f9='谷保';
INSERT postalcode
SET f3='1970000',
    f7='東京都',
    f8='福生市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1970024',
    f7='東京都',
    f8='福生市',
    f9='牛浜';
INSERT postalcode
SET f3='1970012',
    f7='東京都',
    f8='福生市',
    f9='加美平';
INSERT postalcode
SET f3='1970005',
    f7='東京都',
    f8='福生市',
    f9='北田園';
INSERT postalcode
SET f3='1970003',
    f7='東京都',
    f8='福生市',
    f9='熊川';
INSERT postalcode
SET f3='1970002',
    f7='東京都',
    f8='福生市',
    f9='熊川二宮';
INSERT postalcode
SET f3='1970023',
    f7='東京都',
    f8='福生市',
    f9='志茂';
INSERT postalcode
SET f3='1970021',
    f7='東京都',
    f8='福生市',
    f9='東町';
INSERT postalcode
SET f3='1970011',
    f7='東京都',
    f8='福生市',
    f9='福生';
INSERT postalcode
SET f3='1970014',
    f7='東京都',
    f8='福生市',
    f9='福生二宮';
INSERT postalcode
SET f3='1970022',
    f7='東京都',
    f8='福生市',
    f9='本町';
INSERT postalcode
SET f3='1970004',
    f7='東京都',
    f8='福生市',
    f9='南田園';
INSERT postalcode
SET f3='1970013',
    f7='東京都',
    f8='福生市',
    f9='武蔵野台';
INSERT postalcode
SET f3='1970001',
    f7='東京都',
    f8='福生市',
    f9='横田基地内';
INSERT postalcode
SET f3='2010000',
    f7='東京都',
    f8='狛江市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='2010003',
    f7='東京都',
    f8='狛江市',
    f9='和泉本町';
INSERT postalcode
SET f3='2010015',
    f7='東京都',
    f8='狛江市',
    f9='猪方';
INSERT postalcode
SET f3='2010005',
    f7='東京都',
    f8='狛江市',
    f9='岩戸南';
INSERT postalcode
SET f3='2010004',
    f7='東京都',
    f8='狛江市',
    f9='岩戸北';
INSERT postalcode
SET f3='2010016',
    f7='東京都',
    f8='狛江市',
    f9='駒井町';
INSERT postalcode
SET f3='2010012',
    f7='東京都',
    f8='狛江市',
    f9='中和泉';
INSERT postalcode
SET f3='2010011',
    f7='東京都',
    f8='狛江市',
    f9='西和泉';
INSERT postalcode
SET f3='2010001',
    f7='東京都',
    f8='狛江市',
    f9='西野川';
INSERT postalcode
SET f3='2010014',
    f7='東京都',
    f8='狛江市',
    f9='東和泉';
INSERT postalcode
SET f3='2010002',
    f7='東京都',
    f8='狛江市',
    f9='東野川';
INSERT postalcode
SET f3='2010013',
    f7='東京都',
    f8='狛江市',
    f9='元和泉';
INSERT postalcode
SET f3='2070000',
    f7='東京都',
    f8='東大和市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='2070033',
    f7='東京都',
    f8='東大和市',
    f9='芋窪';
INSERT postalcode
SET f3='2070023',
    f7='東京都',
    f8='東大和市',
    f9='上北台';
INSERT postalcode
SET f3='2070011',
    f7='東京都',
    f8='東大和市',
    f9='清原';
INSERT postalcode
SET f3='2070002',
    f7='東京都',
    f8='東大和市',
    f9='湖畔';
INSERT postalcode
SET f3='2070022',
    f7='東京都',
    f8='東大和市',
    f9='桜が丘';
INSERT postalcode
SET f3='2070003',
    f7='東京都',
    f8='東大和市',
    f9='狭山';
INSERT postalcode
SET f3='2070004',
    f7='東京都',
    f8='東大和市',
    f9='清水';
INSERT postalcode
SET f3='2070012',
    f7='東京都',
    f8='東大和市',
    f9='新堀';
INSERT postalcode
SET f3='2070032',
    f7='東京都',
    f8='東大和市',
    f9='蔵敷';
INSERT postalcode
SET f3='2070005',
    f7='東京都',
    f8='東大和市',
    f9='高木';
INSERT postalcode
SET f3='2070021',
    f7='東京都',
    f8='東大和市',
    f9='立野';
INSERT postalcode
SET f3='2070001',
    f7='東京都',
    f8='東大和市',
    f9='多摩湖';
INSERT postalcode
SET f3='2070015',
    f7='東京都',
    f8='東大和市',
    f9='中央';
INSERT postalcode
SET f3='2070016',
    f7='東京都',
    f8='東大和市',
    f9='仲原';
INSERT postalcode
SET f3='2070031',
    f7='東京都',
    f8='東大和市',
    f9='奈良橋';
INSERT postalcode
SET f3='2070014',
    f7='東京都',
    f8='東大和市',
    f9='南街';
INSERT postalcode
SET f3='2070013',
    f7='東京都',
    f8='東大和市',
    f9='向原';
INSERT postalcode
SET f3='2040000',
    f7='東京都',
    f8='清瀬市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='2040002',
    f7='東京都',
    f8='清瀬市',
    f9='旭が丘';
INSERT postalcode
SET f3='2040024',
    f7='東京都',
    f8='清瀬市',
    f9='梅園';
INSERT postalcode
SET f3='2040013',
    f7='東京都',
    f8='清瀬市',
    f9='上清戸';
INSERT postalcode
SET f3='2040001',
    f7='東京都',
    f8='清瀬市',
    f9='下宿';
INSERT postalcode
SET f3='2040011',
    f7='東京都',
    f8='清瀬市',
    f9='下清戸';
INSERT postalcode
SET f3='2040023',
    f7='東京都',
    f8='清瀬市',
    f9='竹丘';
INSERT postalcode
SET f3='2040012',
    f7='東京都',
    f8='清瀬市',
    f9='中清戸';
INSERT postalcode
SET f3='2040003',
    f7='東京都',
    f8='清瀬市',
    f9='中里';
INSERT postalcode
SET f3='2040004',
    f7='東京都',
    f8='清瀬市',
    f9='野塩';
INSERT postalcode
SET f3='2040022',
    f7='東京都',
    f8='清瀬市',
    f9='松山';
INSERT postalcode
SET f3='2040021',
    f7='東京都',
    f8='清瀬市',
    f9='元町';
INSERT postalcode
SET f3='2030000',
    f7='東京都',
    f8='東久留米市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='2030001',
    f7='東京都',
    f8='東久留米市',
    f9='上の原';
INSERT postalcode
SET f3='2030021',
    f7='東京都',
    f8='東久留米市',
    f9='学園町';
INSERT postalcode
SET f3='2030003',
    f7='東京都',
    f8='東久留米市',
    f9='金山町';
INSERT postalcode
SET f3='2030051',
    f7='東京都',
    f8='東久留米市',
    f9='小山';
INSERT postalcode
SET f3='2030052',
    f7='東京都',
    f8='東久留米市',
    f9='幸町';
INSERT postalcode
SET f3='2030043',
    f7='東京都',
    f8='東久留米市',
    f9='下里';
INSERT postalcode
SET f3='2030013',
    f7='東京都',
    f8='東久留米市',
    f9='新川町';
INSERT postalcode
SET f3='2030002',
    f7='東京都',
    f8='東久留米市',
    f9='神宝町';
INSERT postalcode
SET f3='2030012',
    f7='東京都',
    f8='東久留米市',
    f9='浅間町';
INSERT postalcode
SET f3='2030011',
    f7='東京都',
    f8='東久留米市',
    f9='大門町';
INSERT postalcode
SET f3='2030033',
    f7='東京都',
    f8='東久留米市',
    f9='滝山';
INSERT postalcode
SET f3='2030054',
    f7='東京都',
    f8='東久留米市',
    f9='中央町';
INSERT postalcode
SET f3='2030041',
    f7='東京都',
    f8='東久留米市',
    f9='野火止';
INSERT postalcode
SET f3='2030042',
    f7='東京都',
    f8='東久留米市',
    f9='八幡町';
INSERT postalcode
SET f3='2030004',
    f7='東京都',
    f8='東久留米市',
    f9='氷川台';
INSERT postalcode
SET f3='2030014',
    f7='東京都',
    f8='東久留米市',
    f9='東本町';
INSERT postalcode
SET f3='2030022',
    f7='東京都',
    f8='東久留米市',
    f9='ひばりが丘団地';
INSERT postalcode
SET f3='2030053',
    f7='東京都',
    f8='東久留米市',
    f9='本町';
INSERT postalcode
SET f3='2030032',
    f7='東京都',
    f8='東久留米市',
    f9='前沢';
INSERT postalcode
SET f3='2030023',
    f7='東京都',
    f8='東久留米市',
    f9='南沢';
INSERT postalcode
SET f3='2030031',
    f7='東京都',
    f8='東久留米市',
    f9='南町';
INSERT postalcode
SET f3='2030044',
    f7='東京都',
    f8='東久留米市',
    f9='柳窪';
INSERT postalcode
SET f3='2030034',
    f7='東京都',
    f8='東久留米市',
    f9='弥生';
INSERT postalcode
SET f3='2080000',
    f7='東京都',
    f8='武蔵村山市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='2080023',
    f7='東京都',
    f8='武蔵村山市',
    f9='伊奈平';
INSERT postalcode
SET f3='2080022',
    f7='東京都',
    f8='武蔵村山市',
    f9='榎';
INSERT postalcode
SET f3='2080013',
    f7='東京都',
    f8='武蔵村山市',
    f9='大南';
INSERT postalcode
SET f3='2080011',
    f7='東京都',
    f8='武蔵村山市',
    f9='学園';
INSERT postalcode
SET f3='2080031',
    f7='東京都',
    f8='武蔵村山市',
    f9='岸';
INSERT postalcode
SET f3='2080034',
    f7='東京都',
    f8='武蔵村山市',
    f9='残堀';
INSERT postalcode
SET f3='2080002',
    f7='東京都',
    f8='武蔵村山市',
    f9='神明';
INSERT postalcode
SET f3='2080003',
    f7='東京都',
    f8='武蔵村山市',
    f9='中央';
INSERT postalcode
SET f3='2080001',
    f7='東京都',
    f8='武蔵村山市',
    f9='中藤';
INSERT postalcode
SET f3='2080035',
    f7='東京都',
    f8='武蔵村山市',
    f9='中原';
INSERT postalcode
SET f3='2080004',
    f7='東京都',
    f8='武蔵村山市',
    f9='本町';
INSERT postalcode
SET f3='2080033',
    f7='東京都',
    f8='武蔵村山市',
    f9='三ツ木（大字）';
INSERT postalcode
SET f3='2080032',
    f7='東京都',
    f8='武蔵村山市',
    f9='三ツ木（１〜５丁目）';
INSERT postalcode
SET f3='2080021',
    f7='東京都',
    f8='武蔵村山市',
    f9='三ツ藤';
INSERT postalcode
SET f3='2080012',
    f7='東京都',
    f8='武蔵村山市',
    f9='緑が丘';
INSERT postalcode
SET f3='2060000',
    f7='東京都',
    f8='多摩市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='2060041',
    f7='東京都',
    f8='多摩市',
    f9='愛宕';
INSERT postalcode
SET f3='2060002',
    f7='東京都',
    f8='多摩市',
    f9='一ノ宮';
INSERT postalcode
SET f3='2060033',
    f7='東京都',
    f8='多摩市',
    f9='落合';
INSERT postalcode
SET f3='2060015',
    f7='東京都',
    f8='多摩市',
    f9='落川';
INSERT postalcode
SET f3='2060012',
    f7='東京都',
    f8='多摩市',
    f9='貝取';
INSERT postalcode
SET f3='2060035',
    f7='東京都',
    f8='多摩市',
    f9='唐木田';
INSERT postalcode
SET f3='2060014',
    f7='東京都',
    f8='多摩市',
    f9='乞田';
INSERT postalcode
SET f3='2060013',
    f7='東京都',
    f8='多摩市',
    f9='桜ケ丘';
INSERT postalcode
SET f3='2060042',
    f7='東京都',
    f8='多摩市',
    f9='山王下';
INSERT postalcode
SET f3='2060024',
    f7='東京都',
    f8='多摩市',
    f9='諏訪';
INSERT postalcode
SET f3='2060011',
    f7='東京都',
    f8='多摩市',
    f9='関戸';
INSERT postalcode
SET f3='2060034',
    f7='東京都',
    f8='多摩市',
    f9='鶴牧';
INSERT postalcode
SET f3='2060031',
    f7='東京都',
    f8='多摩市',
    f9='豊ケ丘';
INSERT postalcode
SET f3='2060036',
    f7='東京都',
    f8='多摩市',
    f9='中沢';
INSERT postalcode
SET f3='2060025',
    f7='東京都',
    f8='多摩市',
    f9='永山';
INSERT postalcode
SET f3='2060003',
    f7='東京都',
    f8='多摩市',
    f9='東寺方';
INSERT postalcode
SET f3='2060022',
    f7='東京都',
    f8='多摩市',
    f9='聖ケ丘';
INSERT postalcode
SET f3='2060023',
    f7='東京都',
    f8='多摩市',
    f9='馬引沢';
INSERT postalcode
SET f3='2060032',
    f7='東京都',
    f8='多摩市',
    f9='南野';
INSERT postalcode
SET f3='2060004',
    f7='東京都',
    f8='多摩市',
    f9='百草';
INSERT postalcode
SET f3='2060021',
    f7='東京都',
    f8='多摩市',
    f9='連光寺';
INSERT postalcode
SET f3='2060001',
    f7='東京都',
    f8='多摩市',
    f9='和田';
INSERT postalcode
SET f3='2060000',
    f7='東京都',
    f8='稲城市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='2060801',
    f7='東京都',
    f8='稲城市',
    f9='大丸';
INSERT postalcode
SET f3='2060811',
    f7='東京都',
    f8='稲城市',
    f9='押立';
INSERT postalcode
SET f3='2060803',
    f7='東京都',
    f8='稲城市',
    f9='向陽台';
INSERT postalcode
SET f3='2060822',
    f7='東京都',
    f8='稲城市',
    f9='坂浜';
INSERT postalcode
SET f3='2060821',
    f7='東京都',
    f8='稲城市',
    f9='長峰';
INSERT postalcode
SET f3='2060802',
    f7='東京都',
    f8='稲城市',
    f9='東長沼';
INSERT postalcode
SET f3='2060823',
    f7='東京都',
    f8='稲城市',
    f9='平尾';
INSERT postalcode
SET f3='2060804',
    f7='東京都',
    f8='稲城市',
    f9='百村';
INSERT postalcode
SET f3='2060812',
    f7='東京都',
    f8='稲城市',
    f9='矢野口';
INSERT postalcode
SET f3='2060824',
    f7='東京都',
    f8='稲城市',
    f9='若葉台';
INSERT postalcode
SET f3='2050000',
    f7='東京都',
    f8='羽村市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='2050001',
    f7='東京都',
    f8='羽村市',
    f9='小作台';
INSERT postalcode
SET f3='2050021',
    f7='東京都',
    f8='羽村市',
    f9='川崎';
INSERT postalcode
SET f3='2050011',
    f7='東京都',
    f8='羽村市',
    f9='五ノ神';
INSERT postalcode
SET f3='2050002',
    f7='東京都',
    f8='羽村市',
    f9='栄町';
INSERT postalcode
SET f3='2050023',
    f7='東京都',
    f8='羽村市',
    f9='神明台';
INSERT postalcode
SET f3='2050024',
    f7='東京都',
    f8='羽村市',
    f9='玉川';
INSERT postalcode
SET f3='2050012',
    f7='東京都',
    f8='羽村市',
    f9='羽';
INSERT postalcode
SET f3='2050016',
    f7='東京都',
    f8='羽村市',
    f9='羽加美';
INSERT postalcode
SET f3='2050015',
    f7='東京都',
    f8='羽村市',
    f9='羽中';
INSERT postalcode
SET f3='2050014',
    f7='東京都',
    f8='羽村市',
    f9='羽東';
INSERT postalcode
SET f3='2050017',
    f7='東京都',
    f8='羽村市',
    f9='羽西';
INSERT postalcode
SET f3='2050013',
    f7='東京都',
    f8='羽村市',
    f9='富士見平';
INSERT postalcode
SET f3='2050022',
    f7='東京都',
    f8='羽村市',
    f9='双葉町';
INSERT postalcode
SET f3='2050003',
    f7='東京都',
    f8='羽村市',
    f9='緑ケ丘';
INSERT postalcode
SET f3='1900100',
    f7='東京都',
    f8='あきる野市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1970804',
    f7='東京都',
    f8='あきる野市',
    f9='秋川';
INSERT postalcode
SET f3='1970828',
    f7='東京都',
    f8='あきる野市',
    f9='秋留';
INSERT postalcode
SET f3='1900155',
    f7='東京都',
    f8='あきる野市',
    f9='網代';
INSERT postalcode
SET f3='1970827',
    f7='東京都',
    f8='あきる野市',
    f9='油平';
INSERT postalcode
SET f3='1970825',
    f7='東京都',
    f8='あきる野市',
    f9='雨間';
INSERT postalcode
SET f3='1900164',
    f7='東京都',
    f8='あきる野市',
    f9='五日市';
INSERT postalcode
SET f3='1900142',
    f7='東京都',
    f8='あきる野市',
    f9='伊奈';
INSERT postalcode
SET f3='1900161',
    f7='東京都',
    f8='あきる野市',
    f9='入野';
INSERT postalcode
SET f3='1900143',
    f7='東京都',
    f8='あきる野市',
    f9='上ノ台';
INSERT postalcode
SET f3='1970826',
    f7='東京都',
    f8='あきる野市',
    f9='牛沼';
INSERT postalcode
SET f3='1970821',
    f7='東京都',
    f8='あきる野市',
    f9='小川';
INSERT postalcode
SET f3='1970822',
    f7='東京都',
    f8='あきる野市',
    f9='小川東';
INSERT postalcode
SET f3='1900174',
    f7='東京都',
    f8='あきる野市',
    f9='乙津';
INSERT postalcode
SET f3='1970832',
    f7='東京都',
    f8='あきる野市',
    f9='上代継';
INSERT postalcode
SET f3='1970824',
    f7='東京都',
    f8='あきる野市',
    f9='切欠';
INSERT postalcode
SET f3='1970802',
    f7='東京都',
    f8='あきる野市',
    f9='草花';
INSERT postalcode
SET f3='1900165',
    f7='東京都',
    f8='あきる野市',
    f9='小中野';
INSERT postalcode
SET f3='1900153',
    f7='東京都',
    f8='あきる野市',
    f9='小峰台';
INSERT postalcode
SET f3='1900151',
    f7='東京都',
    f8='あきる野市',
    f9='小和田';
INSERT postalcode
SET f3='1900162',
    f7='東京都',
    f8='あきる野市',
    f9='三内';
INSERT postalcode
SET f3='1970831',
    f7='東京都',
    f8='あきる野市',
    f9='下代継';
INSERT postalcode
SET f3='1970801',
    f7='東京都',
    f8='あきる野市',
    f9='菅生';
INSERT postalcode
SET f3='1970803',
    f7='東京都',
    f8='あきる野市',
    f9='瀬戸岡';
INSERT postalcode
SET f3='1900154',
    f7='東京都',
    f8='あきる野市',
    f9='高尾';
INSERT postalcode
SET f3='1900163',
    f7='東京都',
    f8='あきる野市',
    f9='舘谷';
INSERT postalcode
SET f3='1900166',
    f7='東京都',
    f8='あきる野市',
    f9='舘谷台';
INSERT postalcode
SET f3='1900173',
    f7='東京都',
    f8='あきる野市',
    f9='戸倉';
INSERT postalcode
SET f3='1900152',
    f7='東京都',
    f8='あきる野市',
    f9='留原';
INSERT postalcode
SET f3='1970814',
    f7='東京都',
    f8='あきる野市',
    f9='二宮';
INSERT postalcode
SET f3='1970815',
    f7='東京都',
    f8='あきる野市',
    f9='二宮東';
INSERT postalcode
SET f3='1970823',
    f7='東京都',
    f8='あきる野市',
    f9='野辺';
INSERT postalcode
SET f3='1970811',
    f7='東京都',
    f8='あきる野市',
    f9='原小宮';
INSERT postalcode
SET f3='1970834',
    f7='東京都',
    f8='あきる野市',
    f9='引田';
INSERT postalcode
SET f3='1970812',
    f7='東京都',
    f8='あきる野市',
    f9='平沢';
INSERT postalcode
SET f3='1970816',
    f7='東京都',
    f8='あきる野市',
    f9='平沢西';
INSERT postalcode
SET f3='1970813',
    f7='東京都',
    f8='あきる野市',
    f9='平沢東';
INSERT postalcode
SET f3='1900172',
    f7='東京都',
    f8='あきる野市',
    f9='深沢';
INSERT postalcode
SET f3='1970833',
    f7='東京都',
    f8='あきる野市',
    f9='渕上';
INSERT postalcode
SET f3='1900144',
    f7='東京都',
    f8='あきる野市',
    f9='山田';
INSERT postalcode
SET f3='1900171',
    f7='東京都',
    f8='あきる野市',
    f9='養沢';
INSERT postalcode
SET f3='1900141',
    f7='東京都',
    f8='あきる野市',
    f9='横沢';
INSERT postalcode
SET f3='2020000',
    f7='東京都',
    f8='西東京市',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='2020011',
    f7='東京都',
    f8='西東京市',
    f9='泉町';
INSERT postalcode
SET f3='1880003',
    f7='東京都',
    f8='西東京市',
    f9='北原町';
INSERT postalcode
SET f3='2020003',
    f7='東京都',
    f8='西東京市',
    f9='北町';
INSERT postalcode
SET f3='2020006',
    f7='東京都',
    f8='西東京市',
    f9='栄町';
INSERT postalcode
SET f3='1880014',
    f7='東京都',
    f8='西東京市',
    f9='芝久保町';
INSERT postalcode
SET f3='2020004',
    f7='東京都',
    f8='西東京市',
    f9='下保谷';
INSERT postalcode
SET f3='2020023',
    f7='東京都',
    f8='西東京市',
    f9='新町';
INSERT postalcode
SET f3='2020005',
    f7='東京都',
    f8='西東京市',
    f9='住吉町';
INSERT postalcode
SET f3='1880011',
    f7='東京都',
    f8='西東京市',
    f9='田無町';
INSERT postalcode
SET f3='2020013',
    f7='東京都',
    f8='西東京市',
    f9='中町';
INSERT postalcode
SET f3='1880004',
    f7='東京都',
    f8='西東京市',
    f9='西原町';
INSERT postalcode
SET f3='2020012',
    f7='東京都',
    f8='西東京市',
    f9='東町';
INSERT postalcode
SET f3='2020021',
    f7='東京都',
    f8='西東京市',
    f9='東伏見';
INSERT postalcode
SET f3='2020001',
    f7='東京都',
    f8='西東京市',
    f9='ひばりが丘';
INSERT postalcode
SET f3='2020002',
    f7='東京都',
    f8='西東京市',
    f9='ひばりが丘北';
INSERT postalcode
SET f3='2020014',
    f7='東京都',
    f8='西東京市',
    f9='富士町';
INSERT postalcode
SET f3='2020015',
    f7='東京都',
    f8='西東京市',
    f9='保谷町';
INSERT postalcode
SET f3='1880002',
    f7='東京都',
    f8='西東京市',
    f9='緑町';
INSERT postalcode
SET f3='1880012',
    f7='東京都',
    f8='西東京市',
    f9='南町';
INSERT postalcode
SET f3='1880013',
    f7='東京都',
    f8='西東京市',
    f9='向台町';
INSERT postalcode
SET f3='2020022',
    f7='東京都',
    f8='西東京市',
    f9='柳沢';
INSERT postalcode
SET f3='1880001',
    f7='東京都',
    f8='西東京市',
    f9='谷戸町';
INSERT postalcode
SET f3='1901200',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1901211',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='石畑';
INSERT postalcode
SET f3='1901202',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='駒形富士山';
INSERT postalcode
SET f3='1901203',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='高根';
INSERT postalcode
SET f3='1901212',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='殿ケ谷';
INSERT postalcode
SET f3='1901232',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='長岡';
INSERT postalcode
SET f3='1901233',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='長岡下師岡';
INSERT postalcode
SET f3='1901231',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='長岡長谷部';
INSERT postalcode
SET f3='1901234',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='長岡藤橋';
INSERT postalcode
SET f3='1901201',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='二本木';
INSERT postalcode
SET f3='1901221',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='箱根ケ崎';
INSERT postalcode
SET f3='1901222',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='箱根ケ崎東松原';
INSERT postalcode
SET f3='1901223',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='箱根ケ崎西松原';
INSERT postalcode
SET f3='1901204',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='富士山栗原新田';
INSERT postalcode
SET f3='1901224',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='南平';
INSERT postalcode
SET f3='1901213',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='武蔵';
INSERT postalcode
SET f3='1901214',
    f7='東京都',
    f8='西多摩郡瑞穂町',
    f9='むさし野';
INSERT postalcode
SET f3='1900100',
    f7='東京都',
    f8='西多摩郡日の出町',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1900181',
    f7='東京都',
    f8='西多摩郡日の出町',
    f9='大久野';
INSERT postalcode
SET f3='1900182',
    f7='東京都',
    f8='西多摩郡日の出町',
    f9='平井';
INSERT postalcode
SET f3='1900200',
    f7='東京都',
    f8='西多摩郡檜原村',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1900204',
    f7='東京都',
    f8='西多摩郡檜原村',
    f9='小沢';
INSERT postalcode
SET f3='1900221',
    f7='東京都',
    f8='西多摩郡檜原村',
    f9='数馬';
INSERT postalcode
SET f3='1900203',
    f7='東京都',
    f8='西多摩郡檜原村',
    f9='神戸';
INSERT postalcode
SET f3='1900212',
    f7='東京都',
    f8='西多摩郡檜原村',
    f9='上元郷';
INSERT postalcode
SET f3='1900201',
    f7='東京都',
    f8='西多摩郡檜原村',
    f9='倉掛';
INSERT postalcode
SET f3='1900213',
    f7='東京都',
    f8='西多摩郡檜原村',
    f9='下元郷';
INSERT postalcode
SET f3='1900223',
    f7='東京都',
    f8='西多摩郡檜原村',
    f9='南郷';
INSERT postalcode
SET f3='1900205',
    f7='東京都',
    f8='西多摩郡檜原村',
    f9='樋里';
INSERT postalcode
SET f3='1900202',
    f7='東京都',
    f8='西多摩郡檜原村',
    f9='藤原';
INSERT postalcode
SET f3='1900222',
    f7='東京都',
    f8='西多摩郡檜原村',
    f9='人里';
INSERT postalcode
SET f3='1900211',
    f7='東京都',
    f8='西多摩郡檜原村',
    f9='三都郷';
INSERT postalcode
SET f3='1900214',
    f7='東京都',
    f8='西多摩郡檜原村',
    f9='本宿';
INSERT postalcode
SET f3='1980000',
    f7='東京都',
    f8='西多摩郡奥多摩町',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1980213',
    f7='東京都',
    f8='西多摩郡奥多摩町',
    f9='海沢';
INSERT postalcode
SET f3='1980103',
    f7='東京都',
    f8='西多摩郡奥多摩町',
    f9='梅沢';
INSERT postalcode
SET f3='1980101',
    f7='東京都',
    f8='西多摩郡奥多摩町',
    f9='大丹波';
INSERT postalcode
SET f3='1980102',
    f7='東京都',
    f8='西多摩郡奥多摩町',
    f9='川井';
INSERT postalcode
SET f3='1980225',
    f7='東京都',
    f8='西多摩郡奥多摩町',
    f9='川野';
INSERT postalcode
SET f3='1980224',
    f7='東京都',
    f8='西多摩郡奥多摩町',
    f9='河内';
INSERT postalcode
SET f3='1980105',
    f7='東京都',
    f8='西多摩郡奥多摩町',
    f9='小丹波';
INSERT postalcode
SET f3='1980222',
    f7='東京都',
    f8='西多摩郡奥多摩町',
    f9='境';
INSERT postalcode
SET f3='1980107',
    f7='東京都',
    f8='西多摩郡奥多摩町',
    f9='白丸';
INSERT postalcode
SET f3='1980106',
    f7='東京都',
    f8='西多摩郡奥多摩町',
    f9='棚沢';
INSERT postalcode
SET f3='1980104',
    f7='東京都',
    f8='西多摩郡奥多摩町',
    f9='丹三郎';
INSERT postalcode
SET f3='1980221',
    f7='東京都',
    f8='西多摩郡奥多摩町',
    f9='留浦';
INSERT postalcode
SET f3='1980211',
    f7='東京都',
    f8='西多摩郡奥多摩町',
    f9='日原';
INSERT postalcode
SET f3='1980223',
    f7='東京都',
    f8='西多摩郡奥多摩町',
    f9='原';
INSERT postalcode
SET f3='1980212',
    f7='東京都',
    f8='西多摩郡奥多摩町',
    f9='氷川';
INSERT postalcode
SET f3='1000100',
    f7='東京都',
    f8='大島町',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1000102',
    f7='東京都',
    f8='大島町',
    f9='岡田';
INSERT postalcode
SET f3='1000211',
    f7='東京都',
    f8='大島町',
    f9='差木地';
INSERT postalcode
SET f3='1000103',
    f7='東京都',
    f8='大島町',
    f9='泉津';
INSERT postalcode
SET f3='1000104',
    f7='東京都',
    f8='大島町',
    f9='野増';
INSERT postalcode
SET f3='1000212',
    f7='東京都',
    f8='大島町',
    f9='波浮港';
INSERT postalcode
SET f3='1000101',
    f7='東京都',
    f8='大島町',
    f9='元町';
INSERT postalcode
SET f3='1000301',
    f7='東京都',
    f8='利島村',
    f9='利島村一円';
INSERT postalcode
SET f3='1000400',
    f7='東京都',
    f8='新島村',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1000511',
    f7='東京都',
    f8='新島村',
    f9='式根島';
INSERT postalcode
SET f3='1000402',
    f7='東京都',
    f8='新島村',
    f9='本村';
INSERT postalcode
SET f3='1000401',
    f7='東京都',
    f8='新島村',
    f9='若郷';
INSERT postalcode
SET f3='1000601',
    f7='東京都',
    f8='神津島村',
    f9='神津島村一円';
INSERT postalcode
SET f3='1001100',
    f7='東京都',
    f8='三宅島三宅村',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1001212',
    f7='東京都',
    f8='三宅島三宅村',
    f9='阿古';
INSERT postalcode
SET f3='1001103',
    f7='東京都',
    f8='三宅島三宅村',
    f9='伊ケ谷';
INSERT postalcode
SET f3='1001102',
    f7='東京都',
    f8='三宅島三宅村',
    f9='伊豆';
INSERT postalcode
SET f3='1001213',
    f7='東京都',
    f8='三宅島三宅村',
    f9='雄山';
INSERT postalcode
SET f3='1001101',
    f7='東京都',
    f8='三宅島三宅村',
    f9='神着';
INSERT postalcode
SET f3='1001211',
    f7='東京都',
    f8='三宅島三宅村',
    f9='坪田';
INSERT postalcode
SET f3='1001301',
    f7='東京都',
    f8='御蔵島村',
    f9='御蔵島村一円';
INSERT postalcode
SET f3='1001400',
    f7='東京都',
    f8='八丈島八丈町',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1001401',
    f7='東京都',
    f8='八丈島八丈町',
    f9='大賀郷';
INSERT postalcode
SET f3='1001621',
    f7='東京都',
    f8='八丈島八丈町',
    f9='樫立';
INSERT postalcode
SET f3='1001622',
    f7='東京都',
    f8='八丈島八丈町',
    f9='末吉';
INSERT postalcode
SET f3='1001623',
    f7='東京都',
    f8='八丈島八丈町',
    f9='中之郷';
INSERT postalcode
SET f3='1001511',
    f7='東京都',
    f8='八丈島八丈町',
    f9='三根';
INSERT postalcode
SET f3='1001701',
    f7='東京都',
    f8='青ヶ島村',
    f9='青ヶ島村一円';
INSERT postalcode
SET f3='1002100',
    f7='東京都',
    f8='小笠原村',
    f9='以下に掲載がない場合';
INSERT postalcode
SET f3='1002101',
    f7='東京都',
    f8='小笠原村',
    f9='父島';
INSERT postalcode
SET f3='1002211',
    f7='東京都',
    f8='小笠原村',
    f9='母島';

#  The schema for the "Sample_Extensible" sample set.
#
#

DROP TABLE IF EXISTS saleslog;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS item_master;

CREATE TABLE saleslog
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    dt          DATETIME,
    item        VARCHAR(20),
    customer    VARCHAR(70),
    qty         INT,
    item_id     INT,
    customer_id INT,
    unitprice   INT,
    total       INT
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

CREATE TABLE item_master
(
    id        INT PRIMARY KEY,
    name      VARCHAR(20),
    unitprice INT
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

CREATE TABLE customer
(
    id   INT PRIMARY KEY,
    name VARCHAR(70)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

INSERT item_master
SET id=1,
    `name`='Artichokes ',
    unitprice=957;
INSERT item_master
SET id=2,
    `name`='Asparagus ',
    unitprice=103;
INSERT item_master
SET id=3,
    `name`='Aubergine ',
    unitprice=294;
INSERT item_master
SET id=4,
    `name`='Beans ',
    unitprice=245;
INSERT item_master
SET id=5,
    `name`='Bok Choy ',
    unitprice=533;
INSERT item_master
SET id=6,
    `name`='Broccoli ',
    unitprice=1025;
INSERT item_master
SET id=7,
    `name`='Brussels Sprouts ',
    unitprice=776;
INSERT item_master
SET id=8,
    `name`='Cabbage ',
    unitprice=492;
INSERT item_master
SET id=9,
    `name`='Capsicum ',
    unitprice=578;
INSERT item_master
SET id=10,
    `name`='Carrot ',
    unitprice=460;
INSERT item_master
SET id=11,
    `name`='Cauliflower ',
    unitprice=565;
INSERT item_master
SET id=12,
    `name`='Celeriac ',
    unitprice=462;
INSERT item_master
SET id=13,
    `name`='Celery ',
    unitprice=536;
INSERT item_master
SET id=14,
    `name`='Corn ',
    unitprice=739;
INSERT item_master
SET id=15,
    `name`='Courgette ',
    unitprice=251;
INSERT item_master
SET id=16,
    `name`='Cucumber ',
    unitprice=472;
INSERT item_master
SET id=17,
    `name`='Dram sticks ',
    unitprice=164;
INSERT item_master
SET id=18,
    `name`='Fennel ',
    unitprice=662;
INSERT item_master
SET id=19,
    `name`='Garlic ',
    unitprice=484;
INSERT item_master
SET id=20,
    `name`='Leek ',
    unitprice=708;
INSERT item_master
SET id=21,
    `name`='Lettuce ',
    unitprice=964;
INSERT item_master
SET id=22,
    `name`='Mushroom ',
    unitprice=347;
INSERT item_master
SET id=23,
    `name`='Okra ',
    unitprice=1046;
INSERT item_master
SET id=24,
    `name`='Olive ',
    unitprice=781;
INSERT item_master
SET id=25,
    `name`='Onion ',
    unitprice=810;
INSERT item_master
SET id=26,
    `name`='Parsnip ',
    unitprice=336;
INSERT item_master
SET id=27,
    `name`='Peppers ',
    unitprice=297;
INSERT item_master
SET id=28,
    `name`='Potato ',
    unitprice=232;
INSERT item_master
SET id=29,
    `name`='Pumpkin ',
    unitprice=639;
INSERT item_master
SET id=30,
    `name`='Peas ',
    unitprice=373;
INSERT item_master
SET id=31,
    `name`='Rhubarb ',
    unitprice=574;
INSERT item_master
SET id=32,
    `name`='Shallots ',
    unitprice=331;
INSERT item_master
SET id=33,
    `name`='Spinach ',
    unitprice=409;
INSERT item_master
SET id=34,
    `name`='Squash ',
    unitprice=190;
INSERT item_master
SET id=35,
    `name`='Sweet Potato ',
    unitprice=650;
INSERT item_master
SET id=36,
    `name`='Tomato ',
    unitprice=361;
INSERT item_master
SET id=37,
    `name`='Turnip ',
    unitprice=471;
INSERT item_master
SET id=38,
    `name`='Swede ',
    unitprice=528;
INSERT item_master
SET id=39,
    `name`='Yam',
    unitprice=790;

INSERT customer
SET id=1,
    `name`='African glass catfish Food, Co.';
INSERT customer
SET id=2,
    `name`='African lungfish Food, Co.';
INSERT customer
SET id=3,
    `name`='Aholehole Food, Co.';
INSERT customer
SET id=4,
    `name`='Airbreathing catfish Food, Co.';
INSERT customer
SET id=5,
    `name`='Airsac catfish Food, Co.';
INSERT customer
SET id=6,
    `name`='Alaska blackfish Food, Co.';
INSERT customer
SET id=7,
    `name`='Albacore Food, Co.';
INSERT customer
SET id=8,
    `name`='Alewife Food, Co.';
INSERT customer
SET id=9,
    `name`='Alfonsino Food, Co.';
INSERT customer
SET id=10,
    `name`='Algae eater Food, Co.';
INSERT customer
SET id=11,
    `name`='Alligatorfish Food, Co.';
INSERT customer
SET id=12,
    `name`='Amago Food, Co.';
INSERT customer
SET id=13,
    `name`='American sole Food, Co.';
INSERT customer
SET id=14,
    `name`='Amur pike Food, Co.';
INSERT customer
SET id=15,
    `name`='Anchovy Food, Co.';
INSERT customer
SET id=16,
    `name`='Anemonefish Food, Co.';
INSERT customer
SET id=17,
    `name`='Angelfish Food, Co.';
INSERT customer
SET id=18,
    `name`='Angler Food, Co.';
INSERT customer
SET id=19,
    `name`='Angler catfish Food, Co.';
INSERT customer
SET id=20,
    `name`='Anglerfish Food, Co.';
INSERT customer
SET id=21,
    `name`='Antarctic cod Food, Co.';
INSERT customer
SET id=22,
    `name`='Antarctic icefish Food, Co.';
INSERT customer
SET id=23,
    `name`='Antenna codlet Food, Co.';
INSERT customer
SET id=24,
    `name`='Arapaima Food, Co.';
INSERT customer
SET id=25,
    `name`='Archerfish Food, Co.';
INSERT customer
SET id=26,
    `name`='Arctic char Food, Co.';
INSERT customer
SET id=27,
    `name`='Armored gurnard Food, Co.';
INSERT customer
SET id=28,
    `name`='Armored searobin Food, Co.';
INSERT customer
SET id=29,
    `name`='Armorhead Food, Co.';
INSERT customer
SET id=30,
    `name`='Armorhead catfish Food, Co.';
INSERT customer
SET id=31,
    `name`='Armoured catfish Food, Co.';
INSERT customer
SET id=32,
    `name`='Arowana Food, Co.';
INSERT customer
SET id=33,
    `name`='Arrowtooth eel Food, Co.';
INSERT customer
SET id=34,
    `name`='Aruana Food, Co.';
INSERT customer
SET id=35,
    `name`='Asian carps Food, Co.';
INSERT customer
SET id=36,
    `name`='Asiatic glassfish Food, Co.';
INSERT customer
SET id=37,
    `name`='Atka mackerel Food, Co.';
INSERT customer
SET id=38,
    `name`='Atlantic cod Food, Co.';
INSERT customer
SET id=39,
    `name`='Atlantic eel Food, Co.';
INSERT customer
SET id=40,
    `name`='Atlantic herring Food, Co.';
INSERT customer
SET id=41,
    `name`='Atlantic salmon Food, Co.';
INSERT customer
SET id=42,
    `name`='Atlantic saury Food, Co.';
INSERT customer
SET id=43,
    `name`='Atlantic silverside Food, Co.';
INSERT customer
SET id=44,
    `name`='Atlantic trout Food, Co.';
INSERT customer
SET id=45,
    `name`='Australasian salmon Food, Co.';
INSERT customer
SET id=46,
    `name`='Australian grayling Food, Co.';
INSERT customer
SET id=47,
    `name`='Australian herring Food, Co.';
INSERT customer
SET id=48,
    `name`='Australian lungfish Food, Co.';
INSERT customer
SET id=49,
    `name`='Australian prowfish Food, Co.';
INSERT customer
SET id=50,
    `name`='Ayu Food, Co.';
INSERT customer
SET id=51,
    `name`='Alooh Food, Co.';
INSERT customer
SET id=52,
    `name`='Baikal oilfish Food, Co.';
INSERT customer
SET id=53,
    `name`='Bala shark Food, Co.';
INSERT customer
SET id=54,
    `name`='Ballan wrasse Food, Co.';
INSERT customer
SET id=55,
    `name`='Bamboo shark Food, Co.';
INSERT customer
SET id=56,
    `name`='Banded killifish Food, Co.';
INSERT customer
SET id=57,
    `name`='Bandfish Food, Co.';
INSERT customer
SET id=58,
    `name`='Bango Food, Co.';
INSERT customer
SET id=59,
    `name`='Bangus Food, Co.';
INSERT customer
SET id=60,
    `name`='Banjo catfish Food, Co.';
INSERT customer
SET id=61,
    `name`='Barb Food, Co.';
INSERT customer
SET id=62,
    `name`='Barbel Food, Co.';
INSERT customer
SET id=63,
    `name`='Barbeled dragonfish Food, Co.';
INSERT customer
SET id=64,
    `name`='Barbeled houndshark Food, Co.';
INSERT customer
SET id=65,
    `name`='Barbelless catfish Food, Co.';
INSERT customer
SET id=66,
    `name`='Barfish Food, Co.';
INSERT customer
SET id=67,
    `name`='Barracuda Food, Co.';
INSERT customer
SET id=68,
    `name`='Barracudina Food, Co.';
INSERT customer
SET id=69,
    `name`='Barramundi Food, Co.';
INSERT customer
SET id=70,
    `name`='Barred danio Food, Co.';
INSERT customer
SET id=71,
    `name`='Barreleye Food, Co.';
INSERT customer
SET id=72,
    `name`='Basking shark Food, Co.';
INSERT customer
SET id=73,
    `name`='Bass Food, Co.';
INSERT customer
SET id=74,
    `name`='Basslet Food, Co.';
INSERT customer
SET id=75,
    `name`='Batfish Food, Co.';
INSERT customer
SET id=76,
    `name`='Bat ray Food, Co.';
INSERT customer
SET id=77,
    `name`='Beachsalmon Food, Co.';
INSERT customer
SET id=78,
    `name`='Beaked salmon Food, Co.';
INSERT customer
SET id=79,
    `name`='Beaked sandfish Food, Co.';
INSERT customer
SET id=80,
    `name`='Beardfish Food, Co.';
INSERT customer
SET id=81,
    `name`='Beluga sturgeon Food, Co.';
INSERT customer
SET id=82,
    `name`='Bengal danio Food, Co.';
INSERT customer
SET id=83,
    `name`='Bent-tooth Food, Co.';
INSERT customer
SET id=84,
    `name`='Betta Food, Co.';
INSERT customer
SET id=85,
    `name`='Bichir Food, Co.';
INSERT customer
SET id=86,
    `name`='Bigeye Food, Co.';
INSERT customer
SET id=87,
    `name`='Bigeye squaretail Food, Co.';
INSERT customer
SET id=88,
    `name`='Bighead carp Food, Co.';
INSERT customer
SET id=89,
    `name`='Bigmouth buffalo Food, Co.';
INSERT customer
SET id=90,
    `name`='Bigscale Food, Co.';
INSERT customer
SET id=91,
    `name`='Bigscale fish Food, Co.';
INSERT customer
SET id=92,
    `name`='Bigscale pomfret Food, Co.';
INSERT customer
SET id=93,
    `name`='Billfish Food, Co.';
INSERT customer
SET id=94,
    `name`='Bitterling Food, Co.';
INSERT customer
SET id=95,
    `name`='Black angelfish Food, Co.';
INSERT customer
SET id=96,
    `name`='Black bass Food, Co.';
INSERT customer
SET id=97,
    `name`='Black dragonfish Food, Co.';
INSERT customer
SET id=98,
    `name`='Blackchin Food, Co.';
INSERT customer
SET id=99,
    `name`='Blackfish Food, Co.';
INSERT customer
SET id=100,
    `name`='Blacktip reef shark Food, Co.';
INSERT customer
SET id=101,
    `name`='Black mackerel Food, Co.';
INSERT customer
SET id=102,
    `name`='Black pickerel Food, Co.';
INSERT customer
SET id=103,
    `name`='Black prickleback Food, Co.';
INSERT customer
SET id=104,
    `name`='Black scalyfin Food, Co.';
INSERT customer
SET id=105,
    `name`='Black sea bass Food, Co.';
INSERT customer
SET id=106,
    `name`='Black scabbardfish Food, Co.';
INSERT customer
SET id=107,
    `name`='Blacksmelt Food, Co.';
INSERT customer
SET id=108,
    `name`='Black swallower Food, Co.';
INSERT customer
SET id=109,
    `name`='Black tetra Food, Co.';
INSERT customer
SET id=110,
    `name`='Black triggerfish Food, Co.';
INSERT customer
SET id=111,
    `name`='Bleak Food, Co.';
INSERT customer
SET id=112,
    `name`='Blenny Food, Co.';
INSERT customer
SET id=113,
    `name`='Blind goby Food, Co.';
INSERT customer
SET id=114,
    `name`='Blind shark Food, Co.';
INSERT customer
SET id=115,
    `name`='Blobfish Food, Co.';
INSERT customer
SET id=116,
    `name`='Blowfish Food, Co.';
INSERT customer
SET id=117,
    `name`='Blue catfish Food, Co.';
INSERT customer
SET id=118,
    `name`='Blue danio Food, Co.';
INSERT customer
SET id=119,
    `name`='Blue-redstripe danio Food, Co.';
INSERT customer
SET id=120,
    `name`='Blue eye Food, Co.';
INSERT customer
SET id=121,
    `name`='Bluefin tuna Food, Co.';
INSERT customer
SET id=122,
    `name`='Bluefish Food, Co.';
INSERT customer
SET id=123,
    `name`='Bluegill Food, Co.';
INSERT customer
SET id=124,
    `name`='Blue gourami Food, Co.';
INSERT customer
SET id=125,
    `name`='Blue shark Food, Co.';
INSERT customer
SET id=126,
    `name`='Blue triggerfish Food, Co.';
INSERT customer
SET id=127,
    `name`='Blue whiting Food, Co.';
INSERT customer
SET id=128,
    `name`='Bluntnose knifefish Food, Co.';
INSERT customer
SET id=129,
    `name`='Bluntnose minnow Food, Co.';
INSERT customer
SET id=130,
    `name`='Boafish Food, Co.';
INSERT customer
SET id=131,
    `name`='Boarfish Food, Co.';
INSERT customer
SET id=132,
    `name`='Bobtail snipe eel Food, Co.';
INSERT customer
SET id=133,
    `name`='Bocaccio Food, Co.';
INSERT customer
SET id=134,
    `name`='Boga Food, Co.';
INSERT customer
SET id=135,
    `name`='Bombay duck Food, Co.';
INSERT customer
SET id=136,
    `name`='Bonefish Food, Co.';
INSERT customer
SET id=137,
    `name`='Bonito Food, Co.';
INSERT customer
SET id=138,
    `name`='Bonnetmouth Food, Co.';
INSERT customer
SET id=139,
    `name`='Bonytail chub Food, Co.';
INSERT customer
SET id=140,
    `name`='Bonytongue Food, Co.';
INSERT customer
SET id=141,
    `name`='Bottlenose Food, Co.';
INSERT customer
SET id=142,
    `name`='Bowfin Food, Co.';
INSERT customer
SET id=143,
    `name`='Boxfish Food, Co.';
INSERT customer
SET id=144,
    `name`='Bramble shark Food, Co.';
INSERT customer
SET id=145,
    `name`='Bream Food, Co.';
INSERT customer
SET id=146,
    `name`='Bristlemouth Food, Co.';
INSERT customer
SET id=147,
    `name`='Bristlenose catfish Food, Co.';
INSERT customer
SET id=148,
    `name`='Broadband dogfish Food, Co.';
INSERT customer
SET id=149,
    `name`='Brook lamprey Food, Co.';
INSERT customer
SET id=150,
    `name`='Brook trout Food, Co.';
INSERT customer
SET id=151,
    `name`='Brotula Food, Co.';
INSERT customer
SET id=152,
    `name`='Brown trout Food, Co.';
INSERT customer
SET id=153,
    `name`='Buffalofish Food, Co.';
INSERT customer
SET id=154,
    `name`='Bullhead Food, Co.';
INSERT customer
SET id=155,
    `name`='Bullhead shark Food, Co.';
INSERT customer
SET id=156,
    `name`='Bull shark Food, Co.';
INSERT customer
SET id=157,
    `name`='Bull trout Food, Co.';
INSERT customer
SET id=158,
    `name`='Burbot Food, Co.';
INSERT customer
SET id=159,
    `name`='Buri Food, Co.';
INSERT customer
SET id=160,
    `name`='Burma danio Food, Co.';
INSERT customer
SET id=161,
    `name`='Burrowing goby Food, Co.';
INSERT customer
SET id=162,
    `name`='Butterfly ray Food, Co.';
INSERT customer
SET id=163,
    `name`='Butterflyfish Food, Co.';
INSERT customer
SET id=164,
    `name`='California flyingfish Food, Co.';
INSERT customer
SET id=165,
    `name`='California halibut Food, Co.';
INSERT customer
SET id=166,
    `name`='California smoothtongue Food, Co.';
INSERT customer
SET id=167,
    `name`='Canary rockfish Food, Co.';
INSERT customer
SET id=168,
    `name`='Candiru Food, Co.';
INSERT customer
SET id=169,
    `name`='Candlefish Food, Co.';
INSERT customer
SET id=170,
    `name`='Capelin Food, Co.';
INSERT customer
SET id=171,
    `name`='Cardinalfish Food, Co.';
INSERT customer
SET id=172,
    `name`='Carp Food, Co.';
INSERT customer
SET id=173,
    `name`='Carpetshark Food, Co.';
INSERT customer
SET id=174,
    `name`='Carpsucker Food, Co.';
INSERT customer
SET id=175,
    `name`='Catalufa Food, Co.';
INSERT customer
SET id=176,
    `name`='Catfish Food, Co.';
INSERT customer
SET id=177,
    `name`='Catla Food, Co.';
INSERT customer
SET id=178,
    `name`='Cat shark Food, Co.';
INSERT customer
SET id=179,
    `name`='Cavefish Food, Co.';
INSERT customer
SET id=180,
    `name`='Celebes rainbowfish Food, Co.';
INSERT customer
SET id=181,
    `name`='Central mudminnow Food, Co.';
INSERT customer
SET id=182,
    `name`='Cepalin Food, Co.';
INSERT customer
SET id=183,
    `name`='Chain pickerel Food, Co.';
INSERT customer
SET id=184,
    `name`='Channel bass Food, Co.';
INSERT customer
SET id=185,
    `name`='Channel catfish Food, Co.';
INSERT customer
SET id=186,
    `name`='Char Food, Co.';
INSERT customer
SET id=187,
    `name`='Cherry salmon Food, Co.';
INSERT customer
SET id=188,
    `name`='Chimaera Food, Co.';
INSERT customer
SET id=189,
    `name`='Chinook salmon Food, Co.';
INSERT customer
SET id=190,
    `name`='Cherubfish Food, Co.';
INSERT customer
SET id=191,
    `name`='Chub Food, Co.';
INSERT customer
SET id=192,
    `name`='Chubsucker Food, Co.';
INSERT customer
SET id=193,
    `name`='Chum salmon Food, Co.';
INSERT customer
SET id=194,
    `name`='Cichlid Food, Co.';
INSERT customer
SET id=195,
    `name`='Cisco Food, Co.';
INSERT customer
SET id=196,
    `name`='Climbing catfish Food, Co.';
INSERT customer
SET id=197,
    `name`='Climbing gourami Food, Co.';
INSERT customer
SET id=198,
    `name`='Climbing perch Food, Co.';
INSERT customer
SET id=199,
    `name`='Clingfish Food, Co.';
INSERT customer
SET id=200,
    `name`='Clownfish Food, Co.';
INSERT customer
SET id=201,
    `name`='Clown loach Food, Co.';
INSERT customer
SET id=202,
    `name`='Clown triggerfish Food, Co.';
INSERT customer
SET id=203,
    `name`='Cobbler Food, Co.';
INSERT customer
SET id=204,
    `name`='Cobia Food, Co.';
INSERT customer
SET id=205,
    `name`='Cod Food, Co.';
INSERT customer
SET id=206,
    `name`='Cod icefish Food, Co.';
INSERT customer
SET id=207,
    `name`='Codlet Food, Co.';
INSERT customer
SET id=208,
    `name`='Codling Food, Co.';
INSERT customer
SET id=209,
    `name`='Coelacanth Food, Co.';
INSERT customer
SET id=210,
    `name`='Coffinfish Food, Co.';
INSERT customer
SET id=211,
    `name`='Coho salmon Food, Co.';
INSERT customer
SET id=212,
    `name`='Coley Food, Co.';
INSERT customer
SET id=213,
    `name`='Collared carpetshark Food, Co.';
INSERT customer
SET id=214,
    `name`='Collared dogfish Food, Co.';
INSERT customer
SET id=215,
    `name`='Colorado squawfish Food, Co.';
INSERT customer
SET id=216,
    `name`='Combfish Food, Co.';
INSERT customer
SET id=217,
    `name`='Combtail gourami Food, Co.';
INSERT customer
SET id=218,
    `name`='Combtooth blenny Food, Co.';
INSERT customer
SET id=219,
    `name`='Common carp Food, Co.';
INSERT customer
SET id=220,
    `name`='Common tunny Food, Co.';
INSERT customer
SET id=221,
    `name`='Conger eel Food, Co.';
INSERT customer
SET id=222,
    `name`='Convict blenny Food, Co.';
INSERT customer
SET id=223,
    `name`='Convict cichlid Food, Co.';
INSERT customer
SET id=224,
    `name`='Cookie-cutter shark Food, Co.';
INSERT customer
SET id=225,
    `name`='Coolie loach Food, Co.';
INSERT customer
SET id=226,
    `name`='Cornish Spaktailed Bream Food, Co.';
INSERT customer
SET id=227,
    `name`='Cornetfish Food, Co.';
INSERT customer
SET id=228,
    `name`='Cowfish Food, Co.';
INSERT customer
SET id=229,
    `name`='Cownose ray Food, Co.';
INSERT customer
SET id=230,
    `name`='Cow shark Food, Co.';
INSERT customer
SET id=231,
    `name`='Crappie Food, Co.';
INSERT customer
SET id=232,
    `name`='Creek chub Food, Co.';
INSERT customer
SET id=233,
    `name`='Crestfish Food, Co.';
INSERT customer
SET id=234,
    `name`='Crevice kelpfish Food, Co.';
INSERT customer
SET id=235,
    `name`='Croaker Food, Co.';
INSERT customer
SET id=236,
    `name`='Crocodile icefish Food, Co.';
INSERT customer
SET id=237,
    `name`='Crocodile shark Food, Co.';
INSERT customer
SET id=238,
    `name`='Crucian carp Food, Co.';
INSERT customer
SET id=239,
    `name`='Cuchia Food, Co.';
INSERT customer
SET id=240,
    `name`='Cuckoo wrasse Food, Co.';
INSERT customer
SET id=241,
    `name`='Cusk-eel Food, Co.';
INSERT customer
SET id=242,
    `name`='Cuskfish Food, Co.';
INSERT customer
SET id=243,
    `name`='Cutlassfish Food, Co.';
INSERT customer
SET id=244,
    `name`='Cutthroat eel Food, Co.';
INSERT customer
SET id=245,
    `name`='Cutthroat trout Food, Co.';
INSERT customer
SET id=246,
    `name`='Dab Food, Co.';
INSERT customer
SET id=247,
    `name`='Dace Food, Co.';
INSERT customer
SET id=248,
    `name`='Daggertooth pike conger Food, Co.';
INSERT customer
SET id=249,
    `name`='Damselfish Food, Co.';
INSERT customer
SET id=250,
    `name`='Danio Food, Co.';
INSERT customer
SET id=251,
    `name`='Darter Food, Co.';
INSERT customer
SET id=252,
    `name`='Dartfish Food, Co.';
INSERT customer
SET id=253,
    `name`='Dealfish Food, Co.';
INSERT customer
SET id=254,
    `name`='Death Valley pupfish Food, Co.';
INSERT customer
SET id=255,
    `name`='Deep sea anglerfish Food, Co.';
INSERT customer
SET id=256,
    `name`='Deep sea bonefish Food, Co.';
INSERT customer
SET id=257,
    `name`='Deep sea eel Food, Co.';
INSERT customer
SET id=258,
    `name`='Deep sea smelt Food, Co.';
INSERT customer
SET id=259,
    `name`='Deepwater cardinalfish Food, Co.';
INSERT customer
SET id=260,
    `name`='Deepwater flathead Food, Co.';
INSERT customer
SET id=261,
    `name`='Deepwater stingray Food, Co.';
INSERT customer
SET id=262,
    `name`='Delta smelt Food, Co.';
INSERT customer
SET id=263,
    `name`='Demoiselle Food, Co.';
INSERT customer
SET id=264,
    `name`='Denticle herring Food, Co.';
INSERT customer
SET id=265,
    `name`='Desert pupfish Food, Co.';
INSERT customer
SET id=266,
    `name`='Devario Food, Co.';
INSERT customer
SET id=267,
    `name`='Devil ray Food, Co.';
INSERT customer
SET id=268,
    `name`='Dhufish Food, Co.';
INSERT customer
SET id=269,
    `name`='Discus Food, Co.';
INSERT customer
SET id=270,
    `name`='diVer: New Zealand sand diver or Long-finned sand diver Food, Co.';
INSERT customer
SET id=271,
    `name`='Dogfish Food, Co.';
INSERT customer
SET id=272,
    `name`='Dogfish shark Food, Co.';
INSERT customer
SET id=273,
    `name`='Dogteeth tetra Food, Co.';
INSERT customer
SET id=274,
    `name`='Dojo loach Food, Co.';
INSERT customer
SET id=275,
    `name`='Dolly Varden trout Food, Co.';
INSERT customer
SET id=276,
    `name`='Dorab Food, Co.';
INSERT customer
SET id=277,
    `name`='Dorado Food, Co.';
INSERT customer
SET id=278,
    `name`='Dory Food, Co.';
INSERT customer
SET id=279,
    `name`='Dottyback Food, Co.';
INSERT customer
SET id=280,
    `name`='Dragonet Food, Co.';
INSERT customer
SET id=281,
    `name`='Dragonfish Food, Co.';
INSERT customer
SET id=282,
    `name`='Dragon goby Food, Co.';
INSERT customer
SET id=283,
    `name`='Driftfish Food, Co.';
INSERT customer
SET id=284,
    `name`='Driftwood catfish Food, Co.';
INSERT customer
SET id=285,
    `name`='Drum Food, Co.';
INSERT customer
SET id=286,
    `name`='Duckbill Food, Co.';
INSERT customer
SET id=287,
    `name`='Duckbilled barracudina Food, Co.';
INSERT customer
SET id=288,
    `name`='Duckbill eel Food, Co.';
INSERT customer
SET id=289,
    `name`='Dusky grouper Food, Co.';
INSERT customer
SET id=290,
    `name`='Dwarf gourami Food, Co.';
INSERT customer
SET id=291,
    `name`='Dwarf loach Food, Co.';
INSERT customer
SET id=292,
    `name`='Eagle ray Food, Co.';
INSERT customer
SET id=293,
    `name`='Earthworm eel Food, Co.';
INSERT customer
SET id=294,
    `name`='Eel Food, Co.';
INSERT customer
SET id=295,
    `name`='Eelblenny Food, Co.';
INSERT customer
SET id=296,
    `name`='Eel cod Food, Co.';
INSERT customer
SET id=297,
    `name`='Eel-goby Food, Co.';
INSERT customer
SET id=298,
    `name`='Eelpout Food, Co.';
INSERT customer
SET id=299,
    `name`='Eeltail catfish Food, Co.';
INSERT customer
SET id=300,
    `name`='Elasmobranch Food, Co.';
INSERT customer
SET id=301,
    `name`='Electric catfish Food, Co.';
INSERT customer
SET id=302,
    `name`='Electric eel Food, Co.';
INSERT customer
SET id=303,
    `name`='Electric knifefish Food, Co.';
INSERT customer
SET id=304,
    `name`='Electric ray Food, Co.';
INSERT customer
SET id=305,
    `name`='Electric stargazer Food, Co.';
INSERT customer
SET id=306,
    `name`='Elephant fish Food, Co.';
INSERT customer
SET id=307,
    `name`='Elephantnose fish Food, Co.';
INSERT customer
SET id=308,
    `name`='Elver Food, Co.';
INSERT customer
SET id=309,
    `name`='Emperor Food, Co.';
INSERT customer
SET id=310,
    `name`='Emperor angelfish Food, Co.';
INSERT customer
SET id=311,
    `name`='Emperor bream Food, Co.';
INSERT customer
SET id=312,
    `name`='Escolar Food, Co.';
INSERT customer
SET id=313,
    `name`='Eucla cod Food, Co.';
INSERT customer
SET id=314,
    `name`='Eulachon Food, Co.';
INSERT customer
SET id=315,
    `name`='European chub Food, Co.';
INSERT customer
SET id=316,
    `name`='European eel Food, Co.';
INSERT customer
SET id=317,
    `name`='European flounder Food, Co.';
INSERT customer
SET id=318,
    `name`='European minnow Food, Co.';
INSERT customer
SET id=319,
    `name`='European perch Food, Co.';
INSERT customer
SET id=320,
    `name`='False brotula Food, Co.';
INSERT customer
SET id=321,
    `name`='False cat shark Food, Co.';
INSERT customer
SET id=322,
    `name`='False moray Food, Co.';
INSERT customer
SET id=323,
    `name`='False trevally Food, Co.';
INSERT customer
SET id=324,
    `name`='Fangtooth Food, Co.';
INSERT customer
SET id=325,
    `name`='Fathead sculpin Food, Co.';
INSERT customer
SET id=326,
    `name`='Featherback Food, Co.';
INSERT customer
SET id=327,
    `name`='Featherfin knifefish Food, Co.';
INSERT customer
SET id=328,
    `name`='Fierasfer Food, Co.';
INSERT customer
SET id=329,
    `name`='Fire Goby Food, Co.';
INSERT customer
SET id=330,
    `name`='Filefish Food, Co.';
INSERT customer
SET id=331,
    `name`='Finback cat shark Food, Co.';
INSERT customer
SET id=332,
    `name`='Fingerfish Food, Co.';
INSERT customer
SET id=333,
    `name`='Fire bar danio Food, Co.';
INSERT customer
SET id=334,
    `name`='Firefish Food, Co.';
INSERT customer
SET id=335,
    `name`='Flabby whalefish Food, Co.';
INSERT customer
SET id=336,
    `name`='Flagblenny Food, Co.';
INSERT customer
SET id=337,
    `name`='Flagfin Food, Co.';
INSERT customer
SET id=338,
    `name`='Flagfish Food, Co.';
INSERT customer
SET id=339,
    `name`='Flagtail Food, Co.';
INSERT customer
SET id=340,
    `name`='Flashlight fish Food, Co.';
INSERT customer
SET id=341,
    `name`='Flatfish Food, Co.';
INSERT customer
SET id=342,
    `name`='Flathead Food, Co.';
INSERT customer
SET id=343,
    `name`='Flathead catfish Food, Co.';
INSERT customer
SET id=344,
    `name`='Flat loach Food, Co.';
INSERT customer
SET id=345,
    `name`='Flier Food, Co.';
INSERT customer
SET id=346,
    `name`='Flounder Food, Co.';
INSERT customer
SET id=347,
    `name`='Flying characin Food, Co.';
INSERT customer
SET id=348,
    `name`='Flying gurnard Food, Co.';
INSERT customer
SET id=349,
    `name`='Flyingfish Food, Co.';
INSERT customer
SET id=350,
    `name`='Footballfish Food, Co.';
INSERT customer
SET id=351,
    `name`='Forehead brooder Food, Co.';
INSERT customer
SET id=352,
    `name`='Four-eyed fish Food, Co.';
INSERT customer
SET id=353,
    `name`='French angelfish Food, Co.';
INSERT customer
SET id=354,
    `name`='Freshwater eel Food, Co.';
INSERT customer
SET id=355,
    `name`='Freshwater flyingfish Food, Co.';
INSERT customer
SET id=356,
    `name`='Freshwater hatchetfish Food, Co.';
INSERT customer
SET id=357,
    `name`='Freshwater herring Food, Co.';
INSERT customer
SET id=358,
    `name`='Freshwater shark Food, Co.';
INSERT customer
SET id=359,
    `name`='Frigate mackerel Food, Co.';
INSERT customer
SET id=360,
    `name`='Frilled shark Food, Co.';
INSERT customer
SET id=361,
    `name`='Frogfish Food, Co.';
INSERT customer
SET id=362,
    `name`='Frogmouth catfish Food, Co.';
INSERT customer
SET id=363,
    `name`='Fusilier fish Food, Co.';
INSERT customer
SET id=364,
    `name`='Galjoen fish Food, Co.';
INSERT customer
SET id=365,
    `name`='Ganges shark Food, Co.';
INSERT customer
SET id=366,
    `name`='Gar Food, Co.';
INSERT customer
SET id=367,
    `name`='Garden eel Food, Co.';
INSERT customer
SET id=368,
    `name`='Garibaldi Food, Co.';
INSERT customer
SET id=369,
    `name`='Garpike Food, Co.';
INSERT customer
SET id=370,
    `name`='Ghost carp Food, Co.';
INSERT customer
SET id=371,
    `name`='Ghost fish Food, Co.';
INSERT customer
SET id=372,
    `name`='Ghost flathead Food, Co.';
INSERT customer
SET id=373,
    `name`='Ghost knifefish Food, Co.';
INSERT customer
SET id=374,
    `name`='Ghost pipefish Food, Co.';
INSERT customer
SET id=375,
    `name`='Ghoul Food, Co.';
INSERT customer
SET id=376,
    `name`='Giant danio Food, Co.';
INSERT customer
SET id=377,
    `name`='Giant gourami Food, Co.';
INSERT customer
SET id=378,
    `name`='Giant sea bass Food, Co.';
INSERT customer
SET id=379,
    `name`='Giant wels Food, Co.';
INSERT customer
SET id=380,
    `name`='Gianttail Food, Co.';
INSERT customer
SET id=381,
    `name`='Gibberfish Food, Co.';
INSERT customer
SET id=382,
    `name`='Gila trout Food, Co.';
INSERT customer
SET id=383,
    `name`='Gizzard shad Food, Co.';
INSERT customer
SET id=384,
    `name`='Glass catfish Food, Co.';
INSERT customer
SET id=385,
    `name`='Glassfish Food, Co.';
INSERT customer
SET id=386,
    `name`='Glass knifefish Food, Co.';
INSERT customer
SET id=387,
    `name`='Glowlight danio Food, Co.';
INSERT customer
SET id=388,
    `name`='Goatfish Food, Co.';
INSERT customer
SET id=389,
    `name`='Goblin shark Food, Co.';
INSERT customer
SET id=390,
    `name`='Goby Food, Co.';
INSERT customer
SET id=391,
    `name`='Golden dojo Food, Co.';
INSERT customer
SET id=392,
    `name`='Golden loach Food, Co.';
INSERT customer
SET id=393,
    `name`='Golden shiner Food, Co.';
INSERT customer
SET id=394,
    `name`='Golden trout Food, Co.';
INSERT customer
SET id=395,
    `name`='Goldeye Food, Co.';
INSERT customer
SET id=396,
    `name`='Goldfish Food, Co.';
INSERT customer
SET id=397,
    `name`='Goldspotted killifish Food, Co.';
INSERT customer
SET id=398,
    `name`='Gombessa Food, Co.';
INSERT customer
SET id=399,
    `name`='Goosefish Food, Co.';
INSERT customer
SET id=400,
    `name`='Gopher rockfish Food, Co.';
INSERT customer
SET id=401,
    `name`='Gouramie Food, Co.';
INSERT customer
SET id=402,
    `name`='Grass carp Food, Co.';
INSERT customer
SET id=403,
    `name`='Graveldiver Food, Co.';
INSERT customer
SET id=404,
    `name`='Gray eel-catfish Food, Co.';
INSERT customer
SET id=405,
    `name`='Grayling Food, Co.';
INSERT customer
SET id=406,
    `name`='Gray mullet Food, Co.';
INSERT customer
SET id=407,
    `name`='Gray reef shark Food, Co.';
INSERT customer
SET id=408,
    `name`='Great white shark Food, Co.';
INSERT customer
SET id=409,
    `name`='Green swordtail Food, Co.';
INSERT customer
SET id=410,
    `name`='Greeneye Food, Co.';
INSERT customer
SET id=411,
    `name`='Greenling Food, Co.';
INSERT customer
SET id=412,
    `name`='Grenadier Food, Co.';
INSERT customer
SET id=413,
    `name`='Grideye Food, Co.';
INSERT customer
SET id=414,
    `name`='Ground shark Food, Co.';
INSERT customer
SET id=415,
    `name`='Grouper Food, Co.';
INSERT customer
SET id=416,
    `name`='Grunion Food, Co.';
INSERT customer
SET id=417,
    `name`='Grunt Food, Co.';
INSERT customer
SET id=418,
    `name`='Grunter Food, Co.';
INSERT customer
SET id=419,
    `name`='Grunt sculpin Food, Co.';
INSERT customer
SET id=420,
    `name`='Gudgeon Food, Co.';
INSERT customer
SET id=421,
    `name`='Guitarfish Food, Co.';
INSERT customer
SET id=422,
    `name`='Gulf menhaden Food, Co.';
INSERT customer
SET id=423,
    `name`='Gulper eel Food, Co.';
INSERT customer
SET id=424,
    `name`='Gulper Food, Co.';
INSERT customer
SET id=425,
    `name`='Gunnel Food, Co.';
INSERT customer
SET id=426,
    `name`='Guppy Food, Co.';
INSERT customer
SET id=427,
    `name`='Gurnard Food, Co.';
INSERT customer
SET id=428,
    `name`='Haddock Food, Co.';
INSERT customer
SET id=429,
    `name`='Hagfish Food, Co.';
INSERT customer
SET id=430,
    `name`='Hairtail Food, Co.';
INSERT customer
SET id=431,
    `name`='Hake Food, Co.';
INSERT customer
SET id=432,
    `name`='Half-gill Food, Co.';
INSERT customer
SET id=433,
    `name`='Halfbeak Food, Co.';
INSERT customer
SET id=434,
    `name`='Halfmoon Food, Co.';
INSERT customer
SET id=435,
    `name`='Halibut Food, Co.';
INSERT customer
SET id=436,
    `name`='Halosaur Food, Co.';
INSERT customer
SET id=437,
    `name`='Hamlet Food, Co.';
INSERT customer
SET id=438,
    `name`='Hammerhead shark Food, Co.';
INSERT customer
SET id=439,
    `name`='Hammerjaw Food, Co.';
INSERT customer
SET id=440,
    `name`='Handfish Food, Co.';
INSERT customer
SET id=441,
    `name`='Hardhead catfish Food, Co.';
INSERT customer
SET id=442,
    `name`='Harelip sucker Food, Co.';
INSERT customer
SET id=443,
    `name`='Hatchetfish Food, Co.';
INSERT customer
SET id=444,
    `name`='Hawkfish Food, Co.';
INSERT customer
SET id=445,
    `name`='Herring Food, Co.';
INSERT customer
SET id=446,
    `name`='Herring smelt Food, Co.';
INSERT customer
SET id=447,
    `name`='Hillstream loach Food, Co.';
INSERT customer
SET id=448,
    `name`='Hog sucker Food, Co.';
INSERT customer
SET id=449,
    `name`='Hoki Food, Co.';
INSERT customer
SET id=450,
    `name`='Horn shark Food, Co.';
INSERT customer
SET id=451,
    `name`='Horsefish Food, Co.';
INSERT customer
SET id=452,
    `name`='Houndshark Food, Co.';
INSERT customer
SET id=453,
    `name`='Huchen Food, Co.';
INSERT customer
SET id=454,
    `name`='Humuhumu-nukunuku-apua‘a Food, Co.';
INSERT customer
SET id=455,
    `name`='Hussar Food, Co.';
INSERT customer
SET id=456,
    `name`='Icefish Food, Co.';
INSERT customer
SET id=457,
    `name`='Ide Food, Co.';
INSERT customer
SET id=458,
    `name`='Ilisha Food, Co.';
INSERT customer
SET id=459,
    `name`='Inanga Food, Co.';
INSERT customer
SET id=460,
    `name`='Inconnu Food, Co.';
INSERT customer
SET id=461,
    `name`='Indian mul Food, Co.';
INSERT customer
SET id=462,
    `name`='Jack Food, Co.';
INSERT customer
SET id=463,
    `name`='Jackfish Food, Co.';
INSERT customer
SET id=464,
    `name`='Jack Dempsey Food, Co.';
INSERT customer
SET id=465,
    `name`='Japanese eel Food, Co.';
INSERT customer
SET id=466,
    `name`='Javelin Food, Co.';
INSERT customer
SET id=467,
    `name`='Jawfish Food, Co.';
INSERT customer
SET id=468,
    `name`='Jellynose fish Food, Co.';
INSERT customer
SET id=469,
    `name`='Jewelfish Food, Co.';
INSERT customer
SET id=470,
    `name`='Jewel tetra Food, Co.';
INSERT customer
SET id=471,
    `name`='Jewfish Food, Co.';
INSERT customer
SET id=472,
    `name`='John dory Food, Co.';
INSERT customer
SET id=473,
    `name`='Kafue pike Food, Co.';
INSERT customer
SET id=474,
    `name`='Kahawai Food, Co.';
INSERT customer
SET id=475,
    `name`='Kaluga Food, Co.';
INSERT customer
SET id=476,
    `name`='Kanyu Food, Co.';
INSERT customer
SET id=477,
    `name`='Kelp perch Food, Co.';
INSERT customer
SET id=478,
    `name`='Kelpfish Food, Co.';
INSERT customer
SET id=479,
    `name`='Killifish Food, Co.';
INSERT customer
SET id=480,
    `name`='King of herring Food, Co.';
INSERT customer
SET id=481,
    `name`='Kingfish Food, Co.';
INSERT customer
SET id=482,
    `name`='King-of-the-salmon Food, Co.';
INSERT customer
SET id=483,
    `name`='Kissing gourami Food, Co.';
INSERT customer
SET id=484,
    `name`='Knifefish Food, Co.';
INSERT customer
SET id=485,
    `name`='Knifejaw Food, Co.';
INSERT customer
SET id=486,
    `name`='Koi Food, Co.';
INSERT customer
SET id=487,
    `name`='Kokanee Food, Co.';
INSERT customer
SET id=488,
    `name`='Kokopu Food, Co.';
INSERT customer
SET id=489,
    `name`='Kuhli loach Food, Co.';
INSERT customer
SET id=490,
    `name`='Labyrinth fish Food, Co.';
INSERT customer
SET id=491,
    `name`='Ladyfish Food, Co.';
INSERT customer
SET id=492,
    `name`='Lagena Food, Co.';
INSERT customer
SET id=493,
    `name`='Lake chub Food, Co.';
INSERT customer
SET id=494,
    `name`='Lake trout Food, Co.';
INSERT customer
SET id=495,
    `name`='Lake whitefish Food, Co.';
INSERT customer
SET id=496,
    `name`='Lampfish Food, Co.';
INSERT customer
SET id=497,
    `name`='Lamprey Food, Co.';
INSERT customer
SET id=498,
    `name`='Lancetfish Food, Co.';
INSERT customer
SET id=499,
    `name`='Lanternfish Food, Co.';
INSERT customer
SET id=500,
    `name`='Large-eye bream Food, Co.';
INSERT customer
SET id=501,
    `name`='Largemouth bass Food, Co.';
INSERT customer
SET id=502,
    `name`='Largenose fish Food, Co.';
INSERT customer
SET id=503,
    `name`='Leaffish Food, Co.';
INSERT customer
SET id=504,
    `name`='Leatherjacket Food, Co.';
INSERT customer
SET id=505,
    `name`='Lefteye flounder Food, Co.';
INSERT customer
SET id=506,
    `name`='Lemon shark Food, Co.';
INSERT customer
SET id=507,
    `name`='Lemon sole Food, Co.';
INSERT customer
SET id=508,
    `name`='Lenok Food, Co.';
INSERT customer
SET id=509,
    `name`='Leopard danio Food, Co.';
INSERT customer
SET id=510,
    `name`='Lightfish Food, Co.';
INSERT customer
SET id=511,
    `name`='Lighthousefish Food, Co.';
INSERT customer
SET id=512,
    `name`='Limia Food, Co.';
INSERT customer
SET id=513,
    `name`='Lined sole Food, Co.';
INSERT customer
SET id=514,
    `name`='Ling Food, Co.';
INSERT customer
SET id=515,
    `name`='Ling cod Food, Co.';
INSERT customer
SET id=516,
    `name`='Lionfish Food, Co.';
INSERT customer
SET id=517,
    `name`='Livebearer Food, Co.';
INSERT customer
SET id=518,
    `name`='Lizardfish Food, Co.';
INSERT customer
SET id=519,
    `name`='Loach Food, Co.';
INSERT customer
SET id=520,
    `name`='Loach catfish Food, Co.';
INSERT customer
SET id=521,
    `name`='Loach goby Food, Co.';
INSERT customer
SET id=522,
    `name`='Loach minnow Food, Co.';
INSERT customer
SET id=523,
    `name`='Longfin Food, Co.';
INSERT customer
SET id=524,
    `name`='Longfin dragonfish Food, Co.';
INSERT customer
SET id=525,
    `name`='Longfin escolar Food, Co.';
INSERT customer
SET id=526,
    `name`='Longfin smelt Food, Co.';
INSERT customer
SET id=527,
    `name`='Long-finned char Food, Co.';
INSERT customer
SET id=528,
    `name`='Long-finned pike Food, Co.';
INSERT customer
SET id=529,
    `name`='Longjaw mudsucker Food, Co.';
INSERT customer
SET id=530,
    `name`='Longneck eel Food, Co.';
INSERT customer
SET id=531,
    `name`='Longnose chimaera Food, Co.';
INSERT customer
SET id=532,
    `name`='Longnose dace Food, Co.';
INSERT customer
SET id=533,
    `name`='Longnose lancetfish Food, Co.';
INSERT customer
SET id=534,
    `name`='Longnose sucker Food, Co.';
INSERT customer
SET id=535,
    `name`='Longnose whiptail catfish Food, Co.';
INSERT customer
SET id=536,
    `name`='Long-whiskered catfish Food, Co.';
INSERT customer
SET id=537,
    `name`='Lookdown catfish Food, Co.';
INSERT customer
SET id=538,
    `name`='Loosejaw Food, Co.';
INSERT customer
SET id=539,
    `name`='Lost River sucker Food, Co.';
INSERT customer
SET id=540,
    `name`='Louvar Food, Co.';
INSERT customer
SET id=541,
    `name`='Loweye catfish Food, Co.';
INSERT customer
SET id=542,
    `name`='Luderick Food, Co.';
INSERT customer
SET id=543,
    `name`='Luminous hake Food, Co.';
INSERT customer
SET id=544,
    `name`='Lumpsucker Food, Co.';
INSERT customer
SET id=545,
    `name`='Lungfish Food, Co.';
INSERT customer
SET id=546,
    `name`='Lyretail Food, Co.';
INSERT customer
SET id=547,
    `name`='Mackerel Food, Co.';
INSERT customer
SET id=548,
    `name`='Mackerel shark Food, Co.';
INSERT customer
SET id=549,
    `name`='Madtom Food, Co.';
INSERT customer
SET id=550,
    `name`='Mahi-mahi Food, Co.';
INSERT customer
SET id=551,
    `name`='Mahseer Food, Co.';
INSERT customer
SET id=552,
    `name`='Mail-cheeked fish Food, Co.';
INSERT customer
SET id=553,
    `name`='Mako shark Food, Co.';
INSERT customer
SET id=554,
    `name`='Mandarin fish Food, Co.';
INSERT customer
SET id=555,
    `name`='Manefish Food, Co.';
INSERT customer
SET id=556,
    `name`='Man-of-war fish Food, Co.';
INSERT customer
SET id=557,
    `name`='Manta Ray Food, Co.';
INSERT customer
SET id=558,
    `name`='Marblefish Food, Co.';
INSERT customer
SET id=559,
    `name`='Marine hatchetfish Food, Co.';
INSERT customer
SET id=560,
    `name`='Marlin Food, Co.';
INSERT customer
SET id=561,
    `name`='Masu salmon Food, Co.';
INSERT customer
SET id=562,
    `name`='Medaka Food, Co.';
INSERT customer
SET id=563,
    `name`='Medusafish Food, Co.';
INSERT customer
SET id=564,
    `name`='Megamouth shark Food, Co.';
INSERT customer
SET id=565,
    `name`='Menhaden Food, Co.';
INSERT customer
SET id=566,
    `name`='Merluccid hake Food, Co.';
INSERT customer
SET id=567,
    `name`='Mexican blind cavefish Food, Co.';
INSERT customer
SET id=568,
    `name`='Mexican golden trout Food, Co.';
INSERT customer
SET id=569,
    `name`='Midshipman Food, Co.';
INSERT customer
SET id=570,
    `name`='Milkfish Food, Co.';
INSERT customer
SET id=571,
    `name`='Minnow Food, Co.';
INSERT customer
SET id=572,
    `name`='Modoc sucker Food, Co.';
INSERT customer
SET id=573,
    `name`='Mojarra Food, Co.';
INSERT customer
SET id=574,
    `name`='Mola Food, Co.';
INSERT customer
SET id=575,
    `name`='Molly Food, Co.';
INSERT customer
SET id=576,
    `name`='Molly Miller Food, Co.';
INSERT customer
SET id=577,
    `name`='Monkeyface prickleback Food, Co.';
INSERT customer
SET id=578,
    `name`='Monkfish Food, Co.';
INSERT customer
SET id=579,
    `name`='Mooneye Food, Co.';
INSERT customer
SET id=580,
    `name`='Moonfish Food, Co.';
INSERT customer
SET id=581,
    `name`='Moorish idol Food, Co.';
INSERT customer
SET id=582,
    `name`='Mora Food, Co.';
INSERT customer
SET id=583,
    `name`='Moray eel Food, Co.';
INSERT customer
SET id=584,
    `name`='Morid cod Food, Co.';
INSERT customer
SET id=585,
    `name`='Morwong Food, Co.';
INSERT customer
SET id=586,
    `name`='Moses sole Food, Co.';
INSERT customer
SET id=587,
    `name`='Mosquitofish Food, Co.';
INSERT customer
SET id=588,
    `name`='Mosshead warbonnet Food, Co.';
INSERT customer
SET id=589,
    `name`='Mouthbrooder Food, Co.';
INSERT customer
SET id=590,
    `name`='Mozambique tilapia Food, Co.';
INSERT customer
SET id=591,
    `name`='Mrigal Food, Co.';
INSERT customer
SET id=592,
    `name`='Mudfish Food, Co.';
INSERT customer
SET id=593,
    `name`='Mudminnow Food, Co.';
INSERT customer
SET id=594,
    `name`='Mud minnow Food, Co.';
INSERT customer
SET id=595,
    `name`='Mudskipper Food, Co.';
INSERT customer
SET id=596,
    `name`='Mudsucker Food, Co.';
INSERT customer
SET id=597,
    `name`='Mullet Food, Co.';
INSERT customer
SET id=598,
    `name`='Mummichog Food, Co.';
INSERT customer
SET id=599,
    `name`='Murray cod Food, Co.';
INSERT customer
SET id=600,
    `name`='Muskellunge Food, Co.';
INSERT customer
SET id=601,
    `name`='Mustache triggerfish Food, Co.';
INSERT customer
SET id=602,
    `name`='Mustard eel Food, Co.';
INSERT customer
SET id=603,
    `name`='Naked-back knifefish Food, Co.';
INSERT customer
SET id=604,
    `name`='Nase Food, Co.';
INSERT customer
SET id=605,
    `name`='Needlefish Food, Co.';
INSERT customer
SET id=606,
    `name`='Neon tetra Food, Co.';
INSERT customer
SET id=607,
    `name`='New World rivuline Food, Co.';
INSERT customer
SET id=608,
    `name`='New Zealand smelt Food, Co.';
INSERT customer
SET id=609,
    `name`='Nibble Fish Food, Co.';
INSERT customer
SET id=610,
    `name`='Noodlefish Food, Co.';
INSERT customer
SET id=611,
    `name`='North American darter Food, Co.';
INSERT customer
SET id=612,
    `name`='North American freshwater catfish Food, Co.';
INSERT customer
SET id=613,
    `name`='North Pacific daggertooth Food, Co.';
INSERT customer
SET id=614,
    `name`='Northern anchovy Food, Co.';
INSERT customer
SET id=615,
    `name`='Northern clingfish Food, Co.';
INSERT customer
SET id=616,
    `name`='Northern lampfish Food, Co.';
INSERT customer
SET id=617,
    `name`='Northern pearleye Food, Co.';
INSERT customer
SET id=618,
    `name`='Northern pike Food, Co.';
INSERT customer
SET id=619,
    `name`='Northern sea robin Food, Co.';
INSERT customer
SET id=620,
    `name`='Northern squawfish Food, Co.';
INSERT customer
SET id=621,
    `name`='Northern Stargazer Food, Co.';
INSERT customer
SET id=622,
    `name`='Norwegian Atlantic salmon Food, Co.';
INSERT customer
SET id=623,
    `name`='Nurseryfish Food, Co.';
INSERT customer
SET id=624,
    `name`='Nurse shark Food, Co.';
INSERT customer
SET id=625,
    `name`='Oarfish Food, Co.';
INSERT customer
SET id=626,
    `name`='Ocean perch Food, Co.';
INSERT customer
SET id=627,
    `name`='Ocean sunfish Food, Co.';
INSERT customer
SET id=628,
    `name`='Oceanic flyingfish Food, Co.';
INSERT customer
SET id=629,
    `name`='Oceanic whitetip shark Food, Co.';
INSERT customer
SET id=630,
    `name`='Oilfish Food, Co.';
INSERT customer
SET id=631,
    `name`='Oldwife Food, Co.';
INSERT customer
SET id=632,
    `name`='Old World knifefish Food, Co.';
INSERT customer
SET id=633,
    `name`='Old World rivuline Food, Co.';
INSERT customer
SET id=634,
    `name`='Olive flounder Food, Co.';
INSERT customer
SET id=635,
    `name`='Opah Food, Co.';
INSERT customer
SET id=636,
    `name`='Opaleye Food, Co.';
INSERT customer
SET id=637,
    `name`='Orange roughy Food, Co.';
INSERT customer
SET id=638,
    `name`='Orangespine unicorn fish Food, Co.';
INSERT customer
SET id=639,
    `name`='Orangestriped triggerfish Food, Co.';
INSERT customer
SET id=640,
    `name`='Orbicular batfish Food, Co.';
INSERT customer
SET id=641,
    `name`='Orbicular velvetfish Food, Co.';
INSERT customer
SET id=642,
    `name`='Oregon chub Food, Co.';
INSERT customer
SET id=643,
    `name`='Oriental loach Food, Co.';
INSERT customer
SET id=644,
    `name`='Owens pupfish Food, Co.';
INSERT customer
SET id=645,
    `name`='Pacific albacore Food, Co.';
INSERT customer
SET id=646,
    `name`='Pacific argentine Food, Co.';
INSERT customer
SET id=647,
    `name`='Pacific cod Food, Co.';
INSERT customer
SET id=648,
    `name`='Pacific hake Food, Co.';
INSERT customer
SET id=649,
    `name`='Pacific herring Food, Co.';
INSERT customer
SET id=650,
    `name`='Pacific lamprey Food, Co.';
INSERT customer
SET id=651,
    `name`='Pacific salmon Food, Co.';
INSERT customer
SET id=652,
    `name`='Pacific saury Food, Co.';
INSERT customer
SET id=653,
    `name`='Pacific trout Food, Co.';
INSERT customer
SET id=654,
    `name`='Pacific viperfish Food, Co.';
INSERT customer
SET id=655,
    `name`='Paddlefish Food, Co.';
INSERT customer
SET id=656,
    `name`='Panga Food, Co.';
INSERT customer
SET id=657,
    `name`='Paperbone Food, Co.';
INSERT customer
SET id=658,
    `name`='Paradise fish Food, Co.';
INSERT customer
SET id=659,
    `name`='Parasitic catfish Food, Co.';
INSERT customer
SET id=660,
    `name`='Parrotfish Food, Co.';
INSERT customer
SET id=661,
    `name`='Peacock flounder Food, Co.';
INSERT customer
SET id=662,
    `name`='Peamouth Food, Co.';
INSERT customer
SET id=663,
    `name`='Pearleye Food, Co.';
INSERT customer
SET id=664,
    `name`='Pearlfish Food, Co.';
INSERT customer
SET id=665,
    `name`='Pearl danio Food, Co.';
INSERT customer
SET id=666,
    `name`='Pearl perch Food, Co.';
INSERT customer
SET id=667,
    `name`='Pejerrey Food, Co.';
INSERT customer
SET id=668,
    `name`='Peladillo Food, Co.';
INSERT customer
SET id=669,
    `name`='Pelagic cod Food, Co.';
INSERT customer
SET id=670,
    `name`='Pelican eel Food, Co.';
INSERT customer
SET id=671,
    `name`='Pelican gulper Food, Co.';
INSERT customer
SET id=672,
    `name`='Pencil catfish Food, Co.';
INSERT customer
SET id=673,
    `name`='Pencilfish Food, Co.';
INSERT customer
SET id=674,
    `name`='Pencilsmelt Food, Co.';
INSERT customer
SET id=675,
    `name`='Perch Food, Co.';
INSERT customer
SET id=676,
    `name`='Peter\'s elephantnose fish Food, Co.';
INSERT customer
SET id=677,
    `name`='Pickerel Food, Co.';
INSERT customer
SET id=678,
    `name`='Pigfish Food, Co.';
INSERT customer
SET id=679,
    `name`='Pike characid Food, Co.';
INSERT customer
SET id=680,
    `name`='Pike conger Food, Co.';
INSERT customer
SET id=681,
    `name`='Pike eel Food, Co.';
INSERT customer
SET id=682,
    `name`='Pike Food, Co.';
INSERT customer
SET id=683,
    `name`='Pikeblenny Food, Co.';
INSERT customer
SET id=684,
    `name`='Pikehead Food, Co.';
INSERT customer
SET id=685,
    `name`='Pikeperch Food, Co.';
INSERT customer
SET id=686,
    `name`='Pilchard Food, Co.';
INSERT customer
SET id=687,
    `name`='Pilot fish Food, Co.';
INSERT customer
SET id=688,
    `name`='Pineconefish Food, Co.';
INSERT customer
SET id=689,
    `name`='Pink salmon Food, Co.';
INSERT customer
SET id=690,
    `name`='Píntano Food, Co.';
INSERT customer
SET id=691,
    `name`='Pipefish Food, Co.';
INSERT customer
SET id=692,
    `name`='Piranha Food, Co.';
INSERT customer
SET id=693,
    `name`='Pirarucu Food, Co.';
INSERT customer
SET id=694,
    `name`='Pirate perch Food, Co.';
INSERT customer
SET id=695,
    `name`='Plaice Food, Co.';
INSERT customer
SET id=696,
    `name`='Platy Food, Co.';
INSERT customer
SET id=697,
    `name`='Platyfish Food, Co.';
INSERT customer
SET id=698,
    `name`='Pleco Food, Co.';
INSERT customer
SET id=699,
    `name`='Plownose chimaera Food, Co.';
INSERT customer
SET id=700,
    `name`='Plunderfish Food, Co.';
INSERT customer
SET id=701,
    `name`='Poacher Food, Co.';
INSERT customer
SET id=702,
    `name`='Pollyfish Food, Co.';
INSERT customer
SET id=703,
    `name`='Pollock Food, Co.';
INSERT customer
SET id=704,
    `name`='Pomfret Food, Co.';
INSERT customer
SET id=705,
    `name`='Pompano Food, Co.';
INSERT customer
SET id=706,
    `name`='Pompano dolphinfish Food, Co.';
INSERT customer
SET id=707,
    `name`='Ponyfish Food, Co.';
INSERT customer
SET id=708,
    `name`='Poolfish Food, Co.';
INSERT customer
SET id=709,
    `name`='Popeye catafula Food, Co.';
INSERT customer
SET id=710,
    `name`='Porbeagle shark Food, Co.';
INSERT customer
SET id=711,
    `name`='Porcupinefish Food, Co.';
INSERT customer
SET id=712,
    `name`='Porgy Food, Co.';
INSERT customer
SET id=713,
    `name`='Port Jackson shark Food, Co.';
INSERT customer
SET id=714,
    `name`='Powen Food, Co.';
INSERT customer
SET id=715,
    `name`='Priapumfish Food, Co.';
INSERT customer
SET id=716,
    `name`='Prickleback Food, Co.';
INSERT customer
SET id=717,
    `name`='Pricklefish Food, Co.';
INSERT customer
SET id=718,
    `name`='Prickly shark Food, Co.';
INSERT customer
SET id=719,
    `name`='Prowfish Food, Co.';
INSERT customer
SET id=720,
    `name`='Pufferfish Food, Co.';
INSERT customer
SET id=721,
    `name`='Pumpkinseed Food, Co.';
INSERT customer
SET id=722,
    `name`='Pupfish Food, Co.';
INSERT customer
SET id=723,
    `name`='Pygmy sunfish Food, Co.';
INSERT customer
SET id=724,
    `name`='Queen danio Food, Co.';
INSERT customer
SET id=725,
    `name`='Queen parrotfish Food, Co.';
INSERT customer
SET id=726,
    `name`='Queen triggerfish Food, Co.';
INSERT customer
SET id=727,
    `name`='Quillback Food, Co.';
INSERT customer
SET id=728,
    `name`='Quillfish Food, Co.';
INSERT customer
SET id=729,
    `name`='Rabbitfish Food, Co.';
INSERT customer
SET id=730,
    `name`='Raccoon butterfly fish Food, Co.';
INSERT customer
SET id=731,
    `name`='Ragfish Food, Co.';
INSERT customer
SET id=732,
    `name`='Rainbow trout Food, Co.';
INSERT customer
SET id=733,
    `name`='Rainbowfish Food, Co.';
INSERT customer
SET id=734,
    `name`='Rasbora Food, Co.';
INSERT customer
SET id=735,
    `name`='Ratfish Food, Co.';
INSERT customer
SET id=736,
    `name`='Rattail Food, Co.';
INSERT customer
SET id=737,
    `name`='Ray Food, Co.';
INSERT customer
SET id=738,
    `name`='Razorback sucker Food, Co.';
INSERT customer
SET id=739,
    `name`='Razorfish Food, Co.';
INSERT customer
SET id=740,
    `name`='Red salmon Food, Co.';
INSERT customer
SET id=741,
    `name`='Red snapper Food, Co.';
INSERT customer
SET id=742,
    `name`='Redfin perch Food, Co.';
INSERT customer
SET id=743,
    `name`='Redfish Food, Co.';
INSERT customer
SET id=744,
    `name`='Redhorse sucker Food, Co.';
INSERT customer
SET id=745,
    `name`='Redlip blenny Food, Co.';
INSERT customer
SET id=746,
    `name`='Redmouth whalefish Food, Co.';
INSERT customer
SET id=747,
    `name`='Redside Food, Co.';
INSERT customer
SET id=748,
    `name`='Redtooth triggerfish Food, Co.';
INSERT customer
SET id=749,
    `name`='Red velvetfish Food, Co.';
INSERT customer
SET id=750,
    `name`='Red whalefish Food, Co.';
INSERT customer
SET id=751,
    `name`='Reedfish Food, Co.';
INSERT customer
SET id=752,
    `name`='Reef triggerfish Food, Co.';
INSERT customer
SET id=753,
    `name`='Regal whiptail catfish Food, Co.';
INSERT customer
SET id=754,
    `name`='Remora Food, Co.';
INSERT customer
SET id=755,
    `name`='Requiem shark Food, Co.';
INSERT customer
SET id=756,
    `name`='Ribbon eel Food, Co.';
INSERT customer
SET id=757,
    `name`='Ribbon sawtail fish Food, Co.';
INSERT customer
SET id=758,
    `name`='Ribbonbearer Food, Co.';
INSERT customer
SET id=759,
    `name`='Ribbonfish Food, Co.';
INSERT customer
SET id=760,
    `name`='Rice eel Food, Co.';
INSERT customer
SET id=761,
    `name`='Ricefish Food, Co.';
INSERT customer
SET id=762,
    `name`='Ridgehead Food, Co.';
INSERT customer
SET id=763,
    `name`='Riffle dace Food, Co.';
INSERT customer
SET id=764,
    `name`='Righteye flounder Food, Co.';
INSERT customer
SET id=765,
    `name`='Rio Grande perch Food, Co.';
INSERT customer
SET id=766,
    `name`='River loach Food, Co.';
INSERT customer
SET id=767,
    `name`='River shark Food, Co.';
INSERT customer
SET id=768,
    `name`='River stingray Food, Co.';
INSERT customer
SET id=769,
    `name`='Rivuline Food, Co.';
INSERT customer
SET id=770,
    `name`='Roach Food, Co.';
INSERT customer
SET id=771,
    `name`='Roanoke bass Food, Co.';
INSERT customer
SET id=772,
    `name`='Rock bass Food, Co.';
INSERT customer
SET id=773,
    `name`='Rock beauty Food, Co.';
INSERT customer
SET id=774,
    `name`='Rock cod Food, Co.';
INSERT customer
SET id=775,
    `name`='Rocket danio Food, Co.';
INSERT customer
SET id=776,
    `name`='Rockfish Food, Co.';
INSERT customer
SET id=777,
    `name`='Rockling Food, Co.';
INSERT customer
SET id=778,
    `name`='Rockweed gunnel Food, Co.';
INSERT customer
SET id=779,
    `name`='Rohu Food, Co.';
INSERT customer
SET id=780,
    `name`='Ronquil Food, Co.';
INSERT customer
SET id=781,
    `name`='Roosterfish Food, Co.';
INSERT customer
SET id=782,
    `name`='Ropefish Food, Co.';
INSERT customer
SET id=783,
    `name`='Rough pomfret Food, Co.';
INSERT customer
SET id=784,
    `name`='Rough scad Food, Co.';
INSERT customer
SET id=785,
    `name`='Rough sculpin Food, Co.';
INSERT customer
SET id=786,
    `name`='Roughy Food, Co.';
INSERT customer
SET id=787,
    `name`='Roundhead Food, Co.';
INSERT customer
SET id=788,
    `name`='Round herring Food, Co.';
INSERT customer
SET id=789,
    `name`='Round stingray Food, Co.';
INSERT customer
SET id=790,
    `name`='Round whitefish Food, Co.';
INSERT customer
SET id=791,
    `name`='Rudd Food, Co.';
INSERT customer
SET id=792,
    `name`='Rudderfish Food, Co.';
INSERT customer
SET id=793,
    `name`='Ruffe Food, Co.';
INSERT customer
SET id=794,
    `name`='Russian sturgeon Food, Co.';
INSERT customer
SET id=795,
    `name`='Sábalo Food, Co.';
INSERT customer
SET id=796,
    `name`='Sabertooth Food, Co.';
INSERT customer
SET id=797,
    `name`='Saber-toothed blenny Food, Co.';
INSERT customer
SET id=798,
    `name`='Sabertooth fish Food, Co.';
INSERT customer
SET id=799,
    `name`='Sablefish Food, Co.';
INSERT customer
SET id=800,
    `name`='Sacramento blackfish Food, Co.';
INSERT customer
SET id=801,
    `name`='Sacramento splittail Food, Co.';
INSERT customer
SET id=802,
    `name`='Sailback scorpionfish Food, Co.';
INSERT customer
SET id=803,
    `name`='Sailbearer Food, Co.';
INSERT customer
SET id=804,
    `name`='Sailfin silverside Food, Co.';
INSERT customer
SET id=805,
    `name`='Sailfish Food, Co.';
INSERT customer
SET id=806,
    `name`='Salamanderfish Food, Co.';
INSERT customer
SET id=807,
    `name`='Salmon Food, Co.';
INSERT customer
SET id=808,
    `name`='Salmon shark Food, Co.';
INSERT customer
SET id=809,
    `name`='Sandbar shark Food, Co.';
INSERT customer
SET id=810,
    `name`='Sandburrower Food, Co.';
INSERT customer
SET id=811,
    `name`='Sand dab Food, Co.';
INSERT customer
SET id=812,
    `name`='Sparkle Food, Co.';
INSERT customer
SET id=813,
    `name`='Sand diver Food, Co.';
INSERT customer
SET id=814,
    `name`='Sand eel Food, Co.';
INSERT customer
SET id=815,
    `name`='Sandfish Food, Co.';
INSERT customer
SET id=816,
    `name`='Sand goby Food, Co.';
INSERT customer
SET id=817,
    `name`='Sand knifefish Food, Co.';
INSERT customer
SET id=818,
    `name`='Sand lance Food, Co.';
INSERT customer
SET id=819,
    `name`='Sandperch Food, Co.';
INSERT customer
SET id=820,
    `name`='Sandroller Food, Co.';
INSERT customer
SET id=821,
    `name`='Sand stargazer Food, Co.';
INSERT customer
SET id=822,
    `name`='Sand tiger Food, Co.';
INSERT customer
SET id=823,
    `name`='Sand tilefish Food, Co.';
INSERT customer
SET id=824,
    `name`='Sarcastic fringehead Food, Co.';
INSERT customer
SET id=825,
    `name`='Sardine Food, Co.';
INSERT customer
SET id=826,
    `name`='Sargassum fish Food, Co.';
INSERT customer
SET id=827,
    `name`='Sauger Food, Co.';
INSERT customer
SET id=828,
    `name`='Saury Food, Co.';
INSERT customer
SET id=829,
    `name`='Sawfish Food, Co.';
INSERT customer
SET id=830,
    `name`='Saw shark Food, Co.';
INSERT customer
SET id=831,
    `name`='Sawtooth eel Food, Co.';
INSERT customer
SET id=832,
    `name`='Scabbard fish Food, Co.';
INSERT customer
SET id=833,
    `name`='Scaleless black dragonfish Food, Co.';
INSERT customer
SET id=834,
    `name`='Scaly dragonfish Food, Co.';
INSERT customer
SET id=835,
    `name`='Scat Food, Co.';
INSERT customer
SET id=836,
    `name`='Scissor-tail rasbora Food, Co.';
INSERT customer
SET id=837,
    `name`='Scorpionfish Food, Co.';
INSERT customer
SET id=838,
    `name`='Sculpin Food, Co.';
INSERT customer
SET id=839,
    `name`='Scup Food, Co.';
INSERT customer
SET id=840,
    `name`='Scythe butterfish Food, Co.';
INSERT customer
SET id=841,
    `name`='Sea bass Food, Co.';
INSERT customer
SET id=842,
    `name`='Sea bream Food, Co.';
INSERT customer
SET id=843,
    `name`='Sea catfish Food, Co.';
INSERT customer
SET id=844,
    `name`='Sea chub Food, Co.';
INSERT customer
SET id=845,
    `name`='Sea devil Food, Co.';
INSERT customer
SET id=846,
    `name`='Sea dragon Food, Co.';
INSERT customer
SET id=847,
    `name`='Seahorse Food, Co.';
INSERT customer
SET id=848,
    `name`='Sea lamprey Food, Co.';
INSERT customer
SET id=849,
    `name`='Seamoth Food, Co.';
INSERT customer
SET id=850,
    `name`='Sea raven Food, Co.';
INSERT customer
SET id=851,
    `name`='Searobin Food, Co.';
INSERT customer
SET id=852,
    `name`='Sea snail Food, Co.';
INSERT customer
SET id=853,
    `name`='Sea toad Food, Co.';
INSERT customer
SET id=854,
    `name`='Sevan trout Food, Co.';
INSERT customer
SET id=855,
    `name`='Seatrout Food, Co.';
INSERT customer
SET id=856,
    `name`='Sergeant major Food, Co.';
INSERT customer
SET id=857,
    `name`='Shad Food, Co.';
INSERT customer
SET id=858,
    `name`='Shark Food, Co.';
INSERT customer
SET id=859,
    `name`='Sharksucker Food, Co.';
INSERT customer
SET id=860,
    `name`='Canthigaster rostrata Food, Co.';
INSERT customer
SET id=861,
    `name`='Sheatfish Food, Co.';
INSERT customer
SET id=862,
    `name`='Shingle Fish Food, Co.';
INSERT customer
SET id=863,
    `name`='Sheepshead Food, Co.';
INSERT customer
SET id=864,
    `name`='Sheepshead minnow Food, Co.';
INSERT customer
SET id=865,
    `name`='Shell-ear Food, Co.';
INSERT customer
SET id=866,
    `name`='Shiner Food, Co.';
INSERT customer
SET id=867,
    `name`='Shortnose chimaera Food, Co.';
INSERT customer
SET id=868,
    `name`='Shortnose greeneye Food, Co.';
INSERT customer
SET id=869,
    `name`='Shortnose sucker Food, Co.';
INSERT customer
SET id=870,
    `name`='Shovelnose sturgeon Food, Co.';
INSERT customer
SET id=871,
    `name`='Shrimpfish Food, Co.';
INSERT customer
SET id=872,
    `name`='Siamese fighting fish Food, Co.';
INSERT customer
SET id=873,
    `name`='Sillago Food, Co.';
INSERT customer
SET id=874,
    `name`='Silver carp Food, Co.';
INSERT customer
SET id=875,
    `name`='Silver dollar Food, Co.';
INSERT customer
SET id=876,
    `name`='Silver driftfish Food, Co.';
INSERT customer
SET id=877,
    `name`='Silver hake Food, Co.';
INSERT customer
SET id=878,
    `name`='Silverside Food, Co.';
INSERT customer
SET id=879,
    `name`='Sind danio Food, Co.';
INSERT customer
SET id=880,
    `name`='Sixgill ray Food, Co.';
INSERT customer
SET id=881,
    `name`='Sixgill shark Food, Co.';
INSERT customer
SET id=882,
    `name`='Skate Food, Co.';
INSERT customer
SET id=883,
    `name`='Skilfish Food, Co.';
INSERT customer
SET id=884,
    `name`='Skipjack tuna Food, Co.';
INSERT customer
SET id=885,
    `name`='Skipping goby Food, Co.';
INSERT customer
SET id=886,
    `name`='Slender barracudina Food, Co.';
INSERT customer
SET id=887,
    `name`='Slender mola Food, Co.';
INSERT customer
SET id=888,
    `name`='Slender snipe eel Food, Co.';
INSERT customer
SET id=889,
    `name`='Sleeper Food, Co.';
INSERT customer
SET id=890,
    `name`='Sleeper shark Food, Co.';
INSERT customer
SET id=891,
    `name`='Slickhead Food, Co.';
INSERT customer
SET id=892,
    `name`='Slimehead Food, Co.';
INSERT customer
SET id=893,
    `name`='Slimy mackerel Food, Co.';
INSERT customer
SET id=894,
    `name`='Slimy sculpin Food, Co.';
INSERT customer
SET id=895,
    `name`='Slipmouth Food, Co.';
INSERT customer
SET id=896,
    `name`='Smalleye squaretail Food, Co.';
INSERT customer
SET id=897,
    `name`='Smalltooth sawfish Food, Co.';
INSERT customer
SET id=898,
    `name`='Smelt Food, Co.';
INSERT customer
SET id=899,
    `name`='Smelt-whiting Food, Co.';
INSERT customer
SET id=900,
    `name`='Smooth dogfish Food, Co.';
INSERT customer
SET id=901,
    `name`='Smoothtongue Food, Co.';
INSERT customer
SET id=902,
    `name`='Snailfish Food, Co.';
INSERT customer
SET id=903,
    `name`='Snake eel Food, Co.';
INSERT customer
SET id=904,
    `name`='Snakehead Food, Co.';
INSERT customer
SET id=905,
    `name`='Snake mackerel Food, Co.';
INSERT customer
SET id=906,
    `name`='Snake mudhead Food, Co.';
INSERT customer
SET id=907,
    `name`='Snapper Food, Co.';
INSERT customer
SET id=908,
    `name`='Snipe eel Food, Co.';
INSERT customer
SET id=909,
    `name`='Snipefish Food, Co.';
INSERT customer
SET id=910,
    `name`='Snoek Food, Co.';
INSERT customer
SET id=911,
    `name`='Snook Food, Co.';
INSERT customer
SET id=912,
    `name`='Snubnose eel Food, Co.';
INSERT customer
SET id=913,
    `name`='Snubnose parasitic eel Food, Co.';
INSERT customer
SET id=914,
    `name`='Soapfish Food, Co.';
INSERT customer
SET id=915,
    `name`='Sockeye salmon Food, Co.';
INSERT customer
SET id=916,
    `name`='Soldierfish Food, Co.';
INSERT customer
SET id=917,
    `name`='Sole Food, Co.';
INSERT customer
SET id=918,
    `name`='South American darter Food, Co.';
INSERT customer
SET id=919,
    `name`='South American Lungfish Food, Co.';
INSERT customer
SET id=920,
    `name`='Southern Dolly Varden Food, Co.';
INSERT customer
SET id=921,
    `name`='Southern flounder Food, Co.';
INSERT customer
SET id=922,
    `name`='Southern grayling Food, Co.';
INSERT customer
SET id=923,
    `name`='Southern hake Food, Co.';
INSERT customer
SET id=924,
    `name`='Southern sandfish Food, Co.';
INSERT customer
SET id=925,
    `name`='Southern smelt Food, Co.';
INSERT customer
SET id=926,
    `name`='Spadefish Food, Co.';
INSERT customer
SET id=927,
    `name`='Spaghetti eel Food, Co.';
INSERT customer
SET id=928,
    `name`='Spanish mackerel Food, Co.';
INSERT customer
SET id=929,
    `name`='Spearfish Food, Co.';
INSERT customer
SET id=930,
    `name`='Speckled trout Food, Co.';
INSERT customer
SET id=931,
    `name`='Spiderfish Food, Co.';
INSERT customer
SET id=932,
    `name`='Spikefish Food, Co.';
INSERT customer
SET id=933,
    `name`='Spinefoot Food, Co.';
INSERT customer
SET id=934,
    `name`='Spiny-back Food, Co.';
INSERT customer
SET id=935,
    `name`='Spiny basslet Food, Co.';
INSERT customer
SET id=936,
    `name`='Spiny dogfish Food, Co.';
INSERT customer
SET id=937,
    `name`='Spiny dwarf catfish Food, Co.';
INSERT customer
SET id=938,
    `name`='Spiny eel Food, Co.';
INSERT customer
SET id=939,
    `name`='Spinyfin Food, Co.';
INSERT customer
SET id=940,
    `name`='Splitfin Food, Co.';
INSERT customer
SET id=941,
    `name`='Spookfish Food, Co.';
INSERT customer
SET id=942,
    `name`='Spotted danio Food, Co.';
INSERT customer
SET id=943,
    `name`='Spotted dogfish Food, Co.';
INSERT customer
SET id=944,
    `name`='Sprat Food, Co.';
INSERT customer
SET id=945,
    `name`='Springfish Food, Co.';
INSERT customer
SET id=946,
    `name`='Squarehead catfish Food, Co.';
INSERT customer
SET id=947,
    `name`='Squaretail Food, Co.';
INSERT customer
SET id=948,
    `name`='Squawfish Food, Co.';
INSERT customer
SET id=949,
    `name`='Squeaker Food, Co.';
INSERT customer
SET id=950,
    `name`='Squirrelfish Food, Co.';
INSERT customer
SET id=951,
    `name`='Staghorn sculpin Food, Co.';
INSERT customer
SET id=952,
    `name`='Stargazer Food, Co.';
INSERT customer
SET id=953,
    `name`='Starry flounder Food, Co.';
INSERT customer
SET id=954,
    `name`='Steelhead Food, Co.';
INSERT customer
SET id=955,
    `name`='Stickleback Food, Co.';
INSERT customer
SET id=956,
    `name`='Stingfish Food, Co.';
INSERT customer
SET id=957,
    `name`='Stingray Food, Co.';
INSERT customer
SET id=958,
    `name`='Stonecat Food, Co.';
INSERT customer
SET id=959,
    `name`='Stonefish Food, Co.';
INSERT customer
SET id=960,
    `name`='Stoneroller minnow Food, Co.';
INSERT customer
SET id=961,
    `name`='Straptail Food, Co.';
INSERT customer
SET id=962,
    `name`='Stream catfish Food, Co.';
INSERT customer
SET id=963,
    `name`='Streamer fish Food, Co.';
INSERT customer
SET id=964,
    `name`='Striped bass Food, Co.';
INSERT customer
SET id=965,
    `name`='Striped burrfish Food, Co.';
INSERT customer
SET id=966,
    `name`='Sturgeon Food, Co.';
INSERT customer
SET id=967,
    `name`='Sucker Food, Co.';
INSERT customer
SET id=968,
    `name`='Suckermouth armored catfish Food, Co.';
INSERT customer
SET id=969,
    `name`='Summer flounder Food, Co.';
INSERT customer
SET id=970,
    `name`='Sundaland noodlefish Food, Co.';
INSERT customer
SET id=971,
    `name`='Sunfish (opah) Food, Co.';
INSERT customer
SET id=972,
    `name`='Sunfish (mola mola) Food, Co.';
INSERT customer
SET id=973,
    `name`='Surf sardine Food, Co.';
INSERT customer
SET id=974,
    `name`='Surfperch Food, Co.';
INSERT customer
SET id=975,
    `name`='Surgeonfish Food, Co.';
INSERT customer
SET id=976,
    `name`='Swallower Food, Co.';
INSERT customer
SET id=977,
    `name`='Swamp-eel Food, Co.';
INSERT customer
SET id=978,
    `name`='Swampfish Food, Co.';
INSERT customer
SET id=979,
    `name`='Sweeper Food, Co.';
INSERT customer
SET id=980,
    `name`='Swordfish Food, Co.';
INSERT customer
SET id=981,
    `name`='Swordtail Food, Co.';
INSERT customer
SET id=982,
    `name`='Tadpole cod Food, Co.';
INSERT customer
SET id=983,
    `name`='Tadpole fish Food, Co.';
INSERT customer
SET id=984,
    `name`='Tailor Food, Co.';
INSERT customer
SET id=985,
    `name`='Taimen Food, Co.';
INSERT customer
SET id=986,
    `name`='Tang Food, Co.';
INSERT customer
SET id=987,
    `name`='Tapetail Food, Co.';
INSERT customer
SET id=988,
    `name`='Tarpon Food, Co.';
INSERT customer
SET id=989,
    `name`='Tarwhine Food, Co.';
INSERT customer
SET id=990,
    `name`='Telescopefish Food, Co.';
INSERT customer
SET id=991,
    `name`='Temperate bass Food, Co.';
INSERT customer
SET id=992,
    `name`='Temperate ocean-bass Food, Co.';
INSERT customer
SET id=993,
    `name`='Temperate perch Food, Co.';
INSERT customer
SET id=994,
    `name`='Tench Food, Co.';
INSERT customer
SET id=995,
    `name`='Tenpounder Food, Co.';
INSERT customer
SET id=996,
    `name`='Tenuis Food, Co.';
INSERT customer
SET id=997,
    `name`='Tetra Food, Co.';
INSERT customer
SET id=998,
    `name`='Thorny catfish Food, Co.';
INSERT customer
SET id=999,
    `name`='Thornfish Food, Co.';
INSERT customer
SET id=1000,
    `name`='Thornyhead Food, Co.';
INSERT customer
SET id=1001,
    `name`='Threadfin Food, Co.';
INSERT customer
SET id=1002,
    `name`='Threadfin bream Food, Co.';
INSERT customer
SET id=1003,
    `name`='Threadsail Food, Co.';
INSERT customer
SET id=1004,
    `name`='Threadtail Food, Co.';
INSERT customer
SET id=1005,
    `name`='Three spot gourami Food, Co.';
INSERT customer
SET id=1006,
    `name`='Threespine stickleback Food, Co.';
INSERT customer
SET id=1007,
    `name`='Three-toothed puffer Food, Co.';
INSERT customer
SET id=1008,
    `name`='Thresher shark Food, Co.';
INSERT customer
SET id=1009,
    `name`='Tidewater goby Food, Co.';
INSERT customer
SET id=1010,
    `name`='Tiger barb Food, Co.';
INSERT customer
SET id=1011,
    `name`='Tigerperch Food, Co.';
INSERT customer
SET id=1012,
    `name`='Tiger shark Food, Co.';
INSERT customer
SET id=1013,
    `name`='Tiger shovelnose catfish Food, Co.';
INSERT customer
SET id=1014,
    `name`='Tilapia Food, Co.';
INSERT customer
SET id=1015,
    `name`='Tilefish Food, Co.';
INSERT customer
SET id=1016,
    `name`='Titan triggerfish Food, Co.';
INSERT customer
SET id=1017,
    `name`='Toadfish Food, Co.';
INSERT customer
SET id=1018,
    `name`='Tommy ruff Food, Co.';
INSERT customer
SET id=1019,
    `name`='Tompot blenny Food, Co.';
INSERT customer
SET id=1020,
    `name`='Tonguefish Food, Co.';
INSERT customer
SET id=1021,
    `name`='Tope Food, Co.';
INSERT customer
SET id=1022,
    `name`='Topminnow Food, Co.';
INSERT customer
SET id=1023,
    `name`='Torpedo Food, Co.';
INSERT customer
SET id=1024,
    `name`='Torrent catfish Food, Co.';
INSERT customer
SET id=1025,
    `name`='Torrent fish Food, Co.';
INSERT customer
SET id=1026,
    `name`='Trahira Food, Co.';
INSERT customer
SET id=1027,
    `name`='Treefish Food, Co.';
INSERT customer
SET id=1028,
    `name`='Trevally Food, Co.';
INSERT customer
SET id=1029,
    `name`='Trench Food, Co.';
INSERT customer
SET id=1030,
    `name`='Triggerfish Food, Co.';
INSERT customer
SET id=1031,
    `name`='Triplefin blenny Food, Co.';
INSERT customer
SET id=1032,
    `name`='Triplespine Food, Co.';
INSERT customer
SET id=1033,
    `name`='Tripletail Food, Co.';
INSERT customer
SET id=1034,
    `name`='Tripod fish Food, Co.';
INSERT customer
SET id=1035,
    `name`='Trout Food, Co.';
INSERT customer
SET id=1036,
    `name`='Trout cod Food, Co.';
INSERT customer
SET id=1037,
    `name`='Trout-perch Food, Co.';
INSERT customer
SET id=1038,
    `name`='Trumpeter Food, Co.';
INSERT customer
SET id=1039,
    `name`='Trumpetfish Food, Co.';
INSERT customer
SET id=1040,
    `name`='Trunkfish Food, Co.';
INSERT customer
SET id=1041,
    `name`='Tubeblenny Food, Co.';
INSERT customer
SET id=1042,
    `name`='Tube-eye Food, Co.';
INSERT customer
SET id=1043,
    `name`='Tube-snout Food, Co.';
INSERT customer
SET id=1044,
    `name`='Tubeshoulder Food, Co.';
INSERT customer
SET id=1045,
    `name`='Tui chub Food, Co.';
INSERT customer
SET id=1046,
    `name`='Tuna Food, Co.';
INSERT customer
SET id=1047,
    `name`='Turbot Food, Co.';
INSERT customer
SET id=1048,
    `name`='Turkeyfish Food, Co.';
INSERT customer
SET id=1049,
    `name`='Unicorn fish Food, Co.';
INSERT customer
SET id=1050,
    `name`='Upside-down catfish Food, Co.';
INSERT customer
SET id=1051,
    `name`='Velvet-belly shark Food, Co.';
INSERT customer
SET id=1052,
    `name`='Velvet catfish Food, Co.';
INSERT customer
SET id=1053,
    `name`='Velvetfish Food, Co.';
INSERT customer
SET id=1054,
    `name`='Vendace Food, Co.';
INSERT customer
SET id=1055,
    `name`='Vimba Food, Co.';
INSERT customer
SET id=1056,
    `name`='Viperfish Food, Co.';
INSERT customer
SET id=1057,
    `name`='Wahoo Food, Co.';
INSERT customer
SET id=1058,
    `name`='Walking catfish Food, Co.';
INSERT customer
SET id=1059,
    `name`='Wallago Food, Co.';
INSERT customer
SET id=1060,
    `name`='Walleye Food, Co.';
INSERT customer
SET id=1061,
    `name`='Walleye pollock Food, Co.';
INSERT customer
SET id=1062,
    `name`='Walu Food, Co.';
INSERT customer
SET id=1063,
    `name`='Warbonnet Food, Co.';
INSERT customer
SET id=1064,
    `name`='Warmouth Food, Co.';
INSERT customer
SET id=1065,
    `name`='Warty angler Food, Co.';
INSERT customer
SET id=1066,
    `name`='Waryfish Food, Co.';
INSERT customer
SET id=1067,
    `name`='Wasp fish Food, Co.';
INSERT customer
SET id=1068,
    `name`='Weasel shark Food, Co.';
INSERT customer
SET id=1069,
    `name`='Weatherfish Food, Co.';
INSERT customer
SET id=1070,
    `name`='Weever Food, Co.';
INSERT customer
SET id=1071,
    `name`='Weeverfish Food, Co.';
INSERT customer
SET id=1072,
    `name`='Wels catfish Food, Co.';
INSERT customer
SET id=1073,
    `name`='Whale catfish Food, Co.';
INSERT customer
SET id=1074,
    `name`='Whalefish Food, Co.';
INSERT customer
SET id=1075,
    `name`='Whale shark Food, Co.';
INSERT customer
SET id=1076,
    `name`='Whiff Food, Co.';
INSERT customer
SET id=1077,
    `name`='Whiptail gulper Food, Co.';
INSERT customer
SET id=1078,
    `name`='Whitebait Food, Co.';
INSERT customer
SET id=1079,
    `name`='White croaker Food, Co.';
INSERT customer
SET id=1080,
    `name`='Whitefish Food, Co.';
INSERT customer
SET id=1081,
    `name`='White marlin Food, Co.';
INSERT customer
SET id=1082,
    `name`='White shark Food, Co.';
INSERT customer
SET id=1083,
    `name`='Whitetip reef shark Food, Co.';
INSERT customer
SET id=1084,
    `name`='Whiting Food, Co.';
INSERT customer
SET id=1085,
    `name`='Wobbegong Food, Co.';
INSERT customer
SET id=1086,
    `name`='Wolf-eel Food, Co.';
INSERT customer
SET id=1087,
    `name`='Wolffish Food, Co.';
INSERT customer
SET id=1088,
    `name`='Wolf-herring Food, Co.';
INSERT customer
SET id=1089,
    `name`='Woody sculpin Food, Co.';
INSERT customer
SET id=1090,
    `name`='Worm eel Food, Co.';
INSERT customer
SET id=1091,
    `name`='Wormfish Food, Co.';
INSERT customer
SET id=1092,
    `name`='Wrasse Food, Co.';
INSERT customer
SET id=1093,
    `name`='Wrymouth Food, Co.';
INSERT customer
SET id=1094,
    `name`='X-ray tetra Food, Co.';
INSERT customer
SET id=1095,
    `name`='Yellow-and-black triplefin Food, Co.';
INSERT customer
SET id=1096,
    `name`='Yellowbanded perch Food, Co.';
INSERT customer
SET id=1097,
    `name`='Yellow bass Food, Co.';
INSERT customer
SET id=1098,
    `name`='Yellow-edged moray Food, Co.';
INSERT customer
SET id=1099,
    `name`='Yellow-eye mullet Food, Co.';
INSERT customer
SET id=1100,
    `name`='Yellowhead jawfish Food, Co.';
INSERT customer
SET id=1101,
    `name`='Yellowfin croaker Food, Co.';
INSERT customer
SET id=1102,
    `name`='Yellowfin cutthroat trout Food, Co.';
INSERT customer
SET id=1103,
    `name`='Yellowfin grouper Food, Co.';
INSERT customer
SET id=1104,
    `name`='Yellowfin pike Food, Co.';
INSERT customer
SET id=1105,
    `name`='Yellowfin surgeonfish Food, Co.';
INSERT customer
SET id=1106,
    `name`='Yellowfin tuna Food, Co.';
INSERT customer
SET id=1107,
    `name`='Yellow jack Food, Co.';
INSERT customer
SET id=1108,
    `name`='Yellowmargin triggerfish Food, Co.';
INSERT customer
SET id=1109,
    `name`='Yellow moray Food, Co.';
INSERT customer
SET id=1110,
    `name`='Yellow perch Food, Co.';
INSERT customer
SET id=1111,
    `name`='Yellowtail Food, Co.';
INSERT customer
SET id=1112,
    `name`='Yellowtail amberjack Food, Co.';
INSERT customer
SET id=1113,
    `name`='Yellowtail barracuda Food, Co.';
INSERT customer
SET id=1114,
    `name`='Yellowtail clownfish Food, Co.';
INSERT customer
SET id=1115,
    `name`='Yellowtail horse mackerel Food, Co.';
INSERT customer
SET id=1116,
    `name`='Yellowtail kingfish Food, Co.';
INSERT customer
SET id=1117,
    `name`='Yellowtail snapper Food, Co.';
INSERT customer
SET id=1118,
    `name`='Yellow tang Food, Co.';
INSERT customer
SET id=1119,
    `name`='Yellow weaver Food, Co.';
INSERT customer
SET id=1120,
    `name`='Yellowbelly tail catfish Food, Co.';
INSERT customer
SET id=1121,
    `name`='Zander Food, Co.';
INSERT customer
SET id=1122,
    `name`='Zebra bullhead shark Food, Co.';
INSERT customer
SET id=1123,
    `name`='Zebra danio Food, Co.';
INSERT customer
SET id=1124,
    `name`='Zebrafish Food, Co.';
INSERT customer
SET id=1125,
    `name`='Zebra lionfish Food, Co.';
INSERT customer
SET id=1126,
    `name`='Zebra loach Food, Co.';
INSERT customer
SET id=1127,
    `name`='Zebra oto Food, Co.';
INSERT customer
SET id=1128,
    `name`='Zebra pleco Food, Co.';
INSERT customer
SET id=1129,
    `name`='Zebra shark Food, Co.';
INSERT customer
SET id=1130,
    `name`='Zebra tilapia Food, Co.';
INSERT customer
SET id=1131,
    `name`='Ziege Food, Co.';
INSERT customer
SET id=1132,
    `name`='Zingel Food, Co.';
INSERT customer
SET id=1133,
    `name`='Zebra trout Food, Co.';
INSERT customer
SET id=1134,
    `name`='Zebra turkeyfish Food, Co.';

INSERT saleslog
SET dt=timestamp'2010-1-1 00:00:00',
    item='Swede ',
    customer='Madtom Food, Co.',
    qty=7,
    item_id=38,
    customer_id=549,
    unitprice=528,
    total=3696;
INSERT saleslog
SET dt=timestamp'2010-1-1 00:04:45',
    item='Olive ',
    customer='Old World knifefish Food, Co.',
    qty=16,
    item_id=24,
    customer_id=632,
    unitprice=781,
    total=12496;
INSERT saleslog
SET dt=timestamp'2010-1-1 00:14:10',
    item='Peas ',
    customer='Darter Food, Co.',
    qty=8,
    item_id=30,
    customer_id=251,
    unitprice=373,
    total=2984;
INSERT saleslog
SET dt=timestamp'2010-1-1 00:27:02',
    item='Shallots ',
    customer='Lampfish Food, Co.',
    qty=46,
    item_id=32,
    customer_id=496,
    unitprice=331,
    total=15226;
INSERT saleslog
SET dt=timestamp'2010-1-1 00:49:21',
    item='Yam',
    customer='Ratfish Food, Co.',
    qty=20,
    item_id=39,
    customer_id=735,
    unitprice=790,
    total=15800;
INSERT saleslog
SET dt=timestamp'2010-1-1 01:02:15',
    item='Squash ',
    customer='Green swordtail Food, Co.',
    qty=36,
    item_id=34,
    customer_id=409,
    unitprice=190,
    total=6840;
INSERT saleslog
SET dt=timestamp'2010-1-1 01:12:20',
    item='Swede ',
    customer='Cutthroat trout Food, Co.',
    qty=16,
    item_id=38,
    customer_id=245,
    unitprice=528,
    total=8448;
INSERT saleslog
SET dt=timestamp'2010-1-1 01:37:52',
    item='Peas ',
    customer='Frogfish Food, Co.',
    qty=84,
    item_id=30,
    customer_id=361,
    unitprice=373,
    total=31332;
INSERT saleslog
SET dt=timestamp'2010-1-1 01:51:49',
    item='Tomato ',
    customer='Combtail gourami Food, Co.',
    qty=45,
    item_id=36,
    customer_id=217,
    unitprice=361,
    total=16245;
INSERT saleslog
SET dt=timestamp'2010-1-1 01:57:17',
    item='Carrot ',
    customer='Lemon sole Food, Co.',
    qty=57,
    item_id=10,
    customer_id=507,
    unitprice=460,
    total=26220;
INSERT saleslog
SET dt=timestamp'2010-1-1 02:13:52',
    item='Cabbage ',
    customer='Cuskfish Food, Co.',
    qty=40,
    item_id=8,
    customer_id=242,
    unitprice=492,
    total=19680;
INSERT saleslog
SET dt=timestamp'2010-1-1 02:39:36',
    item='Lettuce ',
    customer='Ridgehead Food, Co.',
    qty=68,
    item_id=21,
    customer_id=762,
    unitprice=964,
    total=65552;
INSERT saleslog
SET dt=timestamp'2010-1-1 02:59:45',
    item='Cucumber ',
    customer='Sweeper Food, Co.',
    qty=78,
    item_id=16,
    customer_id=979,
    unitprice=472,
    total=36816;
INSERT saleslog
SET dt=timestamp'2010-1-1 03:23:51',
    item='Aubergine ',
    customer='Combtooth blenny Food, Co.',
    qty=68,
    item_id=3,
    customer_id=218,
    unitprice=294,
    total=19992;
INSERT saleslog
SET dt=timestamp'2010-1-1 03:39:47',
    item='Mushroom ',
    customer='Muskellunge Food, Co.',
    qty=71,
    item_id=22,
    customer_id=600,
    unitprice=347,
    total=24637;
INSERT saleslog
SET dt=timestamp'2010-1-1 03:57:46',
    item='Peppers ',
    customer='Lake whitefish Food, Co.',
    qty=93,
    item_id=27,
    customer_id=495,
    unitprice=297,
    total=27621;
INSERT saleslog
SET dt=timestamp'2010-1-1 04:14:29',
    item='Tomato ',
    customer='Quillback Food, Co.',
    qty=100,
    item_id=36,
    customer_id=727,
    unitprice=361,
    total=36100;
INSERT saleslog
SET dt=timestamp'2010-1-1 04:42:10',
    item='Sweet Potato ',
    customer='Piranha Food, Co.',
    qty=36,
    item_id=35,
    customer_id=692,
    unitprice=650,
    total=23400;
INSERT saleslog
SET dt=timestamp'2010-1-1 04:55:42',
    item='Sweet Potato ',
    customer='Eel Food, Co.',
    qty=18,
    item_id=35,
    customer_id=294,
    unitprice=650,
    total=11700;
INSERT saleslog
SET dt=timestamp'2010-1-1 05:01:56',
    item='Cucumber ',
    customer='Bluefin tuna Food, Co.',
    qty=81,
    item_id=16,
    customer_id=121,
    unitprice=472,
    total=38232;
INSERT saleslog
SET dt=timestamp'2010-1-1 05:26:32',
    item='Olive ',
    customer='Mosquitofish Food, Co.',
    qty=16,
    item_id=24,
    customer_id=587,
    unitprice=781,
    total=12496;
INSERT saleslog
SET dt=timestamp'2010-1-1 05:31:29',
    item='Garlic ',
    customer='Mojarra Food, Co.',
    qty=4,
    item_id=19,
    customer_id=573,
    unitprice=484,
    total=1936;
INSERT saleslog
SET dt=timestamp'2010-1-1 05:48:00',
    item='Brussels Sprouts ',
    customer='Sevan trout Food, Co.',
    qty=14,
    item_id=7,
    customer_id=854,
    unitprice=776,
    total=10864;
INSERT saleslog
SET dt=timestamp'2010-1-1 05:54:16',
    item='Yam',
    customer='Monkfish Food, Co.',
    qty=86,
    item_id=39,
    customer_id=578,
    unitprice=790,
    total=67940;
INSERT saleslog
SET dt=timestamp'2010-1-1 06:18:03',
    item='Courgette ',
    customer='Cow shark Food, Co.',
    qty=97,
    item_id=15,
    customer_id=230,
    unitprice=251,
    total=24347;
INSERT saleslog
SET dt=timestamp'2010-1-1 06:40:03',
    item='Onion ',
    customer='Australian prowfish Food, Co.',
    qty=83,
    item_id=25,
    customer_id=49,
    unitprice=810,
    total=67230;
INSERT saleslog
SET dt=timestamp'2010-1-1 06:51:40',
    item='Olive ',
    customer='Porgy Food, Co.',
    qty=90,
    item_id=24,
    customer_id=712,
    unitprice=781,
    total=70290;
INSERT saleslog
SET dt=timestamp'2010-1-1 06:52:59',
    item='Sweet Potato ',
    customer='Atlantic cod Food, Co.',
    qty=6,
    item_id=35,
    customer_id=38,
    unitprice=650,
    total=3900;
INSERT saleslog
SET dt=timestamp'2010-1-1 07:09:00',
    item='Bok Choy ',
    customer='Sundaland noodlefish Food, Co.',
    qty=21,
    item_id=5,
    customer_id=970,
    unitprice=533,
    total=11193;
INSERT saleslog
SET dt=timestamp'2010-1-1 07:25:52',
    item='Parsnip ',
    customer='Blacktip reef shark Food, Co.',
    qty=95,
    item_id=26,
    customer_id=100,
    unitprice=336,
    total=31920;
INSERT saleslog
SET dt=timestamp'2010-1-1 07:47:33',
    item='Bok Choy ',
    customer='Pacific cod Food, Co.',
    qty=64,
    item_id=5,
    customer_id=647,
    unitprice=533,
    total=34112;
INSERT saleslog
SET dt=timestamp'2010-1-1 07:53:15',
    item='Celery ',
    customer='Lined sole Food, Co.',
    qty=47,
    item_id=13,
    customer_id=513,
    unitprice=536,
    total=25192;
INSERT saleslog
SET dt=timestamp'2010-1-1 08:16:55',
    item='Turnip ',
    customer='Smalltooth sawfish Food, Co.',
    qty=56,
    item_id=37,
    customer_id=897,
    unitprice=471,
    total=26376;
INSERT saleslog
SET dt=timestamp'2010-1-1 08:25:53',
    item='Potato ',
    customer='Cownose ray Food, Co.',
    qty=74,
    item_id=28,
    customer_id=229,
    unitprice=232,
    total=17168;
INSERT saleslog
SET dt=timestamp'2010-1-1 08:36:02',
    item='Spinach ',
    customer='Cichlid Food, Co.',
    qty=85,
    item_id=33,
    customer_id=194,
    unitprice=409,
    total=34765;
INSERT saleslog
SET dt=timestamp'2010-1-1 08:55:22',
    item='Olive ',
    customer='Fierasfer Food, Co.',
    qty=22,
    item_id=24,
    customer_id=328,
    unitprice=781,
    total=17182;
INSERT saleslog
SET dt=timestamp'2010-1-1 09:18:53',
    item='Garlic ',
    customer='Summer flounder Food, Co.',
    qty=43,
    item_id=19,
    customer_id=969,
    unitprice=484,
    total=20812;
INSERT saleslog
SET dt=timestamp'2010-1-1 09:47:06',
    item='Courgette ',
    customer='Lyretail Food, Co.',
    qty=22,
    item_id=15,
    customer_id=546,
    unitprice=251,
    total=5522;
INSERT saleslog
SET dt=timestamp'2010-1-1 10:13:23',
    item='Sweet Potato ',
    customer='Dottyback Food, Co.',
    qty=22,
    item_id=35,
    customer_id=279,
    unitprice=650,
    total=14300;
INSERT saleslog
SET dt=timestamp'2010-1-1 10:22:15',
    item='Olive ',
    customer='Zebra trout Food, Co.',
    qty=39,
    item_id=24,
    customer_id=1133,
    unitprice=781,
    total=30459;
INSERT saleslog
SET dt=timestamp'2010-1-1 10:34:01',
    item='Aubergine ',
    customer='Walu Food, Co.',
    qty=57,
    item_id=3,
    customer_id=1062,
    unitprice=294,
    total=16758;
INSERT saleslog
SET dt=timestamp'2010-1-1 10:38:06',
    item='Carrot ',
    customer='Barramundi Food, Co.',
    qty=10,
    item_id=10,
    customer_id=69,
    unitprice=460,
    total=4600;
INSERT saleslog
SET dt=timestamp'2010-1-1 10:52:33',
    item='Brussels Sprouts ',
    customer='Fire bar danio Food, Co.',
    qty=78,
    item_id=7,
    customer_id=333,
    unitprice=776,
    total=60528;
INSERT saleslog
SET dt=timestamp'2010-1-1 11:15:31',
    item='Spinach ',
    customer='Parrotfish Food, Co.',
    qty=48,
    item_id=33,
    customer_id=660,
    unitprice=409,
    total=19632;
INSERT saleslog
SET dt=timestamp'2010-1-1 11:24:12',
    item='Turnip ',
    customer='Blenny Food, Co.',
    qty=7,
    item_id=37,
    customer_id=112,
    unitprice=471,
    total=3297;
INSERT saleslog
SET dt=timestamp'2010-1-1 11:29:35',
    item='Tomato ',
    customer='Deep sea bonefish Food, Co.',
    qty=42,
    item_id=36,
    customer_id=256,
    unitprice=361,
    total=15162;
INSERT saleslog
SET dt=timestamp'2010-1-1 11:56:55',
    item='Okra ',
    customer='Black mackerel Food, Co.',
    qty=67,
    item_id=23,
    customer_id=101,
    unitprice=1046,
    total=70082;
INSERT saleslog
SET dt=timestamp'2010-1-1 12:14:49',
    item='Cabbage ',
    customer='Lionfish Food, Co.',
    qty=63,
    item_id=8,
    customer_id=516,
    unitprice=492,
    total=30996;
INSERT saleslog
SET dt=timestamp'2010-1-1 12:31:50',
    item='Squash ',
    customer='Mudfish Food, Co.',
    qty=38,
    item_id=34,
    customer_id=592,
    unitprice=190,
    total=7220;
INSERT saleslog
SET dt=timestamp'2010-1-1 12:38:35',
    item='Courgette ',
    customer='Clown loach Food, Co.',
    qty=22,
    item_id=15,
    customer_id=201,
    unitprice=251,
    total=5522;
INSERT saleslog
SET dt=timestamp'2010-1-1 12:48:54',
    item='Onion ',
    customer='Bangus Food, Co.',
    qty=37,
    item_id=25,
    customer_id=59,
    unitprice=810,
    total=29970;
INSERT saleslog
SET dt=timestamp'2010-1-1 13:14:24',
    item='Mushroom ',
    customer='Weever Food, Co.',
    qty=88,
    item_id=22,
    customer_id=1070,
    unitprice=347,
    total=30536;
INSERT saleslog
SET dt=timestamp'2010-1-1 13:34:12',
    item='Garlic ',
    customer='Yellow-edged moray Food, Co.',
    qty=73,
    item_id=19,
    customer_id=1098,
    unitprice=484,
    total=35332;
INSERT saleslog
SET dt=timestamp'2010-1-1 13:40:30',
    item='Cauliflower ',
    customer='Tidewater goby Food, Co.',
    qty=16,
    item_id=11,
    customer_id=1009,
    unitprice=565,
    total=9040;
INSERT saleslog
SET dt=timestamp'2010-1-1 13:42:58',
    item='Broccoli ',
    customer='Spotted dogfish Food, Co.',
    qty=89,
    item_id=6,
    customer_id=943,
    unitprice=1025,
    total=91225;
INSERT saleslog
SET dt=timestamp'2010-1-1 13:52:37',
    item='Dram sticks ',
    customer='Beluga sturgeon Food, Co.',
    qty=41,
    item_id=17,
    customer_id=81,
    unitprice=164,
    total=6724;
INSERT saleslog
SET dt=timestamp'2010-1-1 14:10:07',
    item='Corn ',
    customer='Flatfish Food, Co.',
    qty=15,
    item_id=14,
    customer_id=341,
    unitprice=739,
    total=11085;
INSERT saleslog
SET dt=timestamp'2010-1-1 14:30:17',
    item='Celery ',
    customer='Sandbar shark Food, Co.',
    qty=11,
    item_id=13,
    customer_id=809,
    unitprice=536,
    total=5896;
INSERT saleslog
SET dt=timestamp'2010-1-1 14:42:31',
    item='Peppers ',
    customer='Common tunny Food, Co.',
    qty=88,
    item_id=27,
    customer_id=220,
    unitprice=297,
    total=26136;
INSERT saleslog
SET dt=timestamp'2010-1-1 14:58:36',
    item='Mushroom ',
    customer='Rohu Food, Co.',
    qty=87,
    item_id=22,
    customer_id=779,
    unitprice=347,
    total=30189;
INSERT saleslog
SET dt=timestamp'2010-1-1 15:01:20',
    item='Okra ',
    customer='Squirrelfish Food, Co.',
    qty=84,
    item_id=23,
    customer_id=950,
    unitprice=1046,
    total=87864;
INSERT saleslog
SET dt=timestamp'2010-1-1 15:06:33',
    item='Spinach ',
    customer='Southern sandfish Food, Co.',
    qty=90,
    item_id=33,
    customer_id=924,
    unitprice=409,
    total=36810;
INSERT saleslog
SET dt=timestamp'2010-1-1 15:10:16',
    item='Onion ',
    customer='Zebra tilapia Food, Co.',
    qty=88,
    item_id=25,
    customer_id=1130,
    unitprice=810,
    total=71280;
INSERT saleslog
SET dt=timestamp'2010-1-1 15:32:41',
    item='Capsicum ',
    customer='Devil ray Food, Co.',
    qty=20,
    item_id=9,
    customer_id=267,
    unitprice=578,
    total=11560;
INSERT saleslog
SET dt=timestamp'2010-1-1 16:01:08',
    item='Asparagus ',
    customer='Blue danio Food, Co.',
    qty=24,
    item_id=2,
    customer_id=118,
    unitprice=103,
    total=2472;
INSERT saleslog
SET dt=timestamp'2010-1-1 16:13:19',
    item='Pumpkin ',
    customer='Sandperch Food, Co.',
    qty=6,
    item_id=29,
    customer_id=819,
    unitprice=639,
    total=3834;
INSERT saleslog
SET dt=timestamp'2010-1-1 16:28:45',
    item='Spinach ',
    customer='Jewel tetra Food, Co.',
    qty=64,
    item_id=33,
    customer_id=470,
    unitprice=409,
    total=26176;
INSERT saleslog
SET dt=timestamp'2010-1-1 16:53:37',
    item='Pumpkin ',
    customer='Oilfish Food, Co.',
    qty=51,
    item_id=29,
    customer_id=630,
    unitprice=639,
    total=32589;
INSERT saleslog
SET dt=timestamp'2010-1-1 16:57:16',
    item='Sweet Potato ',
    customer='Sandburrower Food, Co.',
    qty=5,
    item_id=35,
    customer_id=810,
    unitprice=650,
    total=3250;
INSERT saleslog
SET dt=timestamp'2010-1-1 17:00:58',
    item='Cabbage ',
    customer='Whiff Food, Co.',
    qty=12,
    item_id=8,
    customer_id=1076,
    unitprice=492,
    total=5904;
INSERT saleslog
SET dt=timestamp'2010-1-1 17:14:04',
    item='Onion ',
    customer='Eel cod Food, Co.',
    qty=63,
    item_id=25,
    customer_id=296,
    unitprice=810,
    total=51030;
INSERT saleslog
SET dt=timestamp'2010-1-1 17:25:44',
    item='Peas ',
    customer='Glass knifefish Food, Co.',
    qty=26,
    item_id=30,
    customer_id=386,
    unitprice=373,
    total=9698;
INSERT saleslog
SET dt=timestamp'2010-1-1 17:53:06',
    item='Cucumber ',
    customer='Rough pomfret Food, Co.',
    qty=15,
    item_id=16,
    customer_id=783,
    unitprice=472,
    total=7080;
INSERT saleslog
SET dt=timestamp'2010-1-1 18:03:35',
    item='Aubergine ',
    customer='Chimaera Food, Co.',
    qty=90,
    item_id=3,
    customer_id=188,
    unitprice=294,
    total=26460;
INSERT saleslog
SET dt=timestamp'2010-1-1 18:05:16',
    item='Yam',
    customer='Hammerjaw Food, Co.',
    qty=39,
    item_id=39,
    customer_id=439,
    unitprice=790,
    total=30810;
INSERT saleslog
SET dt=timestamp'2010-1-1 18:09:41',
    item='Tomato ',
    customer='Northern lampfish Food, Co.',
    qty=18,
    item_id=36,
    customer_id=616,
    unitprice=361,
    total=6498;
INSERT saleslog
SET dt=timestamp'2010-1-1 18:13:50',
    item='Olive ',
    customer='Cowfish Food, Co.',
    qty=26,
    item_id=24,
    customer_id=228,
    unitprice=781,
    total=20306;
INSERT saleslog
SET dt=timestamp'2010-1-1 18:23:39',
    item='Cabbage ',
    customer='Goldspotted killifish Food, Co.',
    qty=73,
    item_id=8,
    customer_id=397,
    unitprice=492,
    total=35916;
INSERT saleslog
SET dt=timestamp'2010-1-1 18:29:46',
    item='Bok Choy ',
    customer='Old World knifefish Food, Co.',
    qty=34,
    item_id=5,
    customer_id=632,
    unitprice=533,
    total=18122;
INSERT saleslog
SET dt=timestamp'2010-1-1 18:35:10',
    item='Carrot ',
    customer='Crocodile icefish Food, Co.',
    qty=73,
    item_id=10,
    customer_id=236,
    unitprice=460,
    total=33580;
INSERT saleslog
SET dt=timestamp'2010-1-1 18:39:23',
    item='Celeriac ',
    customer='Mozambique tilapia Food, Co.',
    qty=39,
    item_id=12,
    customer_id=590,
    unitprice=462,
    total=18018;
INSERT saleslog
SET dt=timestamp'2010-1-1 19:04:22',
    item='Peppers ',
    customer='Atlantic herring Food, Co.',
    qty=1,
    item_id=27,
    customer_id=40,
    unitprice=297,
    total=297;
INSERT saleslog
SET dt=timestamp'2010-1-1 19:10:06',
    item='Celery ',
    customer='Ridgehead Food, Co.',
    qty=12,
    item_id=13,
    customer_id=762,
    unitprice=536,
    total=6432;
INSERT saleslog
SET dt=timestamp'2010-1-1 19:10:49',
    item='Cabbage ',
    customer='Ghoul Food, Co.',
    qty=84,
    item_id=8,
    customer_id=375,
    unitprice=492,
    total=41328;
INSERT saleslog
SET dt=timestamp'2010-1-1 19:30:12',
    item='Carrot ',
    customer='Flashlight fish Food, Co.',
    qty=46,
    item_id=10,
    customer_id=340,
    unitprice=460,
    total=21160;
INSERT saleslog
SET dt=timestamp'2010-1-1 19:48:35',
    item='Garlic ',
    customer='Pygmy sunfish Food, Co.',
    qty=94,
    item_id=19,
    customer_id=723,
    unitprice=484,
    total=45496;
INSERT saleslog
SET dt=timestamp'2010-1-1 20:02:15',
    item='Shallots ',
    customer='Dwarf loach Food, Co.',
    qty=14,
    item_id=32,
    customer_id=291,
    unitprice=331,
    total=4634;
INSERT saleslog
SET dt=timestamp'2010-1-1 20:20:09',
    item='Pumpkin ',
    customer='Blue-redstripe danio Food, Co.',
    qty=46,
    item_id=29,
    customer_id=119,
    unitprice=639,
    total=29394;
INSERT saleslog
SET dt=timestamp'2010-1-1 20:32:12',
    item='Artichokes ',
    customer='Rio Grande perch Food, Co.',
    qty=33,
    item_id=1,
    customer_id=765,
    unitprice=957,
    total=31581;
INSERT saleslog
SET dt=timestamp'2010-1-1 20:42:44',
    item='Peppers ',
    customer='Bluegill Food, Co.',
    qty=55,
    item_id=27,
    customer_id=123,
    unitprice=297,
    total=16335;
INSERT saleslog
SET dt=timestamp'2010-1-1 20:48:21',
    item='Asparagus ',
    customer='Freshwater eel Food, Co.',
    qty=25,
    item_id=2,
    customer_id=354,
    unitprice=103,
    total=2575;
INSERT saleslog
SET dt=timestamp'2010-1-1 21:13:25',
    item='Carrot ',
    customer='Grunt Food, Co.',
    qty=1,
    item_id=10,
    customer_id=417,
    unitprice=460,
    total=460;
INSERT saleslog
SET dt=timestamp'2010-1-1 21:41:35',
    item='Brussels Sprouts ',
    customer='Warmouth Food, Co.',
    qty=45,
    item_id=7,
    customer_id=1064,
    unitprice=776,
    total=34920;
INSERT saleslog
SET dt=timestamp'2010-1-1 22:02:29',
    item='Cucumber ',
    customer='Canthigaster rostrata Food, Co.',
    qty=4,
    item_id=16,
    customer_id=860,
    unitprice=472,
    total=1888;
INSERT saleslog
SET dt=timestamp'2010-1-1 22:24:34',
    item='Peppers ',
    customer='Deep sea anglerfish Food, Co.',
    qty=41,
    item_id=27,
    customer_id=255,
    unitprice=297,
    total=12177;
INSERT saleslog
SET dt=timestamp'2010-1-1 22:36:34',
    item='Capsicum ',
    customer='Triplefin blenny Food, Co.',
    qty=90,
    item_id=9,
    customer_id=1031,
    unitprice=578,
    total=52020;
INSERT saleslog
SET dt=timestamp'2010-1-1 22:51:40',
    item='Shallots ',
    customer='Bala shark Food, Co.',
    qty=55,
    item_id=32,
    customer_id=53,
    unitprice=331,
    total=18205;
INSERT saleslog
SET dt=timestamp'2010-1-1 23:03:16',
    item='Carrot ',
    customer='Oriental loach Food, Co.',
    qty=9,
    item_id=10,
    customer_id=643,
    unitprice=460,
    total=4140;
INSERT saleslog
SET dt=timestamp'2010-1-1 23:29:13',
    item='Carrot ',
    customer='Cepalin Food, Co.',
    qty=5,
    item_id=10,
    customer_id=182,
    unitprice=460,
    total=2300;
INSERT saleslog
SET dt=timestamp'2010-1-1 23:52:34',
    item='Courgette ',
    customer='Snubnose parasitic eel Food, Co.',
    qty=5,
    item_id=15,
    customer_id=913,
    unitprice=251,
    total=1255;

INSERT information
SET id=1,
    lastupdated=CURDATE();

CREATE VIEW saleslog_summary AS
SELECT SUBSTRING(customer, 1, 1) AS customer,
       SUBSTRING(item, 1, 1)     AS item,
       SUM(qty)                  AS qty,
       SUM(total)                AS total
FROM saleslog
GROUP BY SUBSTRING(customer, 1, 1), SUBSTRING(item, 1, 1);

CREATE TABLE alphabet
(
    id INT AUTO_INCREMENT,
    c  VARCHAR(1),
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4,
  COLLATE utf8mb4_unicode_ci
  ENGINE = InnoDB;

INSERT alphabet(c)
VALUES ('A'),
       ('B'),
       ('C'),
       ('D'),
       ('E'),
       ('F'),
       ('G'),
       ('H'),
       ('I'),
       ('J'),
       ('K'),
       ('L'),
       ('M'),
       ('N'),
       ('O'),
       ('P'),
       ('Q'),
       ('R'),
       ('S'),
       ('T'),
       ('U'),
       ('V'),
       ('W'),
       ('X'),
       ('Y'),
       ('Z');
