vagrant (network)
==========
# ネットワーク
ネットワークについて

## [Vagrantのネットワーク周りのあれこれ](http://labs.septeni.co.jp/?p=966)
### 提供されているネットワーク機能
* ホストオンリーアダプタ  
仮想ネットワークインターフェイスを作成し、ホストOSとゲストOSの間での閉じたネットワークを形成できる。ゲストOSとホストOSでのみの通信なのでゲストOS間の通信などはできない。  
* NAT  
ゲストOSからホストOSを介して外部のネットワークに接続することができる。外部ネットワークからゲストOSへはアクセスできないため、ゲストOSのセキュリティ上の安全を保つことができる。  
* ブリッジアダプタ  
ゲストOSがホストOSと同じネットワークを使用できる。ホストOSとは別の独立したマシンのようにネットーワーク上では存在する。外部ネットワークにさらされる状況もホストOSと同じなためセキュリティを考慮する必要がある。  

これらのVitualBoxのネットワーク機能をVagrantでは目的に応じてより簡単に利用することができる。  

* プライベートネットワーク  
ホストOSとゲストOS間でのみ通信が行える。ホストオンリーアダプタやゲストOS間のみのネットワーク設定など。  
* ポートフォワーディング  
ホストOSへの特定のポートを使った接続をゲストOSに転送する  
* パブリックネットワーク  
同一ネットワーク内のどの端末からでもゲストOSと通信が行える

## プライベートネットワーク例
Vagrantfileに特別なnetwork設定を入れずに立ち上げる。

---
    [Vagrantfile1]
    
    [ifconfig -a]
    eth0      Link encap:Ethernet  HWaddr 08:00:27:4F:B8:06
              inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
              inet6 addr: fe80::a00:27ff:fe4f:b806/64 Scope:Link
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:279 errors:0 dropped:0 overruns:0 frame:0
              TX packets:171 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:28941 (28.2 KiB)  TX bytes:22442 (21.9 KiB)
    
    lo        Link encap:Local Loopback
              inet addr:127.0.0.1  Mask:255.0.0.0
              inet6 addr: ::1/128 Scope:Host
              UP LOOPBACK RUNNING  MTU:16436  Metric:1
              RX packets:0 errors:0 dropped:0 overruns:0 frame:0
              TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:0
              RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
    
    [netstat -rn]
    Kernel IP routing table
    Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
    10.0.2.0        0.0.0.0         255.255.255.0   U         0 0          0 eth0
    169.254.0.0     0.0.0.0         255.255.0.0     U         0 0          0 eth0
    0.0.0.0         10.0.2.2        0.0.0.0         UG        0 0          0 eth0

ホストオンリーアダプタ。vagrant ssh でのみVMにアクセスできる状態。通常のsshコマンドなどで接続することはできない。10.0.2.15はvagrant ssh用のアドレス。

## sshでゲストOSに接続できるようにする
---
    [Vagrantfile2]
    
    [ifconfig -a]
    eth0      Link encap:Ethernet  HWaddr 08:00:27:4F:B8:06
              inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
              inet6 addr: fe80::a00:27ff:fe4f:b806/64 Scope:Link
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:354 errors:0 dropped:0 overruns:0 frame:0
              TX packets:225 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:38643 (37.7 KiB)  TX bytes:31054 (30.3 KiB)
    
    eth1      Link encap:Ethernet  HWaddr 08:00:27:05:89:53
              inet addr:192.168.33.201  Bcast:192.168.33.255  Mask:255.255.255.0
              inet6 addr: fe80::a00:27ff:fe05:8953/64 Scope:Link
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:2 errors:0 dropped:0 overruns:0 frame:0
              TX packets:7 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:84 (84.0 b)  TX bytes:482 (482.0 b)
    
    lo        Link encap:Local Loopback
              inet addr:127.0.0.1  Mask:255.0.0.0
              inet6 addr: ::1/128 Scope:Host
              UP LOOPBACK RUNNING  MTU:16436  Metric:1
              RX packets:0 errors:0 dropped:0 overruns:0 frame:0
              TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:0
              RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
    
    [netstat -rn]
    Kernel IP routing table
    Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
    10.0.2.0        0.0.0.0         255.255.255.0   U         0 0          0 eth0
    192.168.33.0    0.0.0.0         255.255.255.0   U         0 0          0 eth1
    169.254.0.0     0.0.0.0         255.255.0.0     U         0 0          0 eth0
    169.254.0.0     0.0.0.0         255.255.0.0     U         0 0          0 eth1
    0.0.0.0         10.0.2.2        0.0.0.0         UG        0 0          0 eth0
    
    MacBook-Air:test ftakao2007$ ssh 192.168.33.201 -l vagrant
    vagrant@192.168.33.201's password:
    Last login: Sun Aug  3 01:32:26 2014 from 10.0.2.2
    [vagrant@vagrant-centos65 ~]$

sshでホストからアクセス可能。

### ゲストOS同士のみ通信できる設定
---
    [Vagrantfile3]
    
    [ifconfig -a]
    eth0      Link encap:Ethernet  HWaddr 08:00:27:4F:B8:06
              inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
              inet6 addr: fe80::a00:27ff:fe4f:b806/64 Scope:Link
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:371 errors:0 dropped:0 overruns:0 frame:0
              TX packets:241 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:39596 (38.6 KiB)  TX bytes:31968 (31.2 KiB)
    
    eth1      Link encap:Ethernet  HWaddr 08:00:27:05:89:53
              inet addr:192.168.33.201  Bcast:192.168.33.255  Mask:255.255.255.0
              inet6 addr: fe80::a00:27ff:fe05:8953/64 Scope:Link
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:6 errors:0 dropped:0 overruns:0 frame:0
              TX packets:12 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:252 (252.0 b)  TX bytes:856 (856.0 b)
    
    lo        Link encap:Local Loopback
              inet addr:127.0.0.1  Mask:255.0.0.0
              inet6 addr: ::1/128 Scope:Host
              UP LOOPBACK RUNNING  MTU:16436  Metric:1
              RX packets:0 errors:0 dropped:0 overruns:0 frame:0
              TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:0
              RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
    
    [netstat -rn]
    Kernel IP routing table
    Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
    10.0.2.0        0.0.0.0         255.255.255.0   U         0 0          0 eth0
    192.168.33.0    0.0.0.0         255.255.255.0   U         0 0          0 eth1
    169.254.0.0     0.0.0.0         255.255.0.0     U         0 0          0 eth0
    169.254.0.0     0.0.0.0         255.255.0.0     U         0 0          0 eth1
    0.0.0.0         10.0.2.2        0.0.0.0         UG        0 0          0 eth0

ノード間通信のみ可能となる。ホストからはvagrant sshではアクセス可能。

### ポートフォワーディング設定
---
    [Vagrantfile4]
    node.vm.network :forwarded_port, guest:22, host:2191, id:"ssh"
    node.vm.network :forwarded_port, guest:80, host:8190, id:"http"
    node.vm.network :private_network, ip:"192.168.33.201"

ホストから`ssh 127.0.0.1 -l vagrant -p 2191` でアクセス可能。また`ssh 192.168.33.201 -l vagrant -p 22` でもアクセス可能。Webはホストから`http://127.0.0.1:8190` もしくは `http://192.168.33.201:80` でアクセス可能。実際ホスト側でlsofを実行するとLISTEN状態になっている。

---
    MacBook-Air:test ftakao2007$ lsof -i :2191
    COMMAND     PID       USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
    VBoxHeadl 22961 ftakao2007   19u  IPv4 0xbc244e4955942725      0t0  TCP *:tvbus (LISTEN)
    MacBook-Air:test ftakao2007$ lsof -i :8190
    COMMAND     PID       USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
    VBoxHeadl 22961 ftakao2007   20u  IPv4 0xbc244e4957cb0f0d      0t0  TCP *:8190 (LISTEN)

### パブリックネットワーク設定
外部ネットワーク(Macの外)から直接ゲストOSにアクセス可能になる。
---
    [Vagrantfile5]
    
    [ifconfig -a]
    eth0      Link encap:Ethernet  HWaddr 08:00:27:4F:B8:06
              inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
              inet6 addr: fe80::a00:27ff:fe4f:b806/64 Scope:Link
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:377 errors:0 dropped:0 overruns:0 frame:0
              TX packets:241 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:39814 (38.8 KiB)  TX bytes:32898 (32.1 KiB)
    
    eth1      Link encap:Ethernet  HWaddr 08:00:27:05:89:53
              inet addr:172.20.10.2  Bcast:172.20.10.15  Mask:255.255.255.240
              inet6 addr: fe80::a00:27ff:fe05:8953/64 Scope:Link
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:183 errors:0 dropped:0 overruns:0 frame:0
              TX packets:124 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:21341 (20.8 KiB)  TX bytes:18538 (18.1 KiB)
    
    lo        Link encap:Local Loopback
              inet addr:127.0.0.1  Mask:255.0.0.0
              inet6 addr: ::1/128 Scope:Host
              UP LOOPBACK RUNNING  MTU:16436  Metric:1
              RX packets:0 errors:0 dropped:0 overruns:0 frame:0
              TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:0
              RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
    
    [netstat -rn]
    Kernel IP routing table
    Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
    172.20.10.0     0.0.0.0         255.255.255.240 U         0 0          0 eth1
    10.0.2.0        0.0.0.0         255.255.255.0   U         0 0          0 eth0
    169.254.0.0     0.0.0.0         255.255.0.0     U         0 0          0 eth0
    169.254.0.0     0.0.0.0         255.255.0.0     U         0 0          0 eth1
    0.0.0.0         172.20.10.1     0.0.0.0         UG        0 0          0 eth1

外部ネットワークから接続できるようにするための設定。en3はiPhoneのUSB接続でネットワークに接続するとき。en0はWi-Fiで接続するときの設定。Bluetoothだとまたインターフェースが変わるはず。またMacBookAirとProによるインタフェースの違いもあるようなので注意。はじめはbridgeオプション無しで試してみると良いかも。IPアドレスを指定して起動すると、ゲスト側ではちゃんと設定できているように見えるが、ホスト側や外部ネットワークからは接続できなかった。DHCPで自動的に割り当てられたIPアドレスだとアクセスできる。


## [SSH設定](http://lab.raqda.com/vagrant/vagrantfile/ssh_settings.html)

### config.ssh.forward_agent
trueの場合、SSH Agent Forwarding が有効になる。 デフォルト値は false。  
* [SSH Agent Forwarding](http://qiita.com/yudoufu/items/82f752807893c63f06db)
多段sshするときに楽になる設定

## [public_network に固定 IP アドレスを付与する](http://momijiame.tumblr.com/post/65525042320/vagrant-public-network-ip)

---
    config.vm.network :public_network, ip:"10.49.1.11", netmask:"255.255.255.0", bridge:"en0: Wi-Fi (AirPort)"
