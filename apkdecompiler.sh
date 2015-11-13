DEX2JAR_DIR="./dex2jar"
BASEDIR=""
LOGFILE="apkdecompiler.log"
INSTALL_DIR=""

install_dex2jar()
{
    cd $INSTALL_DIR;
    mkdir $DEX2JAR_DIR
    cd $DEX2JAR_DIR

    # Download the latest version of dex2jar
    wget http://sourceforge.net/projects/dex2jar/files/dex2jar-2.0.zip
    
    unzip dex2jar-*
    chmod +x dex2jar-2.0/*
    DEX2JAR_PROG=$INSTALL_DIR/$DEX2JAR_DIR/dex2jar-2.0/d2j-dex2jar.sh
}

install_apktools()
{
    cd $INSTALL_DIR;
    mkdir ./tmp
    cd ./tmp

    wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool
    wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.0.2.jar

    mv apktool_2.0.2.jar apktool.jar
    sudo mv apktool /usr/local/bin
    sudo mv apktool.jar /usr/local/bin
    chmod +x /usr/local/bin/apktool
    chmod +x /usr/local/bin/apktool.jar

    cd ..
    rm -rf ./tmp
}

install_framework_res()
{
    cd $INSTALL_DIR;
    wget http://qc2.androidfilehost.com/dl/iA7HYVmHYlaeIBJzKk9yTw/1447564320/23212708291677144/framework-res.apk;

    # If download is not successful from above link, get it from below
    if [ $? != 0 ]
    then
	wget http://en.osdn.jp/projects/sfnet_hdtechvideo/downloads/Other/4.1.2/framework-res.apk
    fi

    apktool ./framework-res.apk 
}


# Install all the necessary utils required to get the source code 
# from apk
install_utils()
{
    install_dex2jar;
    install_apktools;
    install_framework_res;
}


extract_source()
{
    cd $INSTALL_DIR;
    echo "Entered into $BASEDIR..."
    mkdir ./app
    mkdir ./app_src
    
    # step1 : extract the apk into app_src directory
    app=$1
    cp $app ./app/
    $DEX2JAR_PROG ./app/$app -o ./app_src/"$app".dex2jar.jar

    # step2 : Decode XML files
    apktool d ./app/$app
}



apkdecompiler()
{
    if [ $# -eq 0 ]
    then
	echo "Please supply <.apk> to decode"
	exit -1
    fi

    echo "Decompiling $1..."
    exec > $LOGFILE
    exec 3>&2
    
    install_utils;
    extract_source $1;

    echo "Decoded $1 into ./app_src/"
    exit 0;
}

BASEDIR=`pwd`
INSTALL_DIR=$BASEDIR/installs
mkdir $INSTALL_DIR

echo "current working directory : $BASEDIR"
apkdecompiler $1;
