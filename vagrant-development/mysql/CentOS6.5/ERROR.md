MySQL エラー対応
==========
## [Your password has expired. To log in you must change it using a client that supports expired passwords](http://qiita.com/nandai@github/items/e43e8aaee181c8838bb2)

新しいパスワードを設定する。以下はパスワードを5678に設定する例

---
    mysql -u root -p
    mysql> set password for root@localhost=password('5678');

## [mysql: [Warning] Using a password on the command line interface can be insecure.](http://heartbeats.jp/hbblog/2010/03/mysql-p.html)

---
    [vagrant@vagrant-centos65 ~]$ mysql -uroot -p5678 < mysql_create_fuga_db.sql
    mysql: [Warning] Using a password on the command line interface can be insecure.

以下のようにするとWarningが出ない

--- 
    [vagrant@vagrant-centos65 ~]$ mysql --defaults-file=<( printf '[client]\npassword=%s\n' 5678 ) -uroot < mysql_create_haga_db.sql
