mkdir assets && touch assets/.gitkeep
mkdir data && touch data/.gitkeep
mkdir key && touch key/.gitkeep
mkdir module && touch module/.gitkeep

while [ "$1" != "" ]; 
do
    case $1 in
    -k | --key )
        public_key=1
        ;;
    -n | --name )
        shift
        project_name=$1
        ;;
    * )
        echo "Invalid option: $1"
        echo "Usage: bash $0 [-k|--key] [-n|--name project_name]"
        exit
        ;;
    esac
    shift
done

if [ "$public_key" = 1 ]
then
    cp ~/.aws/key/public-key.csv ./key/
fi

echo \
"import os

os.system('git submodule init')
os.system('git submodule update')
" > ./module/init.py

echo \
"from module import init
" > ./init.py

touch main.py

echo $project_name