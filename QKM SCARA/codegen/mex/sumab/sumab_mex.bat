@echo off
set MATLAB=E:\matlab2016a
set MATLAB_ARCH=win64
set MATLAB_BIN="E:\matlab2016a\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=sumab_mex
set MEX_NAME=sumab_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for sumab > sumab_mex.mki
echo COMPILER=%COMPILER%>> sumab_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> sumab_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> sumab_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> sumab_mex.mki
echo LINKER=%LINKER%>> sumab_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> sumab_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> sumab_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> sumab_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> sumab_mex.mki
echo BORLAND=%BORLAND%>> sumab_mex.mki
echo OMPFLAGS= >> sumab_mex.mki
echo OMPLINKFLAGS= >> sumab_mex.mki
echo EMC_COMPILER=msvc120>> sumab_mex.mki
echo EMC_CONFIG=optim>> sumab_mex.mki
"E:\matlab2016a\bin\win64\gmake" -B -f sumab_mex.mk
