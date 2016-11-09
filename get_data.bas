Sub get_data()
Dim nm_brand As String, patch As String, ShIn As String

Dim ThisYear As Integer, cd_ActualMonth As Integer
Dim LastRow As Long

myLib.VBA_Start

nm_ActWb = ActiveWorkbook.Name
cd_ActualMonth = CInt(InputBox("Month"))
ThisYear = CInt(InputBox("YearEnd"))

ar_brand = Array("LP", "MX", "KR", "RD", "ES")
myLib.VBA_Start

Dim clnts As clsClients, clnt As clsClientInfo
Set clnts = New clsClients


For f_brnd = 0 To UBound(ar_brand)
    nm_brand = ar_brand(f_brnd)
    ShIn = nm_brand
    ShOut = "TR"
    patch = myLib.GetPatchHistTR(nm_brand, ThisYear, ThisYear, cd_ActualMonth, cd_ActualMonth)
    WbTR = myLib.OpenFile(patch, ShIn)
    Workbooks(WbTR).Activate
    Sheets(ShIn).Select
    clnts.FillFromSheet ActiveSheet, 2016, 8, nm_brand
    
    Workbooks(WbTR).Close
    Workbooks(nm_ActWb).Activate
Next f_brnd

myLib.CreateSh (ShOut)
myLib.sheetActivateCleer (ShOut)

i = 1
For Each clnt In clnts
    i = i + 1
    With clnt
        n = 1: Cells(i, n) = .BrandName
        n = n + 1: Cells(i, n) = .DatabaseClientNum
    End With

Next
myLib.VBA_End
End Sub
    
