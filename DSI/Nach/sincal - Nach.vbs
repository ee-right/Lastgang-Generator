Option Explicit

'Function Sincalopen()
const siSimulationOK = 1101 'Status ID Lastfluss für erfolgreiche Berechnung

' Read the Sincal database from Excel
Dim xlsApp, xlsWorkBook, xlsSheet, Filename, Sincalfile
Set xlsApp = CreateObject("Excel.Application")
Filename = xlsApp.GetOpenFilename("Excel Files (*.xls), *.xls")  
Set xlsWorkBook = xlsApp.Workbooks.Open(Filename)
Set xlsSheet = xlsWorkBook.Sheets("Sincal Database")
Sincalfile = xlsSheet.Cells(1, 1)

Dim strDatabase ' Database of sincal network
strDatabase = Sincalfile

Dim strProtDatabase
strProtDatabase = "C:\Programme(x86)\PTI\PSS SINCAL 10.0\Database\ProtectionDB.mdb"

Dim strLF ' Load flow procedure
strLF = "LF_NR"

Dim strLoad 'Generator definieren
strLoad = "LO1"

' Set locale to US -> necessary because '.' is required for SQL commands!
SetLocale( "en-gb" )

' Create an simulation object as "in process server"
Dim SimulateObj
Set SimulateObj = WScript.CreateObject( "Sincal.Simulation" )

' Create an matlab object as "waitbar" 
Dim Matlab
Set Matlab = WScript.CreateObject("Matlab.Application")

If SimulateObj is Nothing Then
	WScript.Echo "Error: CreateObject Sincal.Simulation failed!"
	WScript.Quit

End If

' Setting databases and language
SimulateObj.DataSourceEx "DEFAULT", "JET", strDatabase, "Admin", ""
SimulateObj.DataSourceEx "PROT", "JET", strProtDatabase, "Admin", ""
SimulateObj.Language "US"

' Enable simulation batch mode: load from phys. database, store to virtual database
SimulateObj.BatchMode 1

' Load from database and generating calculation objects
SimulateObj.LoadDB CStr( strLF )   

' Getting virtual database object
Dim SimulateNetworkDataSource
Set SimulateNetworkDataSource = SimulateObj.DB_EL
If SimulateNetworkDataSource Is Nothing Then
	WScript.Echo "Error: getting virtual database object failed!"
	WScript.Quit
End If

Dim anz, num

' Get the number of the transformer
Dim AnzTrafo
AnzTrafo = 0
for anz = 1 To 9999 
    Dim TrafoTest
    Set TrafoTest = SimulateObj.GetObj( "TwoWindingTransformer", CStr( "T"&anz&"" ) )
    if TrafoTest Is Nothing Then
    Else		
        AnzTrafo = AnzTrafo + 1
    End if
next

Dim NumTrafo
Redim NumTrafo(AnzTrafo)
num=1
for anz = 1 To 9999 
    Dim TrafoNumTest
    Set TrafoNumTest = SimulateObj.GetObj( "TwoWindingTransformer", CStr( "T"&anz&"" ) )
    if TrafoNumTest Is Nothing Then
    Else		
        NumTrafo(num)=anz		
		num=num+1
    End if
next
WScript.Echo "The number of the Transformer = " & num-1


' Get the number of the Lines
Dim AnzLeitung
AnzLeitung = 0
for anz = 1 To 9999 
    Dim LineTest
    Set LineTest = SimulateObj.GetObj( "Line", CStr( "L"&anz&"" ) )
    if LineTest Is Nothing Then
    Else		
        AnzLeitung = AnzLeitung + 1
    End if
next

Dim NumLine
Redim NumLine(AnzLeitung)
num=1
for anz = 1 To 9999 
    Dim LineNumTest
    Set LineNumTest = SimulateObj.GetObj( "Line", CStr( "L"&anz&"" ) )
    if LineNumTest Is Nothing Then
    Else		
        NumLine(num)=anz		
		num=num+1
    End if
next
WScript.Echo "The number of the Line = " & num-1


' Get the number of the loads
Dim AnzLoad
AnzLoad = 0
for anz = 1 To 9999 
    Dim LoadTest
    Set LoadTest = SimulateObj.GetObj( "Load", CStr( "LO"&anz&"" ) )
    if LoadTest Is Nothing Then
    Else		
        AnzLoad = AnzLoad + 1
    End if
next

Dim NumLoad
Redim NumLoad(AnzLoad)
num=1
for anz = 1 To 9999 
    Dim LoadNumTest
    Set LoadNumTest = SimulateObj.GetObj( "Load", CStr( "LO"&anz&"" ) )
    if LoadNumTest Is Nothing Then
    Else		
        NumLoad(num)=anz		
		num=num+1
    End if
next
WScript.Echo "The number of the Load = " & num-1

' Get the number of the nodes
Dim AnzNode
AnzNode = 0
for anz = 1 To 9999 
    Dim NodeTest
    Set NodeTest = SimulateObj.GetObj( "NODE", CStr( "N"&anz&"" ) )
    if NodeTest Is Nothing Then
    Else		
        AnzNode = AnzNode + 1
    End if
next

Dim NumNode
Redim NumNode(AnzNode)
num=1
for anz = 1 To 9999 
    Dim NodeNumTest
    Set NodeNumTest = SimulateObj.GetObj( "NODE", CStr( "N"&anz&"" ) )
    if NodeNumTest Is Nothing Then
    Else		
        NumNode(num)=anz		
		num=num+1
    End if
next
WScript.Echo "The number of the Node = " & num-1


Dim AnzDC
AnzDC = 0
for anz = 1 To 9999 
    Dim DCTest
    Set DCTest = SimulateObj.GetObj( "DCInfeeder", CStr( "DCI"&anz&"" ) )
    if DCTest Is Nothing Then
    Else		
        AnzDC = AnzDC + 1
    End if
next

Dim NumDC
Redim NumDC(AnzDC)
num=1
for anz = 1 To 9999 
    Dim DCNumTest
    Set DCNumTest = SimulateObj.GetObj( "DCInfeeder", CStr( "DCI"&anz&"" ) )
    if DCNumTest Is Nothing Then
    Else		
        NumDC(num)=anz		
		num=num+1
    End if
next
WScript.Echo "The number of the DC = " & num-1

	
'------------------------------------------------------------------------------
' Perform a special voltage drop analysis
'------------------------------------------------------------------------------
Dim iLoop, numAdd, i, j, n, TrafoObj, LineObj, NodeObj, DCFeedObj, S_nenn, S, i_l, i_th, u_n, p_pv, P, Q, sheetloop, sheetname

for sheetloop = 1 To 4

    iLoop = 1
	' Create an "waitbar" 
	Matlab.Execute("h = waitbar(0,'Please wait...');")
    
    Select Case sheetloop
        Case 1
            Sheetname = "Normal"
        Case 2
            Sheetname = "Price Signal"
        Case 3
            Sheetname = "Real Time Pricing"
    	Case 4
            Sheetname = "Direct Load Control"	
    End Select
    
    
    Do While iLoop < 35041
        
        Set xlsSheet = xlsWorkBook.Sheets("Nach")
        If xlsSheet.Cells(iLoop+1,3) = 0 Then
            iLoop=iLoop+1
        Else
        'WScript.Echo vbCrLf & "-------- " & CStr( iLoop ) & " --------"
    	
    	' We modify the all loads for each loop
    	Dim LoadObj , PVObj
    	   	
    	Set xlsSheet = xlsWorkBook.Sheets(Sheetname)
    	for j = 1 To Anzload
    	    ' Getting calculation object load for modifying		
            Set LoadObj = SimulateObj.GetObj( "LOAD", CStr( "LO"&NumLoad(j)&"" ) )
            If LoadObj is Nothing Then
    	        WScript.Echo "Error: Load" & strLoad & " not found "
    	        WScript.Quit
            End If 
    		
			' Modify load by increasing P and Q 
            P = xlsSheet.Cells(iLoop+1,j)/1000000         
            LoadObj.Item( "P" ) = P
    
        next  
		
		Set xlsSheet = xlsWorkBook.Sheets("Q " & Sheetname)
    	for j = 1 To Anzload
    	    ' Getting calculation object load for modifying		
            Set LoadObj = SimulateObj.GetObj( "LOAD", CStr( "LO"&NumLoad(j)&"" ) )
            If LoadObj is Nothing Then
    	        WScript.Echo "Error: Load" & strLoad & " not found "
    	        WScript.Quit
            End If 
    		    	
            ' Modify load by increasing P and Q 
            Q = xlsSheet.Cells(iLoop+1,j)/1000000
            LoadObj.Item( "Q" ) = Q
    
        next 
    
    	Set xlsSheet = xlsWorkBook.Sheets("Solar")
        for n = 1 To AnzDC
    	    ' Getting calculation object load for modifying		
            Set PVObj = SimulateObj.GetObj( "DCInfeeder", CStr( "DCI"&NumDC(n)&"" ) )
            If PVObj is Nothing Then
    	        WScript.Echo "Error: Load" & strLoad & " not found "
    	        WScript.Quit
            End If 
    	
            ' Modify load by increasing P and Q 
            Dim P_dc
    		P_dc = xlsSheet.Cells(iLoop+1,n)
            PVObj.Item( "P" ) = P_dc/1000000
    		'WScript.Echo "-------- " & AnzDC & " --------"
        next  	
		
		Set xlsSheet = xlsWorkBook.Sheets("cosphi")
        for n = 1 To AnzDC
    	    ' Getting calculation object load for modifying		
            Set PVObj = SimulateObj.GetObj( "DCInfeeder", CStr( "DCI"&NumDC(n)&"" ) )
            If PVObj is Nothing Then
    	        WScript.Echo "Error: Load" & strLoad & " not found "
    	        WScript.Quit
            End If 
    	
            ' Modify load by increasing P and Q 
            Dim cosphi
    		cosphi = xlsSheet.Cells(iLoop+1,n)
            PVObj.Item( "cosphi" ) = -cosphi
    		'WScript.Echo "-------- " & AnzDC & " --------"
        next  
    	
    
        
        ' Start loadflow simulation
        SimulateObj.Start strLF	
        If SimulateObj.StatusID <> siSimulationOK Then 
            WScript.Echo "Load flow failed!"
            for i= 1 To AnzLeitung
    		    Matlab.Execute("Strom_"&sheetloop&"("&iLoop&", "&i&")=0;")	  
              			
            Next
    		
			for i= 1 To AnzTrafo
    		    Matlab.Execute("Scheinleistung_"&sheetloop&"("&iLoop&", "&i&")=0;")	  
              			
            Next
			
    	    for i= 1 To AnzNode
    		    Matlab.Execute("Spannung_"&sheetloop&"("&iLoop&", "&i&")=0;")	 
    
            Next
    		
        Else   
            ' Getting load flow result for Trafo
    	    for i= 1 To AnzTrafo
                Set TrafoObj = SimulateObj.GetObj( "TwoWindingTransformer", "T"&NumTrafo(i)&"" )   
                Dim LFTrafoResult	
                Set LFTrafoResult = TrafoObj.Result( "LFBranchResult", 1 )
                If LFTrafoResult Is Nothing Then
                Else
                
                    S_nenn = TrafoObj.Item( "Sn" ) 			
                    S = LFTrafoResult.Item( "S" )*100/S_nenn			
                    Matlab.Execute("Scheinleistung_"&sheetloop&"("&iLoop&", "&i&")="&S&";")				
    			    'WScript.Echo "Node voltage at modified load " & "N" & i & " U/Un = " & FormatNumber( u_un(iLoop, i) ) & "%"
                    Set LFLineResult = Nothing
                End If
            Next 		     
			 
            ' Getting load flow result for Strom
    	    for i= 1 To AnzLeitung
                Set LineObj = SimulateObj.GetObj( "Line", "L"&NumLine(i)&"" )   
                Dim LFLineResult	
                Set LFLineResult = LineObj.Result( "LFBranchResult", 1 )
                If LFLineResult Is Nothing Then
                Else
                
                    i_th = LineObj.Item( "Ith" ) 			
                    i_l = LFLineResult.Item( "I" )*100/i_th			
                    Matlab.Execute("Strom_"&sheetloop&"("&iLoop&", "&i&")="&i_l&";")				
    			    'WScript.Echo "Node voltage at modified load " & "N" & i & " U/Un = " & FormatNumber( u_un(iLoop, i) ) & "%"
                    Set LFLineResult = Nothing
                End If
            Next 
    
    		' Getting load flow result for Spannung
    	    for i= 1 To AnzNode
                Set NodeObj = SimulateObj.GetObj( "NODE", "N"&NumNode(i)&"" )   
                Dim LFNodeResult	
                Set LFNodeResult = NodeObj.Result( "LFNODERESULT", 0 )
                If LFNodeResult Is Nothing Then
                Else
                
                    u_n = LFNodeResult.Item( "U_Un" )
                    Matlab.Execute("Spannung_"&sheetloop&"("&iLoop&", "&i&")="&u_n&";")				
    			    'WScript.Echo "Node voltage at modified load " & "N" & i & " U/Un = " & FormatNumber(u_n) & "%"
                    Set LFNodeResult = Nothing
                End If
            Next
			
	        ' Getting load flow result for PV-feed
    	    for i= 1 To AnzDC
                Set DCFeedObj = SimulateObj.GetObj( "DCInfeeder", "DCI"&NumDC(i)&"" )   
                Dim LFDCFeedResult	
                Set LFDCFeedResult = DCFeedObj.Result( "LFBranchResult", 1 )
                If LFDCFeedResult Is Nothing Then
                Else
                
                    p_pv = LFDCFeedResult.Item( "P" )*1000000
                    Matlab.Execute("Einspeisung_"&sheetloop&"("&iLoop&", "&i&")="&p_pv&";")				
    			    'WScript.Echo "Node voltage at modified load " & "N" & i & " U/Un = " & FormatNumber( p_pv ) & "%"
                    Set LFNodeResult = Nothing
                End If
            Next


            iLoop=iLoop+1			
			
        End If
        End If
    	
    	'show the process of the programm
        Matlab.Execute(" waitbar("&iLoop&" / 35040, h, 'Calculating "& Sheetname &" "& iLoop &" of 35040');")
    Loop
    
    	
    'close the waitbar
    Matlab.Execute(" close(h);")

Next

xlsWorkBook.Save
xlsWorkBook.Close
xlsApp.Quit
 
Set xlsSheet= Nothing 
Set xlsWorkBook= Nothing
Set xlsApp= Nothing

Matlab.Execute("xlswrite('"&Filename&"x', Strom_1, 'I Normal', 'C2');")
Matlab.Execute("xlswrite('"&Filename&"x', Spannung_1, 'U Normal', 'C2');")
Matlab.Execute("xlswrite('"&Filename&"x', Scheinleistung_1, 'S Normal', 'C2');")
Matlab.Execute("xlswrite('"&Filename&"x', Einspeisung_1, 'PV Normal', 'C2');")
Matlab.Execute("xlswrite('"&Filename&"x', Strom_2, 'I Price Signal', 'C2');")
Matlab.Execute("xlswrite('"&Filename&"x', Spannung_2, 'U Price Signal', 'C2');")
Matlab.Execute("xlswrite('"&Filename&"x', Scheinleistung_2, 'S Price Signal', 'C2');")
Matlab.Execute("xlswrite('"&Filename&"x', Einspeisung_2, 'PV Price Signal', 'C2');")
Matlab.Execute("xlswrite('"&Filename&"x', Strom_3, 'I Real Time Pricing', 'C2');")
Matlab.Execute("xlswrite('"&Filename&"x', Spannung_3, 'U Real Time Pricing', 'C2');")
Matlab.Execute("xlswrite('"&Filename&"x', Scheinleistung_3, 'S Real Time Pricing', 'C2');")
Matlab.Execute("xlswrite('"&Filename&"x', Einspeisung_3, 'PV Real Time Pricing', 'C2');")
Matlab.Execute("xlswrite('"&Filename&"x', Strom_4, 'I Direct Load Control', 'C2');")
Matlab.Execute("xlswrite('"&Filename&"x', Spannung_4, 'U Direct Load Control', 'C2');")
Matlab.Execute("xlswrite('"&Filename&"x', Scheinleistung_4, 'S Direct Load Control', 'C2');")
Matlab.Execute("xlswrite('"&Filename&"x', Einspeisung_4, 'PV Direct Load Control', 'C2');")


' Free all objects
WScript.Echo "Finish"

Call CleanupAndQuit()


'------------------------------------------------------------------------------
' Write simulation messages
'------------------------------------------------------------------------------
Sub WriteMessages( ByRef SimulateObj )

    WScript.Echo vbCrLf & "Simulation Messages:" & vbCrLf


    Dim objMessages
    Set objMessages = SimulateObj.Messages	

    Dim strType
    Dim intMsgIdx
    For intMsgIdx = 1 To objMessages.Count
        Dim Msg
        Set Msg = objMessages.Item( intMsgIdx )

        Select Case Msg.Type 
            case 1 ' STATUS
            case 2 ' INFO
            case 3 ' WARNING
                WScript.Echo Msg.Text
            case 4 ' ERROR
                WScript.Echo Msg.Text
        End Select
            
        Set Msg = Nothing
    Next
    Set objMessages = Nothing
    
End Sub

'------------------------------------------------------------------------------
' Free all COM objects
'------------------------------------------------------------------------------
Sub CleanupAndQuit() 

    Set SimulateNetworkDataSource = Nothing
    Set LoadObj = Nothing
    Set LineObj = Nothing
	Set NodeObj = Nothing
    Set SimulateObj = Nothing
	Set Matlab = Nothing
    WScript.Quit

End Sub
