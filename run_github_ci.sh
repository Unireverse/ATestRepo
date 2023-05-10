# /bin/bash

PR_string=$(echo $GITHUB_REF | grep -Eo "/[0-9]*/")
echo $PR_string
pr_id=(${PR_string//// })
echo "pr_id is $pr_id"

current=`date "+%Y-%m-%d %H:%M:%S"`
timeStamp=`date -d "$current" +%s` 
# currentTimeStamp=$((timeStamp*1000+10#`date "+%N"`/1000000))
currentTimeStamp="0000000000001"
echo $currentTimeStamp

repo_name="mluops"
repo_root="/github_ci/${repo_name}_ci/"
if [ ! -d $repo_root ];then
    mkdir $repo_root
fi

requests_path="$repo_root/requests"
if [ ! -d $requests_path ];then
    mkdir $requests_path
fi

request_name="${repo_name}_${pr_id}_${currentTimeStamp}"

echo "${repo_name},${pr_id},${currentTimeStamp}" > "$requests_path/${request_name}"

request_root="$repo_root/$request_name/"
sub_logs_path="$request_root/sub_logs"

if [ ! -d $request_root ];then
    mkdir $request_root
fi

if [ -f "$request_root/code.tar.gz" ];then
	echo "file existed, deleted."
	rm "$request_root/code.tar.gz"
fi
tar -czvf "$request_root/code.tar.gz" *

if [ ! -d $sub_logs_path ];then
    mkdir $sub_logs_path
fi

echo "working" > "$request_root/status"

if [ ! -f  "$request_root/log" ];then
	touch "$request_root/log"
fi

if [ ! -f "$request_root/log_list" ];then
    touch "$request_root/log_list"
fi

python3 file_guard.py "$request_root/status" "$request_root/log" &
python3 combine_log.py "$request_root/log" "$request_root/log_list" "$request_root/sub_logs" "$request_root/status" &
wait

