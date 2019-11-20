echo "add epel-release repository..."
sudo yum install epel-release
echo "run yum update..."
yum update
echo "install nginx..."
sudo yum -y install nginx

echo "set PATH variables"
export HOSTNAME=$(hostname | tr -d '\n')
export PRIVATE_IP=$(curl -sf -H 'Metadata-Flavor:Google' http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip | tr -d '\n')


echo "Welcome to $HOSTNAME - $PRIVATE_IP" > /usr/share/nginx/www/index.html

echo "start nginx server..."

service nginx start

echo "output nginx version.."
echo "$(sudo nginx -v)"