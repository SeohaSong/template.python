(
    public_key=0

    if [ "$home_path" = "" ]
    then
        echo "[$0] Need SEOHASONG OS."
        exit
    fi

    while [[ "$1" =~ "-" ]]; 
    do
        case $1 in
        -k | --key )
            public_key=1
            ;;
        * )
            echo "[$0] . init.sh [-k|--key] <project_name>"
            exit
            ;;
        esac
        shift
    done

    if [ "$1" = "" ]
    then
        echo "[$0] . init.sh [-k|--key] <project_name>"
        exit
    fi

    mkdir assets && touch assets/.gitkeep
    mkdir data && touch data/.gitkeep
    mkdir key && touch key/.gitkeep
    cp $home_path/SEOHASONG/.gitignore .
    touch main.py
    echo "from module_ import init" > init.py
    echo "# $1" > README.md
    mkdir module_
    echo \
"import os

os.system('git submodule init')
os.system('git submodule update')"\
    > module_/init.py
    
    if [ "$public_key" = 1 ]
    then
        cp $home_path/.aws/key/public-key.csv key/
    fi

    rm -rf init.sh .git
    mv ../template.project ../$1
)

if [ -f "init.py" ]
then
    cd .
fi
