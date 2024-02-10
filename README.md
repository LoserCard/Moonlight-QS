# Moonlight-QS
Moonlight-QS is a quick start application for Windows that use several scripts to dynamically generate shortcut links (.lnk) for one-click Moonlight Game Streaming startup with the host/app of your choosing. This package does NOT contain the base Moonlight Game Streaming application; you can download the Moonlight application here: https://moonlight-stream.org/

Features:
* Wake-On-Lan functionality.
  * Note: Wake-On-Lan MUST be configured on the host machine beforehand. The built in functionality simply sends a magic packet to the host machine and pings the server to confirm connectivity.
* Batch shortcut creation.
* One-Click Moonlight sessions.

To use this application, follow the steps below:

1. Download and extract the ZIP file to a directory of your choosing. It is important that this folder remains in a static location as the shortcut links require scripts housed in this directory.
2. Edit the `shortcuts.txt` file and add new lines in the following format: MAC-Address,IP-Address,Sunshine-Hostname,App-Name
   1. Example: `00-00-00-00-00-00,10.0.0.1,Main-Computer,Desktop` - This will wake the Main-Computer host and start the Desktop Sunshine app.
3. Run the `createShortcut.bat` file. This will create the `.\Shortcuts\` directory.
4. Navigate to the `.\Shortcuts\` directory and move these shortcuts to a location of your choosing.

Config Options:
* Modify the `config.txt` file for the following options:
  * `MAX_RETRIES`: If your host takes too long to wake (>25s), you can modify this value accordingly (default:`5`).
  * `MOONLIGHT_PATH`: If you are using Moonlight Portable (or installed Moonlight in a different directory), you can modify this path accordingly (default:`"C:\Program Files\Moonlight Game Streaming\Moonlight.exe"`.
  * `CREATE_DESKTOP`: If you wish to create all shortcuts directly on the desktop, set this value to `1` (default:`0`)

Details and Considerations:
* The first time any of the scripts are ran, you may receive the following warnings:
  * Windows Defender SmartScreen (`createShortcut.bat`): Click 'More info' and then 'Run anyway'.
  * Open File - Security Warning (`quickstart.vbs` and `splash.hta`): Click 'Open'. If you wish to prevent this dialog from showing, untick the checkbox for "Always ask before opening this file".
* At this time, Moonlight.exe is ran in the background which means the GUI is not shown. When minimizing your session (L1+R1+Start+Select or CTRL+ALT+SHIFT+Q) you can either run the shortcut again or open the GUI to resume or quit the session.
* When using different app shortcut links to the same host, you will be prompted to end any existing streams prior to starting a new stream.
* If you decide to move the root Moonlight-QS directory, all pre-existing shortcuts will break. As long as your `shortcuts.txt` contains all of your previous host/app details, you can simply re-run the `createShortcut.bat` file to generate new shortcuts.

Disclaimer: I am not associated or affliated with Moonlight Game Streaming. Any use of intellectual property regarding the base Moonlight application or artwork is strictly used for informative purposes to indicate which application (e.g. Moonlight) is operating in the background.
