echo "Provisioning virtual machine..."

echo "Installing Utilities"
dpkg --add-architecture i386
apt-get update  > /dev/null
apt-get install git curl python-dev python-pip python-pil python-setuptools zlib1g-dev libjpeg-dev libudev-dev build-essential libusb-1.0-0-dev -y > /dev/null
apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 libc6-dev-i386 -y > /dev/null
pip install --upgrade setuptools
pip install ledgerblue

echo "Setting up BOLOS environment"
mkdir /opt/bolos
cd /opt/bolos

echo "Installing custom compilers, this will take a few minutes..."
wget -q https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q1-update/+download/gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2
tar xjf gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2
ln -s /opt/bolos/gcc-arm-none-eabi-5_3-2016q1/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc

wget -q https://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
tar xvf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
mv clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04 clang-arm-fropi
chmod 757 -R clang-arm-fropi/
chmod +x clang-arm-fropi/bin/clang
ln -s /opt/bolos/clang-arm-fropi/bin/clang /usr/bin/clang

echo "Fetching the Nano S SDK"
cd /opt/bolos/
if [ ! -d "/opt/bolos/nanos-secure-sdk" ]; then
  git clone https://github.com/LedgerHQ/nanos-secure-sdk.git
  cd nanos-secure-sdk/
  git -c advice.detachedHead=false checkout tags/nanos-1553
  cd /opt/bolos/
fi

echo "Finetuning rights for USB access"
sudo bash /vagrant/provision/udev.sh
usermod -a -G plugdev vagrant

echo "Setting up bash profile"
echo "" >> /home/vagrant/.bashrc
echo "# Custom variables for Ledger Development" >> /home/vagrant/.bashrc
echo "export BOLOS_ENV=/opt/bolos" >> /home/vagrant/.bashrc
echo "export BOLOS_SDK=/opt/bolos/nanos-secure-sdk" >> /home/vagrant/.bashrc
echo "export ARM_HOME=/opt/bolos/gcc-arm-none-eabi-5_3-2016q1" >> /home/vagrant/.bashrc
echo "" >> /home/vagrant/.bashrc
echo "export PATH=\$PATH:\$ARM_HOME/bin" >> /home/vagrant/.bashrc

echo "Fetching example app for the Ledger Nano"
if [ ! -d "apps/ledger-app-ark" ]; then
  echo "cloning..."
  git clone https://github.com/ArkEcosystem/ledger apps/ledger-app-ark
else
  echo "updating..."
  cd apps/ledger-app-ark && git pull origin master
fi
