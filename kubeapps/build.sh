#!/usr/bin/env bash

save_dirname=/artifacts/ko-3.0/data/charts-kubeapps/images
source ./image_list

app_list=(argo
harbor
gitlab
jenkins
sonarqube)


function download_image() {
  mkdir -p $save_dirname/$app/images
  file_name=`echo ${image}|sed -r 's/.*\///'`
  echo "下载 $image"
  docker pull $image
  echo  "保存至  $save_dirname/$app/${file_name}.tar"
  docker save -o $save_dirname/$app/images/${file_name}.tar ${image}
}


for app in ${app_list[@]}
do
case ${app} in
argo)
    for image in ${argo[@]}
    do
      download_image
    done
    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
harbor)
    for image in ${harbor[@]}
    do
      download_image
    done
    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
gitlab)
    for image in ${gitlab[@]}
    do
      download_image
    done
    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
jenkins)
    for image in ${jenkins[@]}
    do
      download_image
    done
    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
sonarqube)
    for image in ${sonarqube[@]}
    do
      download_image
    done
    echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    ;;
esac
done