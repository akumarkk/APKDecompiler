DEX2JAR_DIR=./tmp

install_dex2jar()
{
    cd $DEX2JAR_DIR

    # Download the latest version of dex2jar
    wget http://sourceforge.net/projects/dex2jar/files/dex2jar-2.0.zip

    unzip dex2jar-*

    chmod +x dex2jar-*/*
}

extract_source()
{
    mkdir ./app_src
    
    # step1 : extract the apk into app_src directory
    app=$1
    cp $app ./app_src/$app.zip
    unzip ./app_src/$app.zip -d ./app_src/

    $DEX2JAR_PROG ./app_src/
}




