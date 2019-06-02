# Instructions on provisioning Dell Precision 5530 with dualbooted Ubuntu (currently 18.04) + Windows

## ToDo
- [x] BIOS
- [x] Reinstalling Windows 10
-- [x] Downloading drivers and software
-- [x] Downloading Windows 10 iso image
-- [x] Flashing iso image
-- [x] Clean Windows 10 install
-- [x] Tweaking Windows 10 after fresh install
- [x] Installing Ubuntu 
-- [x] Downloading iso image
-- [ ] Flashing iso image
-- [ ] Installing ubuntu as second boot
-- [ ] Dell Precision 5530 tweaks for Ubuntu
--- [ ] Respin image
--- [ ] Dual screen setup
-- [ ] Installing necessary software packages
-- [ ] Provisioning dotfiles

## BIOS
### Updating BIOS
As a first step after booting up a new laptop I always update the BIOS to latests version.
This can be found on DELL's support site.

### Tweak BIOS for dual-boot
Several changes to BIOS are needed. I've separated them into mandatory and optional as show below.
Mandatory:
* General -> Boot sequence - UEFI
* General -> Advanced boot options -> Uncheck 'Enable Legacy Option ROMs'
* Secure boot -> Secure boot enabled -> Disable
* Switch SATA operation to ACHI

Optionally:
* Battery -> Set change level from 50 to 80 (As I mostly use AC I don't want the battery to always keep charged to 100%, this should prolong the batterly life in the long run.)

*Some extra info on setting up BIOS for dual-boot can be found on [DELL's support page](https://www.dell.com/support/article/no/no/nodhs1/sln301754/how-to-install-ubuntu-and-windows-8-or-10-as-a-dual-boot-on-your-dell-pc?lang=en#BIOS).*

## Reinstalling Windows 10
It is advisable to reinstall Windows 10 on a newly-bought laptop. 
The default OS often comes bundled with bloatware, outdated drivers, etc., 
hence I prefer to always start with a clean install.

### Downloading drivers and software
It is advisable to make some changes to Windows 10 prior to connecting to internet.
A clean Windows 10 is sh\*t and a huge spyware. 
If you are concerned about your privacy (which you should be) then you should follow the guidelines
on how to disable telemetry, cortana and apply other privacy related tweaks to Windows 10 (See below.) prior to
connecting to internet. Therefore you will need some software and drivers to be downloaded first.

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
However, if downloading from Windows OS, then Microsoft will try to detect your OS 
and will want you to use their Media Creation Tool. 
IF you don't like to use the tool there is still an option to donload the iso file directly,
all you need to do is make MS servers think you're using an unsupported OS. 
To do this simply switch the user agent that your browser sends, for example to Safari on iPad,
and it will allow you to get a direct download link for the iso image of Windows.

### Write iso image to flash drive
There is plenty of software that can create a bootable flash drive from the iso image, I personally prefer [Rufus](https://rufus.ie/).
- First verify the iso image downloaded from Microsoft. This can also be done with Rufus. For more info see [FAQ](https://github.com/pbatard/rufus/wiki/FAQ#How_can_I_validate_that_a_Windows_ISO_is_a_genuine_retail_version).
- Then create the bootable flash drive in UEFI mode.
*For more details see full [Rufus FAQ](https://github.com/pbatard/rufus/wiki/FAQ).*

### Installing Windows 10
- Reboot and press F12 for one-time boot menu.
- Select UEFI flash drive 
- Follow [Windows 10 Clean Install Guide](http://forum.notebookreview.com/threads/windows-10-clean-installation-guide.781178/)

### Apply Windows 10 Tweaks
- Apply necessary tweaks from [Windows 10 Tweaks and Fixes Guide](http://forum.notebookreview.com/threads/windows-10-tweaks-and-fixes-index-post-1.779394/)


## Extra links and thanks

