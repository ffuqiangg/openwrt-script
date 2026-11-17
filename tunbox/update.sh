#!/bin/sh

dir="/etc/tunbox"
tmp="/tmp/tunbox"

set -- \
    ""

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
