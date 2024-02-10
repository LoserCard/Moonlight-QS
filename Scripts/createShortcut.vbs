Set oWS = WScript.CreateObject("WScript.Shell")
sLinkFile = WScript.Arguments(0)   REM Get shortcut name from first argument
sTargetPath = WScript.Arguments(1) REM Get target path from second argument
sMAC = WScript.Arguments(2)         REM Get MAC from third argument
sIP = WScript.Arguments(3)          REM Get IP from fourth argument
sHost = WScript.Arguments(4)        REM Get Host from fifth argument
sApp = WScript.Arguments(5)         REM Get App from sixth argument

REM Ensure the shortcut name includes the .lnk extension
If Right(sLinkFile, 4) <> ".lnk" Then
    sLinkFile = sLinkFile & ".lnk"
End If

Set oLink = oWS.CreateShortcut(sLinkFile)
oLink.TargetPath = sTargetPath
oLink.Arguments = sMAC & " " & sIP & " " & sHost & " " & sApp

REM Set the icon path
oLink.IconLocation = oWS.CurrentDirectory & "\Scripts\moonlight.ico"

REM Set the "Start in" directory
oLink.WorkingDirectory = oWS.CurrentDirectory

oLink.Save