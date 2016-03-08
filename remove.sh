echo "$1" >> .gitignore
git rm --cached $1
git add -u
git commit -m "removing files from host"
git pull
git push
