# Project Knowledge Summary

## Primary Objective
- Build a functional `xinput1_4.dll` that supports both XInput and DirectInput controllers simultaneously.
- The DLL should prioritize real XInput devices; if none are connected, fall back to DirectInput via the existing `ControllerManager` implementation.
- No mandatory external `x360ce.ini`; provide hard‑coded default mappings (Logitech F310 style) when the INI is absent.

## Implemented Features (Updated 2025-12-17)
- **Unified Dynamic DLL**: Single `xinput1_4.dll` that handles both XInput and DirectInput
- **Arbitration Logic** in `x360ce.cpp`:
  1. Load the system XInput DLL via `SystemXInputLoader`
  2. Call the real `XInputGetState`; on success, return the result
  3. If the real call fails (`ERROR_DEVICE_NOT_CONNECTED`), use `ControllerManager::Get().DeviceInitialize()` to poll DirectInput
  4. All XInput APIs support fallback (GetState, SetState, GetCapabilities, GetKeystroke, etc.)
- **Debug Mode**: Place `debugmode-on` file next to DLL to enable logging
- **DirectInput via x360ce.ini**: Standard x360ce INI format for DirectInput mappings

## Build System
- `build_debug.bat` invokes MSBuild on `x360ce\x360ce\x360ce.vcxproj` with `Release|Win32`
- Output: `xinput1_4.dll` in `bin\Release`

## Key Files
- `x360ce.cpp` - Main XInput API implementations with fallback logic
- `ControllerManager.h` - DirectInput device management
- `Controller.cpp` - DirectInput device polling and state synthesis
- `Config.cpp` - INI parsing for DirectInput mappings
- `SystemXInputLoader.cpp` - Real system XInput loading

## Architecture
1. **XInputGetState** called by game
2. Try real XInput via `SystemXInputLoader::Real_XInputGetState`
3. If SUCCESS → return
4. If NOT_CONNECTED → `ControllerManager::Get().DeviceInitialize()` + `pController->GetState()`
5. DirectInput device polled, state mapped to XINPUT_STATE

## Notes for Future Development
- Force feedback supported for DirectInput devices
- Combined controllers supported via `ControllerCombiner`
- Consider adding unit tests for fallback path
