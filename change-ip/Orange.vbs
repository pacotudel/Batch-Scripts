strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set colItems = objWMIService.ExecQuery("Select * from Win32_NetworkAdapterConfiguration where IPEnabled = true")

'// Static Ip addrerss settings
strIPAddress = Array("192.168.1.148")
strSubnetMask = Array("255.255.255.0")
strGateway = Array("192.168.1.1")
strGatewayMetric = Array(1)
strDNSservers = Array ("8.8.8.8","8.8.4.4")



goStatic


Sub goStatic()
For Each objItem In colItems
errEnable = objItem.EnableStatic(strIPAddress, strSubnetMask)
errGateways = objItem.SetGateways(strGateway, strGatewaymetric)
'// This line removes all DNS servers
errDNS = objitem.SetDNSServerSearchOrder()
errDNS = objitem.SetDNSServerSearchOrder(strDNSServers)
If errEnable = 0 Then
WScript.Echo "The IP address has been changed."
Else
WScript.Echo "The IP address could not be changed."
End If
Next
'// ReQuery to see changes
Set colItems = objWMIService.ExecQuery("Select * from Win32_NetworkAdapterConfiguration where IPEnabled = true")
For Each objItem In colItems
If Not IsNull(objitem.ipaddress) Then
        For i = LBound(objitem.IPAddress) To UBound(objitem.IPAddress)
        WScript.Echo "New IP is " & objitem.IPAddress(i)
        Next
    End If
    If Not IsNull(objitem.ipSubnet) Then
        For i = LBound(objitem.IPSubnet) To UBound(objitem.IPSubnet)
        WScript.Echo "New subnet is " & objitem.IPSubnet(i)
        Next
    End If
    If Not IsNull(objitem.DefaultIPGateway) Then
        For i = LBound(objitem.DefaultIPGateway) To UBound(objitem.DefaultIPGateway)
        WScript.Echo "Gateway is " & objitem.DefaultIPGateway(i)
        Next
    End If
Next
End Sub

Sub goDHCP()
For Each objItem In colItems

errEnable = objItem.EnableDHCP()
    If errEnable = 0 Then
        Wscript.Echo "DHCP has been enabled."
    Else
        Wscript.Echo "DHCP could not be enabled."
    End If
    Msgbox "setting DNS"
    errDNS = objitem.SetDNSServerSearchOrder()
    errDDNS = objItem.SetDynamicDNSRegistration
        msgbox "DNS Set"
    errRenew = objItem.RenewDHCPLease
    msgbox "renew called"
    If errRenew = 0 Then
        Wscript.Echo "DHCP lease renewed."
    Else
        Wscript.Echo "DHCP lease could not be renewed." & err.number & err.description
    End If
Next
End Sub 