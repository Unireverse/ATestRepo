import time
import sys
import os
guard_status_file = sys.argv[1]
guard_log_file = sys.argv[2]

if __name__ == '__main__':
    where= 0
    while True:
        file = open(guard_log_file)
        file.seek(where)
        for line in file.readlines():
            os.system('echo ' + line)
        where = file.tell()
        file.close()
        status_file = open(guard_status_file)
        line = status_file.readline().strip()
        status_file.close()
        if line == "success":
            break
        time.sleep(2)

