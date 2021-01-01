# Turn on I2C in interface
```
sudo raspi-config
```

# Install all
```
chmod +x *.sh
sudo apt install git -y
git clone -b jupyter https://github.com/lbaitemple/raspberry_IP/
./allinstall.sh
```

# raspberry_IP
This code will upload raspberry private ip address to iot.eclipse.org using mqtt protocol
```
sudo apt install git -y
git clone -b jupyter https://github.com/lbaitemple/raspberry_IP/
cd ~/raspberry_IP/
chmod +x loadscreen.sh
./loadscreen.sh
```

# Install jupyter lab with [passwd], default is raspberry
```
cd ~/raspberry_IP/scripts
chmod +x jupyter.sh
./jupyter.sh [passwd]

```

# Install ROS

```
cd ~/raspberry_IP/
chmod +x installros.sh
./installros.sh
```


# Install Greengrass v1 and v2, make sure you add aws credential first before you run the commands below
```
cd ~/raspberry_IP/
chmod +x greengrass.sh
./greengrass.sh
```
appene 'cgroup_enable=memory cgroup_memory=1' to the end of /boot/cmdline.txt

```
sudo service greengrass start
```
