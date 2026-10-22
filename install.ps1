# UTF-8 Desteğini Etkinleştir (Türkçe karakterlerin düzgün görünmesi için)
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# --- DİL MENÜSÜ FONKSİYONU ---
function Show-LanguageMenu {
    $options = @("1. Türkçe (Turkish)", "2. English (İngilizce)")
    $selectedIndex = 0
    $running = $true

    # İmleci gizle
    [Console]::CursorVisible = $false

    while ($running) {
        Clear-Host
        Write-Host "`n=== SelimAI Installer - Dil Seçimi / Language Selection ===" -ForegroundColor Cyan
        Write-Host "Lütfen yön tuşlarını (↑ ↓) kullanarak dili seçin ve Enter'a basın." -ForegroundColor Gray
        Write-Host "Please use arrow keys (↑ ↓) to select language and press Enter.`n" -ForegroundColor Gray

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

# --- DİL SEÇİMİNİ BAŞLAT ---
$selectedLangIndex = Show-LanguageMenu
Clear-Host

# --- METİN SÖZLÜĞÜ ---
$msgTitle = if ($selectedLangIndex -eq 0) { "=== SelimAI Kurulum Sihirbazı ===" } else { "=== SelimAI Installation Wizard ===" }
$msgInstalling = if ($selectedLangIndex -eq 0) { "SelimAI yükleniyor..." } else { "SelimAI is installing..." }
$msgDownloading = if ($selectedLangIndex -eq 0) { "Yüklenen" } else { "Downloaded" }
$msgComplete = if ($selectedLangIndex -eq 0) { "[+] İndirme tamamlandı! Program aynı pencerede başlatılıyor..." } else { "[+] Download complete! Launching program in the same window..." }
$msgError = if ($selectedLangIndex -eq 0) { "[-] Hata Oluştu. Lütfen bağlantınızı veya Drive izinlerini kontrol edin." } else { "[-] An Error Occurred. Please check your connection or Drive permissions." }

# --- İNDİRME VE ÇALIŞTIRMA SÜRECİ ---
Write-Host "`n$msgTitle" -ForegroundColor Cyan
Write-Host $msgInstalling -ForegroundColor Yellow

$url = "https://google.com" # Change this to your Google Drive / File URL
$outputFile = Join-Path $env:TEMP "SelimAI_Setup.exe"

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
            Write-Host -NoNewline "`r$msgDownloading: %$percent ($([Math]::Round($totalBytesRead / 1MB, 2)) MB / $([Math]::Round($totalBytes / 1MB, 2)) MB)" -ForegroundColor Green
        } else {
            Write-Host -NoNewline "`r$msgDownloading: $($([Math]::Round($totalBytesRead / 1MB, 2))) MB" -ForegroundColor Green
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
