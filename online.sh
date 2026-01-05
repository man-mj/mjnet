#!/bin/bash
LIMIT=250
ONLINE=$(ss -H state established | wc -l)

# ตอบแบบ HTTP + JSON (เพื่อให้เรียกผ่าน curl/แอพได้)
echo -e "HTTP/1.1 200 OK\r"
echo -e "Content-Type: application/json\r"
echo -e "\r"
echo "[{\"onlines\":\"$ONLINE\",\"limite\":\"$LIMIT\"}]"
