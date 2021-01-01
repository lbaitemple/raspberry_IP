#!/bin/sh

export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_SESSION_TOKEN=AQoDYXdzEJr1K...o5OytwEXAMPLE=
export REGION=us-east-1

echo "fs.protected_hardlinks = 1" | sudo tee /etc/sysctl.d/98-rpi.conf
echo "protected_symlinks = 1" | sudo tee /etc/sysctl.d/98-rpi.conf
sudo apt install openjdk-8-jdk -y
cd ~
curl -s https://d2s8p88vqu9w66.cloudfront.net/releases/greengrass-nucleus-latest.zip > greengrass-nucleus-latest.zip
unzip greengrass-nucleus-latest.zip -d GreengrassCore && rm greengrass-nucleus-latest.zip
sudo -E java -Dlog.store=FILE   -jar ./GreengrassCore/lib/Greengrass.jar   --aws-region $REGION   --root /greengrass/v2 --thing-name MyGreengrassCore   --thing-group-name MyGreengrassCoreGroup   --tes-role-name MyGreengrassV2TokenExchangeRole   --tes-role-alias-name MyGreengrassCoreTokenExchangeRoleAlias   --component-default-user ggc_user:ggc_group   --provision true   --setup-system-service true   --deploy-dev-tools true
sudo chmod 755 /greengrass/v2 && sudo chmod 755 /greengrass
# download greengrass v1
wget https://d1onfpft10uf5o.cloudfront.net/greengrass-core/downloads/1.9.4/greengrass-linux-armv7l-1.9.4.tar.gz
gunzip -c greengrass-linux-armv7l-1.9.4.tar.gz | sudo tar -xvf - --directory /
sudo /greengrass/v2/alts/current/distro/bin/loader
