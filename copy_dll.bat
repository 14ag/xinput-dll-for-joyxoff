@echo off
echo Copying DLL...
copy /Y "c:\Users\philip\sauce\xinput-dll-for-joyxoff\x360ce\x360ce\x360ce\bin\Release\xinput1_3.dll" "c:\Users\philip\sauce\xinput-dll-for-joyxoff\xinput1_4.dll"
if %ERRORLEVEL% NEQ 0 (
    echo Copy failed with error level %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)
if exist "c:\Users\philip\sauce\xinput-dll-for-joyxoff\xinput1_4.dll" (
    echo SUCCESS: File copied.
    dir "c:\Users\philip\sauce\xinput-dll-for-joyxoff\xinput1_4.dll"
) else (
    echo FAILURE: File not found after copy.
)
