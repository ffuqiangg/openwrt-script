#!/bin/sh

# --- 基础变量 ---
dir="/etc/tunbox"
tmp="/tmp/tunbox"
d=3
a=1
b=1

# --- 订阅配置 ---
# 节点前缀与订阅地址间用竖线 | 分割，注意行末添加反斜杠(最后一行不需要)
set -- \
    "[provider1] |https://xxx.com/token?=xxx" \
    "[provider2] |https://yyy.com/token?=yyy"


# --- 生成配置 ---
mkdir -p "$tmp"
for i in "$@"; do
    case "$i" in
        *\|*)
            while [ "$b" -le "$d" ]; do
                ${dir}/sub --url "${i##*|}" --prefix "${i%%|*}" --timeout 120s --only-nodes --out ${tmp}/$a.json
                [ -f "${tmp}/$a.json" ] && break
                a=$((a + 1))
                b=$((b + 1))
                sleep 5
            done
            ;;
        *)
            while [ "$b" -le "$d" ]; do
                ${dir}/sub --url "$i" --timeout 120s --only-nodes --out ${tmp}/$a.json
                [ -f "${tmp}/$a.json" ] && break
                a=$((a + 1))
                b=$((b + 1))
                sleep 5
            done
            ;;
    esac
done
jq -s '{outbounds: add}' ${tmp}/*.json > ${tmp}/outbounds.json
${dir}/sub ${tmp}/outbounds.json --template ${dir}/template.json --out ${dir}/config.json
rm -rf "$tmp"

exit 0
