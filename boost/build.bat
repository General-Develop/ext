@echo off

set RAR_PATH=C:\greentools\rw\WinRAR\WinRAR.exe
set CUR_PATH=%~dp0
set CODE_PATH=%CUR_PATH%..\..

set BOOST_LIB_VERSION=1_67
set BOOST_FILE_STEM=boost_1_67_0
set BOOST_FILE_TYPE=zip
set BOOST_FILE=%BOOST_FILE_STEM%.%BOOST_FILE_TYPE%
set BOOST_ROOT=%CODE_PATH%\%BOOST_FILE_STEM%

call "%RAR_PATH%" x -y "%CUR_PATH%\%BOOST_FILE%" "%CODE_PATH%"

call "%VS90COMNTOOLS%\..\..\VC\vcvarsall.bat" x86

cd /d %BOOST_ROOT%
call "bootstrap.bat"
bjam.exe stage --toolset=msvc-9.0 --build-type=complete --stagedir=%BOOST_ROOT%\stage link=static address-model=32 runtime-link=shared threading=multi debug release

set REG_PATH=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment
reg add "%REG_PATH%" /v BOOST_ROOT /d %BOOST_ROOT% /f 
reg add "%REG_PATH%" /v BOOST_LIB_VERSION /d %BOOST_LIB_VERSION% /f 

cd /d %CUR_PATH%

pause