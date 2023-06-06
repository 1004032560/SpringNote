#!/bin/bash

echo -e "开始执行 looper.sh 脚本"

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding update note"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push

echo -e "执行结束"
