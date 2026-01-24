param(
  [Parameter(Mandatory = $true)]
  [string]$ChangeId,

  [Parameter(Mandatory = $true)]
  [string[]]$Capabilities
)

$ErrorActionPreference = "Stop"

function Copy-Template {
  param(
    [Parameter(Mandatory = $true)][string]$TemplateName,
    [Parameter(Mandatory = $true)][string]$TargetPath,
    [Parameter(Mandatory = $true)][string]$ChangeId
  )

  $templatePath = Join-Path $PSScriptRoot "..\\assets\\templates\\$TemplateName"
  $content = Get-Content -Raw $templatePath
  $content = $content.Replace("<change-id>", $ChangeId)

  $targetDir = Split-Path -Parent $TargetPath
  if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir | Out-Null
  }

  if (Test-Path $TargetPath) {
    throw "Refusing to overwrite existing file: $TargetPath"
  }

  Set-Content -Path $TargetPath -Value $content -Encoding UTF8
}

$changeRoot = Join-Path (Get-Location) "openspec\\changes\\$ChangeId"
if (Test-Path $changeRoot) {
  throw "Change already exists: $changeRoot"
}

New-Item -ItemType Directory -Path $changeRoot | Out-Null
New-Item -ItemType Directory -Path (Join-Path $changeRoot "specs") | Out-Null

Copy-Template -TemplateName "proposal.md" -TargetPath (Join-Path $changeRoot "proposal.md") -ChangeId $ChangeId
Copy-Template -TemplateName "tasks.md" -TargetPath (Join-Path $changeRoot "tasks.md") -ChangeId $ChangeId
Copy-Template -TemplateName "design.md" -TargetPath (Join-Path $changeRoot "design.md") -ChangeId $ChangeId

foreach ($capability in $Capabilities) {
  $specPath = Join-Path $changeRoot "specs\\$capability\\spec.md"
  $specDir = Split-Path -Parent $specPath
  New-Item -ItemType Directory -Path $specDir | Out-Null

  $delta = @"
## ADDED Requirements
### Requirement: <requirement-name>
<describe behavior>

#### Scenario: <scenario-name>
- **GIVEN** <context>
- **WHEN** <action>
- **THEN** <outcome>
"@

  Set-Content -Path $specPath -Value $delta -Encoding UTF8
}

Write-Host "[OK] Created change: $ChangeId"
Write-Host "  - $($changeRoot)\\proposal.md"
Write-Host "  - $($changeRoot)\\tasks.md"
Write-Host "  - $($changeRoot)\\design.md"
Write-Host "  - specs: $($Capabilities -join ', ')"
