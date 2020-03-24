#SingleInstance force
; #NoTrayIcon
; KeyHistory

SetWinDelay 5		; ms - default 100ms






; *********************************************
; *************** BUTTONS SETUP ***************
; *********************************************



global Trigger_Hotkey:= ">^"	; must be prefix (^ or >!, NOT Ctrl or RAlt)


global Move_MouseBtn := "LButton"



;--------------------------------------------------------------------------------
;--------------------------------HOTKEYS INITIALIZATION

Hotkey Trigger_Hotkey Move_MouseBtn, "MoveWindow"


;--------------------------------------------------------------------------------
;--------------------------------Actions: MOVE WINDOW
;
MoveWindow() {
	
	; Get initial mouse position & window ID
	MouseGetPos Xstart, Ystart, winID
	
	; Get initial Window position + size
	WinGetPos winX, winY, winw, winh, "ahk_id " winID
	
	; Set X/Y vars ahead of time(for performance; see below inside loop)
	X := Xstart, Y := Ystart
	
	
	; Set initial button state
	; ---
	; This flag helps when using programs that simulate the first click, like
	; GestureSign - because in those cases the btn's "pressed" state will only
	; show "0" (whereas a real mouse always shows "1") - until you click again.
	; Therefore we'd rather check when the first button's state has been TOGGLED,
	; rather than absolute down/up.
	;
	; This way, you just need another tap/click to break the loop.
	; Regular mice will still break the loop normally on btn release.
	StartState := GetKeyState(Move_MouseBtn, "P")
	
	
	; bring to front
	WinActivate "ahk_id " winID
	
	
	; main loop
	while StartState = GetKeyState(Move_MouseBtn, "P")
	{
		; update current mouse position
		MouseGetPos X, Y
		; Calculate new window position
		winX += X-Xstart, winY += Y-Ystart
		
		; you really want to ADD to the existing (win-)X/Y vars, rather than
		; reassign them, because AHK rips open a new memory address for every
		; variable reassignment (just like Python), causing performance issues
		; when doing it again & again in every loop iteration
		; NOTE: at least, I think that's how it works... :/
		
		
		; TODO: borders (/snapping) stuff
		
		
		; MOVE IT
		WinMove winX, winY, winw, winh, "ahk_id " winID
							;^^^  ^^^
							;resizing
	}
}