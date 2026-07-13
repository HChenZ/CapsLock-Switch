# CapsLock-Switch
使用 AutoHotkey 修改 Windows 中 CapsLock 键的功能，使其操作逻辑与 macOS 相同
## 说明
* CapsLockSwitch.ahk 需要使用 AutoHotkey v2.0 版本，CapsLockSwitch_v1.0.ahk 则需要使用 AutoHotkey v1.0 版本
* CapsLock 键的功能被修改为短按切换中英文，长按切换大小写
* 默认使用 Ctrl+Space 作为切换中英文的快捷键，如果使用其它快捷键请在代码中修改
* 长按时间阈值默认为 0.3s，如果不合适可以自行调整
* 该脚本在开头添加了自动以管理员权限运行，这是为了让脚本在一些系统级窗口中也能够使用
* 若想实现开机自启动，则可以将脚本的快捷方式添加到启动文件夹中（Win+R，输入 shell:startup）
