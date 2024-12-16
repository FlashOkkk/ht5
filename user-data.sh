#!/bin/bash

# Оновлення системи
sudo apt update -y && sudo apt upgrade -y

# Створення каталогів
sudo mkdir -p /home/ubuntu/folder1
sudo mkdir -p /home/ubuntu/folder2
sudo chmod 777 /home/ubuntu/folder1
sudo chmod 777 /home/ubuntu/folder2

# Створення скрипта переміщення файлів
cat << 'EOF' > /home/ubuntu/move_script.sh
#!/bin/bash
while true; do
    # Переміщуємо всі файли з folder1 до folder2
    mv /home/ubuntu/folder1/* /home/ubuntu/folder2/ 2>/dev/null
    # Чекаємо 10 секунд перед наступною спробою
    sleep 10
done
EOF

# Робимо скрипт виконуваним
sudo chmod +x /home/ubuntu/move_script.sh

# Створення системного демона
cat << 'EOF' > /etc/systemd/system/move_files.service
[Unit]
Description=Move Files from folder1 to folder2
After=network.target

[Service]
ExecStart=/home/ubuntu/move_script.sh
Restart=always
User=ubuntu

[Install]
WantedBy=multi-user.target
EOF

# Налаштування та запуск системного демона
sudo systemctl daemon-reload
sudo systemctl start move_files.service
sudo systemctl enable move_files.service
