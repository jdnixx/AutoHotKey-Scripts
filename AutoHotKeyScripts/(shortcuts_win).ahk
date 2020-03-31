;--------------------------------------------------------------------------------
#SingleInstance Force
;#NoTrayIcon
; KeyHistory

;--------------------------------------------------------------------------------
;--------------------------------VARIABLE SETUPS

ENV_ProgramFilesx86 := EnvGet("ProgramFiles(x86)")
ENV_AppData := EnvGet("AppData")
ENV_LocalAppData := EnvGet("LocalAppData")
ENV_UserProfile := EnvGet("UserProfile")

apps := A_ScriptDir . "\..\WindowsAppsShortcuts\"
brave := ENV_localappdata . "\BraveSoftware\Brave-Browser\Application\brave"
brave_proxy_default := brave . "\..\chrome_proxy.exe  --profile-directory=Default"

MouseIsOver(wintitle) {
	MouseGetPos ,,, winid
	return WinExist(wintitle . " ahk_id " . winid)
}

; CurrentMouseWinId() {
	; MouseGetPos,,, mousewinid
	; return WinExist(wintitlestring . " ahk_id " . mousewinid)
; }

;--------------------------------------------------------------------------------
;--------------------------------GLOBAL KEY/MOUSE MODS

												; Shift+Wheel: scroll left/right
+WheelDown::WheelRight							
+WheelUp::WheelLeft

												; Win+Z: Media keys
#z:: Media_Play_Pause
!#z:: Media_Next
^#z:: Media_Prev

												; Shift+<>: Virtual Desktops
>+left:: Send "^#{left}"
>+right:: Send "^#{right}"
; without Send does nothing

												; MButton: explorer, Properties...
#If MouseIsOver("ahk_class CabinetWClass")		;https://lexikos.github.io/v2/docs/commands/KeyWait.htm#ExDouble
Send "{LButton}{RButton}"
Return
#IF

												; MButton: Task Manager
; #If MouseIsOver("ahk_class Shell_TrayWnd")
MButton:: run taskmgr.exe
; MButton:: ToolTip MouseIsOver("ahk_class Shell_TrayWnd")
; #if

												; ctrl+backspace fix
#If WinActive("ahk_exe explorer.exe")
^BS::
#If WinActive("ahk_class #32770")				; ctrl+f menu
^BS:: send "^+{left}{del}"
#If

;--------------------------------------------------------------------------------
;--------------------------------APPS
;shell:AppsFolder	>	create shortcut in ..\WindowsAppsShortcuts	(get-appxpackage > UWP_Apps_List.txt)
;		,run apps " - Shortcut"


; Brave	(new window)
#space:: run brave, WinActivate

; Everything
#!space:: run apps . "Search Everything - Shortcut"

; Notepad++
#n:: SwitchOrRun "ahk_exe notepad++.exe", apps "Notepad++ - Shortcut"

; Spotify
#s:: SwitchOrRun("ahk_exe spotify.exe", apps "Spotify - Shortcut")

; Twitter
#t:: run brave . "--app-id=jgeocpdicgmkeemopbanhokmhcgcflmi"

; Telegram
#y:: SwitchOrRun "ahk_exe Telegram.exe", apps "Telegram Desktop - Shortcut"

; Tradingview
#q:: SwitchOrRun("Main Charte", apps "Tradingview - Analyze Your Chart - Shortcut")

; Calculator
Numlock & NumpadAdd:: run apps "Calculator - Shortcut"

; Sticky notes
#w:: run apps "Sticky Notes - Shortcut"

; Your Phone
#p:: run apps "Your Phone - Shortcut"

; Resmon
#+Esc:: run apps "Resource Monitor - Shortcut"

; Messages
#m:: SwitchOrRun("Messages for web", apps . "Messages - Shortcut")


SwitchOrRun(wintitlename, runname) {
	if WinExist(wintitlename)
		WinActivate
	else run runname
	return
}


;--------------------------------------------------------------------------------
;--------------------------------CHROME
#If WinActive("ahk_exe brave.exe")
!d:: send "!d!{enter}"



#If


;--------------------------------------------------------------------------------
;--------------------------------EXPLORER FOLDERS

; Clipboard
!#e:: run clipboard


;---------------------------------

;--------------------------------------------------------------------------------
;--------------------------------AHK

; Reload script
^+#a:: Reload

; AHK scripts folder
^#a:: Run A_ScriptDir

; Documentation ( +go to Search)
!#a::Run "https://lexikos.github.io/v2/docs/KeyList.htm"
;Run https://www.autohotkey.com/docs/KeyList.htm;WinWaitActive, Hotkeys -, , 5
;Send, !s

; Restart altdrag
>^>+Enter:: Run A_ScriptDir . "\..\restart_altdrag.bat"


;--------------------------------------------------------------------------------
;--------------------------------POWERSHELL/TERMINAL

; Powershell - current folder
#c:: 
run "powershell" 
WinWaitActive("ahk_exe powershell.exe")
Send "cd " getCurrentExplorerDirectoryV2() "{Enter}"
return

; Powershell ADMIN
^#c::
run "*RunAs powershell" 
WinWaitActive("ahk_exe powershell.exe")
Send "cd " getCurrentExplorerDirectory() "{Enter}"
return

; Close terminal
#IF WinActive("ahk_class ConsoleWindowClass")
	!f4::
	^w::
	^q::
	WinClose A
	return
#IF


getCurrentExplorerDirectory() {
	dir := A_Desktop
	If WinActive("ahk_class CabinetWClass") || WinActive("ahk_class ExploreWClass") {
		WinHWND := WinActive()
		For win in ComObjCreate("Shell.Application").Windows
			If (win.HWND = WinHWND) {
				dir := SubStr(win.LocationURL, 9) ; remove "file:///"
				dir := RegExReplace(dir, "%20", " ")
				Break
			}
	}
	return dir
}
getCurrentExplorerDirectoryV2() {
	dir := A_Desktop
	WinHWND := WinActive()
	For win in ComObjCreate("Shell.Application").Windows
		If (win.HWND = WinHWND) {
			dir := SubStr(win.LocationURL, 9) ; remove "file:///"
			dir := RegExReplace(dir, "%20", " ")
			Break
		}
	return dir
}






























;		LAPTOP FN KEY

;SC163::
;sc163::
;Input, next_key, L1 T1, {esc}, 

;if (ErrorLevel = "Timeout")
;{
;    Send, #
;    return
;}

;if (next_key = "z")
;	Send, {Media_Play_Pause}
;if (next_key = "x")
;	Send, {Media_Next}
;if (next_key = "c")
;	Send, {Launch_Media}

;return