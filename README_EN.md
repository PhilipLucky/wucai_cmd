# wucai_cmd

## Overview
This project lets you type `wucai` directly in the Windows File Explorer address bar.

Expected behavior:

- Type `wucai` in the address bar of any folder and press Enter
- A new `CMD` window opens
- The new window starts in that same folder
- `wucai` runs automatically

This is equivalent to running:

```bat
cmd
wucai
```

## What This Project Is
This is a Windows Explorer address-bar launcher adapter for `wucai`.

It is responsible for:

- launching `wucai` from the Explorer address bar
- keeping the current folder as the working directory

It does not include:

- the `wucai` main program
- npm installation artifacts
- `%APPDATA%\npm\wucai.cmd`

## Prerequisites
Before using this project, install `wucai` on your machine first.

Install command:

```bash
npm install -g @wucai/wucai-code
```

Installation guide:

- http://class.wucai.com/docs/wucai-installation

After installation, this file should usually exist:

```text
%APPDATA%\npm\wucai.cmd
```

If that file does not exist, this project will not work correctly.

## Installation Video
You can watch the installation demo here:

[install_wucai_cmd_video.mp4](./install_wucai_cmd_video.mp4)

## Why PATH Alone Is Not Enough
`cmd` and the Explorer address bar do not resolve `wucai` in exactly the same way.

A common situation is:

- `cmd` correctly resolves `wucai.cmd`
- Explorer may hit the extensionless npm file named `wucai` first

When that happens, Windows may treat it like a file instead of a program and ask how to open it.

So this project uses a more reliable approach:

- provide a real `wucai.exe`
- register it through `App Paths`

That makes Explorer treat `wucai` as a program launch.

## Files
- `wucai.exe`: launcher used by the Explorer address bar
- `wucai_launcher.cs`: source code for `wucai.exe`
- `wucai.bat`: batch fallback
- `install_wucai_cmd.cmd`: one-click installer that writes the current folder to the registry
- `register_wucai_app_path.reg`: optional manual registry file
- `install_wucai_cmd_video.mp4`: installation demo video

## Recommended Installation
The recommended method is to use the one-click installer.

Steps:

1. Run `npm install -g @wucai/wucai-code` and make sure `wucai` is installed.
2. Put this project in a fixed folder on your machine.
3. Double-click `install_wucai_cmd.cmd`.
4. Close all Explorer windows and open Explorer again.
5. In any folder, type `wucai` in the address bar and press Enter to test.

`install_wucai_cmd.cmd` automatically detects its own folder and registers the local `wucai.exe` to:

```text
HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\wucai.exe
```

So in normal use, you do not need to edit any paths manually.

## Manual Installation
If you do not want to use the script, you can manually edit and import:

- `register_wucai_app_path.reg`

However, that method requires editing the path first, so `install_wucai_cmd.cmd` is recommended.

## Verification
After installation:

1. Open any folder
2. Type `wucai` in the address bar
3. Press Enter

Expected result:

- a new `CMD` window opens
- the working directory is the current folder
- the real `wucai` command runs automatically

## Common Issues

### 1. Windows still asks how to open the file
This usually means Explorer has not refreshed the new registration yet.

Try:

- closing and reopening all Explorer windows
- restarting `explorer.exe`
- signing out and signing back in

### 2. CMD opens but the command does not run
This usually means `wucai` is not installed correctly, or `%APPDATA%\npm\wucai.cmd` does not exist.

Check again:

```bash
npm install -g @wucai/wucai-code
```

And refer to:

- http://class.wucai.com/docs/wucai-installation

### 3. Do users still need to change `D:\tool\batch\wucai.exe`
Usually no, if they use `install_wucai_cmd.cmd`.

The installer writes the current script folder into the registry automatically.

Users only need to edit paths manually if they choose to import `register_wucai_app_path.reg` by hand.

## Acknowledgment
Special thanks to Dr. Chen for providing `wucai-code`.
