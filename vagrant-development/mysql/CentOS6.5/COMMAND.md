MySQL コマンド
==========
## ログイン
---
    [rootでログイン]
    mysql -uroot -p
    
    [リモート接続]
    mysql -u[ユーザ名] -p [データベース名]　-h [ホスト名] -P [ポート番号]

## ユーザ操作
---
    [ユーザ作成]
    grant all on [データベース名].* to [ユーザ名]@localhost;
    flush privileges;
    set password for [ユーザ名]@localhost=password('パスワード');
    
    [ユーザ確認]
    select host,user from mysql.user;
    
    [ユーザ削除]
    delete from mysql.user where user='ユーザ名';
    revoke all privileges on *.* from [ユーザ名];

## データベース操作
---
    [作成]
    create database [データベース名] character set utf8
    
    [確認]
    show databases;
    
    [接続]
    use [データベース名]
    
    [接続しているデータベースの確認]
    select databases();
    
    [削除]
    drop database [データベース名];

## テーブル操作
---
    [作成]
    create table [テーブル名] (カラム名1 データタイプ1, カラム名2 データタイプ2, ...);
    
    [一覧表示]
    show tables;
    show tables from [データベース名];

    [テーブルの中身を確認]
    select * from [テーブル名];
    
    [テーブルの定義を確認]
    desc [テーブル名];
    
