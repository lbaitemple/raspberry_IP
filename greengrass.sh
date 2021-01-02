#!/bin/sh

#wget -q -O ./gg-device-setup-latest.sh https://d1onfpft10uf5o.cloudfront.net/greengrass-device-setup/downloads/gg-device-setup-latest.sh && chmod +x ./gg-device-setup-latest.sh && sudo -E ./gg-device-setup-latest.sh bootstrap-greengrass-interactive
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_SESSION_TOKEN=
export REGION=us-east-1

if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "AWS_SECRET_ACCESS_KEY" ] || [ -z "$AWS_SESSION_TOKEN" ]; then
   echo "please setup your AWS environment variables before you procceed"
   exit 1
fi
#wget -q -O ./gg-device-setup-latest.sh https://d1onfpft10uf5o.cloudfront.net/greengrass-device-setup/downloads/gg-device-setup-latest.sh 
#chmod +x ./gg-device-setup-latest.sh 
#sudo -E ./gg-device-setup-latest.sh bootstrap-greengrass
#--aws-access-key-id $AWS_ACCESS_KEY_ID
#--aws-secret-access-key $AWS_SECRET_ACCESS_KEY
#--aws-session-token $AWS_SESSION_TOKEN
#--region $REGION
#--group-name Custom_Group_Name
#--core-name Custom_Core_Name
#--ggc-root-path /greengrass
#--deployment-timeout 300
#--log-path /greengrass/ggc/var/log
#--hello-world-lambda
#--verbose

sudo bash -c 'echo "fs.protected_hardlinks = 1" >> /etc/sysctl.d/98-rpi.conf'
sudo bash -c 'echo "fs.protected_symlinks = 1" >> /etc/sysctl.d/98-rpi.conf'
sed '${s/$/ cgroup_enable=memory cgroup_memory=1/}' /boot/cmdline.txt |sudo tee /boot/cmdline.txt
sudo apt update --fix-missing
sudo apt install openjdk-8-jdk -y
cd ~
curl -s https://d2s8p88vqu9w66.cloudfront.net/releases/greengrass-nucleus-latest.zip > greengrass-nucleus-latest.zip
unzip greengrass-nucleus-latest.zip -d GreengrassCore && rm greengrass-nucleus-latest.zip
sudo -E java -Dlog.store=FILE   -jar ./GreengrassCore/lib/Greengrass.jar   --aws-region $REGION   --root /greengrass/v2 --thing-name MyGreengrassCore   --thing-group-name MyGreengrassCoreGroup   --tes-role-name MyGreengrassV2TokenExchangeRole   --tes-role-alias-name MyGreengrassCoreTokenExchangeRoleAlias   --component-default-user ggc_user:ggc_group   --provision true   --setup-system-service true   --deploy-dev-tools true
sudo chmod 755 /greengrass/v2 && sudo chmod 755 /greengrass
# download greengrass v1
wget https://d1onfpft10uf5o.cloudfront.net/greengrass-core/downloads/1.9.4/greengrass-linux-armv7l-1.9.4.tar.gz
gunzip -c greengrass-linux-armv7l-1.9.4.tar.gz | sudo tar -xvf - --directory /
# add ggc_user
sudo adduser --system ggc_user
sudo addgroup --system ggc_group
#sudo /greengrass/v2/alts/current/distro/bin/loader
