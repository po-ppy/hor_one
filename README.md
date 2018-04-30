# hor_one
通过邮件，让运行该该服务程序的机器可以执行某些操作
## 初步
实现执行命令，易班签到，结果反馈。
## 使用前的配置
- 将lib/config/mail_config_template.rb中的用户名和密码改为自己的，并将文件重命名为mail_config.rb
## 使用说明
### 支持两种操作
1. 命令 -> command
2. 常用 -> common
- 在命令中，可以执行一些非管理员权限的命令
- 在常用中，可以进行易班签到，清空邮箱
### 使用方法
- 邮件的标题为 'command' 或 'common'
- 若标题为 'common',邮件正文为要执行的命令，如：'ls -al'
- 若标题为 'command',邮件正文为 'sign' 或 'delete_all'
- 邮件内容（正文）必须为纯文本，暂时还不支持Multipart Email！！
