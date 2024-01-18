#!/bin/bash

cd /var/packages/EmbyServer/target/system/dashboard-ui

# 创建emby-crx目录并下载所需文件
rm -rf emby-crx
mkdir -p emby-crx
wget https://raw.githubusercontent.com/xingfanxia/emby-crx/master/static/css/style.css -P emby-crx/
wget https://raw.githubusercontent.com/xingfanxia/emby-crx/master/static/js/common-utils.js -P emby-crx/
wget https://raw.githubusercontent.com/xingfanxia/emby-crx/master/static/js/jquery-3.6.0.min.js -P emby-crx/
wget https://raw.githubusercontent.com/xingfanxia/emby-crx/master/static/js/md5.min.js -P emby-crx/
wget https://raw.githubusercontent.com/xingfanxia/emby-crx/master/content/main.js -P emby-crx/

# chown -R emby:emby emby-crx/*
# chmod 644 emby-crx/*

cp -r emby-crx/* . && chown -R emby:emby common-utils.js jquery-3.6.0.min.js main.js md5.min.js style.css config.js && chmod 644 common-utils.js jquery-3.6.0.min.js main.js md5.min.js style.css config.js

# 读取index.html文件内容
content=$(cat index.html)

# 检查index.html是否包含emby-crx
if grep -q "main.js" index.html; then
    echo "Index.html already contains emby-crx, skipping insertion."
else
    # 定义要插入的代码
    code='<link rel="stylesheet" id="theme-css" href="style.css" type="text/css" media="all" />\n<script src="common-utils.js"></script>\n<script src="jquery-3.6.0.min.js"></script>\n<script src="md5.min.js"></script>\n<script src="main.js"></script>'

    # 在</head>之前插入代码
    new_content=$(echo -e "${content/<\/head>/$code<\/head>}")

    # 将新内容写入index.html文件
    echo -e "$new_content" > index.html
fi

# cd /var/packages/EmbyServer/target/system/dashboard-ui && wget -O - https://raw.githubusercontent.com/xingfanxia/emby-crx/master/emby_script.sh | sh