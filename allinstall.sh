chmod +x *.sh
sudo apt install git -y
git clone -b jupyter https://github.com/lbaitemple/raspberry_IP/
cd ~/raspberry_IP/
chmod +x loadscreen.sh
./loadscreen.sh

cd ~/raspberry_IP/scripts
chmod +x jupyter.sh
./jupyter.sh

cd ~/raspberry_IP/
chmod +x installros.sh
./installros.sh

cd ~/raspberry_IP/
chmod +x greengrass.sh
./greengrass.sh
