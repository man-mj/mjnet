#!/bin/bash
set -e

# 0) ติดตั้ง netcat + iproute2 (ให้มี ss, nc)
apt update -y
apt install -y netcat-openbsd iproute2

# 1) ดาวน์โหลด online.sh จาก GitHub มาไว้ที่ /root/online.sh
curl -fsSL "https://raw.githubusercontent.com/man-mj/mjnet/main/online.sh" -o /root/online.sh
chmod +x /root/online.sh

# 2) สร้าง systemd service เปิดพอร์ต 8080
cat > /etc/systemd/system/online-api.service <<'EOF'
[Unit]
Description=Online API Service
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash -c 'while true; do /root/online.sh | nc -l -p 8080 -q 1; done'
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable online-api
systemctl restart online-api

echo "OK: online-api started"
echo "Test local: curl http://127.0.0.1:8080"
