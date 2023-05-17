import time
import sys
import os
# Get info.
# output_path: the target file that you want to combine sub log with.
# list_path: the list of sub log name. When it is updated, the correspondding file will be add to output tail.
# list_dir_path: the dir path where sub logs stored.
# status_path: the path of status file. When status file is written to "success" or "fail", exit script.

output_path = sys.argv[1]
list_path = sys.argv[2]
list_dir_path = sys.argv[3]
status_path = sys.argv[4]

if __name__ == '__main__':
    # list_pos stores the last position that pointer of list file pointed to.
    list_pos = 0
    # log_pos stores the last position that pointer of log file pointed to.
    log_pos = 0
    while True:
        list_file = open(list_path, 'r')
        list_file.seek(list_pos)
        # read all lines starting from list_pos.
        items = list_file.readlines()
        # update list_pos
        list_pos = list_file.tell()
        # if read any line
        if items is not None:
            items.sort()
            # open correspondding file and read, then write to log file.
            log_file = open(output_path, 'a+')
            log_file.seek(log_pos)
            print(items)
            os.system("ls " + list_dir_path)
            for item in items:
                sub_path = item.strip()
                print(sub_path)
                if sub_path is not "":
                    sub_file = open(list_dir_path + '/' + sub_path)
                    lines = sub_file.readlines()
                    for line in lines:
                        log_file.write(line)
                    sub_file.close()
            log_pos = log_file.tell()
            log_file.close()
        # check status_file, when read "success" or "fail" exit cycle, or else, sleep some seconds and start from beginning.
        status_file = open(status_path)
        status = status_file.readline().strip()
        status_file.close()
        if status == "success" or status == "fail":
            break
        else:
            time.sleep(2)
    # Just a mark for process endding.
    os.system("echo 'End log file query.'")

