# conditional

$num = 10
if ( $num -gt 14) {
    <# Action to perform if the condition is true #>
    Write-Output ("Greater than")
} elseif( $num -lt 12) {
    Write-Output ("Less than")
} else {
    Write-Output ("Other case")
}

