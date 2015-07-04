#Git pull for each first level child directory which is a Git repository.
#cd $PWD

date --rfc-822 | tee date.log

for i in $(find . -maxdepth 1 -type d)
do
   echo Found "$i" child directory.
   cd $i
   echo \$PWD is $PWD
   
   if [ -d .git ]; then
      echo "Git repository found."
      git pull --verbose
   else
      echo "Sorry. This is not a Git repository."
   fi

   cd - > /dev/null
done

date --rfc-822 | tee --append date.log

