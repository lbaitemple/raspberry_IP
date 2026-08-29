# raspberry_IP


## ubuntu 24.04 wpa_supplicant 

- you can download [file](https://github.com/lbaitemple/raspberry_IP/releases/download/ubuntu/ubuntu_24.04_rpi5_4_11_2026_s.zip)

- get wpa_supplicant-wlan0.conf file from [here](http://temple.s.gy/pihash)



You will need to get an
[OLED screen](https://www.amazon.com/PEMENOL-Display-0-96inch-Raspberry-Microcontroller/dp/B07F3KY8NF/ref=asc_df_B07F3KY8NF/?tag=hyprod-20&linkCode=df0&hvadid=366338360563&hvpos=&hvnetw=g&hvrand=12501945816479314715&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9007196&hvtargid=pla-617553222439&psc=1&tag=&ref=&adgrpid=79101991107&hvpone=&hvptwo=&hvadid=366338360563&hvpos=&hvnetw=g&hvrand=12501945816479314715&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9007196&hvtargid=pla-617553222439)


## following the following setup
```
sudo apt update
sudo apt-get install python3-pip python3-pil python3-rpi.gpio  i2c-tools git -y
sudo apt-get install libopenjp2-7 libatlas-base-dev -y
git clone -b ubuntu24  https://github.com/lbaitemple/raspberry_IP/
sudo pip3 install  --break-system-package adafruit-blinka adafruit-circuitpython-ssd1306
sudo sh raspberry_IP/setup-i2c.sh
cp raspberry_IP/stats.py ~/stats.py
```


Now, you will need to create a startup service
```
sudo cp raspberry_IP/ipaddress.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable  ipaddress
sudo systemctl start  ipaddress
```

You can also download the ubuntu 24.04 image for raspberry pi 4 [here](https://github.com/lbaitemple/raspberry_IP/releases/download/ubuntu/ubuntu_24.04_1_s.zip)

username: ubuntu

password: manadang


You can create a 50-cloud-init.yaml file at [here](http://bit.ly/pihash)
