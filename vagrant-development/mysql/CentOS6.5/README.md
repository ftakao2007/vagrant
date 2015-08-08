MySQL
==========
# MySQL(5.1.73)
## インストールと起動

201407現在以下でインストール可能。

---
    sudo yum install -y http://ftp.jaist.ac.jp/pub/mysql/Downloads/MySQL-5.7/MySQL-client-5.7.4_m14-1.el6.x86_64.rpm \
    http://ftp.jaist.ac.jp/pub/mysql/Downloads/MySQL-5.7/MySQL-devel-5.7.4_m14-1.el6.x86_64.rpm \
    http://ftp.jaist.ac.jp/pub/mysql/Downloads/MySQL-5.7/MySQL-server-5.7.4_m14-1.el6.x86_64.rpm \
    http://ftp.jaist.ac.jp/pub/mysql/Downloads/MySQL-5.7/MySQL-shared-compat-5.7.4_m14-1.el6.x86_64.rpm \
    http://ftp.jaist.ac.jp/pub/mysql/Downloads/MySQL-5.7/MySQL-shared-5.7.4_m14-1.el6.x86_64.rpm
    sudo service mysql start

## DBとユーザ作成
hogeというDBを作成。ftakao2007というユーザ。
パスワードは1234。  
rootパスワードは`sudo cat /root/.mysql_secret`で確認し、
mysqlにログインしたあと5678に変更

---
    mysql -uroot -p
    mysql> set password for root@localhost=password('5678');
    mysql> \q
    
    vi mysql_create_hoge_db.sql
    ===========================
    create database hoge character set utf8
    ===========================
    mysql -uroot -p5678 < mysql_create_hoge_db.sql
    
    vi mysql_create_ftakao2007_user.sql
    ===========================
    create user 'ftakao2007'@'localhost' identified by '1234';
    grant all privileges on hoge.* to 'ftakao2007'@'localhost';
    ===========================
    mysql -uroot -p5678 < mysql_create_ftakao2007_user.sql

## DB確認

---
    mysql -uftakao2007 -p1234
    mysql> show databases;
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema |
    | hoge               |
    | mysql              |
    | performance_schema |
    +--------------------+
    4 rows in set (0.02 sec)

## リンク
[CentOS 6.3 に MySQL 5.6 をインストールしてみた](http://d.hatena.ne.jp/akishin999/20130207/1360241401)
