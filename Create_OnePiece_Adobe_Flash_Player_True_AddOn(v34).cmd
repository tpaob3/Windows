@echo Off

IF /I NOT EXIST "%SystemRoot%\System32\Macromed\Flash\*.ocx" GOTO EXIT
FOR /F "USEBACKQ DELIMS==" %%I IN (`DIR /A-D /OGN /B %SystemRoot%\System32\Macromed\Flash\*.ocx`) DO SET PlayerVersion=%%~nI
SET PlayerVersion=%PlayerVersion:~8%
SET VersionNumber=%PlayerVersion:_=.%

CD /D "%~p0"

RD /S /Q "OnePiece_Adobe_Flash_Player_v%VersionNumber%_True_AddOn"
MD "OnePiece_Adobe_Flash_Player_v%VersionNumber%_True_AddOn"
CD /D "OnePiece_Adobe_Flash_Player_v%VersionNumber%_True_AddOn"

IF %PROCESSOR_ARCHITECTURE% == x86 (
CALL :X32
) Else (
CALL :X64
)

CALL :Create_INI_INF
>"Flash.dif" ECHO .option explicit
>>"Flash.dif" ECHO .set DiskDirectoryTemplate=.
>>"Flash.dif" ECHO .set CabinetNameTemplate="..\OnePiece_Adobe_Flash_Player_v%VersionNumber%_True_AddOn.cab"
>>"Flash.dif" ECHO .set SourceDir=.\
>>"Flash.dif" ECHO .set RptFileName=nul
>>"Flash.dif" ECHO .set InfFileName=nul
>>"Flash.dif" ECHO .set MaxDiskSize=999948288
>>"Flash.dif" ECHO .set Compress=on
>>"Flash.dif" ECHO .set Cabinet=on
>>"Flash.dif" ECHO .set CompressionType=LZX
>>"Flash.dif" ECHO .set CompressionMemory=21
>>"Flash.dif" ECHO.
>>"Flash.dif" ECHO "entries_Flash.ini"
>>"Flash.dif" ECHO "Flash.ocx"
>>"Flash.dif" ECHO "FlashApp.exe"
>>"Flash.dif" ECHO "FlashUAX.cpl"
>>"Flash.dif" ECHO "FlashUAX.dll"
>>"Flash.dif" ECHO "FlashUAX.exe"
>>"Flash.dif" ECHO "swflash.inf"
IF /I EXIST "Flash64.cab" ECHO "Flash64.cab">>"Flash.dif"
"%SystemRoot%\System32\MAKECAB.exe" /f "Flash.dif"
CD /D "%~p0"
RD /S /Q "OnePiece_Adobe_Flash_Player_v%VersionNumber%_True_AddOn"

Goto EXIT

:X32
COPY %SystemRoot%\System32\Macromed\Flash\Flash32_%PlayerVersion%.ocx flash.ocx
COPY %SystemRoot%\System32\Macromed\Flash\FlashUtil32_%PlayerVersion%_ActiveX.exe FlashUAX.exe
COPY %SystemRoot%\System32\Macromed\Flash\FlashUtil32_%PlayerVersion%_ActiveX.dll FlashUAX.dll
COPY %SystemRoot%\System32\FlashPlayerCPLApp.cpl FlashUAX.cpl
COPY %SystemRoot%\System32\FlashPlayerApp.exe FlashApp.exe
Goto EOF

:X64
COPY %SystemRoot%\SysWOW64\Macromed\Flash\Flash32_%PlayerVersion%.ocx flash.ocx
COPY %SystemRoot%\SysWOW64\Macromed\Flash\FlashUtil32_%PlayerVersion%_ActiveX.exe FlashUAX.exe
COPY %SystemRoot%\SysWOW64\Macromed\Flash\FlashUtil32_%PlayerVersion%_ActiveX.dll FlashUAX.dll
COPY %SystemRoot%\SysWOW64\FlashPlayerCPLApp.cpl FlashUAX.cpl
COPY %SystemRoot%\SysWOW64\FlashPlayerApp.exe FlashApp.exe

MD "Flash64"
CD /D "Flash64"
COPY %SystemRoot%\System32\Macromed\Flash\Flash64_%PlayerVersion%.ocx FlashUAX64.ocx
COPY %SystemRoot%\System32\Macromed\Flash\FlashUtil64_%PlayerVersion%_ActiveX.exe FlashUAX64.exe
COPY %SystemRoot%\System32\Macromed\Flash\FlashUtil64_%PlayerVersion%_ActiveX.dll FlashUAX64.dll

>"Flash64.dif" ECHO .option explicit
>>"Flash64.dif" ECHO .set DiskDirectoryTemplate=.
>>"Flash64.dif" ECHO .set CabinetNameTemplate="..\Flash64.cab"
>>"Flash64.dif" ECHO .set SourceDir=.\
>>"Flash64.dif" ECHO .set RptFileName=nul
>>"Flash64.dif" ECHO .set InfFileName=nul
>>"Flash64.dif" ECHO .set MaxDiskSize=999948288
>>"Flash64.dif" ECHO .set Compress=on
>>"Flash64.dif" ECHO .set Cabinet=on
>>"Flash64.dif" ECHO .set CompressionType=LZX
>>"Flash64.dif" ECHO .set CompressionMemory=21
>>"Flash64.dif" ECHO.
>>"Flash64.dif" ECHO "FlashUAX64.ocx"
>>"Flash64.dif" ECHO "FlashUAX64.exe"
>>"Flash64.dif" ECHO "FlashUAX64.dll"
"%SystemRoot%\System32\MAKECAB.exe" /f "Flash64.dif"
CD /D "%~p0\OnePiece_Adobe_Flash_Player_v%VersionNumber%_True_AddOn"
RD /S /Q "Flash64"
Goto EOF

:Create_INI_INF
>"entries_Flash.ini" ECHO ;by OnePiece
>>"entries_Flash.ini" ECHO ;###########################################################################################################################
>>"entries_Flash.ini" ECHO ;This section contains version information to nLite - RyanVM Integrator - WinNT6.x True Integrator Entries_swflash.ini
>>"entries_Flash.ini" ECHO ;# SPECIAL THANKS TO NONNO FABIO Update By Milk-Chan
>>"entries_Flash.ini" ECHO ;# Huge thanks voidseesaw (http://voidseesaw.com) and N1K (http://www.WinCert.net) host this AddOn
>>"entries_Flash.ini" ECHO ;# a huge thanks to all Italian guys and all guys of WinCert Forum and Eng2ITA Forum and RyanVM Forum
>>"entries_Flash.ini" ECHO ;# This file contains a list of all necessary entries to add in the various installation
>>"entries_Flash.ini" ECHO ;# files of Windows for the integration of OnePiece Adobe Flash Player %VersionNumber% (by Adobe Systems, Inc) AddOn.
>>"entries_Flash.ini" ECHO ;###########################################################################################################################
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO ;This section contains version info for RyanVM Integrator - nLite - WinNT6.x True Integrator
>>"entries_Flash.ini" ECHO [general]
>>"entries_Flash.ini" ECHO builddate=2021-11-14
>>"entries_Flash.ini" ECHO description=Adobe Flash Player ActiveX
>>"entries_Flash.ini" ECHO language=neutral
>>"entries_Flash.ini" ECHO title=Adobe Flash Player
>>"entries_Flash.ini" ECHO version=%%VersionNumber%%
>>"entries_Flash.ini" ECHO website=http://get.adobe.com/flashplayer/
>>"entries_Flash.ini" ECHO Windows=ALL
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO ;;WinNT6.x True Integrator Optional info
>>"entries_Flash.ini" ECHO ;processorArchitecture=x86
>>"entries_Flash.ini" ECHO ReleaseType=True AddOn
>>"entries_Flash.ini" ECHO Customizedby=OnePiece
>>"entries_Flash.ini" ECHO Copyright=Adobe, Inc.
>>"entries_Flash.ini" ECHO Company=Adobe Systems, Inc.
>>"entries_Flash.ini" ECHO InstallPackageName=swflash.inf
>>"entries_Flash.ini" ECHO LastUpdateTime=2015-01-01T14:22:11Z
>>"entries_Flash.ini" ECHO ;Adobe Systems Incorporated
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO ;This section contains entries that need to go into the [Components] section of the Sysoc.inf file.
>>"entries_Flash.ini" ECHO [Sysoc]
>>"entries_Flash.ini" ECHO ;;SWFlash=ocgen.dll,OcEntry,SWFlash.inf,,7 ;;; Windows Server 2003
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO [dosnet_files]
>>"entries_Flash.ini" ECHO d1,FlashUAX.cpl
>>"entries_Flash.ini" ECHO d1,FlashUAX.exe
>>"entries_Flash.ini" ECHO d1,FlashUAX.dll
>>"entries_Flash.ini" ECHO d1,FlashApp.exe
>>"entries_Flash.ini" ECHO d1,swflash.inf
>>"entries_Flash.ini" ECHO d1,Flash.ocx
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO ;This section contains entries that need to go into the [SourceDisksFiles] section of txtsetup.sif
>>"entries_Flash.ini" ECHO [txtsetup_files]
>>"entries_Flash.ini" ECHO FlashUAX.cpl = 100,,,,,,,,3,3
>>"entries_Flash.ini" ECHO FlashUAX.exe = 100,,,,,,,,3,3
>>"entries_Flash.ini" ECHO FlashUAX.dll = 100,,,,,,,,3,3
>>"entries_Flash.ini" ECHO FlashApp.exe = 100,,,,,,,,3,3
>>"entries_Flash.ini" ECHO swflash.inf  = 100,,,,,,,20,0,0
>>"entries_Flash.ini" ECHO Flash.ocx    = 100,,,,,,,,3,3
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO ;This section contains a list of files in i386 which should be compressed at the very
>>"entries_Flash.ini" ECHO ;beginning of the integration process
>>"entries_Flash.ini" ECHO [i386_compress]
>>"entries_Flash.ini" ECHO rvmtemp\extracted\FlashUAX.cpl
>>"entries_Flash.ini" ECHO rvmtemp\extracted\FlashUAX.exe
>>"entries_Flash.ini" ECHO rvmtemp\extracted\FlashUAX.dll
>>"entries_Flash.ini" ECHO rvmtemp\extracted\FlashApp.exe
>>"entries_Flash.ini" ECHO rvmtemp\extracted\swflash.inf
>>"entries_Flash.ini" ECHO rvmtemp\extracted\Flash.ocx
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO ;Removes files from i386 which are no longer necessary
>>"entries_Flash.ini" ECHO [obsolete_files]
>>"entries_Flash.ini" ECHO Flash64.cab
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO ;This section allows you to edit things that normally would not be possible to edit.
>>"entries_Flash.ini" ECHO [ExtraFileEdits]
>>"entries_Flash.ini" ECHO swflash.inf^|16425^|11^|
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO ;This section contains entries that need to go into the [Components] section of the OCSysPrep.inf file.
>>"entries_Flash.ini" ECHO [SysPrepOC]
>>"entries_Flash.ini" ECHO swflash=setupapi.dll,InstallHinfSection,swflash.inf,swflash
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO [GlobalOffLineChanges.Install]
>>"entries_Flash.ini" ECHO 	AddReg              = Flash.AddReg
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO [GlobalOffLineChanges.Uninstall]
>>"entries_Flash.ini" ECHO 	DelReg               = Flash.DelReg
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO [Flash.AddReg]
>>"entries_Flash.ini" ECHO 	HKU, "DefaultUsers\Software\Macromedia\FlashPlayer","FlashPlayerVersion", ,"%%VersionNumber%%~installVector=1"
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO [Flash.DelReg]
>>"entries_Flash.ini" ECHO 	HKU, "DefaultUsers\Software\Macromedia\FlashPlayer"
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO [ProcessesToRunBeforeIntegration]
>>"entries_Flash.ini" ECHO cmd.exe /c DEL /Q /F """%%16425%%\Macromed\Flash\Flash*.ocx"""
>>"entries_Flash.ini" ECHO cmd.exe /c DEL /Q /F """%%16425%%\Macromed\Flash\Flash*ActiveX*.dll"""
>>"entries_Flash.ini" ECHO cmd.exe /c DEL /Q /F """%%16425%%\Macromed\Flash\Flash*ActiveX*.exe"""
>>"entries_Flash.ini" ECHO cmd.exe /c IF /I NOT EXIST """%%16425%%\Macromed\Flash\NPSWF*.dll""" DEL /Q /F """%%16425%%\Macromed\Flash\FlashInstall*"""
>>"entries_Flash.ini" ECHO cmd.exe /c IF /I NOT EXIST """%%16425%%\Macromed\Flash\NPSWF*.dll""" DEL /Q /F """%%16425%%\Macromed\Flash\*.cfg"""
>>"entries_Flash.ini" ECHO cmd.exe /c IF /I NOT EXIST """%%16425%%\Macromed\Flash\NPSWF*.dll""" DEL /Q /F """%%10%%\Tasks\Adobe Flash Player Updater*.job"""
>>"entries_Flash.ini" ECHO cmd.exe /c DEL /Q /F """%%11%%\Macromed\Flash\Flash*.ocx"""
>>"entries_Flash.ini" ECHO cmd.exe /c DEL /Q /F """%%11%%\Macromed\Flash\Flash*ActiveX*.dll"""
>>"entries_Flash.ini" ECHO cmd.exe /c DEL /Q /F """%%11%%\Macromed\Flash\Flash*ActiveX*.exe"""
>>"entries_Flash.ini" ECHO cmd.exe /c IF /I NOT EXIST """%%11%%\Macromed\Flash\NPSWF*.dll""" DEL /Q /F """%%11%%\Macromed\Flash\FlashInstall*"""
>>"entries_Flash.ini" ECHO cmd.exe /c IF /I NOT EXIST """%%11%%\Macromed\Flash\NPSWF*.dll""" DEL /Q /F """%%11%%\Macromed\Flash\*.cfg"""
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO [SecurityFilesBeforeIntegration]
>>"entries_Flash.ini" ECHO "%%16425%%\Macromed\Flash",2,"O:BAD:PAI(A;;FA;;;BA)(A;OICIIO;GA;;;BA)(A;;0x1200a9;;;SY)(A;OICIIO;GXGR;;;SY)(A;;0x1200a9;;;BU)(A;OICIIO;GXGR;;;BU)(A;;0x1200a9;;;AC)(A;OICIIO;GXGR;;;AC)"
>>"entries_Flash.ini" ECHO "%%11%%\Macromed\Flash",2,"O:BAD:PAI(A;;FA;;;BA)(A;OICIIO;GA;;;BA)(A;;0x1200a9;;;SY)(A;OICIIO;GXGR;;;SY)(A;;0x1200a9;;;BU)(A;OICIIO;GXGR;;;BU)(A;;0x1200a9;;;AC)(A;OICIIO;GXGR;;;AC)"
>>"entries_Flash.ini" ECHO "%%16425%%\FlashPlayerCPLApp.cpl",2,"O:BAD:AI(A;;FA;;;BA)(A;;FA;;;SY)(A;;0x1200a9;;;BU)(A;;0x1200a9;;;AC)(A;ID;FA;;;SY)(A;ID;FA;;;BA)(A;ID;0x1200a9;;;BU)(A;ID;0x1200a9;;;AC)"
>>"entries_Flash.ini" ECHO "%%11%%\FlashPlayerCPLApp.cpl",2,"O:BAD:AI(A;;FA;;;BA)(A;;FA;;;SY)(A;;0x1200a9;;;BU)(A;;0x1200a9;;;AC)(A;ID;FA;;;SY)(A;ID;FA;;;BA)(A;ID;0x1200a9;;;BU)(A;ID;0x1200a9;;;AC)"
>>"entries_Flash.ini" ECHO "%%11%%\FlashPlayerApp.exe",2,"O:BAD:P(A;;GA;;;BA)(A;;GR;;;SY)(A;;GR;;;BU)"
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO [SecurityRegistryBeforeIntegration]
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\.mfp",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\.sol",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\.sor",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\.spl",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\.swf",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO [SecurityRegistryBeforeIntegration.NT.6.2]
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\CLSID\{A483C63A-CDBC-426E-BF93-872502E8144E}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\Interface\{E3F2C3CB-5EB8-4A04-B22C-7E3B4B6AF30F}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\.mfp",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\.sol",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\.sor",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\.spl",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\.swf",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\CLSID\{B019E3BF-E7E5-453C-A2E4-D2C18CA0866F}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\FlashFactory.FlashFactory",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\FlashFactory.FlashFactory.1",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\Interface\{299817DA-1FAC-4CE2-8F48-A108237013BD}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\MacromediaFlashPaper.MacromediaFlashPaper",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\MIME\Database\Content Type\application/futuresplash",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\MIME\Database\Content Type\application/x-shockwave-flash",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.1",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.3",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.4",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.5",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.6",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.7",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.8",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.9",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.10",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.11",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.12",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.13",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.14",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.15",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.16",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.17",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.18",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.19",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.20",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.21",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.22",2,"O:SYD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\TypeLib\{FAB3E735-69C7-453B-A446-B6823C6DF1C9}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\Wow6432Node\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\Wow6432Node\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\Wow6432Node\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\Wow6432Node\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Classes\Wow6432Node\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Macromedia\FlashPlayer",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Macromedia\FlashPlayerActiveX",2,"O:SYD:AI(A;CIID;KR;;;BU)(A;CIID;KA;;;BA)(A;CIID;KA;;;SY)(A;CIIOID;KA;;;CO)(A;CIID;KR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Microsoft\Internet Explorer\ActiveX Compatibility\{D27CDB6E-AE6D-11cf-96B8-444553540000}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Microsoft\Internet Explorer\ActiveX Compatibility\{D27CDB70-AE6D-11cf-96B8-444553540000}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Microsoft\Internet Explorer\Low Rights\ElevationPolicy\{FAF199D2-BFA7-4394-A4DE-044A08E59B32}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FlashPlayerApp.exe",2,"O:BAD:AI(A;ID;KR;;;BU)(A;CIIOID;GR;;;BU)(A;ID;KA;;;BA)(A;CIIOID;GA;;;BA)(A;ID;KA;;;SY)(A;CIIOID;GA;;;SY)(A;CIIOID;GA;;;CO)(A;ID;KR;;;AC)(A;CIIOID;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Wow6432Node\Macromedia\FlashPlayer",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Wow6432Node\Macromedia\FlashPlayerActiveX",2,"O:SYD:AI(A;CIID;KR;;;BU)(A;CIID;KA;;;BA)(A;CIID;KA;;;SY)(A;CIIOID;KA;;;CO)(A;CIID;KR;;;AC)"
>>"entries_Flash.ini" ECHO "MACHINE\SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\ActiveX Compatibility\{D27CDB70-AE6D-11cf-96B8-444553540000}",2,"O:S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464D:PAI(A;;KA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;CIIO;GA;;;S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464)(A;;KR;;;SY)(A;CIIO;GR;;;SY)(A;;KA;;;BA)(A;CIIO;GA;;;BA)(A;;KR;;;BU)(A;CIIO;GR;;;BU)(A;;KR;;;AC)(A;CIIO;GR;;;AC)"
>>"entries_Flash.ini" ECHO "USER\Software\Macromedia\FlashPlayer",2,"O:SYD:AI(A;CIID;KR;;;BU)(A;CIID;KA;;;BA)(A;CIID;KA;;;SY)(A;CIIOID;KA;;;CO)(A;CIID;KR;;;AC)"
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO [Strings]
>>"entries_Flash.ini" ECHO productname="Adobe Flash Player"
>>"entries_Flash.ini" ECHO VersionNumber = "%VersionNumber%"
>>"entries_Flash.ini" ECHO PlayerVersion = "%PlayerVersion%"
>>"entries_Flash.ini" ECHO.
>>"entries_Flash.ini" ECHO.

>"swflash.inf" ECHO ;OnePiece Update By Milk-Chan
>>"swflash.inf" ECHO [Version]
>>"swflash.inf" ECHO 	signature="$Windows NT$"
>>"swflash.inf" ECHO 	ClassGUID={00000000-0000-0000-0000-000000000000}
>>"swflash.inf" ECHO 	SetupClass=Base
>>"swflash.inf" ECHO 	LayoutFile=layout.inf
>>"swflash.inf" ECHO 	DriverVer=14/11/2021, %%VersionNumber%%
>>"swflash.inf" ECHO 	Provider=Adobe Inc.
>>"swflash.inf" ECHO 	Customizedby=OnePiece,Milk-Chan
>>"swflash.inf" ECHO 	PackageDisplayName=%%DefaultName%%
>>"swflash.inf" ECHO 	PackageReleaseType=True AddOn
>>"swflash.inf" ECHO 	PackageLanguage=%%LANGNAME%%
>>"swflash.inf" ECHO 	PackageDescription=%%SWFlashTip%%
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [DefaultInstall]
>>"swflash.inf" ECHO 	CopyFiles = SWFiles, SWFiles.CPL
>>"swflash.inf" ECHO 	AddReg = SW.AddReg, SW.NT5.AddReg
>>"swflash.inf" ECHO 	RegisterDlls = Base.RegSvr
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [UpdateInstall]
>>"swflash.inf" ECHO 	AddReg = SW.AddReg, SW.NT5.AddReg
>>"swflash.inf" ECHO 	RegisterOCXs=Base.RegSvr.Update
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFiles]
>>"swflash.inf" ECHO 	Flash32_%%PlayerVersion%%.ocx,flash.ocx, ,32
>>"swflash.inf" ECHO 	FlashUtil32_%%PlayerVersion%%_ActiveX.exe,FlashUAX.exe, ,32
>>"swflash.inf" ECHO 	FlashUtil32_%%PlayerVersion%%_ActiveX.dll,FlashUAX.dll, ,32
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFiles.CPL]
>>"swflash.inf" ECHO 	FlashPlayerCPLApp.cpl,FlashUAX.cpl, ,32
>>"swflash.inf" ECHO 	FlashPlayerApp.exe,FlashApp.exe, ,32
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFiles.x64]
>>"swflash.inf" ECHO 	Flash64_%%PlayerVersion%%.ocx,FlashUAX64.ocx, ,32
>>"swflash.inf" ECHO 	FlashUtil64_%%PlayerVersion%%_ActiveX.exe,FlashUAX64.exe, ,32
>>"swflash.inf" ECHO 	FlashUtil64_%%PlayerVersion%%_ActiveX.dll,FlashUAX64.dll, ,32
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFiles.x64.CPL]
>>"swflash.inf" ECHO 	FlashPlayerCPLApp.cpl,FlashUAX.cpl, ,32
>>"swflash.inf" ECHO 	FlashPlayerApp.exe,FlashApp.exe, ,32
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SourceDisksNames]
>>"swflash.inf" ECHO 	1="Flash Player Files","WIN51",,"i386"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SourceDisksNames.amd64]
>>"swflash.inf" ECHO 	2="Flash x64 Files","Flash64.cab",,"i386"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SourceDisksFiles]
>>"swflash.inf" ECHO 	Flash.ocx=1,,16929968
>>"swflash.inf" ECHO 	FlashUAX.cpl=1,,71344
>>"swflash.inf" ECHO 	FlashUAX.exe=1,,959152
>>"swflash.inf" ECHO 	FlashUAX.dll=1,,534704
>>"swflash.inf" ECHO 	FlashApp.exe=1,,701616
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SourceDisksFiles.amd64]
>>"swflash.inf" ECHO 	FlashUAX64.ocx=2,,12451016
>>"swflash.inf" ECHO 	FlashUAX64.exe=2,,417992
>>"swflash.inf" ECHO 	FlashUAX64.dll=2,,513224
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [DestinationDirs]
>>"swflash.inf" ECHO 	SWFiles        = 16425, "Macromed\Flash"
>>"swflash.inf" ECHO 	SWFiles.CPL    = 16425
>>"swflash.inf" ECHO 	SWFiles.x64     = 11, "Macromed\Flash"
>>"swflash.inf" ECHO 	SWFiles.x64.CPL = 11
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [Flash.Reg.Backup]
>>"swflash.inf" ECHO HKLM, "SOFTWARE\Classes\.mfp"
>>"swflash.inf" ECHO HKLM, "SOFTWARE\Classes\.sol"
>>"swflash.inf" ECHO HKLM, "SOFTWARE\Classes\.sor"
>>"swflash.inf" ECHO HKLM, "SOFTWARE\Classes\.spl"
>>"swflash.inf" ECHO HKLM, "SOFTWARE\Classes\.swf"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO ;	HKLM,"SOFTWARE\Microsoft\Active Setup\Installed Components\%%GUID%%"
>>"swflash.inf" ECHO ;	HKLM,"SOFTWARE\Microsoft\Active Setup\Installed Components\%%GUIDFACT%%"
>>"swflash.inf" ECHO ;	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Accepted Documents"
>>"swflash.inf" ECHO ;	HKLM,"SOFTWARE\Classes\CLSID\{B019E3BF-E7E5-453C-A2E4-D2C18CA0866F}"
>>"swflash.inf" ECHO ;	HKLM,"SOFTWARE\Classes\Interface\{299817DA-1FAC-4CE2-8F48-A108237013BD}"
>>"swflash.inf" ECHO ;	HKLM,"SOFTWARE\Classes\TypeLib\{FAB3E735-69C7-453B-A446-B6823C6DF1C9}"
>>"swflash.inf" ECHO ;	HKCU,"Software\Macromedia\FlashPlayer"
>>"swflash.inf" ECHO ;	;HKLM,"SOFTWARE\Macromedia\FlashPlayerActiveX"
>>"swflash.inf" ECHO ;	;HKLM,"SOFTWARE\Macromedia\FlashPlayerActiveXReleaseType"
>>"swflash.inf" ECHO ;	HKLM,"SOFTWARE\Microsoft\Internet Explorer\Low Rights\ElevationPolicy\{FAF199D2-BFA7-4394-A4DE-044A08E59B32}"
>>"swflash.inf" ECHO ;	HKLM,"SOFTWARE\Microsoft\Internet Explorer\ActiveX Compatibility\%%GUID%%"
>>"swflash.inf" ECHO ;	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SW.AddReg]
>>"swflash.inf" ECHO ;	;;	Flash11*.ocx Registry
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Macromedia\FlashPlayer", "CurrentVersion", ,"11,1,102,55"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Macromedia\FlashPlayer\SafeVersions", "6.0", %%REG_DWORD%%, ff,ff,ff,ff
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Macromedia\FlashPlayer\SafeVersions", "7.0", %%REG_DWORD%%, ff,ff,ff,ff
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Macromedia\FlashPlayer\SafeVersions", "8.0", %%REG_DWORD%%, ff,ff,ff,ff
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Macromedia\FlashPlayer\SafeVersions", "9.0", %%REG_DWORD%%, ff,ff,ff,ff
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Macromedia\FlashPlayer\SafeVersions", "10.0", %%REG_DWORD%%, 1e,00,e6,00
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Macromedia\FlashPlayer\SafeVersions", "11.0", %%REG_DWORD%%, 37,00,66,00
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\FlashFactory.FlashFactory", , ,"Macromedia Flash Factory Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\FlashFactory.FlashFactory\CLSID", , ,"{D27CDB70-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\FlashFactory.FlashFactory\CurVer", , ,"FlashFactory.FlashFactory.1"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\FlashFactory.FlashFactory.1", , ,"Macromedia Flash Factory Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\FlashFactory.FlashFactory.1\CLSID", , ,"{D27CDB70-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}", , ,"Macromedia Flash Factory Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\Control", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\InprocServer32", , ,"%%16425%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\InprocServer32", "ThreadingModel", ,"Apartment"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\ProgID", , ,"FlashFactory.FlashFactory.1"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\Programmable", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\ToolboxBitmap32", , ,"%%16425%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx, 1"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\TypeLib", , ,"{D27CDB6B-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\Version", , ,"1.0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\VersionIndependentProgID", , ,"FlashFactory.FlashFactory"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Microsoft\Internet Explorer\ActiveX Compatibility\{D27CDB70-AE6D-11cf-96B8-444553540000}", "Compatibility Flags", %%REG_DWORD%%, 00,00,01,00
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\.mfp", , ,"MacromediaFlashPaper.MacromediaFlashPaper"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\.mfp", "Content Type", ,"application/x-shockwave-flash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\.sol", "Content Type", ,"text/plain"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\.sor", "Content Type", ,"text/plain"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\.spl", , ,"ShockwaveFlash.ShockwaveFlash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\.spl", "Content Type", ,"application/futuresplash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\.swf", , ,"ShockwaveFlash.ShockwaveFlash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\.swf", "Content Type", ,"application/x-shockwave-flash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\MacromediaFlashPaper.MacromediaFlashPaper", , ,"Macromedia Flash Paper"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\MacromediaFlashPaper.MacromediaFlashPaper\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\MacromediaFlashPaper.MacromediaFlashPaper\DefaultIcon", , ,"%%16426%%\Internet Explorer\iexplore.exe,-17"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\MacromediaFlashPaper.MacromediaFlashPaper\shell\open\command", , ,"""%%16426%%\Internet Explorer\iexplore.exe"" -nohome ""%%%%1"""
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash\CurVer", , ,"ShockwaveFlash.ShockwaveFlash.16"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.1", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.1\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.3", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.3\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.4", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.4\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.5", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.5\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.6", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.6\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.7", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.7\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.8", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.8\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.9", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.9\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.10", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.10\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.11", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.11\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.12", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.12\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.13", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.13\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.14", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.14\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.15", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.15\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.16", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.16\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.17", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.17\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.18", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.18\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.19", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.19\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.20", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.20\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.21", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.21\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.22", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.22\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\Control", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\EnableFullPage\.mfp", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\EnableFullPage\.spl", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\EnableFullPage\.swf", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\Implemented Categories\{31CAF6E4-D6AA-4090-A050-A5AC8972E9EF}", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\Implemented Categories\{59FB2056-D625-48D0-A944-1A85B5AB2640}", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\Implemented Categories\{7DD95801-9882-11CF-9FA9-00AA006C42C4}", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\Implemented Categories\{7DD95802-9882-11CF-9FA9-00AA006C42C4}", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\InprocServer32", , ,"%%16425%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\InprocServer32", "ThreadingModel", ,"Apartment"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\MiscStatus", , ,"0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\MiscStatus\1", , ,"131473"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\ProgID", , ,"ShockwaveFlash.ShockwaveFlash.16"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\Programmable", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\ToolboxBitmap32", , ,"%%16425%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx, 1"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\TypeLib", , ,"{D27CDB6B-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\Version", , ,"1.0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\VersionIndependentProgID", , ,"ShockwaveFlash.ShockwaveFlash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\MIME\Database\Content Type\application/futuresplash", "Extension", ,".spl"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\MIME\Database\Content Type\application/futuresplash", "CLSID", ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\MIME\Database\Content Type\application/x-shockwave-flash", "Extension", ,".swf"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\MIME\Database\Content Type\application/x-shockwave-flash", "CLSID", ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}", , ,"ISimpleTextSelection"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}\TypeLib", , ,"{57A0E746-3863-4D20-A811-950C84F1DB9B}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}\TypeLib", "Version", ,"1.1"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}", , ,"IFlashAccessibility"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}\TypeLib", , ,"{57A0E746-3863-4D20-A811-950C84F1DB9B}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}\TypeLib", "Version", ,"1.1"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}", , ,"IFlashObject"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}\TypeLib", , ,"{D27CDB6B-AE6D-11CF-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}\TypeLib", "Version", ,"1.0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}", , ,"IShockwaveFlash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}\TypeLib", , ,"{D27CDB6B-AE6D-11CF-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}\TypeLib", "Version", ,"1.0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}", , ,"_IShockwaveFlashEvents"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}\ProxyStubClsid32", , ,"{00020420-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}\TypeLib", , ,"{D27CDB6B-AE6D-11CF-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}\TypeLib", "Version", ,"1.0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1", , ,"FlashAccessibility"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1\0\win32", , ,"%%16425%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx\2"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1\FLAGS", , ,"0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1\HELPDIR", , ,"%%16425%%\Macromed\Flash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0", , ,"Shockwave Flash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0\0\win32", , ,"%%16425%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0\FLAGS", , ,"0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0\HELPDIR", , ,"%%16425%%\Macromed\Flash"
>>"swflash.inf" ECHO ;
>>"swflash.inf" ECHO ;	;;	Flash11*.ocx x64 Registry
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Wow6432Node\Macromedia\FlashPlayer", "CurrentVersion", ,"11,1,102,55"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Wow6432Node\Macromedia\FlashPlayer\SafeVersions", "6.0", %%REG_DWORD%%, ff,ff,ff,ff
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Wow6432Node\Macromedia\FlashPlayer\SafeVersions", "7.0", %%REG_DWORD%%, ff,ff,ff,ff
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Wow6432Node\Macromedia\FlashPlayer\SafeVersions", "8.0", %%REG_DWORD%%, ff,ff,ff,ff
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Wow6432Node\Macromedia\FlashPlayer\SafeVersions", "9.0", %%REG_DWORD%%, ff,ff,ff,ff
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Wow6432Node\Macromedia\FlashPlayer\SafeVersions", "10.0", %%REG_DWORD%%, 1e,00,e6,00
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Wow6432Node\Macromedia\FlashPlayer\SafeVersions", "11.0", %%REG_DWORD%%, 37,00,66,00
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}", , ,"Macromedia Flash Factory Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\Control", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\InprocServer32", , ,"%%16425%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\InprocServer32", "ThreadingModel", ,"Apartment"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\ProgID", , ,"FlashFactory.FlashFactory.1"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\Programmable", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\ToolboxBitmap32", , ,"%%16425%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx, 1"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\TypeLib", , ,"{D27CDB6B-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\Version", , ,"1.0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}\VersionIndependentProgID", , ,"FlashFactory.FlashFactory"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\ActiveX Compatibility\{D27CDB70-AE6D-11cf-96B8-444553540000}", "Compatibility Flags", %%REG_DWORD%%, 00,00,01,00
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\Control", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\EnableFullPage\.mfp", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\EnableFullPage\.spl", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\EnableFullPage\.swf", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\Implemented Categories\{31CAF6E4-D6AA-4090-A050-A5AC8972E9EF}", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\Implemented Categories\{59FB2056-D625-48D0-A944-1A85B5AB2640}", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\Implemented Categories\{7DD95801-9882-11CF-9FA9-00AA006C42C4}", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\Implemented Categories\{7DD95802-9882-11CF-9FA9-00AA006C42C4}", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\InprocServer32", , ,"%%16425%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\InprocServer32", "ThreadingModel", ,"Apartment"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\MiscStatus", , ,"0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\MiscStatus\1", , ,"131473"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\ProgID", , ,"ShockwaveFlash.ShockwaveFlash.16"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\Programmable", ,0x10
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\ToolboxBitmap32", , ,"%%16425%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx, 1"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\TypeLib", , ,"{D27CDB6B-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\Version", , ,"1.0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\VersionIndependentProgID", , ,"ShockwaveFlash.ShockwaveFlash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}", , ,"ISimpleTextSelection"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}\TypeLib", , ,"{57A0E746-3863-4D20-A811-950C84F1DB9B}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}\TypeLib", "Version", ,"1.1"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}", , ,"IFlashAccessibility"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}\TypeLib", , ,"{57A0E746-3863-4D20-A811-950C84F1DB9B}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}\TypeLib", "Version", ,"1.1"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}", , ,"IFlashObject"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}\TypeLib", , ,"{D27CDB6B-AE6D-11CF-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}\TypeLib", "Version", ,"1.0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}", , ,"IShockwaveFlash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}\TypeLib", , ,"{D27CDB6B-AE6D-11CF-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}\TypeLib", "Version", ,"1.0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}", , ,"_IShockwaveFlashEvents"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}\ProxyStubClsid32", , ,"{00020420-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}\TypeLib", , ,"{D27CDB6B-AE6D-11CF-96B8-444553540000}"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}\TypeLib", "Version", ,"1.0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1", , ,"FlashAccessibility"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1\0\win32", , ,"%%16425%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx\2"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1\FLAGS", , ,"0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1\HELPDIR", , ,"%%16425%%\Macromed\Flash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0", , ,"Shockwave Flash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0\0\win32", , ,"%%16425%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0\FLAGS", , ,"0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0\HELPDIR", , ,"%%16425%%\Macromed\Flash"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO 	HKCU,"Software\Macromedia\FlashPlayer","FlashPlayerVersion",,"%%VersionNumber%%~installVector=1"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Macromedia\FlashPlayer", "CheckFrequency", %%REG_DWORD%%, 1
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Internet Explorer\ActiveX Compatibility\%%GUID%%", "Compatibility Flags", %%REG_DWORD%%, 0
>>"swflash.inf" ECHO 	;HKLM,"SOFTWARE\Microsoft\Internet Explorer\ActiveX Compatibility\%%GUIDFACT%%", "Compatibility Flags", %%REG_DWORD%%, 0
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Macromedia\FlashPlayerActiveX", "isScriptDebugger", %%REG_DWORD%%, 0
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Macromedia\FlashPlayerActiveX", "Version", ,"%%VersionNumber%%"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Macromedia\FlashPlayerActiveX", "PlayerPath", ,"%%16425%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Macromedia\FlashPlayerActiveX", "UninstallerPath", ,"%%16425%%\Macromed\Flash\FlashUtil32_%%PlayerVersion%%_ActiveX.exe"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Macromedia\FlashPlayerActiveXReleaseType", "Release", %%REG_DWORD%%, 1
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Internet Explorer\Low Rights\ElevationPolicy\{FAF199D2-BFA7-4394-A4DE-044A08E59B32}", "Policy", %%REG_DWORD%%, 3
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Internet Explorer\Low Rights\ElevationPolicy\{FAF199D2-BFA7-4394-A4DE-044A08E59B32}", "AppPath", ,"%%16425%%\Macromed\Flash"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Internet Explorer\Low Rights\ElevationPolicy\{FAF199D2-BFA7-4394-A4DE-044A08E59B32}", "AppName", ,"FlashUtil32_%%PlayerVersion%%_ActiveX.exe"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\CLSID\{B019E3BF-E7E5-453C-A2E4-D2C18CA0866F}", , ,"FlashBroker"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\CLSID\{B019E3BF-E7E5-453C-A2E4-D2C18CA0866F}", "LocalizedString", ,"@%%16425%%\Macromed\Flash\FlashUtil32_%%PlayerVersion%%_ActiveX.exe,-101"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\CLSID\{B019E3BF-E7E5-453C-A2E4-D2C18CA0866F}\Elevation", "Enabled", %%REG_DWORD%%, 1
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\CLSID\{B019E3BF-E7E5-453C-A2E4-D2C18CA0866F}\LocalServer32", , ,"%%16425%%\Macromed\Flash\FlashUtil32_%%PlayerVersion%%_ActiveX.exe"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\CLSID\{B019E3BF-E7E5-453C-A2E4-D2C18CA0866F}\TypeLib", , ,"{FAB3E735-69C7-453B-A446-B6823C6DF1C9}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Interface\{299817DA-1FAC-4CE2-8F48-A108237013BD}", , ,"IFlashBroker6"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Interface\{299817DA-1FAC-4CE2-8F48-A108237013BD}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Interface\{299817DA-1FAC-4CE2-8F48-A108237013BD}\TypeLib", , ,"{FAB3E735-69C7-453B-A446-B6823C6DF1C9}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Interface\{299817DA-1FAC-4CE2-8F48-A108237013BD}\TypeLib", "Version", ,"1.0"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\TypeLib\{FAB3E735-69C7-453B-A446-B6823C6DF1C9}", , ,""
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\TypeLib\{FAB3E735-69C7-453B-A446-B6823C6DF1C9}\1.0",,,"FlashBroker"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\TypeLib\{FAB3E735-69C7-453B-A446-B6823C6DF1C9}\1.0\0\win32",,,"%%16425%%\Macromed\Flash\FlashUtil32_%%PlayerVersion%%_ActiveX.exe"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\TypeLib\{FAB3E735-69C7-453B-A446-B6823C6DF1C9}\1.0\FLAGS",,,"0"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\TypeLib\{FAB3E735-69C7-453B-A446-B6823C6DF1C9}\1.0\HELPDIR",,,"%%16425%%\Macromed\Flash\FlashUtil32_%%PlayerVersion%%_ActiveX.exe"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FlashPlayerApp.exe", "DisableExceptionChainValidation", %%REG_DWORD%%, 0
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SW.NT5.AddReg]
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Active Setup\Installed Components\%%GUID%%",,,"%%DefaultName%%"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Active Setup\Installed Components\%%GUID%%","ComponentID",,"%%ComponentID%%"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Active Setup\Installed Components\%%GUID%%","IsInstalled",0x00010001,1
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Active Setup\Installed Components\%%GUID%%","Version",,"%%VersionNumber%%"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Active Setup\Installed Components\%%GUID%%","Locale",,"%%LocaleID%%"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Active Setup\Installed Components\%%GUIDFACT%%",,,"%%DefaultName%%"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Active Setup\Installed Components\%%GUIDFACT%%","ComponentID",,"%%ComponentID%%"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Active Setup\Installed Components\%%GUIDFACT%%","IsInstalled",0x00010001,1
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Active Setup\Installed Components\%%GUIDFACT%%","Version",,"%%VersionNumber%%"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Active Setup\Installed Components\%%GUIDFACT%%","Locale",,"%%LocaleID%%"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Accepted Documents","flash",,"application/x-shockwave-flash"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Extended Properties\{2CA4F306-B280-4ab2-B5E1-1DFA3583F046}", "%%11%%\FlashPlayerCPLApp.cpl", %%REG_DWORD%%, 10
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SW.NT6.AddReg]
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Extended Properties\System.ControlPanel.Category", "%%11%%\FlashPlayerCPLApp.cpl", %%REG_DWORD%%, 10
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SW.amd64.AddReg]
>>"swflash.inf" ECHO ;	;;	Flash64_*.ocx Registry		(;;;; = Flash11*.ocx also adds this registry)
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\.mfp", , ,"MacromediaFlashPaper.MacromediaFlashPaper"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\.mfp", "Content Type", ,"application/x-shockwave-flash"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\.sol", "Content Type", ,"text/plain"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\.sor", "Content Type", ,"text/plain"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\.spl", , ,"ShockwaveFlash.ShockwaveFlash"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\.spl", "Content Type", ,"application/futuresplash"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\.swf", , ,"ShockwaveFlash.ShockwaveFlash"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\.swf", "Content Type", ,"application/x-shockwave-flash"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\FlashFactory.FlashFactory", , ,"Macromedia Flash Factory Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\FlashFactory.FlashFactory\CLSID", , ,"{D27CDB70-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\FlashFactory.FlashFactory\CurVer", , ,"FlashFactory.FlashFactory.1"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\FlashFactory.FlashFactory.1", , ,"Macromedia Flash Factory Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\FlashFactory.FlashFactory.1\CLSID", , ,"{D27CDB70-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\MacromediaFlashPaper.MacromediaFlashPaper", , ,"Macromedia Flash Paper"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\MacromediaFlashPaper.MacromediaFlashPaper\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\MacromediaFlashPaper.MacromediaFlashPaper\DefaultIcon", , ,"%%16422%%\Internet Explorer\iexplore.exe,-17"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\MacromediaFlashPaper.MacromediaFlashPaper\shell\open\command", , ,"""%%16422%%\Internet Explorer\iexplore.exe"" -nohome ""%%%%1"""
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash\CurVer", , ,"ShockwaveFlash.ShockwaveFlash.16"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.1", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.1\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.3", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.3\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.4", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.4\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.5", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.5\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.6", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.6\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.7", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.7\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.8", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.8\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.9", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.9\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.10", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.10\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.11", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.11\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.12", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.12\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.13", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.13\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.14", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.14\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.15", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.15\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.16", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.16\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.17", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.17\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.18", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.18\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.19", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.19\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.20", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.20\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.21", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.21\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.22", , ,"Shockwave Flash Object"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.22\CLSID", , ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\MIME\Database\Content Type\application/futuresplash", "Extension", ,".spl"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\MIME\Database\Content Type\application/futuresplash", "CLSID", ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\MIME\Database\Content Type\application/x-shockwave-flash", "Extension", ,".swf"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\MIME\Database\Content Type\application/x-shockwave-flash", "CLSID", ,"{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}", , ,"ISimpleTextSelection"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}\TypeLib", , ,"{57A0E746-3863-4D20-A811-950C84F1DB9B}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}\TypeLib", "Version", ,"1.1"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}", , ,"ISimpleTextSelection"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}\TypeLib", , ,"{57A0E746-3863-4D20-A811-950C84F1DB9B}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}\TypeLib", "Version", ,"1.1"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}", , ,"IFlashAccessibility"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}\TypeLib", , ,"{57A0E746-3863-4D20-A811-950C84F1DB9B}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}\TypeLib", "Version", ,"1.1"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}", , ,"IFlashAccessibility"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}\TypeLib", , ,"{57A0E746-3863-4D20-A811-950C84F1DB9B}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}\TypeLib", "Version", ,"1.1"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}", , ,"IFlashObject"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}\TypeLib", , ,"{D27CDB6B-AE6D-11CF-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}\TypeLib", "Version", ,"1.0"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}", , ,"IFlashObject"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}\TypeLib", , ,"{D27CDB6B-AE6D-11CF-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}\TypeLib", "Version", ,"1.0"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}", , ,"IShockwaveFlash"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}\TypeLib", , ,"{D27CDB6B-AE6D-11CF-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}\TypeLib", "Version", ,"1.0"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}", , ,"IShockwaveFlash"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}\TypeLib", , ,"{D27CDB6B-AE6D-11CF-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}\TypeLib", "Version", ,"1.0"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}", , ,"_IShockwaveFlashEvents"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}\ProxyStubClsid32", , ,"{00020420-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}\TypeLib", , ,"{D27CDB6B-AE6D-11CF-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}\TypeLib", "Version", ,"1.0"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}", , ,"_IShockwaveFlashEvents"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}\ProxyStubClsid32", , ,"{00020420-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}\TypeLib", , ,"{D27CDB6B-AE6D-11CF-96B8-444553540000}"
>>"swflash.inf" ECHO ;	;;;;HKLM, "SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}\TypeLib", "Version", ,"1.0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1", , ,"FlashAccessibility"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1\0\win64", , ,"%%11%%\Macromed\Flash\Flash64_%%PlayerVersion%%.ocx\2"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1\FLAGS", , ,"0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1\HELPDIR", , ,"%%11%%\Macromed\Flash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1", , ,"FlashAccessibility"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1\0\win64", , ,"%%11%%\Macromed\Flash\Flash64_%%PlayerVersion%%.ocx\2"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1\FLAGS", , ,"0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1\HELPDIR", , ,"%%11%%\Macromed\Flash"
>>"swflash.inf" ECHO ;	;;???
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0", , ,"Shockwave Flash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0\0\win64", , ,"%%11%%\Macromed\Flash\Flash64_%%PlayerVersion%%.ocx"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0\FLAGS", , ,"0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0\HELPDIR", , ,"%%11%%\Macromed\Flash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0", , ,"Shockwave Flash"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0\0\win64", , ,"%%11%%\Macromed\Flash\Flash64_%%PlayerVersion%%.ocx"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0\FLAGS", , ,"0"
>>"swflash.inf" ECHO ;	HKLM, "SOFTWARE\Classes\Wow6432Node\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0\HELPDIR", , ,"%%11%%\Macromed\Flash"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO 	;;;HKLM,"SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Control Panel\Extended Properties\{2CA4F306-B280-4ab2-B5E1-1DFA3583F046}", "%%11%%\FlashPlayerCPLApp.cpl", %%REG_DWORD%%, 10
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Control Panel\Extended Properties\System.ControlPanel.Category", "%%11%%\FlashPlayerCPLApp.cpl", %%REG_DWORD%%, 10
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\ActiveX Compatibility\%%GUIDFACT%%", "Compatibility Flags", %%REG_DWORD%%, 0
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\ActiveX Compatibility\%%GUID%%", "Compatibility Flags", %%REG_DWORD%%, 0
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Macromedia\FlashPlayerActiveX", "Version", ,"%%VersionNumber%%"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Macromedia\FlashPlayerActiveX", "PlayerPath", ,"%%16425%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Macromedia\FlashPlayerActiveX", "UninstallerPath", ,"%%16425%%\Macromed\Flash\FlashUtil32_%%PlayerVersion%%_ActiveX.exe"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Macromedia\FlashPlayerActiveXReleaseType", "Release", %%REG_DWORD%%, 1
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\Low Rights\ElevationPolicy\{FAF199D2-BFA7-4394-A4DE-044A08E59B32}", "Policy", %%REG_DWORD%%, 3
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\Low Rights\ElevationPolicy\{FAF199D2-BFA7-4394-A4DE-044A08E59B32}", "AppPath", ,"%%16425%%\Macromed\Flash"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\Low Rights\ElevationPolicy\{FAF199D2-BFA7-4394-A4DE-044A08E59B32}", "AppName", ,"FlashUtil32_%%PlayerVersion%%_ActiveX.exe"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\CLSID\{B019E3BF-E7E5-453C-A2E4-D2C18CA0866F}", , ,"FlashBroker"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\CLSID\{B019E3BF-E7E5-453C-A2E4-D2C18CA0866F}", "LocalizedString", ,"@%%16425%%\Macromed\Flash\FlashUtil32_%%PlayerVersion%%_ActiveX.exe,-101"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\CLSID\{B019E3BF-E7E5-453C-A2E4-D2C18CA0866F}\Elevation", "Enabled", %%REG_DWORD%%, 1
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\CLSID\{B019E3BF-E7E5-453C-A2E4-D2C18CA0866F}\LocalServer32", , ,"%%16425%%\Macromed\Flash\FlashUtil32_%%PlayerVersion%%_ActiveX.exe"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\CLSID\{B019E3BF-E7E5-453C-A2E4-D2C18CA0866F}\TypeLib", , ,"{FAB3E735-69C7-453B-A446-B6823C6DF1C9}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\Interface\{299817DA-1FAC-4CE2-8F48-A108237013BD}", , ,"IFlashBroker6"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\Interface\{299817DA-1FAC-4CE2-8F48-A108237013BD}\ProxyStubClsid32", , ,"{00020424-0000-0000-C000-000000000046}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\Interface\{299817DA-1FAC-4CE2-8F48-A108237013BD}\TypeLib", , ,"{FAB3E735-69C7-453B-A446-B6823C6DF1C9}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\Interface\{299817DA-1FAC-4CE2-8F48-A108237013BD}\TypeLib", "Version", ,"1.0"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\TypeLib\{FAB3E735-69C7-453B-A446-B6823C6DF1C9}\1.0",,,"FlashBroker"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\TypeLib\{FAB3E735-69C7-453B-A446-B6823C6DF1C9}\1.0\0\win32",,,"%%16425%%\Macromed\Flash\FlashUtil32_%%PlayerVersion%%_ActiveX.exe"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\TypeLib\{FAB3E735-69C7-453B-A446-B6823C6DF1C9}\1.0\FLAGS",,,"0"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\TypeLib\{FAB3E735-69C7-453B-A446-B6823C6DF1C9}\1.0\HELPDIR",,,"%%16425%%\Macromed\Flash\FlashUtil32_%%PlayerVersion%%_ActiveX.exe"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFlash.Reg.Delete.Keys.x86]
>>"swflash.inf" ECHO 	HKCU,"Software\Macromedia\FlashPlayer","FlashPlayerVersion"
>>"swflash.inf" ECHO 	;HKLM,"SOFTWARE\Classes\.mfp"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\.mfp", "Content Type"
>>"swflash.inf" ECHO 	;HKLM,"SOFTWARE\Classes\.sol"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\.sol", "Content Type"
>>"swflash.inf" ECHO 	;HKLM,"SOFTWARE\Classes\.sor"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\.sor", "Content Type"
>>"swflash.inf" ECHO 	;HKLM,"SOFTWARE\Classes\.spl"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\.spl", "Content Type"
>>"swflash.inf" ECHO 	;HKLM,"SOFTWARE\Classes\.swf"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\.swf", "Content Type"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\CLSID\{A483C63A-CDBC-426E-BF93-872502E8144E}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\CLSID\{73C9DFA0-750D-11E1-B0C4-0800200C9A66}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\CLSID\{B019E3BF-E7E5-453C-A2E4-D2C18CA0866F}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\FlashFactory.FlashFactory"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\FlashFactory.FlashFactory.1"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Interface\{E3F2C3CB-5EB8-4A04-B22C-7E3B4B6AF30F}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Interface\{6AE38AE0-750C-11E1-B0C4-0800200C9A66}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Interface\{299817DA-1FAC-4CE2-8F48-A108237013BD}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\MacromediaFlashPaper.MacromediaFlashPaper"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\MIME\Database\Content Type\application/futuresplash"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\MIME\Database\Content Type\application/x-shockwave-flash"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.1"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.3"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.4"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.5"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.6"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.7"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.8"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.9"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.10"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.11"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.12"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.13"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.14"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.15"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.16"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.17"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.18"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.19"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.20"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.21"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\ShockwaveFlash.ShockwaveFlash.22"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\TypeLib\{FAB3E735-69C7-453B-A446-B6823C6DF1C9}\1.0"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Macromedia\FlashPlayer"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Macromedia\FlashPlayerActiveX"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Macromedia\FlashPlayerActiveXReleaseType"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Internet Explorer\ActiveX Compatibility\%%GUID%%"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Internet Explorer\ActiveX Compatibility\{D27CDB70-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Internet Explorer\Low Rights\ElevationPolicy\{FAF199D2-BFA7-4394-A4DE-044A08E59B32}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Extended Properties\{2CA4F306-B280-4ab2-B5E1-1DFA3583F046}", "%%11%%\FlashPlayerCPLApp.cpl"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Extended Properties\{2CA4F306-B280-4ab2-B5E1-1DFA3583F046}", "%%16425%%\FlashPlayerCPLApp.cpl"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Extended Properties\System.ControlPanel.Category", "%%11%%\FlashPlayerCPLApp.cpl"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Extended Properties\System.ControlPanel.Category", "%%16425%%\FlashPlayerCPLApp.cpl"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FlashPlayerApp.exe"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX"
>>"swflash.inf" ECHO 	HKLM,"SYSTEM\CurrentControlSet\Services\AdobeFlashPlayerUpdateSvc"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFlash.Reg.Delete.Keys.amd64]
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\CLSID\{A483C63A-CDBC-426E-BF93-872502E8144E}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\CLSID\{73C9DFA0-750D-11E1-B0C4-0800200C9A66}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\CLSID\{B019E3BF-E7E5-453C-A2E4-D2C18CA0866F}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\CLSID\{D27CDB70-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\Interface\{307F64C0-621D-4D56-BBC6-91EFC13CE40D}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\Interface\{57A0E747-3863-4D20-A811-950C84F1DB9B}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\Interface\{86230738-D762-4C50-A2DE-A753E5B1686F}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6C-AE6D-11CF-96B8-444553540000}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\Interface\{D27CDB6D-AE6D-11CF-96B8-444553540000}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\Interface\{E3F2C3CB-5EB8-4A04-B22C-7E3B4B6AF30F}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\Interface\{6AE38AE0-750C-11E1-B0C4-0800200C9A66}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\Interface\{299817DA-1FAC-4CE2-8F48-A108237013BD}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\TypeLib\{57A0E746-3863-4D20-A811-950C84F1DB9B}\1.1"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}\1.0"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Classes\Wow6432Node\TypeLib\{FAB3E735-69C7-453B-A446-B6823C6DF1C9}\1.0"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Macromedia\FlashPlayer"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Macromedia\FlashPlayerActiveX"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Macromedia\FlashPlayerActiveXReleaseType"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\ActiveX Compatibility\%%GUIDFACT%%"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\ActiveX Compatibility\{D27CDB70-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\Low Rights\ElevationPolicy\{FAF199D2-BFA7-4394-A4DE-044A08E59B32}"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Control Panel\Extended Properties\{2CA4F306-B280-4ab2-B5E1-1DFA3583F046}", "%%11%%\FlashPlayerCPLApp.cpl"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Control Panel\Extended Properties\{2CA4F306-B280-4ab2-B5E1-1DFA3583F046}", "%%16425%%\FlashPlayerCPLApp.cpl"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Control Panel\Extended Properties\System.ControlPanel.Category", "%%11%%\FlashPlayerCPLApp.cpl"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Control Panel\Extended Properties\System.ControlPanel.Category", "%%16425%%\FlashPlayerCPLApp.cpl"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FlashPlayerApp.exe"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [Uninstall.AddReg]
>>"swflash.inf" ECHO 	;   Used during remove
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO 	;   Used during install
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","DisplayName", ,"%%DefaultName%%"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","Publisher", ,"Adobe Systems Incorporated"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","DisplayVersion", ,"%%VersionNumber%%"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","HelpLink", ,"http://www.adobe.com/go/flashplayer_support/"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","NoModify",%%REG_DWORD%%,1
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","NoRepair",%%REG_DWORD%%,1
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","RequiresIESysFile", ,"4.70.0.1155"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","URLInfoAbout", ,"http://www.adobe.com"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","URLUpdateInfo", ,"http://www.adobe.com/go/getflashplayer/"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","VersionMajor",%%REG_DWORD%%,11
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","VersionMinor",%%REG_DWORD%%,1
>>"swflash.inf" ECHO 	;HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","UninstallString", ,"%%11%%\Macromed\Flash\FlashUtil32_%%PlayerVersion%%_ActiveX.exe -maintain activex"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","UninstallString", ,"rundll32.exe advpack.dll,LaunchINFSection %%17%%\swflash.inf,SWFlash.Uninstall"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","DisplayIcon", ,"%%16425%%\Macromed\Flash\FlashUtil32_%%PlayerVersion%%_ActiveX.exe"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","EstimatedSize",%%REG_DWORD%%,00,18,00,00
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","ParentKeyName", ,"OperatingSystem"
>>"swflash.inf" ECHO 	HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX","ParentDisplayName", ,"%%PARENT_DISPLAY_NAME%%"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [Base.RegSvr]
>>"swflash.inf" ECHO 	16425,Macromed\Flash,Flash32_%%PlayerVersion%%.ocx,1
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO ;	Createn%%16425%%\Macromed\Flash\mms.cfg
>>"swflash.inf" ECHO ;		-setSilentAutoUpdate
>>"swflash.inf" ECHO ;		-setNotifyAutoUpdate
>>"swflash.inf" ECHO ;		-setDisableAutoUpdate
>>"swflash.inf" ECHO ;	Or manual Update method
>>"swflash.inf" ECHO ;		16425,,cmd.exe,,,"/c >%%16425%%\Macromed\Flash\mms.cfg ECHO AutoUpdateDisable=%%AutoUpdateDisable%% && >>%%16425%%\Macromed\Flash\mms.cfg ECHO SilentAutoUpdateEnable=%%SilentAutoUpdateEnable%%"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [Base.UnRegSvr]
>>"swflash.inf" ECHO 11,Macromed\Flash,Flash32_%%PlayerVersion%%.ocx,1
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [Base_UnRegSvr]
>>"swflash.inf" ECHO %%11%%\regsvr32.exe /u /s %%11%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [Base.RegSvr.Update]
>>"swflash.inf" ECHO 	%%16425%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [Base.RegSvr.amd64]
>>"swflash.inf" ECHO 	11,Macromed\Flash,Flash64_%%PlayerVersion%%.ocx,1
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [Base.RegSvr.Update.amd64]
>>"swflash.inf" ECHO 	%%11%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFlash.ntx86]
>>"swflash.inf" ECHO 	CopyFiles = SWFiles, SWFiles.CPL
>>"swflash.inf" ECHO 	AddReg = SW.AddReg, SW.NT6.AddReg, Uninstall.AddReg
>>"swflash.inf" ECHO 	RegisterDlls = Base.RegSvr
>>"swflash.inf" ECHO 	BackupReg = Flash.Reg.Backup
>>"swflash.inf" ECHO 	;;;;;PreRollBack  = SWFlash_Cleanup.x86
>>"swflash.inf" ECHO 	PostRollBack = SWFlash_Cleanup.x86
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFlash.ntamd64]
>>"swflash.inf" ECHO 	CopyFiles = SWFiles, SWFiles.x64, SWFiles.x64.CPL ;, SWFiles.CPL
>>"swflash.inf" ECHO 	AddReg = SW.AddReg, SW.NT6.AddReg, SW.amd64.AddReg, Uninstall.AddReg
>>"swflash.inf" ECHO 	RegisterDlls = Base.RegSvr, Base.RegSvr.amd64
>>"swflash.inf" ECHO 	BackupReg = Flash.Reg.Backup
>>"swflash.inf" ECHO 	;;;;;PreRollBack  = SWFlash_Cleanup.x86, SWFlash_Cleanup.amd64
>>"swflash.inf" ECHO 	PostRollBack = SWFlash_Cleanup.x86, SWFlash_Cleanup.amd64
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFlash.CleanUp]
>>"swflash.inf" ECHO 	RunPreSetupCommands = Base_UnRegSvr:1
>>"swflash.inf" ECHO 	UnregisterOCXs = Base.RegSvr.Update, Base.RegSvr.Update.amd64
>>"swflash.inf" ECHO 	DelFiles       = SWFiles, SWFiles.CPL, SWFiles.x64, SWFiles.x64.CPL
>>"swflash.inf" ECHO 	DelReg         = SWFlash.Reg.Delete.Keys.x86, SWFlash.Reg.Delete.Keys.amd64
>>"swflash.inf" ECHO  	AddReg         = Flash.Reg.Backup.RollBack
>>"swflash.inf" ECHO 	RunPostSetupCommands = SWFlash.Dir.CleanUp.x86:1, SWFlash.Dir.CleanUp.amd64:1
>>"swflash.inf" ECHO 	CleanUp        = 1
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFlash_Cleanup.x86]
>>"swflash.inf" ECHO 	RunPreSetupCommands = SWFlash.Dir.CleanUp.x86:1
>>"swflash.inf" ECHO 	DelReg              = SWFlash.Reg.Delete.Keys.x86
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFlash_Cleanup.amd64]
>>"swflash.inf" ECHO 	RunPreSetupCommands = SWFlash.Dir.CleanUp.amd64:1
>>"swflash.inf" ECHO 	DelReg              = SWFlash.Reg.Delete.Keys.amd64
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFlash_Uninstall_x86]
>>"swflash.inf" ECHO 	%%16425%%\cmd.exe /c %%16425%%\Macromed\Flash\FlashUtil32_%%PlayerVersion%%_ActiveX.exe ;; -maintain activex
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFlash_Uninstall_amd64]
>>"swflash.inf" ECHO 	%%11%%\cmd.exe /c %%11%%\Macromed\Flash\FlashUtil64_%%PlayerVersion%%_ActiveX.exe ;; -maintain activex
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFlash.Dir.CleanUp.x86]
>>"swflash.inf" ECHO 	%%16425%%\cmd.exe /c TASKKILL /F /IM iexplore.exe
>>"swflash.inf" ECHO 	%%16425%%\cmd.exe /c RegSvr32.exe /s /u %%16425%%\Macromed\Flash\Flash32_%%PlayerVersion%%.ocx
>>"swflash.inf" ECHO 	%%16425%%\cmd.exe /c DEL /Q /F %%16425%%\Macromed\Flash\Flash*.ocx
>>"swflash.inf" ECHO 	%%16425%%\cmd.exe /c DEL /Q /F %%16425%%\Macromed\Flash\Flash*ActiveX*.dll
>>"swflash.inf" ECHO 	%%16425%%\cmd.exe /c DEL /Q /F %%16425%%\Macromed\Flash\Flash*ActiveX*.exe
>>"swflash.inf" ECHO 	%%16425%%\cmd.exe /c IF /I NOT EXIST %%16425%%\Macromed\Flash\NPSWF*.dll DEL /Q /F %%16425%%\Macromed\Flash\FlashInstall*
>>"swflash.inf" ECHO 	%%16425%%\cmd.exe /c IF /I NOT EXIST %%16425%%\Macromed\Flash\NPSWF*.dll DEL /Q /F %%16425%%\Macromed\Flash\*.cfg
>>"swflash.inf" ECHO 	%%16425%%\cmd.exe /c IF /I NOT EXIST %%16425%%\Macromed\Flash\NPSWF*.dll DEL /Q /F """%%10%%\Tasks\Adobe Flash Player Updater*.job"""
>>"swflash.inf" ECHO 	%%11%%\RUNDLL32.exe advpack.dll,DelNodeRunDLL32 %%16425%%\Macromed\Flash,1
>>"swflash.inf" ECHO 	%%11%%\RUNDLL32.exe advpack.dll,DelNodeRunDLL32 %%16425%%\Macromed,1
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFlash.Dir.CleanUp.amd64]
>>"swflash.inf" ECHO 	%%11%%\cmd.exe /c TASKKILL /F /IM iexplore.exe
>>"swflash.inf" ECHO 	%%11%%\cmd.exe /c RegSvr32.exe /s /u %%11%%\Macromed\Flash\Flash64_%%PlayerVersion%%.ocx
>>"swflash.inf" ECHO 	%%11%%\cmd.exe /c DEL /Q /F %%11%%\Macromed\Flash\Flash*.ocx
>>"swflash.inf" ECHO 	%%11%%\cmd.exe /c DEL /Q /F %%11%%\Macromed\Flash\Flash*ActiveX*.dll
>>"swflash.inf" ECHO 	%%11%%\cmd.exe /c DEL /Q /F %%11%%\Macromed\Flash\Flash*ActiveX*.exe
>>"swflash.inf" ECHO 	%%11%%\cmd.exe /c IF /I NOT EXIST %%11%%\Macromed\Flash\NPSWF*.dll DEL /Q /F %%11%%\Macromed\Flash\FlashInstall*
>>"swflash.inf" ECHO 	%%11%%\cmd.exe /c IF /I NOT EXIST %%11%%\Macromed\Flash\NPSWF*.dll DEL /Q /F %%11%%\Macromed\Flash\*.cfg
>>"swflash.inf" ECHO 	%%11%%\RUNDLL32.exe advpack.dll,DelNodeRunDLL32 %%11%%\Macromed\Flash,1
>>"swflash.inf" ECHO 	%%11%%\RUNDLL32.exe advpack.dll,DelNodeRunDLL32 %%11%%\Macromed,1
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFlash.Uninstall.ntx86]
>>"swflash.inf" ECHO 	RunPreSetupCommands = SWFlash_Uninstall_x86:1, SWFlash.Dir.CleanUp.x86:1
>>"swflash.inf" ECHO 	AddReg = Flash.Reg.Backup.RollBack
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWFlash.Uninstall.ntamd64]
>>"swflash.inf" ECHO 	RunPreSetupCommands = SWFlash_Uninstall_amd64:1, SWFlash.Dir.CleanUp.x86:1, SWFlash.Dir.CleanUp.amd64:1
>>"swflash.inf" ECHO 	AddReg = Flash.Reg.Backup.RollBack
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [DefaultUninstall.ntx86]
>>"swflash.inf" ECHO 	BeginPrompt = BeginUnInsPrompt
>>"swflash.inf" ECHO 	RunPreSetupCommands = SWFlash_Uninstall_x86:1
>>"swflash.inf" ECHO 	UnregisterOCXs=Base.RegSvr.Update
>>"swflash.inf" ECHO 	DelReg = SW.AddReg, SW.NT5.AddReg, SW.NT6.AddReg, Uninstall.AddReg
>>"swflash.inf" ECHO 	AddReg = Flash.Reg.Backup.RollBack
>>"swflash.inf" ECHO 	CleanUp = 1
>>"swflash.inf" ECHO 	EndPrompt = EndUnInsPrompt
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [DefaultUninstall.ntamd64]
>>"swflash.inf" ECHO 	BeginPrompt = BeginUnInsPrompt
>>"swflash.inf" ECHO 	RunPreSetupCommands = SWFlash_Uninstall_amd64:1
>>"swflash.inf" ECHO 	UnregisterOCXs=Base.RegSvr.Update, Base.RegSvr.Update.amd64
>>"swflash.inf" ECHO 	DelReg = SW.AddReg, SW.NT5.AddReg, SW.NT6.AddReg, SW.amd64.AddReg, Uninstall.AddReg
>>"swflash.inf" ECHO 	AddReg = Flash.Reg.Backup.RollBack
>>"swflash.inf" ECHO 	CleanUp = 1
>>"swflash.inf" ECHO 	EndPrompt = EndUnInsPrompt
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [SWInstall]
>>"swflash.inf" ECHO 	AddReg = SW.AddReg, SW.NT5.AddReg
>>"swflash.inf" ECHO 	RegisterOCXs=Base.RegSvr.Update
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO [Strings]
>>"swflash.inf" ECHO 	productname="Shockwave Flash"
>>"swflash.inf" ECHO 	GUID = "{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO 	GUIDFACT = "{D27CDB6E-AE6D-11cf-96B8-444553540000}"
>>"swflash.inf" ECHO 	DefaultName = "Macromedia Shockwave Flash"
>>"swflash.inf" ECHO 	ComponentID = "Flash"
>>"swflash.inf" ECHO 	VersionNumber = "%VersionNumber%"
>>"swflash.inf" ECHO 	PlayerVersion = "%PlayerVersion%"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO 	REG_EXPAND_SZ=0x00020000
>>"swflash.inf" ECHO 	REG_SZ=0x00000000
>>"swflash.inf" ECHO 	REG_DWORD=0x00010001
>>"swflash.inf" ECHO 	REG_BINARY=0x00000001
>>"swflash.inf" ECHO 	REG_MULTI_SZ = 0x00010000
>>"swflash.inf" ECHO 	REG_DWORD_NOCLOBBER = 0x00010003
>>"swflash.inf" ECHO 	Reg_SZ_NOCLOBBER = 0x00000002
>>"swflash.inf" ECHO 	REG_BINARY_NOCLOBBER = 0x00000003
>>"swflash.inf" ECHO 	REG_MULTI_SZ_APPEND = 0x0001000A
>>"swflash.inf" ECHO 	REG_MULTI_SZ_NOCLOBBER = 0x00010002
>>"swflash.inf" ECHO 	REG_MULTI_SZ_DELVAL = 0x00010006
>>"swflash.inf" ECHO 	REG_ADDREG_APPEND = 0x00010008
>>"swflash.inf" ECHO 	REG_EXPAND_SZ_NOCLOBBER = 0x00020002
>>"swflash.inf" ECHO 	REG_NONE = 0x00020001
>>"swflash.inf" ECHO 	VALUE_NOT_SET = 0x00000010
>>"swflash.inf" ECHO 	VALUE_NOT_SET_NOCLOBBER = 0x00000012
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO 	NOCLOBBER_SERVICE=0x00000010
>>"swflash.inf" ECHO 	SERVICE_BOOT_START=0x0
>>"swflash.inf" ECHO 	SERVICE_SYSTEM_START=0x1
>>"swflash.inf" ECHO 	SERVICE_AUTO_START=0x2
>>"swflash.inf" ECHO 	SERVICE_DEMAND_START=0x3
>>"swflash.inf" ECHO 	SERVICE_DISABLED=0x4
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO 	; ****************************************************************************
>>"swflash.inf" ECHO 	; Choose your update method
>>"swflash.inf" ECHO 	;
>>"swflash.inf" ECHO 	; 	(Default) Install updates automatically when available (recommended)
>>"swflash.inf" ECHO 	;	AutoUpdateDisable = "0"
>>"swflash.inf" ECHO 	;	SilentAutoUpdateEnable = "1"
>>"swflash.inf" ECHO 	;
>>"swflash.inf" ECHO 	; 	Notify me when updates are available
>>"swflash.inf" ECHO 	;	AutoUpdateDisable = "0"
>>"swflash.inf" ECHO 	;	SilentAutoUpdateEnable = "0"
>>"swflash.inf" ECHO 	;
>>"swflash.inf" ECHO 	; 	Nerver check updates (Not recommended)
>>"swflash.inf" ECHO 	;	AutoUpdateDisable = "1"
>>"swflash.inf" ECHO 	;	SilentAutoUpdateEnable = "0"
>>"swflash.inf" ECHO 	; ****************************************************************************
>>"swflash.inf" ECHO 	AutoUpdateDisable = "0"
>>"swflash.inf" ECHO 	SilentAutoUpdateEnable = "1"
>>"swflash.inf" ECHO 	LANGNAME = "neutral"
>>"swflash.inf" ECHO 	SWFlashTip = "Adobe Flash Player"
>>"swflash.inf" ECHO 	PARENT_DISPLAY_NAME = "Optional Components"			;"Windows XP - Software Updates"
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO 	;Localizable
>>"swflash.inf" ECHO 	LocaleID = "EN"
>>"swflash.inf" ECHO 	UnInsPrompt  = "Are you sure you want to remove Adobe Flash Player from your computer?"
>>"swflash.inf" ECHO 	EndUnInsPrompt = "Adobe Flash Player was successfully removed from your computer."
>>"swflash.inf" ECHO.
>>"swflash.inf" ECHO.
Goto EOF

:EXIT
GOTO EOF

:EOF
