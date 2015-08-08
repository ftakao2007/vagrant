vagrant
==========
## インストール
[ここ](http://www.vagrantup.com/)からダウンロードする

## [仮想マシンからBoxファイルを作り直す](http://momijiame.tumblr.com/post/65429388802/vagrant-box)
---
    vagrant halt node1
    vagrant package node1
    vagrant box add mycentos65 package.box
