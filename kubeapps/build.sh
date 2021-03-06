#!/usr/bin/env bash

# 离线文件存放目录
# save_dirname=/artifacts/ko-3.0/data/charts-kubeapps/images
source ./image_list

app_list=(
argo
harbor
gitlab
jenkins
sonarqube
weave_scope
redmine
kuboard
tensorflow_notebook
tensorflow_serving
)


function download_image() {
    file_name=`echo ${image}|sed -r 's/.*\///'`
    echo "下载 $image"
    docker pull $image
    echo  "保存至  $save_dirname/$app/images/${file_name}.tar"
    docker save -o $save_dirname/$app/images/${file_name}.tar ${image}
}

function pre_download_image() {
    mkdir -p $save_dirname/$app/images
}

function post_download_image() {
    cd $save_dirname/
    echo "$app 拷贝 install.sh 文件"
    cp -rp ../kubeapps/install.sh ./$app
    echo "压缩文件 $app.tar.gz"
    tar zcvf ${app}.tar.gz $app
}

for app in ${app_list[@]}
do
case ${app} in
argo)
    pre_download_image

    for image in ${argo[@]}
    do
        download_image
    done

    post_download_image

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
harbor)
    pre_download_image

    for image in ${harbor[@]}
    do
        download_image
    done

    post_download_image

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
gitlab)
    pre_download_image

    for image in ${gitlab[@]}
    do
        download_image
    done

    post_download_image

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
jenkins)
    pre_download_image

    for image in ${jenkins[@]}
    do
        download_image
    done

    post_download_image

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
sonarqube)
    pre_download_image

    for image in ${sonarqube[@]}
    do
        download_image
    done

    post_download_image

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
weave_scope)
    pre_download_image

    for image in ${weave_scope[@]}
    do
        download_image
    done

    post_download_image

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
redmine)
    pre_download_image

    for image in ${redmine[@]}
    do
        download_image
    done

    post_download_image

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
kuboard)
    pre_download_image

    for image in ${kuboard[@]}
    do
        download_image
    done

    post_download_image

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
tensorflow_notebook)
    pre_download_image

    for image in ${tensorflow_notebook[@]}
    do
        download_image
    done

    post_download_image

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
tensorflow_serving)
    pre_download_image

    for image in ${tensorflow_serving[@]}
    do
        download_image
    done

    post_download_image

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
esac
done