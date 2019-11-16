# Instructions on provisioning Dell Precision 5530 with dualbooted Ubuntu (currently 18.04) + Windows

**DISCLAIMER. THESE GUIDELINES ARE MY PERSONAL NOTES AND ALL THE MATERIALS HERE ARE PROVIDED “AS IS” WITH NO WARRANTIES WHATSOEVER REGARDING THE SECURITY, RELIABILITY, AND PERFORMANCE. THE AUTHOR MAKES NO WARRANTY THAT FOLLOWING THESE GUIDELINES YOUR SYSTEM WILL BE UNINTERRUPTED, TIMELY OR ERROR-FREE OR THAT THE RESULTS OR INFORMATION OBTAINED FROM USE OF THESE GUIDELINES WILL BE ACCURATE. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, CONSEQUENTIAL, SPECIAL, INDIRECT, EXEMPLARY OR PUNITIVE DAMAGES. YOU UNDERSTAND AND AGREE THAT YOU USE THE THE MATERIALS PROVIDED HERE AT YOUR OWN DISCRETION AND RISK AND THAT YOU WILL BE SOLELY RESPONSIBLE FOR YOUR ACTIONS, AND FOR ANY DAMAGES TO YOUR COMPUTER SYSTEM OR LOSS OF DATA THAT RESULTS FROM THE DOWNLOAD OR USE OF THESE GUIDELINES.**

These are my personal notes on installing Ubuntu LTS (18.04 at the time of writing) alongside Windows 10 Pro
on a Dell Precision 5530 (mid 2019) laptop.
Most of these intructions and tweaks should apply to Dell XPS 15 9570 as well since they share mostly same hardware.
They should also apply to some previous models of these laptop lines (Dell Precision 5520, Dell XPS 15 9560, Dell XPS 15 9550).
I have personally tested the same setup (with very slight differences) on my other Dell XPS 15 9550 and everything works just fine.
I don't make any guarantees though. If in doubt - read the disclaimer first and proceed at your own risk.

## NOTE: This is a WIP guide.##

## ToDo
- [ ] ToC
- [x] BIOS
- [x] Reinstalling Windows 10
  - [x] Downloading drivers and software
  - [x] Downloading Windows 10 iso image
  - [x] Creating bootable flash drive
  - [x] Clean Windows 10 install
  - [x] Tweaking Windows 10 after fresh install
  - [ ] Optional software
- [x] Installing Ubuntu
  - [x] Downloading iso image
  - [x] Creating bootable flash drive
  - [x] Installing ubuntu as second boot
  - [x] Partitioning SDD drive for Ubuntu installation
  - [x] Dell Precision 5530 tweaks for Ubuntu
    - [x] Respin image
  - [ ] Installing necessary software packages **(This should be done with ansible)**
  - [ ] Dotfiles **(This should be done with ansible)**
  - [ ] Creating shared drive for Ubuntu and Windows
  - [ ] Optional software


# Table of Contents
- [BIOS](#bios)
  - [Updating BIOS](#updating-bios)
  - [Tweaking BIOS for dual-boot](#tweaking-bios-for-dual-boot)
- [Reinstalling Windows 10](#reinstalling-windows-10)
  - [Downloading drivers and software](#donwloading-drivers-and-software)
  - [Downloading Windows 10 image](#downloading-windows-10-image)
  - [Creating bootable flash drive with Win10](#creating-bootable-flash-drive-with-win10)
  - [Installing Windows 10](#installing-windows-10)
  - [Applying optional tweaks to Windows 10](#applying-optional-tweaks-to-windows-10)


## BIOS
### Updating BIOS
As a first step after booting up a new laptop I always update the BIOS to latest version. This can be found on [DELL's support site](https://www.dell.com/support/home/en/us/nodhs1/product-support/product/precision-15-5530-laptop/drivers). Simply download and run the executable file and the runner will do the job.
*Note: it is advisable to charge the laptop and connect it to AC. Any interruption during BIOS update may render the laptop unusable*

### Tweaking BIOS for dual-boot
Several changes to BIOS are needed. I've separated them into mandatory and optional as show below.
Mandatory:
* General -> Boot sequence - UEFI
* General -> Advanced boot options -> Uncheck 'Enable Legacy Option ROMs'
* Secure boot -> Secure boot enabled -> Disable
* Switch SATA operation to ACHI (Do this after installing windows and setting safeboot to minimal. See [Windows won't boot with ACHI mode](#windows-won't-boot-with-achi-mode) for details.)

Optionally:
* Battery -> Set change level from 50 to 80 (As I mostly use AC I don't want the battery to always keep charged to 100%, this should prolong the battery life in the long run.)  

*Some extra info on setting up BIOS for dual-boot can be found on [DELL's support page](https://www.dell.com/support/article/no/no/nodhs1/sln301754/how-to-install-ubuntu-and-windows-8-or-10-as-a-dual-boot-on-your-dell-pc?lang=en#BIOS).*


## Reinstalling Windows 10
It is advisable to reinstall Windows 10 on a newly-bought laptop.
The default OS often comes bundled with bloatware, outdated drivers, etc., hence I prefer to always start with a clean install.

### Downloading drivers and software
It is advisable to make some changes to Windows 10 prior to connecting to internet.
A clean Windows 10 is sh\*t and a huge spyware. If you are concerned about your privacy (which you should be) then you should follow the guidelines on how to disable telemetry, cortana and apply other privacy related tweaks to Windows 10 (See below.) prior to connecting to internet. Therefore you will need some software and drivers to be downloaded first.

Prior to wiping the hard drive and installing clean Windows 10 download the following drivers, software and win10 tweak files.
They will be needed later after installing fresh OS.
- [DELL Precision 5530 Drivers](https://www.dell.com/support/home/en/us/nodhs1/product-support/product/precision-15-5530-laptop/drivers)
- [O&O ShutUp10](https://www.oo-software.com/en/shutup10)
- [CCleaner Portable](http://www.majorgeeks.com/files/details/ccleaner_portable.html)
- [Autoruns](https://docs.microsoft.com/en-us/sysinternals/downloads/autoruns)
- [Registry and bat tweaks](./win10_reg_tweaks)
- [VisualCppRedist_AIO_x86_x64_v12](https://drive.google.com/file/d/17oIRuawR3Plb3O9JPjhoFKGGDZ5iCrs5)

### Downloading Windows 10 image
Windows 10 images are available for [download from Microsoft support site](https://www.microsoft.com/en-us/software-download/windows10ISO).
However, if downloading from Windows OS, then Microsoft will try to detect your OS and will want you to use their Media Creation Tool.
IF you don't like to use the tool there is still an option to download the iso file directly, all you need to do is make MS servers think you're using an unsupported OS.
To do this simply switch the user agent that your browser sends, for example to Safari on iPad, and it will allow you to get a direct download link for the iso image of Windows.

### Creating bootable flash drive with Win10
There is plenty of software that can create a bootable flash drive from the iso image, I personally prefer [Rufus](https://rufus.ie/).
- First verify the iso image downloaded from Microsoft. This can also be done with Rufus. For more info see [FAQ](https://github.com/pbatard/rufus/wiki/FAQ#How_can_I_validate_that_a_Windows_ISO_is_a_genuine_retail_version).
- Then create the bootable flash drive in UEFI mode.
*For more details see full [Rufus FAQ](https://github.com/pbatard/rufus/wiki/FAQ).*

### Installing Windows 10
- Reboot and press F12 for one-time boot menu.
- Select UEFI flash drive
- Follow [Windows 10 Clean Install Guide](http://forum.notebookreview.com/threads/windows-10-clean-installation-guide.781178/)

### Applying optional tweaks to Windows 10
After completing the previous step you should have a usable Windows 10 platform with most of spyware and telemetry disabled. However there are some additional tweaks that can be applied based on your tastes and desires. See [Windows 10 Tweaks and Fixes Guide](http://forum.notebookreview.com/threads/windows-10-tweaks-and-fixes-index-post-1.779394/) for more details.


## Installing Ubuntu
### Downloading iso image
For this guide I have used the latest LTS version available at the time - Ubuntu 18.04.2 LTS.
I haven't tried the short-term support versions and can't guarantee everything will work the same.  

Download Ubuntu Desktop version from here: [link](https://ubuntu.com/download/desktop).

### Creating bootable flash drive with Ubuntu
The instructions are same as for Windows 10 bootable flash drive - see this [section](#creating-bootable-flash-drive-with-win10) for more details.

### Installing Ubuntu as second boot
This step is pretty straight-forward. After creating a bootable drive with Ubuntu just boot from the flash-drive using a one-time-boot menu (F12)
and follow the on-screen instructions.

### Partitioning SDD drive for Ubuntu installation
I have a 1 TB SSD drive and I have partitioned it the following way:  

- Windows and shared:
    - System - 90G
    - Shared Data - 600G
- Ubuntu
    - `/` - 36G
    - `/home` - 274G
    - SWAP - 18G (Though it's recommended to have twice of RAM on SWAP I think allocating 64G for SWAP would be an overkill.)

*Note: after installing Windows OS I have left the rest of the space unallocated and partitioned the rest during ubuntu installation.*  

**Additional read:**  
- [How to use manual partitioning during installation on AskUbuntu](https://askubuntu.com/questions/343268/how-to-use-manual-partitioning-during-installation)
- [Drives and Partitions on Ubuntu Help Wiki](https://help.ubuntu.com/community/DrivesAndPartitions)

### Dell Precision 5530 tweaks for Ubuntu
The first step I took after installing Ubuntu is running a script from this repo:
[DELL XPS 15 9570 Ubuntu 18.04 respin and post installation script](https://github.com/JackHack96/dell-xps-9570-ubuntu-respin)  

To run the script without cloning the repo execute the following command (requires curl):
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/JackHack96/dell-xps-9570-ubuntu-respin/master/xps-tweaks.sh)"
```

Or clone the repo and run from the cloned dir (requires git):
```
$ cd ~ && git clone git@github.com:JackHack96/dell-xps-9570-ubuntu-respin.git
$ sudo /bin/bash ~/dell-xps-9570-ubuntu-respin/xps-tweaks.sh
```

This will install several drivers (including prime drivers for nvidia/intel graphics) and add some extra tweaks to the OS.

### Creating shared drive for Ubuntu and Windows

### Installing software packages and drivers
This is an optional list of things that I use. Feel free to skip entirely or pick out what you might need.  

Packages: **(This should be moved to install script)**
- VPN
  - install openvpn network manager for gnome shell `$ sudo apt-get install network-manager-openvpn-gnome` - without this package I was unable to import openvpn config file via `Settings -> Network` menu, nor connect to any of the remote host adresses using openvpn client from cli.
  - Install openconnect network manager for gnome shell `$ sudo apt-get install network-manager-openconnect-gnome`
  - Go to `Settings -> Network -> Modify vpn settings -> IPv4 -> Use this connection only for resources on its network -> Save`
JDK - https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-18-04
Gnome extensions and tweaks
  - `$ sudo apt install gnome-shell-extensions gnome-tweaks`
  - `$ sudo apt install stow`
  - `$ sudo apt install xclip`
  - `$ sudo apt install git`
  - `$ sudo apt install python3-gpg`
  - `$ sudo apt install curl`

### Optional software
- [Dropbox](https://www.dropbox.com/install-linux)
- [PCloud](https://www.pcloud.com/download-free-online-cloud-file-storage.html)
- [KeePassXC](https://keepassxc.org/download/#linux)
- [Brave Browser](https://brave.com/)
  - [Start Page](https://github.com/xero/startpage)
  - Extensions:
    - [Add to Wunderlist](https://chrome.google.com/webstore/detail/add-to-wunderlist/dmnddeddcgdllibmaodanoonljfdmooc)
    - [cVim](https://chrome.google.com/webstore/detail/cvim/ihlenndgcmojhcghmfjfneahoeklbjjh)
    - [GNOME Shell integration](https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep)
    - [Google Translate](https://chrome.google.com/webstore/detail/google-translate/aapbdbdomjkkjkaonfhkkikfgjllcleb) - until Brave comes up with their own translator.
    - [New Tab Redirect](https://chrome.google.com/webstore/detail/new-tab-redirect/icpgjfneehieebagbmdbhnlpiopdcmna)
    - [NoScript](https://chrome.google.com/webstore/detail/noscript/doojmbjmlfjjnbmnoijecmcbfeoakpjm)
    - [OneTab](https://chrome.google.com/webstore/detail/onetab/chphlpgkkbolifaimnlloiipkdnihall)
    - [Quick Tabs](https://chrome.google.com/webstore/detail/quick-tabs/jnjfeinjfmenlddahdjdmgpbokiacbbb)
    - [Session Buddy](https://chrome.google.com/webstore/detail/session-buddy/edacconmaakjimmfgnblocblbcdcpbko)
    - [Stylus](https://chrome.google.com/webstore/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne)
    - [TabCloud](https://chrome.google.com/webstore/detail/tabcloud/npecfdijgoblfcgagoijgmgejmcpnhof/)
    - [uBLock Origin](https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm)
- [IntelliJ Idea](https://www.jetbrains.com/idea/download/#section=linux)
- [Atom](https://atom.io/)
- [Guake Terminal](http://guake-project.org/)
- [Slack](https://slack.com/intl/en-no/downloads/linux)
- [Telegram](https://desktop.telegram.org/)
- [Wire](https://wire.com/en/download/)
- [Back in Time](https://github.com/bit-team/backintime) - backups
- [Thunderbird](https://www.thunderbird.net/en-US/)
- [DavMail](http://davmail.sourceforge.net/)
- [Firefox Browser](https://www.mozilla.org/en-US/firefox/new/)
  - Extensions:
    - [NoScript](https://addons.mozilla.org/en-US/firefox/addon/noscript/)
    - [uBLock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)
- [FlameShot](https://github.com/lupoDharkael/flameshot) - screenshot utility
- [Freeplane](https://sourceforge.net/projects/freeplane/) - mind-mapping
- [YourKit](https://www.yourkit.com/java/profiler/download/) - java profiler
- [GIMP](https://www.gimp.org/downloads/)


## Useful tips and tricks
<details><summary><b>Some useful command-line tricks:</b></summary>
<p>

- To see the history of all changes made with `apt`([credits](https://askubuntu.com/a/250530/700229)):
```
$ (zcat $(ls -tr /var/log/apt/history.log*.gz); cat /var/log/apt/history.log) 2>/dev/null | \
    egrep '^(Start-Date:|Commandline:)' | \
    grep -v aptdaemon | \
    egrep -B1 '^Commandline:'
```

- To see the history of all `apt(-get)? install` commands(without dates):
```
$ (zcat $(ls -tr /var/log/apt/history.log*.gz); cat /var/log/apt/history.log) 2>/dev/null | \
    egrep '^(Commandline: apt(-get)? install)' | \
    grep -v aptdaemon | \
    egrep '^Commandline:'
```

- To see the history of all `apt(-get)? (remove|purge)` commands(without dates):
```
$ (zcat $(ls -tr /var/log/apt/history.log*.gz); cat /var/log/apt/history.log) 2>/dev/null | \
    egrep '^(Commandline: apt(-get)? (remove|purge))' | \
    grep -v aptdaemon | \
    egrep '^Commandline:'
```

- Change the duration logs are kept for `dpkg` and `apt`:
```
$ sudo vim /etc/logrotate.d/apt
# change rotate from 12 (months) to any other value
$ sudo vim /etc/logrotate.d/dpkg
# same as above
```
</p>
</details>


## Fixes and Troubleshooting
### Windows won't boot without ACHI mode
- Run a Command Prompt (Admin)
- Set reboot on safe mode, typing this command: bcdedit /set safeboot minimal
- Restart and enter BIOS Setup
- Change the SATA Operation mode to AHCI
- Save changes and exit Setup
- Windows will automatically boot to Safe Mode
- Run a Command Prompt (Admin)
- Set reboot to normal Windows, typing this command: bcdedit /deletevalue safeboot
- Reboot once more and Windows will automatically start with AHCI drivers enabled

### Fixing DNS resolutin on Ubuntu 18.04+ when connected to OpenVPN
After some time of using Ubuntu I've noticed that connecting to VPN (with an option "Use this connection only for resources on this network") did not automatically resolve DNSs on that network.  

Issuing `systemd-resolve --status` with VPN connection with disabled "Use this connection only for ..." option produced the following output:
```
Link 10 (tun0)
      Current Scopes: DNS
       LLMNR setting: yes
MulticastDNS setting: no
      DNSSEC setting: no
    DNSSEC supported: no
         DNS Servers: 10.xxx.xx.xx
          DNS Domain: ~.
```

Whereas enabling "Use this connection only for ..." option produced:
```
Link 10 (tun0)
      Current Scopes: none
       LLMNR setting: yes
MulticastDNS setting: no
      DNSSEC setting: no
    DNSSEC supported: no
```

#### Option 1 (didn't work for me, but kept as a possible solution)
* Install `openvpn-systemd-resolved` with `sudo apt install openvpn-systemd-resolved` or by following instructions in the [jonathanio/update-systemd-resolved](https://github.com/jonathanio/update-systemd-resolved#openvpn-configuration)
* Enable stub resolver `sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf`
* Modify openvpn conf by adding the following lines (At the beginning of the config file.)
  ```
  script-security 2
  setenv PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
  up /etc/openvpn/scripts/update-systemd-resolved
  up-restart
  down /etc/openvpn/scripts/update-systemd-resolved
  down-pre
  ```
[Source](https://askubuntu.com/questions/1032476/ubuntu-18-04-no-dns-resolution-when-connected-to-openvpn)

#### Option 2 (this helped fix the issue and DNS were again resolving automatically on establishing VPN connection)
Execute:
```
nmcli c modify <vpn-settings-name> ipv4.dns-search '<domain>'
```
where `<vpn-settings-name>` is the name of the VPN connection as displayed in Network Manager,
and `<domain>` is the DNS search domain, i.e. `example.com`


### Useful links
[Using boot-repair tool to fix Windows boot](https://help.ubuntu.com/community/Boot-Repair#A2nd_option_:_install_Boot-Repair_in_Ubuntu)  
[Disabling Secure Boot in Windows](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-8.1-and-8/dn481258(v=win.10))  
[Recovering Ubuntu after installing Windows](https://help.ubuntu.com/community/RecoveringUbuntuAfterInstallingWindows)  

## Extra links and thanks
