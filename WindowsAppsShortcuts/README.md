
# WindowsAppsShortcuts folder

This folder is for storing Windows shortcuts (.lnk files) to all your favorite apps that you want to set up universal keyboard shortcuts for - *see (shortcuts_win.ahk)*

**Quick setup**

* Hit `Ctrl+R` (Windows "Run" command) and type: `shell:appsfolder`
* Right-click on whichever apps you need, and select "Create shortcut"
* This will make a new shortcut for each app on your desktop. Simply copy+paste those into this folder, WindowsAppsShortcuts, and `Run` an app with its shortcut's name in the AHK script like: `#w:: Run "\..\WindowsAppsShortcuts\SomeImportantApp - Shortcut"` (Win+W will launch SomeImportantApp)
* Note: in my script (shortcuts_win), I used the relative path (`"\..\WindowsAppsShortcuts\<shortcut name>"` since the script is one level deeper than the root, inside the AutoHotKeyScripts folder which is on the same level as WindowsAppsShortcuts. You could put shortcuts in the same folder as your script and use `".\SomeAppShortcut"`, or anywhere else on your computer and use the full path name.