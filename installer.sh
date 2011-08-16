#!/bin/bash
#
#This script is designed to install the Android SDK, NDK, and Eclipse in Linux Mint 11 and make it easier for people that want to develop for Android using Linux.
#Script written by @ArchDukeDoug with special thanks to @BoneyNicole, @tabbwabb, and @animedbz16 for putting up with me and proofreading and/or testing the script.
#I can be reached at dougw@uab.edu, twitter, or linuxrandomly.blogspot.com
#Script version: 1.0.4
#Changelog: 1.0.4 - Added more devices to 99-android.rules
i=$(cat /proc/$PPID/cmdline)
if [[ $UID != 0 ]]; then
    echo "Please type sudo $0 $*to use this."
    exit 1
fi

#Download and install the Android SDK
if [ ! -d "/usr/local/android-sdk" ]; then
	for a in $( wget -qO- http://developer.android.com/sdk/index.html | egrep -o "http://dl.google.com[^\"']*linux_x86.tgz" ); do 
		wget $a && tar --wildcards --no-anchored -xvzf android-sdk_*-linux_x86.tgz; mv android-sdk-linux_x86 /usr/local/android-sdk; chmod 777 -R /usr/local/android-sdk; rm android-sdk_*-linux_x86.tgz;
	done
else
     echo "Android SDK already installed to /usr/local/android-sdk.  Skipping."
fi

#Download and install the Android NDK
if [ ! -d "/usr/local/android-ndk" ]; then 
	for b in $(  wget -qO- http://developer.android.com/sdk/ndk/index.html | egrep -o "http://dl.google.com[^\"']*linux-x86.tar.bz2"
 ); do wget $b && tar --wildcards --no-anchored -xjvf android-ndk-*-linux-x86.tar.bz2; mv android-ndk-*/ /usr/local/android-ndk; chmod 777 -R /usr/local/android-ndk; rm android-ndk-*-linux-x86.tar.bz2;
	done
else
    echo "Android NDK already installed to /usr/local/android-ndk.  Skipping."
fi

d=ia32-libs

#Determine if there is a 32 or 64-bit operating system installed and then install ia32-libs if necessary.

if [[ `getconf LONG_BIT` = "64" ]]; 

then
    echo "64-bit operating system detected.  Checking to see if $d is installed."

    if [[ $(dpkg-query -f'${Status}' --show $d 2>/dev/null) = *\ installed ]]; then
    	echo "$d already installed."
    else
        echo "Installing now..."
    	apt-get --force-yes -y install $d
    fi
else
	echo "32-bit operating system detected.  Skipping."
fi

#Check if Eclipse is installed
c=eclipse
	echo "checking if $c is installed" 2>&1
if [[ $(dpkg-query -f'${Status}' --show $c 2>/dev/null) = *\ installed ]]; 
then
	echo "$c already installed.  Skipping."
else 
	echo "$c was not found, installing..." 2>&1
	apt-get --force-yes -y install $c 2>/dev/null
fi

#Check if the ADB environment is set up.

if grep -q /usr/local/android-sdk/platform-tools /etc/bash.bashrc; 
then
    echo "ADB environment already set up"
else
    echo "export PATH=$PATH:/usr/local/android-sdk/platform-tools" >> /etc/bash.bashrc
fi

#Check if the ddms symlink is set up.

if [ -f /bin/ddms ] 
then
    rm /bin/ddms; ln -s /usr/local/android-sdk/tools/ddms /bin/ddms
else
    ln -s /usr/local/android-sdk/tools/ddms /bin/ddms
fi

#Create etc/udev/rules.d/99-android.rules file

touch -f 99-android.rules
echo "#Acer" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="0502", MODE="0666"" >> 99-android.rules
echo "#ASUS" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="0b05", MODE="0666"" >> 99-android.rules
echo "#Dell" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="413c", MODE="0666"" >> 99-android.rules
echo "#Foxconn" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="0489", MODE="0666"" >> 99-android.rules
echo "#Garmin-Asus" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="091E", MODE="0666"" >> 99-android.rules
echo "#Google" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="18d1", MODE="0666"" >> 99-android.rules
echo "#HTC" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="0bb4", MODE="0666"" >> 99-android.rules
echo "#Huawei" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="12d1", MODE="0666"" >> 99-android.rules
echo "#K-Touch" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="24e3", MODE="0666"" >> 99-android.rules
echo "#KT Tech" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="2116", MODE="0666"" >> 99-android.rules
echo "#Kyocera" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="0482", MODE="0666"" >> 99-android.rules
echo "#Lenevo" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="17EF", MODE="0666"" >> 99-android.rules
echo "#LG" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="1004", MODE="0666"" >> 99-android.rules
echo "#Motorola" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="22b8", MODE="0666"" >> 99-android.rules
echo "#NEC" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="0409", MODE="0666"" >> 99-android.rules
echo "#Nook" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="2080", MODE="0666"" >> 99-android.rules
echo "#Nvidia" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="0955", MODE="0666"" >> 99-android.rules
echo "#OTGV" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="2257", MODE="0666"" >> 99-android.rules
echo "#Pantech" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="10A9", MODE="0666"" >> 99-android.rules
echo "#Philips" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="0471", MODE="0666"" >> 99-android.rules
echo "#PMC-Sierra" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="04da", MODE="0666"" >> 99-android.rules
echo "#Qualcomm" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="05c6", MODE="0666"" >> 99-android.rules
echo "#SK Telesys" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="1f53", MODE="0666"" >> 99-android.rules
echo "#Samsung" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="04e8", MODE="0666"" >> 99-android.rules
echo "#Sharp" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="04dd", MODE="0666"" >> 99-android.rules
echo "#Sony Ericsson" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="0fce", MODE="0666"" >> 99-android.rules
echo "#Toshiba" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="0930", MODE="0666"" >> 99-android.rules
echo "#ZTE" >> 99-android.rules
echo "SUBSYSTEM=="usb", SYSFS{idVendor}=="19D2", MODE="0666"" >> 99-android.rules
mv -f 99-android.rules /etc/udev/rules.d/
chmod a+r /etc/udev/rules.d/99-android.rules

#Check if ADB is already installed
if [ ! -f "/usr/local/android-sdk/platform-tools/adb" ];
then
nohup /usr/local/android-sdk/tools/android update sdk > /dev/null 2>&1 &
zenity --info --text="Please accept the licensing agreement for Android SDK Platform-tools to install the Android Debug Bridge."
else
echo "Android Debug Bridge already detected."
fi
exit 0