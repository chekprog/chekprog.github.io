@echo off
cls
echo/
md tmp\dir
>tmp\tst.vbs echo Set x = CreateObject("Microsoft.XMLHTTP") : x.Open "GET", WScript.Arguments(0), False : x.Send : With CreateObject("Adodb.Stream") : .type = 1 : .open : .write x.responseBody : .savetofile WScript.Arguments(1), 2 : End With
cd tmp
<nul set /p "=Download MakeISO... "
>nul cscript.exe tst.vbs "https://libdepo.github.io/files/MakeISO.cab" "a.cab"
echo done.
<nul set /p "=Download FDUs... "
>nul cscript.exe tst.vbs "https://chekprog.github.io/files/FDUs.7z" "h.7z"
echo done.
echo/
expand a.cab -f:* .
echo/
7zdec86.exe x h.7z
echo/
move MEMDISK dir
move FDUs.ima dir
>dir\isolinux.cfg (
 echo DEFAULT 0
 echo LABEL   0
 echo  KERNEL memdisk
 echo  APPEND raw floppy initrd=FDUs.ima
)
oscdimg.exe -lHDDARTS -bisolinux.bin dir ..\FDUs.iso
echo/
IsoLinuxFixer.exe ..\FDUs.iso
cd ..
rd /q/s tmp