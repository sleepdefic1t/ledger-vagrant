# Ledger-Vagrant

## Installation

Requirements:
-   Git
-   VirtualBox
-   Vagrant

### Install Vagrant and VirtualBox on your machine

Linux:
```shell
sudo apt install virtualbox
sudo apt install vagrant
```

macOS:
```shell
brew cask install virtualbox
brew cask install vagrant
```

Windows:
1) **Install VirtualBox**
    -   Download and run the installer:  
    `https://download.virtualbox.org/virtualbox/6.0.10/VirtualBox-6.0.10-132072-Win.exe`  
    -   Download and install the Oracle VM VirtualBox Extension Pack:  
    `https://download.virtualbox.org/virtualbox/6.0.10/Oracle_VM_VirtualBox_Extension_Pack-6.0.10.vbox-extpack`

2) **Install Vagrant**
    -   Download and run the installer:  
    `https://releases.hashicorp.com/vagrant/2.2.5/vagrant_2.2.5_x86_64.msi`


## Clone the Ledger-Vagrant package

```shell
git clone https://github.com/fix/ledger-vagrant
cd ledger-vagrant
vagrant up
```

*_this will take a few minutes to install_

## Compile an app

-   install the app under the `apps/` directory:

example:
```shell
git clone https://github.com/ArkEcosystem/ledger apps/ledger-app-ark
```

## Connect to the machine 
```shell
vagrant ssh
```

## Build the app

```shell
cd apps/ledger-app-<appName>
make clean
make
```

or

```shell
cd apps/ledger-app-ark
sh ./rebuild.sh
```

-    connect your ledger Nano S to your computer
-    install the app on your ledger: `make load`
-    remove the app from the ledger: `make delete`

## Known issues

-    USB port is locked out of the host machine, making tests rather tedious (needs to tear down `vagrant halt`) to test ledger on host machine
-    On Ubuntu, if the dongle is not found in the vagrant box, be sure that your **host** user belongs to the vboxusers group `sudo usermod -aG vboxusers <username>` (see https://askubuntu.com/questions/25596/how-to-set-up-usb-for-virtualbox/25600#25600)
-   If you have some issue involving wrong TARGET_ID, please either upgrade your nano S firmware to 1.5.x, and/or downgrade the nanos-secure-sdk tag to match your version.
  ```shell
cd /opt/bolos/nanos-secure-sdk
sudo git checkout tags/nanos-1553
```
-   Some python example scripts use the SECP256K1 library, you can install it via pip:
```shell
pip install secp256k1
```

## Credits

This project exists thanks to all the people who [contribute](../../contributors).

## License

[MIT](LICENSE)

