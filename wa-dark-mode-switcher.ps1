Param(
    [string] $WaBase = $null
)

$WeAreOnWindows = $IsWindows -or $ENV:OS

# if (!$WeAreOnWindows) {
    # throw "This script works only on Windows environment. For *nix use wa-dark-mode-switcher.sh"
# }

if (-not (Get-Command -Name "npx" -ErrorAction SilentlyContinue)) {
    throw "npx is required to unpack WhatsApp. Please install node.js for your OS."
}

$default_npm_cache = &npm config get cache --global
if ($default_npm_cache -match " ") {
    # if the path contains a space, then lets set to a temporary location until we finish.
    &npm config set cache C:\tmp\nodejs\npm-cache --global
}

$latestPath = $WaBase
if ([string]::IsNullOrWhiteSpace($WaBase)) {
    Write-Output "Locating WhatsApp"
    if ($WeAreOnWindows) {
      $WaBase = Join-Path -Path $env:LOCALAPPDATA -ChildPath whatsapp
    } elseif ($IsLinux) {
      # linux path
    } elseif ($IsMacOs) {
      $WaBase = "/Applications/WhatsApp.app"
    }

    if (-not (Test-Path -Path $WaBase)) {
        Write-Output "Checking for MSI-based installations"
        $latestPath = Join-Path -Path $env:ProgramFiles -ChildPath "WhatsApp"
        if (-not (Test-Path -Path $latestPath)) {
            throw "It doesn't look like WhatsApp is installed"
        }

        Write-Output "Found WhatsApp MSI Install"
    } else {
      if ($WeAreOnWindows) {
        $latestPath = Get-ChildItem -Path $WaBase -Directory -Filter "app*" | Sort-Object -Descending | Select-Object -First 1 -ExpandProperty FullName
        Write-Output "Found WhatsApp $($latestPath.Name) in AppData"
      } elseif ($IsLinux) {
        # linux path
      } elseif ($IsMacOs) {
        $latestPath = Get-ChildItem -Path $WaBase -Directory -Filter "Contents" | Sort-Object -Descending | Select-Object -First 1 -ExpandProperty FullName
        Write-Output "Found WhatsApp Contents at $latestPath"
      }
    }
} elseif (-not (Test-Path -Path $WaBase)) {
    throw "Could not find $WaBase"
}


if ($WeAreOnWindows) {
  $resources = Join-Path -Path $latestPath -ChildPath "resources"
} elseif ($IsLinux) {
  # linux path
} elseif ($IsMacOs) {
  $resources = Join-Path -Path $latestPath -ChildPath "Resources"
}

Write-Output "Stopping WhatsApp"
Get-Process *whatsapp* | Stop-Process -Force

$asar = Join-Path -Path $resources -ChildPath "app.asar"
$unpacked = Join-Path -Path $resources -ChildPath "app.de-asar"

Write-Output "Unpacking asar archive"

&npx asar extract "$asar" "$unpacked"

Write-Output "Adding Hook"
$filePath = Join-Path -Path "$unpacked" -ChildPath "index.html"
$src = Get-Content -Raw $filePath

$lead = "<!-- BEGIN CUSTOM LISTENER SWITCH -->"
$tail = "<!--  END  CUSTOM LISTENER SWITCH -->"
if ($src.Contains($lead)) {
  Write-Output "Replacing Dark Theme switch to WhatsApp..."
  $start = $src.IndexOf($lead)
  $end   = $src.IndexOf($tail) + $tail.length
  $src1 = $src.Substring(0, $start)
  $src2 = $src.Substring($end)
  $src = $src1 + $src2
} else {
  Write-Output "Adding Dark Theme switch to WhatsApp..."
}

$lead = "script>"
$tail = "</body>"

$start = $src.LastIndexOf($lead) + $lead.length
$end   = $src.LastIndexOf($tail)


$src1 = $src.Substring(0, $start)
$src2 = $src.Substring($end)

$patch = Get-Content -Path (Join-Path -Path $PSScriptRoot -ChildPath "event-listener.html") -Raw

Write-Output @"
$src1
$patch
$src2
"@ | Set-Content -Path $filePath

Write-Output "Packing asar archive"
&npx asar pack "$unpacked" "$asar"

if ($default_npm_cache -match " "){
  # if the path contains a space, then lets set it back to the original value.
  &npm config set cache $default_npm_cache --global
}
