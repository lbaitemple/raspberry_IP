# raspberry_IP

You will need to get an
[OLED screen](https://www.amazon.com/PEMENOL-Display-0-96inch-Raspberry-Microcontroller/dp/B07F3KY8NF/ref=asc_df_B07F3KY8NF/?tag=hyprod-20&linkCode=df0&hvadid=366338360563&hvpos=&hvnetw=g&hvrand=12501945816479314715&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9007196&hvtargid=pla-617553222439&psc=1&tag=&ref=&adgrpid=79101991107&hvpone=&hvptwo=&hvadid=366338360563&hvpos=&hvnetw=g&hvrand=12501945816479314715&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9007196&hvtargid=pla-617553222439)

You will need to enable I2C interface 
```
sudo raspi-config
```
choose Interface Options and select P5:I2C to enable it

Easy Way:
```
sudo apt install git -y
git clone -b python3  https://github.com/lbaitemple/raspberry_IP/
cd raspberry_IP/
bash ./loadall.sh
```

Also, you can try the following way

#This code will upload raspberry private ip address to iot.eclipse.org using mqtt protocol
```
sudo apt-get install python3-pip python3-pil  i2c-tools git -y
git clone -b python3  https://github.com/lbaitemple/raspberry_IP/
sudo pip3 install Adafruit_SSD1306 RPi.GPIO Adafruit_BBIO
sudo sh raspberry_IP/setup-i2c.sh
cp raspberry_IP/newtest2.sh ~/test2.sh
cp raspberry_IP/stats.py ~/stats.py
chmod +x ~/test2.sh
```


Now, you will need to create a startup service
```
sudo cp raspberry_IP/ipaddress.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable  ipaddress
sudo systemctl start  ipaddress
```

