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
sudo apt install openjdk-8-jdk
cd ~
curl -s https://d2s8p88vqu9w66.cloudfront.net/releases/greengrass-nucleus-latest.zip > greengrass-nucleus-latest.zip
unzip greengrass-nucleus-latest.zip -d GreengrassCore && rm greengrass-nucleus-latest.zip

```
