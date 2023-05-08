# /bin/bash

#if [ -f '/github_ci/file.tar.gz' ];then
#	echo "file existed, deleted."
#	rm /github_ci/file.tar.gz
#fi
#tar -czvf /github_ci/file.tar.gz *
echo "REPO_TIME_ID" > /github_ci/REPO_TIME_ID
echo "working" > /github_ci/REPO_TIME_ID_RESULT
touch /github_ci/REPO_TIME_ID_LOG
if [ ! -f "/github_ci/REPO_TIME_ID_LOG_LIST" ];then
	echo > /github_ci/REPO_TIME_ID_LOG_LIST
fi
if [ ! -d  "/github_ci/REPO_TIME_ID_SUB_LOGS" ];then
	mkdir /github_ci/REPO_TIME_ID_SUB_LOGS
fi
python3 file_guard.py /github_ci/REPO_TIME_ID_RESULT /github_ci/REPO_TIME_ID_LOG &
python3 combine_log.py /github_ci/REPO_TIME_ID_LOG /github_ci/REPO_TIME_ID_LOG_LIST /github_ci/REPO_TIME_ID_SUB_LOGS/ /github_ci/REPO_TIME_ID_RESULT &
wait

