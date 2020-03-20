# Ansible System Setup Roles

*  這個項目用來放系統部屬用的Ansible角色
*  提供兩個分別為依照inventory循環部屬及單點部屬

# 部屬範例
*  更新須部屬的inventory(格式參考inventory.sample)
*  playbook.yml 依inventory群組循環執行所有相關的角色  
```ansible-playbook playbook.yml -i inventory.sample```
*  playone.yml 依變數選擇主機(群組)及腳本  
```ansible-playbook playone.yml -i inventory.sample -e "HOST=192.168.1.184" -e ONE=setup/ansible/yum```

# 注意事項
*  目標限制為CentOS 7系統
*  驗證的部屬主機Ansible版本為ansible 2.8.6 (python version = 2.7.15+)
*  勿更動目錄結構
*  所有提交安裝包皆為獨立目錄(如setup/nginx/1.16.1完整一包)

# 完成框架項目
*  Config: ansible.cfg
*  Config: inventory.sample
*  Playbook: playbook.yml
*  Playbook: playone.yml
*  Role: ping
*  Role: setup_all
*  Role: setup_one
*  Setup Package: setup/template/1.0/setup.sh (安裝包入口腳本)
*  Setup Package: setup/template/1.0/setup.tar.gz (安裝包額外資源)

# 已整合安裝包
*  setup/ansible/yum
*  setup/chkrootkit/1.0
*  setup/docker/yum
*  setup/fastdfs/5.05
*  setup/java/1.8.0
*  setup/nginx/1.16.1
*  setup/openssl/1.1.1d
*  setup/php/7.1.32
*  setup/python/3.7.4
*  setup/redis/5.0.5
*  setup/template/1.0

# 待整合安裝包
*  持續整合

# 標準inventory結構及標準群組命名
```
(pyenv) cllee@DESKTOP-GO0EA4R:~/ansible-system-setup-roles$ cat inventory.sample 
192.168.1.111
192.168.1.112
192.168.1.113

[setup/ansible/yum]
192.168.1.111
192.168.1.113

[setup/docker/yum]
192.168.1.111

[setup/fastdfs/5.05]
192.168.1.112
```

# 標準目錄結構
{playbook_dir}/setup/<apk name>/<apk version>/{README.md,setup.sh,setup.tar.gz}
```
(pyenv) cllee@DESKTOP-GO0EA4R:~/ansible-system-setup-roles$ tree 
.
├── README.md
├── ansible.cfg
├── inventory.sample
├── ping
│   └── tasks
│       └── main.yml
├── playbook.yml
├── playone.yml
├── setup
│   ├── ansible
│   │   └── yum
│   │       ├── setup.sh
│   │       └── setup.tar.gz
...(略)
│   └── template
│       └── 1.0
│           ├── setup.sh
│           └── setup.tar.gz
...(略)

```
