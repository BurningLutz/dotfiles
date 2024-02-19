# this will install apt-add-repository.
sudo apt install software-properties-common -y

# fish shell
sudo apt-add-repository ppa:fish-shell/release-3 -y

sudo apt update
sudo apt install build-essential fish -y

sudo locale-gen en_US.UTF-8
