# raspberry_IP
This code will upload raspberry private ip address to iot.eclipse.org using mqtt protocol
```
sudo apt install git
git clone -b jupyter https://github.com/lbaitemple/raspberry_IP/
cd ~/raspberry_IP/
chmod +x loadscreen.sh
./loadscreen.sh
```

# Install jupyter lab
```
cd ~/raspberry_IP/scripts
chmod +x jupyter.sh
./jupyter.sh

```

# Install Greengrass v2
```
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_SESSION_TOKEN=AQoDYXdzEJr1K...o5OytwEXAMPLE=
export REGION=us-east-1
sudo apt install openjdk-8-jdk
cd ~
curl -s https://d2s8p88vqu9w66.cloudfront.net/releases/greengrass-nucleus-latest.zip > greengrass-nucleus-latest.zip
unzip greengrass-nucleus-latest.zip -d GreengrassCore && rm greengrass-nucleus-latest.zip
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
sudo -E java -Dlog.store=FILE   -jar ./GreengrassCore/lib/Greengrass.jar   --aws-region $REGION   --root /greengrass/v2 --thing-name MyGreengrassCore   --thing-group-name MyGreengrassCoreGroup   --tes-role-name MyGreengrassV2TokenExchangeRole   --tes-role-alias-name MyGreengrassCoreTokenExchangeRoleAlias   --component-default-user ggc_user:ggc_group   --provision true   --setup-system-service true   --deploy-dev-tools true


```
