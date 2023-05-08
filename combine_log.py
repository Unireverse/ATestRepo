import time
import sys
import os
output_path = sys.argv[1]
list_path = sys.argv[2]
list_dir_path = sys.argv[3]
status_path = sys.argv[4]

if __name__ == '__main__':
    list_pos = 0
    log_pos = 0
    while True:
        list_file = open(list_path, 'r')
        list_file.seek(list_pos)
        items = list_file.readlines()
        list_pos = list_file.tell()
        if items is not None:
            items.sort()
            log_file = open(output_path, 'a+')
            log_file.seek(log_pos)
            for item in items:
                sub_path = item.strip()
                if sub_path is not "":
                    sub_file = open(list_dir_path + '/' + sub_path)
                    lines = sub_file.readlines()
                    for line in lines:
                        log_file.write(line)
                    sub_file.close()
            log_pos = log_file.tell()
            log_file.close()
        status_file = open(status_path)
        status = status_file.readline().strip()
        status_file.close()
        if status == "success" or status == "fail":
            break
        else:
            time.sleep(2)
    os.system("echo 'End log file query.'")

