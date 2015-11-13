DEX2JAR_DIR=./tmp

install_dex2jar()
{
    cd $DEX2JAR_DIR

    # Download the latest version of dex2jar
    wget http://sourceforge.net/projects/dex2jar/files/dex2jar-2.0.zip
    
    unzip dex2jar-*
    chmod +x dex2jar-*/*
}

install_apktools()
{
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
    wget http://qc2.androidfilehost.com/dl/iA7HYVmHYlaeIBJzKk9yTw/1447564320/23212708291677144/framework-res.apk;

    # If download is not successful from above link, get it from below
    if [ $? != 0 ]:
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
    mkdir ./app
    
    # step1 : extract the apk into app_src directory
    app=$1
    cp $app ./app/

    $DEX2JAR_PROG ./app/$app -o ./app_src/
}




