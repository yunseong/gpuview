#!/bin/sh

echo 'Install gpuview service:'

user=$USER
path=$(which gpuview)

echo ''
echo 'Installing supervisor...'
sudo apt install -y supervisor

echo ''
echo 'Deploying service...'

log_path=$HOME/.gpuview
mkdir -p ${log_path}

sudo echo "[program:gpuview]
user = ${user}
directory = $HOME
command = ${path} run ${1}
autostart = true
autorestart = true
stderr_logfile = ${log_path}/stderr.log
stdout_logfile = ${log_path}/stdout.log" \
| sudo tee /etc/supervisor/conf.d/gpuview.conf > /dev/null

sudo supervisorctl reread

echo ''
sudo service supervisor restart

echo ''
sudo supervisorctl restart gpuview

echo '~DONE~'
