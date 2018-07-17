@echo off

call "%VS90COMNTOOLS%\..\..\VC\vcvarsall.bat" x86

bjam stage --toolset=msvc-9.0 --build-type=complete --stagedir=P:\workplace\code\boost_1_67_0\stage link=static address-model=32 runtime-link=shared threading=multi debug release

pause