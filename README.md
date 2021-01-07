# Turn on I2C in interface
```
sudo raspi-config
```

## 1.1 Install all for 1.1.a, 1.1.b and 1.1.c
```
sudo apt install git -y
git clone -b jupyter https://github.com/lbaitemple/raspberry_IP/
cd ~/raspberry_IP/
chmod +x *.sh
./allinstall.sh
```

### 1.1.a raspberry_IP (OLED screen is required)
This code will upload raspberry private ip address to iot.eclipse.org using mqtt protocol
```
sudo apt install git -y
git clone -b jupyter https://github.com/lbaitemple/raspberry_IP/
cd ~/raspberry_IP/
chmod +x loadscreen.sh
./loadscreen.sh
```

### 1.1.b Install jupyter lab with [passwd], default is raspberry
```
cd ~/raspberry_IP/scripts
chmod +x jupyter.sh
./jupyter.sh [passwd]
```

### 1.1.c add swap
This code will upload raspberry private ip address to iot.eclipse.org using mqtt protocol
```
cd ~/raspberry_IP/
chmod +x addswap.sh
./addswap.sh
```


### 1.1.d Install ROS

```
cd ~/raspberry_IP/
chmod +x installros.sh
./installros.sh
```


## 2.1 Install Greengrass v1 and v2, make sure you add aws credential first before you run the commands below
```
cd ~/raspberry_IP/
chmod +x greengrass.sh
./greengrass.sh
```
appene 'cgroup_enable=memory cgroup_memory=1' to the end of /boot/cmdline.txt

```
sudo service greengrass start
```
