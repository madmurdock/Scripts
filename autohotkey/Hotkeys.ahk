; WIN+C Code
#C::Run "C:\Program Files\Microsoft VS Code\Code.exe"

; WIN+ALT+C Calculator
#!C::Run Calc.exe

; Volume Up/Down with mouse wheel over the systray
#If MouseIsOver("ahk_class Shell_TrayWnd")
WheelUp::Send {Volume_Up}     ; Wheel over taskbar: increase/decrease volume.
WheelDown::Send {Volume_Down}

MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}