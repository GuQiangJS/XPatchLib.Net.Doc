@ECHO OFF

::XPatchLib��Ŀ·��
IF EXIST "%~dp0src\XPatchLib.Net.Doc.sln" SET "SLN=%~dp0src\NET45\NET45.shfbproj"
::XPatchLib��Ŀ·��
IF EXIST "%~dp0..\XPatchLib.Net" SET "XPATCHLIB_SRC=%~dp0..\XPatchLib.Net"
::XPatchLib.Net��������ű�������Release�汾
IF EXIST "%XPATCHLIB_SRC%\builder\MasterBuild.bat" SET "MASTERBUILD=%XPATCHLIB_SRC%\builder\MasterBuild.bat"
::XPatchLib.Net Release ���·��
IF EXIST "%XPATCHLIB_SRC%\src\XPatchLib\bin\Release" SET "RELEASE_PATH=%XPATCHLIB_SRC%\src\XPatchLib\bin\Release\"
SET "OUTPUT_PATH=%~dp0..\XPatchLib.Output\Release\"

IF NOT EXIST "%SLN%" (
echo "%SLN% �����ڣ�����!"
GOTO End
)
IF NOT EXIST "%XPATCHLIB_SRC%" (
echo "XPatchLib��Ŀ·�� (%XPATCHLIB_SRC%) �����ڣ�����!"
GOTO End
)
IF NOT EXIST "%MASTERBUILD%" (
echo "XPatchLib.Net��������ű� (%MASTERBUILD%) �����ڣ�����!"
GOTO End
)

call %MASTERBUILD%

IF NOT EXIST "%RELEASE_PATH%" (
echo "XPatchLib.Net Release ���·�� (%RELEASE_PATH%) �����ڣ�����!"
GOTO End
)

xcopy /S /E /Y "%RELEASE_PATH%*.*" "%OUTPUT_PATH%"

IF EXIST "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Community\MSBuild\15.0" SET "VS150COMNTOOLS=%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Community\MSBuild\15.0"
IF EXIST "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Professional\MSBuild\15.0" SET "VS150COMNTOOLS=%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Professional\MSBuild\15.0"
IF EXIST "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0" SET "VS150COMNTOOLS=%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0"

IF EXIST "%VS150COMNTOOLS%\bin\MSBuild.exe" (
SET MSBUILD="%VS150COMNTOOLS%\bin\MSBuild.exe"
GOTO Build
)

FOR %%b in (
	"%VS140COMNTOOLS%..\..\VC\vcvarsall.bat"
	"%VS120COMNTOOLS%..\..\VC\vcvarsall.bat" 
	"%VS110COMNTOOLS%..\..\VC\vcvarsall.bat"
	"%VS90COMNTOOLS%..\..\VC\vcvarsall.bat" 
) do (
if exist %%b (
	call %%b
	SET MSBUILD="msbuild.exe"
	goto Build
	)
)
 
::https://social.msdn.microsoft.com/Forums/en-US/1071be0e-2a46-4c30-9546-ea9d7c4755fa/where-is-vcvarsallbat-file?forum=visualstudiogeneral
echo "not found vcvarshall.bat"

:Build
(
call %MSBUILD% /nologo /v:m /m %SLN% /t:Rebuild /clp:ErrorOnly;Summary;PerformanceSummary
goto CopyResult
)

:CopyResult
(
IF NOT EXIST "%~dp0docs\" MD "%~dp0docs\"
::Ĭ�ϸ���.NET20�汾�İ����ĵ�
xcopy /S /E /Y "%~dp0src\NET471\bin\*.*" "%~dp0docs\"
)
 
:End
pause