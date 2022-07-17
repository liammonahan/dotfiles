#!/bin/sh

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if output=$(git --git-dir "$BASEDIR/.git" --work-tree "$BASEDIR" status --porcelain) && [ -z "$output" ];
then
    GIT_SSH_COMMAND="ssh -o LogLevel=ERROR" git --git-dir "$BASEDIR/.git" --work-tree "$BASEDIR" pull > /dev/null
else
    /usr/sbin/sendmail liam@liammonahan.com <<EOF
Subject: $HOSTNAME dotfiles have uncommitted changes
To: Liam Monahan <liam@liammonahan.com>
From: Liam Monahan <liam@liammonahan.com>

This host has uncommitted changes in $BASEDIR
EOF
fi
