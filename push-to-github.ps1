# Запуск после входа в GitHub:  gh auth login
$gh = "C:\Program Files\GitHub CLI\gh.exe"

if (-not (Test-Path $gh)) {
  Write-Error "GitHub CLI не найден. Установи: winget install GitHub.cli"
  exit 1
}

& $gh auth status 2>$null
if ($LASTEXITCODE -ne 0) {
  Write-Host "Сначала войди в GitHub:"
  Write-Host "  & `"$gh`" auth login"
  exit 1
}

Set-Location $PSScriptRoot

& $gh repo create Stickify --private --source=. --remote=origin --push
if ($LASTEXITCODE -eq 0) {
  Write-Host ""
  Write-Host "Готово! Репозиторий на GitHub создан и код отправлен."
  & $gh repo view --web
}
