args = "-c" & " -l " & """DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0 emacs"""
WScript.CreateObject("Shell.Application").ShellExecute "bash", args, "", "open", 0
