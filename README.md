# raspberry_IP
This code will upload raspberry private ip address to iot.eclipse.org using mqtt protocol
```
sudo apt install git -y
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
chmod +x greengrass.sh
./greengrass.sh
```

```
sudo service greengrass start
```
