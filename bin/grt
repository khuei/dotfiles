#!/bin/sh
#
# [g]it [r]emote [t]oggle

repo_remote="$(git remote get-url origin)"

case $repo_remote in
git@github*)
	repo=${repo_remote##git@github.com:}
	repo=${repo%%.git}
	repo=https://github.com/$repo.git
	;;
git@gitlab*)
	repo=${repo_remote##git@gitlab.com:}
	repo=${repo%%.git}
	repo=https://gitlab.com/$repo.git
	;;
*https*github*)
	repo=${repo_remote##https://github.com/}
	repo=${repo%%.git}
	repo=git@github.com:$repo.git
	;;
*https*gitlab*)
	repo=${repo_remote##https://gitlab.com/}
	repo=${repo%%.git}
	repo=git@gitlab.com:$repo.git
	;;
*)
	exit 1
	;;
esac

printf 'Changing repo to %s\n' "$repo"
git remote set-url origin "$repo"
