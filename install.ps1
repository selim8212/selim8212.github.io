$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

function Show-LanguageMenu {
    $options = @("1. Turkce", "2. English")
    $selectedIndex = 0
    $running = $true

    [Console]::CursorVisible = $false

    while ($running) {
        Clear-Host
        Write-Host ""
        Write-Host "=== SelimAI Installer - Dil Secimi / Language Selection ===" -ForegroundColor Cyan
        Write-Host "Lutfen yon tuslarini kullanarak dili secin ve Enter tusuna basin." -ForegroundColor Gray
        Write-Host "Please use arrow keys to select language and press Enter.`n" -ForegroundColor Gray

        for ($i = 0; $i -lt $options.Length; $i++) {
            if ($i -eq $selectedIndex) {
                Write-Host " > $($options[$i]) " -ForegroundColor Black -BackgroundColor White
            } else {
                Write-Host "    $($options[$i]) " -ForegroundColor Gray
            }
        }

        $key = [Console]::ReadKey($true)

        switch ($key.Key) {
            "UpArrow" {
                $selectedIndex--
                if ($selectedIndex -lt 0) { $selectedIndex = $options.Length - 1 }
            }
            "DownArrow" {
                $selectedIndex++
                if ($selectedIndex -ge $options.Length) { $selectedIndex = 0 }
            }
            "Enter" {
                $running = $false
            }
        }
    }

    [Console]::CursorVisible = $true
    return $selectedIndex
}

$selectedLangIndex = Show-LanguageMenu
Clear-Host

$msgTitle = if ($selectedLangIndex -eq 0) { "=== SelimAI Kurulum Sihirbazi ===" } else { "=== SelimAI Installation Wizard ===" }
$msgInstalling = if ($selectedLangIndex -eq 0) { "SelimAI yukleniyor..." } else { "SelimAI is installing..." }
$msgComplete = if ($selectedLangIndex -eq 0) { "[+] Indirme tamamlandi! Program ayni pencerede baslatiliyor..." } else { "[+] Download complete! Launching program in the same window..." }
$msgError = if ($selectedLangIndex -eq 0) { "[-] Bir Hata Olustu. Lutfen baglantinizi kontrol edin." } else { "[-] An Error Occurred. Please check your connection." }

Write-Host ""
Write-Host $msgTitle -ForegroundColor Cyan
Write-Host $msgInstalling -ForegroundColor Yellow

$url = "https://github.com/selim8212/selim8212.github.io/releases/download/kjjk/SelimAI.exe"
$outputFile = Join-Path $env:TEMP "SelimAI.exe"

# Terminate any running instance and remove old file to avoid lock errors
Get-Process -Name "SelimAI" -ErrorAction SilentlyContinue | Stop-Process -Force
if (Test-Path $outputFile) {
    Remove-Item $outputFile -Force -ErrorAction SilentlyContinue
}

$request = [System.Net.HttpWebRequest]::Create($url)
$request.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
$request.Timeout = 60000

try {
    $response = $request.GetResponse()
    $totalBytes = $response.ContentLength
    $responseStream = $response.GetResponseStream()
    $fileStream = [System.IO.FileStream]::new($outputFile, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write)
    $buffer = [byte[]]::new(4096)
    $bytesRead = 0
    $totalBytesRead = 0

    while (($bytesRead = $responseStream.Read($buffer, 0, $buffer.Length)) -gt 0) {
        $fileStream.Write($buffer, 0, $bytesRead)
        $totalBytesRead += $bytesRead
        
        if ($totalBytes -gt 0) {
            $percent = [Math]::Floor(($totalBytesRead / $totalBytes) * 100)
            $completedBlocks = [Math]::Floor($percent / 2)
            $remainingBlocks = 50 - $completedBlocks
            $bar = "[" + ("#" * $completedBlocks) + ("-" * $remainingBlocks) + "]"
            
            Write-Host -NoNewline "`r$bar %$percent ($([Math]::Round($totalBytesRead / 1MB, 2)) MB / $([Math]::Round($totalBytes / 1MB, 2)) MB)" -ForegroundColor Green
        } else {
            Write-Host -NoNewline "`rIndirilen: $($([Math]::Round($totalBytesRead / 1MB, 2))) MB" -ForegroundColor Green
        }
    }

    $fileStream.Close()
    $responseStream.Close()
    $response.Close()
    
    Write-Host "`n`n$msgComplete" -ForegroundColor Cyan
    Start-Sleep -Seconds 1

    Start-Process -FilePath $outputFile -NoNewWindow -Wait

} catch {
    Write-Host "`n`n$msgError" -ForegroundColor Red
    Write-Host "Details: $_" -ForegroundColor Yellow
}
