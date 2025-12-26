; CapsLock短按切换中英文，长按切换大小写

; 自动以管理员权限运行
if not A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; 长按时间阈值（毫秒）
longPressThreshold := 400

; 状态标志
capsLockPressed := false
longPressDetected := false

; 处理CapsLock按下
*CapsLock::
    capsLockPressed := true
    longPressDetected := false
    
    ; 记录按下时间
    keyDownTime := A_TickCount
    
    ; 等待按键释放，设置超时
    KeyWait, CapsLock, T0.5  ; 等待0.5秒
    
    ; ErrorLevel=1 表示超时（长按）
    ; ErrorLevel=0 表示按键已释放（短按）
    if (ErrorLevel = 1) {
        ; 长按 - 切换大小写锁定
        longPressDetected := true
        SetCapsLockState, % GetKeyState("CapsLock", "T") ? "Off" : "On"
        
        ; 等待按键释放
        KeyWait, CapsLock
    } else {
        ; 短按 - 只在长按未检测到时切换输入法
        if (capsLockPressed and not longPressDetected) {
            ; 确保是真正的短按
            keyDuration := A_TickCount - keyDownTime
            if (keyDuration < 300) {
                ; 切换输入法
                Send, ^{Space}
            }
        }
    }
    
    ; 重置状态
    capsLockPressed := false
Return