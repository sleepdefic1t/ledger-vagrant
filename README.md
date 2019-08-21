# Ledger-Vagrant

## Installation

Requirements:
-   Ledger Nano S
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
git clone https://github.com/sleepdefic1t/ledger-vagrant
cd ledger-vagrant
vagrant up
```

*_this will take a few minutes to install_

## Prepare an app

-   install the app under the `apps/` directory:

example:
```shell
git clone https://github.com/ArkEcosystem/ledger apps/ledger-app-ark
```

## Connect to the machine 
```shell
vagrant ssh
```

## Build and Flash an app

-    connect your ledger Nano S to your computer

**Option 1**: ledger-app-ark
```shell
cd apps/ledger-app-ark
sh ./rebuild.sh
```

**Option 2**: using make

```shell
cd apps/<appName>
make clean
make


# to install the app on your Ledger:
make load

# to remove the app from the Ledger:
make delete
```

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
