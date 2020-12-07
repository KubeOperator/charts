#!/usr/bin/env bash

# 离线文件存放目录
# save_dirname=/artifacts/ko-3.0/data/charts-kubeapps/images
source ./image_list

app_list=(argo
harbor
gitlab
jenkins
sonarqube
weave_scope
redmine
kuboard
tensorflow-notebook
tensorflow-serving)


function download_image() {
  file_name=`echo ${image}|sed -r 's/.*\///'`
  echo "下载 $image"
  docker pull $image
  echo  "保存至  $save_dirname/$app/images/${file_name}.tar"
  cp -rp install.sh $save_dirname/$app
  docker save -o $save_dirname/$app/images/${file_name}.tar ${image}
}

function pre_image_download() {
  mkdir -p $save_dirname/$app/images
}

function post_image_download() {
  cd $save_dirname/
  tar zcvf ${app}.tar.gz $app
}

for app in ${app_list[@]}
do
case ${app} in
argo)
    pre_image_download

    for image in ${argo[@]}
    do
      download_image
    done

    post_image_download

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
harbor)
    pre_image_download

    for image in ${harbor[@]}
    do
      download_image
    done

    post_image_download

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
gitlab)
    pre_image_download

    for image in ${gitlab[@]}
    do
      download_image
    done

    post_image_download

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
jenkins)
    pre_image_download

    for image in ${jenkins[@]}
    do
      download_image
    done

    post_image_download

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
sonarqube)
    pre_image_download

    for image in ${sonarqube[@]}
    do
      download_image
    done

    post_image_download

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
weave_scope)
    pre_image_download

    for image in ${weave_scope[@]}
    do
      download_image
    done

    post_image_download

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
redmine)
    pre_image_download

    for image in ${redmine[@]}
    do
      download_image
    done

    post_image_download

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
kuboard)
    pre_image_download

    for image in ${kuboard[@]}
    do
      download_image
    done

    post_image_download

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
tensorflow-notebook)
    pre_image_download

    for image in ${tensorflow-notebook[@]}
    do
      download_image
    done

    post_image_download

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
tensorflow-serving)
    pre_image_download

    for image in ${tensorflow-serving[@]}
    do
      download_image
    done

    post_image_download

    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
esac
done