param(
    [ValidateSet("junction", "copy")]
    [string]$Mode = "junction"
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptDir
$SkillsHome = if ($env:AGENT_SKILLS_HOME) {
    $env:AGENT_SKILLS_HOME
} else {
    Join-Path $HOME ".agents\skills"
}
$LearningHome = if ($env:AI_LEARNING_HOME) {
    $env:AI_LEARNING_HOME
} else {
    Join-Path $HOME ".ai-learning\backend-engineering"
}

New-Item -ItemType Directory -Force -Path $SkillsHome | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $LearningHome "learner\learning-records") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $LearningHome "learner\sessions") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $LearningHome "learner\reference") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $LearningHome "learner\lessons") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $LearningHome "repositories") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $LearningHome "active") | Out-Null

$SkillNames = @("engineering-mentor", "teach")

foreach ($SkillName in $SkillNames) {
    $SourcePath = Join-Path $RepoRoot "skills\$SkillName"
    $TargetPath = Join-Path $SkillsHome $SkillName

    if (-not (Test-Path -LiteralPath $SourcePath -PathType Container)) {
        throw "Missing skill source: $SourcePath"
    }

    if (Test-Path -LiteralPath $TargetPath) {
        $Existing = Get-Item -LiteralPath $TargetPath -Force
        $ExistingTargets = @($Existing.Target)
        if ($Existing.LinkType -and $ExistingTargets -contains $SourcePath) {
            Write-Host "Already linked: $TargetPath"
            continue
        }
        throw "Refusing to overwrite existing path: $TargetPath"
    }

    if ($Mode -eq "junction") {
        New-Item -ItemType Junction -Path $TargetPath -Target $SourcePath | Out-Null
        Write-Host "Junction: $TargetPath -> $SourcePath"
    } else {
        Copy-Item -LiteralPath $SourcePath -Destination $TargetPath -Recurse
        Write-Host "Copied: $TargetPath"
    }
}

Get-ChildItem -LiteralPath (Join-Path $RepoRoot "learning-profile-template\learner") -Filter "*.md" | ForEach-Object {
    $ProfilePath = Join-Path (Join-Path $LearningHome "learner") $_.Name
    if (Test-Path -LiteralPath $ProfilePath) {
        Write-Host "Preserved existing profile file: $ProfilePath"
    } elseif ($_.Name -eq "PREFERENCES.md" -and (Test-Path -LiteralPath (Join-Path $LearningHome "NOTES.md"))) {
        $LegacyPath = Join-Path $LearningHome "NOTES.md"
        Copy-Item -LiteralPath $LegacyPath -Destination $ProfilePath
        Write-Host "Migrated legacy profile file: $LegacyPath -> $ProfilePath"
    } elseif (Test-Path -LiteralPath (Join-Path $LearningHome $_.Name)) {
        $LegacyPath = Join-Path $LearningHome $_.Name
        Copy-Item -LiteralPath $LegacyPath -Destination $ProfilePath
        Write-Host "Migrated legacy profile file: $LegacyPath -> $ProfilePath"
    } else {
        Copy-Item -LiteralPath $_.FullName -Destination $ProfilePath
        Write-Host "Created profile file: $ProfilePath"
    }
}

@("ai-native-task-tutor", "diagnosing-bugs") | ForEach-Object {
    $LegacySkillPath = Join-Path $SkillsHome $_
    if (Test-Path -LiteralPath $LegacySkillPath) {
        Write-Host "Legacy skill remains installed and should be removed after review: $LegacySkillPath"
    }
}

Write-Host ""
Write-Host "Bootstrap complete."
Write-Host "Skills:   $SkillsHome"
Write-Host "Learning: $LearningHome"
Write-Host "Restart the AI application before using the skills."
