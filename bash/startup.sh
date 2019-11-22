echo "################################################################################"
echo "              GET BASE ARCHITECTURE AND SET TO BASEARCH"
echo "################################################################################"
basearch=$(rpm -q --qf "%{arch}" -f /etc/$distro)

sudo cat <<EOT >> /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=https://nginx.org/packages/mainline/centos/7/$basearch/
gpgcheck=0
enabled=1
EOT

echo "################################################################################"
echo "\tRUN YUM UPDATE"
echo "################################################################################"
sudo yum update

echo "################################################################################"
echo "              INSTALL NANO"
echo "################################################################################"
sudo yum -y- install nano

echo "################################################################################"
echo "              INSTALL NGXINX"
echo "################################################################################"
sudo yum -y install nginx

echo "################################################################################"
echo "              NGINX VERSION: $(sudo nginx -v) INSTALLED"
echo "################################################################################"

nginxpid="/run/nginx.pid;"
replacewith="/var/run/nginx.pid;"
echo "################################################################################"
echo "\tUPDATE NGINX.PID FROM '$nginxpid' TO '$replacewith'"
echo "################################################################################"
sudo sed -i 's/$nginxpid/$replacewith/g' /etc/nginx/nginx.conf

echo "################################################################################"
echo "                      ENABLE NGINX SERVICE"
echo "################################################################################"
sudo systemctl enable nginx

echo "################################################################################"
echo "                      START NGINX SERVER"
echo "################################################################################"
sudo systemctl start nginx

echo "################################################################################"
echo "                  VERIFY pygme AND yum-utils ARE INSTALLED"
echo "################################################################################"
sudo yum -y install pygpgme yum-utils

echo "################################################################################"
echo "                      CONFIGURE VARNISH REPOSITORY"
echo "################################################################################"
sudo cat <<EOT >> /etc/yum.repos.d/varnishcache_varnish52.repo
[varnishcache_varnish52]
name=varnishcache_varnish52
baseurl=https://packagecloud.io/varnishcache/varnish52/el/7/$basearch
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packagecloud.io/varnishcache/varnish52/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300

[varnishcache_varnish52-source]
name=varnishcache_varnish52-source
baseurl=https://packagecloud.io/varnishcache/varnish52/el/7/SRPMS
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packagecloud.io/varnishcache/varnish52/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300
EOT

echo "################################################################################"
echo "                  UPDATE YUM CACHE BEFORE INSTALL"
echo "################################################################################"
sudo yum -q makecache -y --disablerepo='*' --enablerepo='varnishcache_varnish52'

echo "################################################################################"
echo "                          INSTALL VARNISH"
echo "################################################################################"
sudo yum -y install varnish

echo "################################################################################"
echo "                          VERIFY VARNISH VERSION:"
echo "$(varnishd -V)"
echo "################################################################################"
echo "                          START VARNISH"
echo "################################################################################"
sudo service varnish start

echo "################################################################################"
echo "                          Everything finished, bye!"
echo "################################################################################"