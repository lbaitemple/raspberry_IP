# Download 64-bit image
https://downloads.raspberrypi.org/raspios_arm64/images/

http://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-2020-08-24/

sudo apt-get update --allow-releaseinfo-change
# Turn on I2C in interface and add 64-bit kernel
```
sudo raspi-config
```
choose I2C interface enabled by select 3, select P5, select Yes, then Ok. Use tab key to select Finish and quite.

# If you have an I2C based OLED Screen
```
sudo apt install git -y
git clone -b aarch64 https://github.com/lbaitemple/raspberry_IP/
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

Make sure you reboot.

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
### 1.1.c Install Greengrass v1 and v2, make sure you add aws credential first before you run the commands below
```
cd ~/raspberry_IP/
chmod +x greengrass.sh
./greengrass.sh
```
## You must REBOOT NOW to enable greengrass on your raspberry pi.
```
sudo reboot
```
The script automatically append 'cgroup_enable=memory cgroup_memory=1' to the end of /boot/cmdline.txt

```
sudo /greengrass/ggc/core/greengrassd start
```
or
```
sudo service greengrass start
```
check any issue with greengrass at https://docs.aws.amazon.com/greengrass/latest/developerguide/setup-filter.rpi.html

### 1.1.d Install ROS [can be installed later, take abouut 90 mins]

```
cd ~/raspberry_IP/
chmod +x installros.sh
./installros.sh
```


### 1.1.e raspberry_IP (OLED screen is required)
This code will upload raspberry private ip address to iot.eclipse.org using mqtt protocol
```
sudo apt install git -y
git clone -b jupyter https://github.com/lbaitemple/raspberry_IP/
cd ~/raspberry_IP/
chmod +x loadscreen.sh
./loadscreen.sh
```

### Install Samba
```
sudo apt-get install samba samba-common-bin -y
mkdir /home/pi/shared
sudo nano /etc/samba/smb.conf
```
add the following to the end of the file
```
[FPGA]
path = /home/pi/shared
writeable=Yes
create mask=0777
directory mask=0777
public=no
```
add password
```
sudo smbpasswd -a pi
sudo systemctl restart smbd
```

### Install Docker
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
Add otheer architectures
```
sudo apt-get install qemu binfmt-support qemu-user-static -y
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
# You can verify that you are able to execute x86 32-bits version image
docker run --rm -t i386/ubuntu uname -m
```


###  Setup USB-C OTG
#### open configuration file
```
sudo nano /boot/config.txt
```
add a line to the end of the file
```
dtoverlay=dwc2
```

#### open cmdline file
```
sudo nano /boot/cmdline.txt
```
add below before "root=" (make sure that is one line)
```
modules-load=dwc2 
```
#### open moddule file
```
sudo nano /etc/modules
```
add  a line to the end of the file
```
libcomposite 
```

#### open dhcpcd.conf file
```
sudo nano  /etc/dhcpcd.conf
```
add  a line to the end of the file
```
denyinterfaces usb0 
```

###### Install dnsmasq
```
sudo apt-get install dnsmasq -y
sudo nano /etc/dnsmasq.d/usb
```
Add the following content
```
interface=usb0
dhcp-range=10.55.0.2,10.55.0.6,255.255.255.248,1h
dhcp-option=3
leasefile-ro
```

###### Install ifdownup
```
sudo apt-get install ifupdown -y
sudo nano /etc/network/interfaces
```
Add the following content
```
auto usb0
allow-hotplug usb0
iface usb0 inet static
  address 10.55.0.1
  netmask 255.255.255.248
  
allow-hotplug wlan0
iface wlan0 inet dhcp
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
iface default inet dhcp

```

#### create a startup file
```
sudo nano /root/usb.sh
```
Add the following content
```
#!/bin/bash
cd /sys/kernel/config/usb_gadget/
mkdir -p pi4
cd pi4
echo 0x1d6b > idVendor # Linux Foundation
echo 0x0104 > idProduct # Multifunction Composite Gadget
echo 0x0100 > bcdDevice # v1.0.0
echo 0x0200 > bcdUSB # USB2
echo 0xEF > bDeviceClass
echo 0x02 > bDeviceSubClass
echo 0x01 > bDeviceProtocol
mkdir -p strings/0x409
echo "fedcba9876543211" > strings/0x409/serialnumber
echo "Ben Hardill" > strings/0x409/manufacturer
echo "PI4 USB Device" > strings/0x409/product
mkdir -p configs/c.1/strings/0x409
echo "Config 1: ECM network" > configs/c.1/strings/0x409/configuration
echo 250 > configs/c.1/MaxPower
# Add functions here
# see gadget configurations below
# End functions
mkdir -p functions/ecm.usb0
HOST="00:dc:c8:f7:75:14" # "HostPC"
SELF="00:dd:dc:eb:6d:a1" # "BadUSB"
echo $HOST > functions/ecm.usb0/host_addr
echo $SELF > functions/ecm.usb0/dev_addr
ln -s functions/ecm.usb0 configs/c.1/
udevadm settle -t 5 || :
ls /sys/class/udc > UDC
ifup usb0
service dnsmasq restart
```

#### create rc.local file
```
sudo nano /etc/rc.local
```
Add the following content
```
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
/root/usb.sh

exit 0
```

#### make /root/usb.sh executable
```
sudo chmod +x /etc/rc.local
sudo chmod +x /root/usb.sh
```


