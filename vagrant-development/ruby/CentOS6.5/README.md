Ruby
==========
## [rbenvインストール(システムワイド)](http://office.tsukuba-bunko.org/ppoi/entry/systemwide-rbenv)

---
    sudo su
    export RBENV_ROOT=/usr/local/rbenv
    export PATH=${RBENV_ROOT}/bin:${PATH}
    git clone git://github.com/sstephenson/rbenv.git ${RBENV_ROOT}
    git clone git://github.com/sstephenson/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build
    rbenv init -
    vi ~/.bashrc
    ===========================
    ...
    export RBENV_ROOT=/usr/local/rbenv
    export PATH=${RBENV_ROOT}/bin:${PATH}
    eval "$(rbenv init -)"
    ===========================
    rbenv -v
    echo "execute 'source ~/.bashrc'"

## ruby インストール

---
    sudo su
    ### http://qiita.com/legnoh/items/835ad5d1fa06a333348e
    yum install -y openssl-devel readline-devel zlib-devel curl-devel libyaml-devel
    ruby_version=2.1.2
    rbenv install $ruby_version
    rbenv global $ruby_version
    rbenv rehash

## bundlerインストール
---
    gem install bundler --no-rdoc --no-ri
    rbenv rehash
    rbenv exec gem list


## rbenvインストール(個人ユーザ)
## ruby インストール
## リンク
