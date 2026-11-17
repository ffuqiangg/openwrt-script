#!/bin/sh

dir="/etc/tunbox"
tmp="/tmp/tunbox"

# --- 订阅配置 ---
# set 设置节点前缀及订阅地址，前缀用于区分不同订阅的节点
# 每组节点前缀与订阅地址间用竖线 | 分割
# 除最后一行外每行末尾添加反斜杠 \
set -- \
    "[provider1] |https://xxx.com/token?=xxx" \
    "[provider2] |https://yyy.com/token?=yyy"
# --- 订阅配置END ---


mkdir -p "$tmp"

a=1
for i in "$@"; do
    case "$i" in
        *\|*)
            ${dir}/sub --url "${i##*|}" --prefix "${i%%|*}" --timeout 120s --only-nodes --out ${tmp}/$a.json
            ;;
        *)
            ${dir}/sub --url "$i" --timeout 120s --only-nodes --out ${tmp}/$a.json
            ;;
    esac
    a=$((a + 1))
done

jq -s '{outbounds: add}' ${tmp}/*.json > ${tmp}/outbounds.json
${dir}/sub ${tmp}/outbounds.json --template ${dir}/template.json --out ${dir}/config.json

rm -rf "$tmp"

exit 0
