TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")


AMI_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/ami-id)

INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
PUBLIC_IPV4=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4)
MAC=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/mac)
REGION=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/region)
TYPE=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/instance-type)

git clone https://github.com/LuchoZ22/CERT-III-ALB.git
cd CERT-III-ALB
sudo cp -r * /var/www/html/

sudo sed -i "s/_INSTANCE_ID_/${INSTANCE_ID}/g" /var/www/html/index.html
sudo sed -i "s/_IPV4_/${PUBLIC_IPV4}/g" /var/www/html/index.html
sudo sed -i "s/_MAC_/${MAC}/g" /var/www/html/index.html
sudo sed -i "s/_REGION_/${REGION}/g" /var/www/html/index.html
sudo sed -i "s/_TYPE_/${TYPE}/g" /var/www/html/index.html



sudo systemctl restart httpd