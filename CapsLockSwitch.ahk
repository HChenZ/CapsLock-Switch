#Requires AutoHotkey v2.0  ; 强制使用 v2.0 版本
; CapsLock 短按切换中英文，长按切换大小写

; 自动以管理员权限运行
if !A_IsAdmin
{
    Run '*RunAs "' A_ScriptFullPath '"'
    ExitApp
}

#SingleInstance Force
SendMode "Input"
SetWorkingDir(A_ScriptDir)

; 长按防重入标志
longPressActive := false

*CapsLock::
{
    global longPressActive

    ; 如果处于长按状态，等待解锁
    if (longPressActive)
    {
        KeyWait("CapsLock")
        longPressActive := false
        return
    }

    ; 长按时间阈值 0.3s
    if (!KeyWait("CapsLock", "T0.3"))  ; 超时 → 长按
    {
        longPressActive := true  ; 锁定，阻止后续触发

        ; 切换大小写锁定状态
        if GetKeyState("CapsLock", "T")
            SetCapsLockState "Off"
        else
            SetCapsLockState "On"

        KeyWait("CapsLock")  ; 等待按键释放
        longPressActive := false  ; 解锁，允许下一次正常触发
    }
    else  ; 阈值内释放 → 短按
        Send("#{Space}")  ; 切换输入法
}
