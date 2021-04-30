#!/bin/bash

set -e

password=${1:-raspberry}

sudo apt-get update
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install -y  python3-pip nodejs libffi-dev 
sudo pip3 install setuptools
sudo apt install libffi-dev -y
sudo pip3 install cffi


sudo -H pip3 install jupyterlab
#sudo -H jupyter labextension install @jupyter-widgets/jupyterlab-manager

mkdir -p $HOME/notebooks

jupyter lab --generate-config
python3 -c "from jupyter_server.auth.security import set_password; set_password('$password', '$HOME/.jupyter/jupyter_server_config.json')"
#sudo chown -R pi:pi /home/pi/.local/share/

# Install bokeh
#sudo pip3 install bokeh
#sudo jupyter labextension install @bokeh/jupyter_bokeh
echo "c.NotebookApp.token = ''" >> $HOME/.jupyter/jupyter_lab_config.py
echo "c.NotebookApp.password_required = True" >> $HOME/.jupyter/jupyter_lab_config.py
echo "c.NotebookApp.allow_credentials = False" >> $HOME/.jupyter/jupyter_lab_config.py


python3 create_jupyter_service.py
sudo mv jetbot_jupyter.service /etc/systemd/system/jetbot_jupyter.service
sudo systemctl enable jetbot_jupyter
sudo systemctl daemon-reload
sudo systemctl start jetbot_jupyter