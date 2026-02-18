@echo off
echo Starting Process Monitor to trace JoyXoff DLL loading...
echo.
echo Instructions:
echo 1. Process Monitor will start
echo 2. Start JoyXoff
echo 3. Wait 5 seconds
echo 4. Press Ctrl+E in Process Monitor to stop capture
echo 5. Look for "xinput" in the Path column
echo.
echo Press any key to start Process Monitor...
pause

REM Start Process Monitor with filter for JoyXoff and xinput DLLs
"C:\Program_Files\utilities\systeminternals\Procmon.exe" /AcceptEula /Minimized /BackingFile C:\procmon_joyxoff.pml

echo.
echo Process Monitor is running. Start JoyXoff now.
echo After JoyXoff starts, press any key to stop capture...
pause

REM Stop capture
"C:\Program_Files\utilities\systeminternals\Procmon.exe" /Terminate

echo.
echo Capture saved to: C:\procmon_joyxoff.pml
echo.
echo To view results:
echo 1. Open Process Monitor
echo 2. File -^> Open: C:\procmon_joyxoff.pml
echo 3. Filter -^> Filter: Path contains "xinput"
echo 4. Look for "CreateFile" or "QueryOpen" operations
echo.
pause
