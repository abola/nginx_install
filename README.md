# nginx_install
具Health check的nginx安裝

# 安裝方式
```bash
sudo git clone https://github.com/abola/nginx_install.git
sudo cd nginx_install
sudo sh nginx-1.8.1-for-centos-6.8.sh
```

# 相關路徑
- Nginx設定檔 /etc/nginx/nginx.conf
- Log目錄 /var/log/nginx

# 基本服務操作
```bash
# 啟動Nginx
service nginx start

# 停止Nginx
service nginx stop

# 重新讀取設定 (推薦)
service nginx reload
```
