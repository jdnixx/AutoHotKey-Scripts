:warning: **NOTE: THESE SCRIPTS WERE MADE FOR [AHK v2](https://www.autohotkey.com/download/) ONLY (won't work with the current default (v1.1) installer)**

# AutoHotKey-Scripts


I use these on startup (create shortcuts or copy scripts to `shell:startup` or %appdata%\Microsoft\Windows\Start Menu\Programs\Startup; see my other StartupAndSync repo), as far as I'm concerned they might as well be baked into Windows by default.

### AltDrag v2
[AltDrag](https://stefansundin.github.io/altdrag/) has been one of if not my favorite programs for years - I intuitively want to drag windows with Mouse1 when using other people's computers - but the creator hasn't updated it since 2015, the code is old and full of security vulnerabilities, and I decided I had to update it. You basically hold down a modifier key (Ctrl or Alt) and left-click anywhere on any window to move it/resize it/close it/etc without hunting for the teeny tiny title bar or resize handles.

It's working incredibly well so far being written in just pure AHK. Stupidly useful for huge monitors; I use a Sceptre 40" 4k TV as my main, and combining AltDrag movements with it makes it feel like an extremely fluid, giant digital canvas for dev work or research.

Inspiration from the also old-as-dirt [KDE Mover-Sizer AHK Script](http://corz.org/windows/software/accessories/KDE-resizing-moving-for-Windows.php).

**Defaults:**
* RCtrl - Main modifier hotkey
* LButton - Move
