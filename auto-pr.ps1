### Co-Author

$BASE_BRANCH = "main"
$COUNT = 64

# Co-author (edit these)
$CO_NAME  = "andrewwilson944"
$CO_EMAIL = "andrew.wilson944@outlook.com"

for ($i = 1; $i -le $COUNT; $i++) {
  $branch = "pullshark-$i"

  git checkout $BASE_BRANCH | Out-Null
  git pull | Out-Null
  git checkout -B $branch | Out-Null

  $file = "pullshark-log.md"
  Add-Content $file "PR $i merged at $(Get-Date -Format u)"

  git add $file

  # Multi-line commit message with Co-authored-by trailer
  $msg = @"
chore: pull shark progress ($i)

Co-authored-by: $CO_NAME <$CO_EMAIL>
"@

  git commit -m $msg | Out-Null
  git push -u origin $branch | Out-Null

  gh pr create --base $BASE_BRANCH --head $branch --title "Pull Shark PR #$i" --body "Automated PR ($i)" | Out-Null

  # Merge PR for current branch (auto-confirm)
  "y" | gh pr merge -s -d

  Start-Sleep -Seconds 1
}

git checkout $BASE_BRANCH