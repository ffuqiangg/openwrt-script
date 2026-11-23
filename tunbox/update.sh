#!/bin/sh

# --- 基础变量 ---
dir="/etc/tunbox"
tmp="/tmp/tunbox"
a="1"

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
            curl -fsL -A clash.meta -m 120 --connect-timeout 15 --retry 3 -X GET -o $tmp/config.tmp ${i##*|}
            ${dir}/sub $tmp/config.tmp --prefix "${i%%|*}" --only-nodes --out ${tmp}/$a.json
            rm $tmp/config.tmp
            ;;
        *)
            curl -fsL -A clash.meta -m 120 --connect-timeout 15 --retry 3 -X GET -o $tmp/config.tmp $i
            ${dir}/sub $tmp/config.tmp --only-nodes --out ${tmp}/$a.json
            rm $tmp/config.tmp
            ;;
    esac
    a=$((a + 1))
done
jq -s '{outbounds: add}' ${tmp}/*.json > ${tmp}/outbounds.json
${dir}/sub ${tmp}/outbounds.json --template ${dir}/template.json --out ${dir}/config.json
rm -rf "$tmp"

exit 0
