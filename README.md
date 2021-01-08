# Turn on I2C in interface
```
sudo raspi-config
```
choose I2C interface enabled by select 3, select P5, select Yes, then Ok. Use tab key to select Finish and quite.

# If you have an I2C based OLED Screen
```
sudo apt install git -y
git clone -b jupyter https://github.com/lbaitemple/raspberry_IP/
cd ~/raspberry_IP/
chmod +x *.sh
```
 Make sure you add aws credential in greengrass.sh first before you run the commands below
```
nano greengrass.sh
```
After the credntials are save, you can run
```
./allinstall.sh
```

# Open a browser, you can type
```
http://<raspberry_ip_address>:8888
```
The password/token is raspberry

# If you do not have an I2C based OLED screen, or you want to do them step by step
```
sudo apt install git -y
git clone -b jupyter https://github.com/lbaitemple/raspberry_IP/
cd ~/raspberry_IP/
chmod +x *.sh
```

### 1.1.a Install jupyter lab with [passwd], default is raspberry
```
cd ~/raspberry_IP/scripts
chmod +x jupyter.sh
./jupyter.sh [passwd]
```

### 1.1.b add swap
This code will upload raspberry private ip address to iot.eclipse.org using mqtt protocol
```
cd ~/raspberry_IP/
chmod +x addswap.sh
./addswap.sh
```


### 1.1.c Install ROS

```
cd ~/raspberry_IP/
chmod +x installros.sh
./installros.sh
```

### 1.1.d raspberry_IP (OLED screen is required)
This code will upload raspberry private ip address to iot.eclipse.org using mqtt protocol
```
sudo apt install git -y
git clone -b jupyter https://github.com/lbaitemple/raspberry_IP/
cd ~/raspberry_IP/
chmod +x loadscreen.sh
./loadscreen.sh
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
