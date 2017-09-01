#!/usr/bin/env python
import os
import json
t=os.popen("""ps aux | grep redis | grep redis-server | grep -v sentinel | grep -v grep | awk -F'redis' '{print $2}' | awk -F':' '{print $2}' | grep -v '^$'""")
ports = []
for port in  t.readlines():
        r = os.path.basename(port.strip())
        ports += [{'{#REDISPORT}':r}]
print json.dumps({'data':ports},sort_keys=True,indent=4,separators=(',',':'))
