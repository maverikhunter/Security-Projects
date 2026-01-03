Function Calculate-File-Hash($filepath) {
    try {
        return Get-FileHash -Path $filepath -Algorithm SHA512 -ErrorAction Stop
    } catch {
        return $null # Return null if file is locked/inaccessible
    }
}

Function Erase-Baseline-If-Already-Exists() {
    if (Test-Path -Path .\baseline.txt) {
        Remove-Item -Path .\baseline.txt
    }
}

# ... [Menu Logic remains the same] ...

if ($response.ToUpper() -eq "A") {
    Erase-Baseline-If-Already-Exists
    Write-Host "Calculating baseline..." -ForegroundColor Cyan
    
    Get-ChildItem -Path .\Files | ForEach-Object {
        $hash = Calculate-File-Hash $_.FullName
        if ($hash) { "$($hash.Path)|$($hash.Hash)" }
    } | Out-File -FilePath .\baseline.txt

    Write-Host "Baseline created successfully!" -ForegroundColor Green
}

elseif ($response.ToUpper() -eq "B") {
    $fileHashDictionary = @{}

    if (Test-Path -Path .\baseline.txt) {
        Get-Content -Path .\baseline.txt | ForEach-Object {
            $parts = $_.Split("|")
            $fileHashDictionary[$parts[0]] = $parts[1]
        }
        Write-Host "Monitoring started... (Ctrl+C to stop)" -ForegroundColor Gray
    } else {
        Write-Host "ERROR: baseline.txt not found." -ForegroundColor Red; return
    }

    while ($true) {
        Start-Sleep -Seconds 1
        $currentFiles = Get-ChildItem -Path .\Files

        # Check for New or Changed Files
        foreach ($f in $currentFiles) {
            $hashObj = Calculate-File-Hash $f.FullName
            if (-not $hashObj) { continue }

            $path = $hashObj.Path
            $hash = $hashObj.Hash

            if (-not $fileHashDictionary.ContainsKey($path)) {
                Write-Host "[NEW] $path" -ForegroundColor Green
                $fileHashDictionary[$path] = $hash # Update state
            } 
            elseif ($fileHashDictionary[$path] -ne $hash) {
                Write-Host "[CHANGED] $path" -ForegroundColor Yellow
                $fileHashDictionary[$path] = $hash # Update state
            }
        }

        # Check for Deleted Files
        $pathsInDictionary = @($fileHashDictionary.Keys) # Create a copy to allow removal
        foreach ($path in $pathsInDictionary) {
            if (-not (Test-Path -Path $path)) {
                Write-Host "[DELETED] $path" -ForegroundColor Red
                $fileHashDictionary.Remove($path) # Update state
            }
        }
    }
}
