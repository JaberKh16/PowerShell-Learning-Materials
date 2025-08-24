# any application is a component object 
$excel = New-Object -ComObject Excel.Application # ComObject is component object
$excel.visible = $false # set visibility to false

$workbook = $excel.Workbooks.open("C:\NewFolder\Test.xlsx")
$sheet = $workbook.sheets.item(1) # in workbook from multiple pick the first one
$sheet.cells.item(1, 1).value="New"

$workbook.save()
$workbook.close()

