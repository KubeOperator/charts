#!/usr/bin/env bash
# 上传kubeapps内置应用 docker image

BASE_DIR=$(
    cd "$(dirname "$0")"
    pwd
)

action=$1
# 应用列表
app_list=(argo harbor gitlab jenkins sonarqube)
# 默认镜像仓库地址，也是KubeOperator部署机地址
registry_host=registry.kubeoperator.io:8082

function set_registry() {
    echo ">>> 配置registry"
    use_external_registry="n"
    read -p  "是否使用外部Docker Image Registry y/n: " use_external_registry
    if [[ "${use_external_registry}" == "y" ]]; then
        read -p  " 请输入registry的域名 " registry_host
        read -p  " 请输入registry的用户名 " registry_user
        read -p  " 请输入registry的密码 " registry_pass
        docker login $registry_host -u$registry_user -p$registry_pass
    else
        echo "配置docker登录信息: $registry_host"
        read -p  " 请输入registry的用户名 " registry_user
        read -p  " 请输入registry的密码 " registry_pass
        docker login $registry_host -u$registry_user -p$registry_pass
    fi
}

function upload_image() {
    cd $BASE_DIR/$app
    echo "正在上传 $image ... "
    image_name=`docker load -i $image |awk '{print $3}'`
    docker tag image_name registry_host/$image
    docker push registry_host/$image
    docker rmi registry_host/$image
}

function upload_tools() {
  for app in ${app_list[@]}
  do
  if [[ `pwd` =~ $app ]];then
  case ${app} in
  argo)
      for image in `ls $BASE_DIR/$app`
      do
        upload_image
      done
      echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
      ;;
  harbor)
      for image in `ls $BASE_DIR/$app`
      do
        upload_image
      done
      echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
      ;;
  gitlab)
      for image in `ls $BASE_DIR/$app`
      do
        upload_image
      done
      echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
      ;;
  jenkins)
      for image in `ls $BASE_DIR/$app`
      do
        upload_image
      done
      echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
      ;;
  sonarqube)
      for image in `ls $BASE_DIR/$app`
      do
        upload_image
      done
      echo "+++++++++++++++++++++++++++++++++++$app++++++++++++++++++++++++++++++++++++++++++++++++++++++"
      ;;
  esac
  fi
  done
}


function usage() {
    echo "Kubeapps 推送Docker"
    echo
    echo "Usage: "
    echo "  ./kubeappsctl.sh [COMMAND] [ARGS...]"
    echo "  ./kubeappsctl.sh --help"
    echo
    echo "Commands: "
    echo "  start 推送Docker镜像"
}



#主进程
function main() {
    case "${action}" in
    start)
        set_registry
        upload_tools
        ;;
    help)
        usage
        ;;
    --help)
        usage
        ;;
    *)
        usage
        ;;
    esac
}
main