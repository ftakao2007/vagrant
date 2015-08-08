virtualenv の使い方
==========

---
    [環境の作成]
    mkvirtualenv (newenv)
    
    [環境の利用]
    workon (newenv)
    
    [環境の一覧表示]
    workon
    
    [環境から抜ける]
    deactivate
    
    [環境の削除]
    rmvirtualenv (newenv)
    
    [例] Python2.7とPython3.4環境の作成と利用
    mkvirtualenv --python=/usr/local/bin/python2.7 python2.7
    mkvirtualenv --python=/usr/local/bin/python3.4 python3.4
    
    (python3.4)[vagrant@vagrant-centos65 ~]$ python -V
    Python 3.4.1
    (python3.4)[vagrant@vagrant-centos65 ~]$ workon python2.7
    (python2.7)[vagrant@vagrant-centos65 ~]$ python -V
    Python 2.7.8
    (python2.7)[vagrant@vagrant-centos65 ~]$ deactivate
    [vagrant@vagrant-centos65 ~]$ workon
    python2.7
    python3.4
    [vagrant@vagrant-centos65 ~]$

## リンク
