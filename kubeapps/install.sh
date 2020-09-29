#!/usr/bin/env bash
# 上传kubeapps内置应用 docker image

BASE_DIR=$(
    cd "$(dirname "$0")"
    pwd
)

set -e
action=$1
# 应用列表
app_list=(argo harbor gitlab jenkins sonarqube weave_scope redmine)
# 默认镜像仓库地址，也是KubeOperator部署机地址
registry_host=registry.kubeoperator.io:8083


function set_registry() {
    echo ">>> 配置registry"
    use_external_registry="n"
    read -p  "是否使用外部Docker Image Registry y/n: " use_external_registry
    if [[ "${use_external_registry}" == "y" ]] || [[ "${use_external_registry}" == "Y" ]] ; then
        read -p  " 请输入registry的域名: " registry_host
        read -p  " 请输入registry的用户名: " registry_user
        read -p  " 请输入registry的密码: " registry_pass
        docker login $registry_host -u$registry_user -p$registry_pass
    else
        echo "配置docker登录信息: $registry_host"
        read -p  " 请输入registry的用户名: " registry_user
        read -p  " 请输入registry的密码: " registry_pass
        docker login $registry_host -u$registry_user -p$registry_pass
    fi
}

function upload_image() {
    cd $BASE_DIR/images
    echo "正在上传 $image ... "
    orign_image_name=`docker load -i $image |awk '{print $3}'`
    if [[ ${orign_image_name} =~ "quay.io" ]]; then
      image_name=`echo $orign_image_name|sed -r 's/quay.io\///g'`
    else
      image_name=`echo $orign_image_name`
    fi
    docker tag $orign_image_name $registry_host/$image_name
    docker push $registry_host/$image_name
    docker rmi $orign_image_name
    docker rmi $registry_host/$image_name
}

function load_image() {
     echo "+++++++++++++++++++++++++++++++++++$app+++++++++++++++++++++++++++++++++++"
     for image in $BASE_DIR/images/*.tar
     do
      upload_image
     done
}
function upload_tools() {
  for app in ${app_list[@]}
  do
  if [[ `pwd` =~ $app ]];then
  case ${app} in
  argo)
      load_image
      ;;
  harbor)
      load_image
      ;;
  gitlab)
      load_image
      ;;
  jenkins)
      load_image
      ;;
  sonarqube)
      load_image
      ;;
  weave_scope)
      load_image
      ;;
  redmine)
      load_image
      ;;
  esac
  fi
  done
}


function usage() {
    echo "Kubeapps 推送Docker镜像"
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