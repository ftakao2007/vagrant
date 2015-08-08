Serf
==========
## インストール
[ここ](http://www.serfdom.io/downloads.html)からダウンロードする

201407現在以下でインストール可能。

---
    wget https://dl.bintray.com/mitchellh/serf/0.6.3_linux_amd64.zip
    unzip 0.6.3_linux_amd64.zip
    ls -lh /usr/local/bin/serf       # serfが無いことを確認
    sudo mv serf /usr/local/bin
    which serf

wgetは入ってなければ`sudo yum install -y wget`で入れておく。

## 起動

---
    [node1]
    serf agent -iface=eth1 -node=node1 &
    [node2]
    serf agent -iface=eth1 -node=node2 &
    serf join 192.168.33.11     # node1のIPアドレス
    serf members # node1, node2がメンバーになっていることを確認する
    serf monitor  # ログの確認


### 起動(マルチキャストDNS)
serf joinしなくても自動でクラスタに参加する

---
    [node1]
    serf agent -iface=eth1 -node=node1  -discover=webapp &
    [node2]
    serf agent -iface=eth1 -node=node2  -discover=webapp &
    serf members # node1, node2がメンバーになっていることを確認する
    serf monitor  # ログの確認

## テスト
---
    serf event 'Hello World'

どこで実行してもHello Worldが表示される

## [serf-hosts](https://github.com/kentaro/serf-hosts)
/etc/hostsを自動管理する。うまく動かなかったので[shellscript版](http://blog.manabusakai.com/2014/01/serf-hosts-for-shell-script/)を利用

### 使い方
---
    [node1]
    wget https://gist.githubusercontent.com/manabusakai/8266181/raw/c2414cddc3648c8e5003d9fd2503653f9941b8eb/event_handler.sh
    chmod 755 event_handler.sh
    sudo /usr/local/bin/serf agent -iface=eth1 -node=node1 -discover=webapp -event-handler=./event_handler.sh &
    cat /etc/hosts    # /etc/hostsにnode1追加されている事を確認

    [node2]
    wget https://gist.githubusercontent.com/manabusakai/8266181/raw/c2414cddc3648c8e5003d9fd2503653f9941b8eb/event_handler.sh
    chmod 755 event_handler.sh
    sudo /usr/local/bin/serf agent -iface=eth1 -node=node2 -event-handler=./event_handler.sh &
    sudo /usr/local/bin/serf join 192.168.33.11   # node1のIPアドレス。joinでnode2の/etc/hostsに反映される
    cat /etc/hosts    # /etc/hostsにnode1, node2が追加されている事を確認

    [node1]
    cat /etc/hosts    # /etc/hostsにnode1, node2が追加されている事を確認

## オプション
* -log-level=debug : デバッグモード

## リンク
* [「hbstudy#60 SerfとConsulでシステム運用を楽し>くしよう！」に行ってきました＆Serf試してみまし>た](http://blog.pg1x.com/entry/2014/07/21/231327)
* [Serf Cheat Sheet 日本語版](http://qiita.com/zembutsu/items/1e2cddd0a424ef7a4895)
* [Serfが面白いと俺の中で話題にwwwwww 【改訂版】](http://www.slideshare.net/zembutsu/serf-the-liberator-2nd)
* [kentaro/serf-hosts](https://github.com/kentaro/serf-hosts)
*  [serf-hostsを試してみた](http://blog.hifumi.info/2014/07/27/try-serf-hosts/)
* [serf-hosts をシェルスクリプトで書き直した](http://blog.manabusakai.com/2014/01/serf-hosts-for-shell-script/)
