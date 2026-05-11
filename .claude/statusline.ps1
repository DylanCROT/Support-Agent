# Claude Code statusline for the Support Agent repo.
#
# Reads the JSON event from stdin (Claude Code passes session info on stdin)
# and emits a single line: <project> | <branch> [+N] | <model> [<dir>]

$ErrorActionPreference = "Stop"

try {
    $raw = [Console]::In.ReadToEnd()
    $event = $raw | ConvertFrom-Json
} catch {
    $event = $null
}

$repoRoot = $null
try {
    $repoRoot = (& git rev-parse --show-toplevel 2>$null).Trim()
} catch {}
if (-not $repoRoot) { $repoRoot = (Get-Location).Path }
$project = Split-Path -Leaf $repoRoot

$branch = ""
$dirty = 0
try {
    $branch = (& git -C $repoRoot symbolic-ref --short HEAD 2>$null).Trim()
    if (-not $branch) {
        $branch = (& git -C $repoRoot rev-parse --short HEAD 2>$null).Trim()
        if ($branch) { $branch = "($branch)" }
    }
    $statusLines = @(& git -C $repoRoot status --porcelain 2>$null)
    if ($statusLines) { $dirty = $statusLines.Count }
} catch {}

$model = ""
$cwd = ""
if ($event) {
    if ($event.model -and $event.model.display_name) {
        $model = $event.model.display_name
    } elseif ($event.model -and $event.model.id) {
        $model = $event.model.id
    }
    if ($event.workspace -and $event.workspace.current_dir) {
        $cwd = Split-Path -Leaf $event.workspace.current_dir
    }
}

$parts = @()
if ($project) { $parts += $project }
if ($branch) {
    if ($dirty -gt 0) { $parts += ("{0} +{1}" -f $branch, $dirty) }
    else { $parts += $branch }
}
if ($model) { $parts += $model }
if ($cwd -and $cwd -ne $project) { $parts += "[$cwd]" }

[Console]::Out.Write(($parts -join " | "))
