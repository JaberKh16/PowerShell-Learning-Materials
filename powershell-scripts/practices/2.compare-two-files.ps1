# comparing two files

$file1 = get-content ./process.txt
$file2 = get-content ./services.txt

compare-object $file1 $file2
