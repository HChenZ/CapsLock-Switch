#Requires AutoHotkey v2.0   ; 强制使用 v2.0 版本
; CapsLock短按切换中英文，长按切换大小写

; 自动以管理员权限运行
if !A_IsAdmin
{
    Run '*RunAs "' A_ScriptFullPath '"'
    ExitApp
}

#SingleInstance Force
SendMode "Input"
SetWorkingDir(A_ScriptDir)

*CapsLock::
{
    ; 等待按键释放，长按时间阈值为 0.3s
    if (!KeyWait("CapsLock", "T0.3"))  ; 超时 → 长按
    {
        ; 立即切换大小写锁定状态
        if GetKeyState("CapsLock", "T")
            SetCapsLockState "Off"
        else
            SetCapsLockState "On"
        
        ; 等待按键实际释放
        KeyWait("CapsLock")
    }
    else  ; 在阈值时间内释放 → 短按
    {
        ; 切换输入法
        Send("^{Space}")
    }
}