Python
==========
## Python2.7 インストール

---
    sudo su
    vi ~/.bashrc
    ===========================
    ...
    export PATH=/usr/local/bin:${PATH}
    ===========================
    source ~/.bashrc
    yum groupinstall -y "Development tools"
    yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel
    cd /usr/local/src
    wget http://python.org/ftp/python/2.7.8/Python-2.7.8.tgz
    tar zxf Python-2.7.8.tgz
    cd Python-2.7.8
    ### default python setting option "--enable-shared"
    ### ./configure --prefix=/usr/local --enable-shared
    ./configure --prefix=/usr/local --enable-shared
    make
    make altinstall
    ln -s /usr/local/src/Python-2.7.8/libpython2.7.so.1.0 /lib64
    ln -s /usr/local/bin/python2.7 /usr/local/bin/python
    

## Python3.4 インストール

---
    wget http://python.org/ftp/python/3.4.1/Python-3.4.1.tgz
    tar zxf Python-3.4.1.tgz
    cd Python-3.4.1
    ./configure --prefix=/usr/local
    make
    make altinstall

## [pipインストール](http://qiita.com/a_yasui/items/5f453297855791ed648d)

---
    # curl -kL https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python
    wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
    /usr/local/bin/python2.7 get-pip.py

## virtualenv インストール

---
    pip install virtualenv
    export VIRTUALENV_USE_DISTRIBUTE=true

## virtualenvwrapper インストール
    pip install virtualenvwrapper
    export WORKON_HOME=$HOME/.virtualenvs
    cat <<\__EOT__ >> ~/.bashrc
    source /usr/local/bin/virtualenvwrapper.sh
    __EOT__
    



## リンク
