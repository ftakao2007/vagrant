Jenkins
==========
# Jenkins(1.573)
## インストールと起動

201407現在以下でインストール可能。

---
    sudo vi /etc/hosts   # `uname -n`と`ifconfig`から自ホストの設定を追加
    ===========================
    ...
    192.168.33.11 vagrant-centos65.vagrantup.com
    ===========================
    wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
    rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
    yum install -y jenkins
    yum install -y java-1.7.0-openjdk
    chown -R jenkins:jenkins /usr/lib/jenkins
    vi /etc/sysconfig/jenkins
    ===========================
    ...
    JENKINS_PORT="8080"
    ...
    JENKINS_ARGS="--webroot=/usr/lib/jenkins/war --httpPort=$JENKINS_PORT"
    ===========================
    service jenkins start
    chkconfig jenkins on

wgetは入ってなければ`sudo yum install -y wget`で入れておく。

### 動かない時は直接起動
---
    java -jar /usr/lib/jenkins/jenkins.war --httpPort=8080

### Webブラウザでアクセス
http://192.168.33.11:8080

## 設定、プラグイン追加
gitインストール  
githubと連携

## バックアップ
プラグインや認証は別途設定。  
JENKINS_HOMEは/var/lib/jenkinsとする。

---
    [バックアップ元]
    cd /var/lib/jenkins
    sudo tar zcvf xml.tar.gz *xml
    sudo tar zcvf userContent.tar.gz userContent
    sudo tar zcvf jobs.tar.gz jobs
    # tar.gzファイルをリストア先の/var/lib/jenkinsに移動させておく
    
    [リストア先]
    cd /var/lib/jenkins
    sudo tar zxvf xml_org.tar.gz *xml    # バックアップ
    sudo mv job job_org
    sudo mv userContent userContent_org
    sudo -u jenkins -H tar zxvf xml.tar.gz
    sudo -u jenkins -H tar zxvf jobs.tar.gz
    sudo -u jenkins -H tar zxvf userContent.tar.gz

jenkinsを再起動すると反映される

## リンク
[Jenkinsのバックアップとリストアについてメモ](http://qiita.com/tq_jappy/items/3654059d09a4896ae598)
