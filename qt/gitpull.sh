if [ $# -gt 0 ]; then
    echo "Your command line contains $# arguments."
else
    echo "Your command line contains no arguments."
fi

if [ "$1" != "" ]; then
    echo "Positional parameter 1 contains something."
else
    echo "Positional parameter 1 is empty."
fi

processDirectory="${1:-$PWD}"
echo "The ${processDirectory} directory will be processed."
cd ${processDirectory}
echo "\$PWD is" $PWD "directory."

echo "Git pull started on [$(date --rfc-2822)]." | tee date.log
echo "Git pull started on [$(date +"%a, %d %h %Y %H:%M:%S.%N %z")]." | tee --append date.log
echo "Git pull started on [$(date --rfc-3339=ns)]." | tee --append date.log

for i in $(find . -maxdepth 1 -type d)
do
    echo Found "$i" child directory.
    cd $i
    echo \$PWD is $PWD

    if [ -d .git ]; then
        echo "Git repository found."
        git pull --verbose 2>&1 | tee update.log
    else
        echo "Sorry. This is not a Git repository."
    fi

    cd - > /dev/null
done

echo "Git pull completed on [$(date --rfc-2822)]." | tee --append date.log
echo "Git pull completed on [$(date +"%a, %d %h %Y %H:%M:%S.%N %z")]." | tee --append date.log
echo "Git pull completed on [$(date --rfc-3339=ns)]." | tee --append date.log

