#!/bin/bash
#kill -9 $(pgrep -f "sh /home/git/sync_2023hk\.sh")
x=1
cd /home/git/{filename}/
rm -f .git/index.lock
rm -f .git/ORIG_HEAD.lock
while [ $x -le 6 ]
do
echo "$x times"
x=$(( $x + 1 ))
echo "Running Git"
 git fetch --all --prune
 git checkout master
 git reset --hard origin/master
 git push origin master
 git checkout master
echo "=====Copying file to Pro Server====="
rsync -avz --chown=root:root /home/git/{filename}/* /home/web/ --timeout=30
echo "=====Done====="
sleep 5
done
exit