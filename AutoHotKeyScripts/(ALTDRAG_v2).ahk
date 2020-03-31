#SingleInstance force
SetWinDelay 5		; ms - default 100ms
; CoordMode "Mouse", "Screen"	; causes craziness, leave it default ("Client") for now

; #NoTrayIcon
; KeyHistory





; *********************************************			;	Customize your trigger hotkey
; *************** BUTTONS SETUP ***************			;	and Mouse btn functions here
; *********************************************			
global Trigger_Hotkey:= ">^"	; must be symbol prefix
								; (like:  ^  or  >!  )
								; (NOT  Ctrl or RAlt )


global Mousebtn_Move := "LButton"
global Mousebtn_Resize := "MButton"
global Mousebtn_Minimize := "RButton"
global Mousebtn_Close := "XButton1"
global Mousebtn_AlwaysOnTop := "XButton2"
; *********************************************
; *********************************************
; *********************************************





;--------------------------------------------------------------------------------
;--------------------------------GLOBAL VARS / FUNCTIONS

Hotkey Trigger_Hotkey Mousebtn_Move, "MoveWindow"			; Move
Hotkey Trigger_Hotkey Mousebtn_Resize, "ResizeWindow"		; Resize
Hotkey Trigger_Hotkey Mousebtn_Minimize, "MinimizeWindow"	; Minimize
Hotkey Trigger_Hotkey Mousebtn_Close, "CloseWindow"			; Close

>^WheelUp::Volume_Up		; Volume wheel
>^WheelDown::Volume_Down



; 

global X:=0, Y:=0, winID:=0
MouseSetWinID() {
	MouseGetPos ,, winID
}
MouseSetWinIDActivate() {
	; bring to front
	MouseGetPos ,, winID
	WinActivate "ahk_id " winID
}






MouseSetWinIDAndCoordsActivate() {
	; bring to front, make transparent
	MouseGetPos X,Y,winID
	WinActivate "ahk_id " winID
	WinWaitActive "ahk_id " winID
	WinSetTransparent 215, "ahk_id " winID
}




;--------------------------------------------------------------------------------
;--------------------------------Actions: RESIZE
;
ResizeWindow() {
	MouseSetWinIDActivate()
	
	
	; buggy; sometimes takes a few clicks of the Resize button
	Send "{Alt down}{Space}{Alt up}"
	Sleep 30
	; Send "{down 3}{Enter}"
	Send "s"
	Send "{Right}{Down}"
	
	
	; MenuSelect("ahk_id winID",, "0&", "Size")
	
	; WM_SYSCOMMAND := 0x112
	; WM_SIZE := 0x05
	; PostMessage WM_SYSCOMMAND, WM_SIZE, 0,, A
	
	
	
	/* 
	; Main loop
	while StartState = GetKeyState(Mousebtn_Move, "P")
	{
		; update current mouse position
		MouseGetPos X, Y
		
		; Calculate new window position
		winw += X-Xstart, winh += Y-Ystart
		
		
		; TODO: borders (/snapping) stuff
		
		
		; MOVE IT
		WinMove winX, winY, winw, winh, "ahk_id " winID
							;^^^  ^^^
							;resizing
	}
	*/		; doesn't work^^^^^^^^ adds way too much to w/h on each loop
}
;--------------------------------------------------------------------------------
;--------------------------------Actions: MINIMIZE
;
MinimizeWindow() => (MouseGetPos( ,,winID), WinMinimize("ahk_id " winID))
;--------------------------------------------------------------------------------
;--------------------------------Actions: CLOSE
;
CloseWindow() {
	MouseSetWinID()
	
	WinClose winID
	return
}
;--------------------------------------------------------------------------------
;--------------------------------Actions: ALWAYS ON TOP
;
SetAlwaysOnTop() {
	
}
;--------------------------------------------------------------------------------
;--------------------------------Actions: MOVE
;
MoveWindow() {
	
	; Get initial window ID, bring to front, make transparent
	MouseGetPos ,, winID
	WinActivate "ahk_id " winID		; because mousegetpos reads active window
	WinWaitActive "ahk_id " winID
	WinSetTransparent 215, "ahk_id " winID
	
	; toggle restore/maximize with the Resize mouse button
	; Hotkey Mousebtn_Resize, ()=>WinMaximize("ahk_id " winID), "On"
	
	; Get initial mouse position (RELATIVE TO ACTIVE CLIENT WINDOW)
	Xstart:=0,Ystart:=0
	MouseGetPos Xstart, Ystart
	
	; Set X/Y vars ahead of time(for performance; see below inside loop)
	X := Xstart, Y := Ystart
	
	; Get initial Window position + size
	WinGetPos winX, winY, winw, winh, "ahk_id " winID
	
	
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
	StartState := GetKeyState(Mousebtn_Move, "P")
	
	
	; Main loop
	while StartState = GetKeyState(Mousebtn_Move, "P")
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
	; Hotkey Mousebtn_Resize, , "Off"
	WinSetTransparent "off", "ahk_id " winID
}