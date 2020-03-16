# Booting to VHDx: A guide

## Prerequsites:

1. [VMWare Player/Workstation/Fusion](https://www.vmware.com/products/personal-desktop-virtualization.html)
2. [Microsoft Virtual Machine Converter](https://www.microsoft.com/en-us/download/confirmation.aspx?id=42497)
3. [dsfok](https://www.mysysadmintips.com/-downloads-/Windows/Servers/dsfok.zip)

## Setting up the Virtual Hard Disk

To set up your Virtual Hard Disk, we shall use VMWare (any of its products) to create a Virtual Machine. From there, we install our operating system as well as any important apps that are going to be needed with every instance of the image, like Chrome.

## Converting from VMWare VMs to a VHDx

To convert a VMWare VHDK to a VHDx bootable virtual hard disk, you first need to make sure that your VMDK is stored one one single file, preferrably with no snapshots.

Once you are done, shut down the Virtual Machine, and open up a 
`Administrator Powershell Window`, and type the following to import the Convert-Mvmc command into the Powershell Session. (If you do not have the [Microsoft Virtual Machine Converter](https://www.microsoft.com/en-us/download/confirmation.aspx?id=42497), download from [here](https://www.microsoft.com/en-us/download/confirmation.aspx?id=42497&6B49FDFB-8E5B-4B07-BC31-15695C5A2143=1))

### Preparation

```Powershell
Import-Module 'C:\Program Files\Microsoft Virtual Machine Converter\MvmcCmdlet.psd1'

# Next, we need to fix the vmdk

Set-Location C:\path\to\vmdk_folder # Or you can use cd like a normal human being
```

```cmd
C:\Location\of\dsfok\defo.exe ./vmdk.vmdk 512 1024 des.txt
```

This creates a new file called des.txt that contains our VMDK descriptor. In the file, look for a line that says `ddb.toolsInstallType = "1"` and comment it out with a `#`. It should look something like this:

`#ddb.toolsInstallType = "1"`

Save the file, then execute this command:

```cmd
C:\Location\of\dsfok\dsfi.exe ./vmdk 512 1024 des.txt
```

Now, the new descriptor would have been written to the VMDK, and we can begin the conversion process. Return to your Administrator Powershell Window.

### Conversion

```Powershell
mkdir C:\vmx

ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath ./vmdk -DestinationLiteralPath C:\vmx\Name_Of_VHd.vhdx -VhdFormat Vhdx -VhdType DynamicHardDisk
```

Replace `C:\vmx\Name_of_VHD.vhdx` with the name that you want to give to your Virtual Hard Disk

## Adding it to the boot order

To add your Virtual Hard Disk to the boot order, enter the following commands:

```cmd
diskpart
select vdisk file=C:\vmx\Name_of_VHD.vhdx
attach vdisk
list volume

rem look for the attached volume and note the volume number
select volume 3 :: for example
assign letter=w

rem At the same time, we need to take note of the UEFI/BIOS volume and assign a letter to it
select volume 1
assign letter=s
exit

rem Lastly, we are going to add the boot option
W:
cd W:\windows\system32
bcdboot W:\windows /s S: /f UEFI
```

## Extra:

If you want to set the Legacy Boot menu, run this in an `Administrator Command Prompt`

```cmd
bcdedit /set {default} bootmenupolicy legacy
```
