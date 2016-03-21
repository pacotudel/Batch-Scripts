intHorizontal = 0
intVertical = 0
 WScript.Echo "Metodo 1"
 Set objWMIService = GetObject("Winmgmts:\\.\root\cimv2") 
    Set colItems = objWMIService.ExecQuery("Select * From Win32_DesktopMonitor where DeviceID = 'DesktopMonitor1'",,0) 
    For Each objItem in colItems 
        intHorizontal = objItem.ScreenWidth 
        intVertical = objItem.ScreenHeight 
    Next 
WScript.Echo "Monitor1: " & intHorizontal & " * " & intVertical 

intHorizontal = 0
intVertical = 0
WScript.Echo "Metodo 2"
Set objWMIService = GetObject("Winmgmts:\\.\root\cimv2") 
    Set colItems = objWMIService.ExecQuery("Select * From Win32_DesktopMonitor",,0)
	x=1
    For Each objItem in colItems 
        intHorizontal = objItem.ScreenWidth 
        intVertical = objItem.ScreenHeight 
		WScript.Echo "Monitor" & x & ": " & intHorizontal & " * " & intVertical 
		x = x + 1
    Next 

intHorizontal = 0
intVertical = 0
WScript.Echo "Metodo 3"
Set colItems = objWMIService.ExecQuery("Select * from Win32_VideoController",,48)
    For Each objItem in colItems 
        intHorizontal = objItem.CurrentHorizontalResolution 
        intVertical = objItem.CurrentVerticalResolution 
		WScript.Echo intHorizontal & " * " & intVertical 
    Next

	

If intHorizontal/IntVertical <= 1.334 then
	WScript.Echo "4:3"
	Else
	WScript.Echo "Widescreen"
End if