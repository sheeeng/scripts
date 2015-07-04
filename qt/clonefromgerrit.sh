# then get a current list of projects
rawproj=`ssh -p 29418 codereview.qt-project.org gerrit ls-projects`
allproj=`echo "$rawproj" | grep -v '^\{graveyard\}/'`
# this test ensures that the list is complete, identified by the trailing graveyard projects
if test x"$allproj" = x"$rawproj"; then
    echo "List of projects from gerrit is incomplete." >&2
    exit 1
fi

for project in `ssh -p 29418 codereview.qt-project.org gerrit ls-projects`
do
  mkdir -p `dirname "$project"`
  git clone "ssh://codereview.qt-project.org/$project.git"
done
