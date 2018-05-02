# hor_one
通过邮件，让运行该该服务程序的机器可以执行某些操作
## 最新说明
增加通过易班id和url签到,终于支持Multipart Email了，哈哈哈哈哈
## 使用前的配置
- gem依赖:nokogiri,mechanize,mail
- 将lib/config/mail_config_template.rb中的用户名和密码改为自己的，并将文件重命名为mail_config.rb
## 使用说明
- 在自己的机器上运行runme.rb,即可启动服务
### 支持两种操作
1. 命令 -> command
2. 常用 -> common
- 在命令中，可以执行一些非管理员权限的命令
- 在常用中，可以进行易班签到，清空邮箱
### 使用方法
- 邮件的标题为 'command' 或 'common'
- 若标题为 'common',邮件正文为要执行的命令，如：'ls -al'
- 若标题为 'command',邮件正文为 'sign_all' 或 'delete_all'
- 邮件内容（正文）必须为纯文本，暂时还不支持Multipart Email！！
- 通过易班id签到，标题为'common',正文为'sign_id::YB???','YB???'为自己的易班id
- 通过易班签到url签到，标题为'common',正文为’sign_url::url?','url?'为签到页面的url，如'http://kqapp.nwsuaf.edu.cn/Index.aspx?xsid=YB6666666&sch=10712&ts=1525261092978'
## 个人修改
可以将common方法重写，进而执行自己的常用操作
- 示例
```ruby
include Hor_one
module Hor_one
  def do_common_job(common)
    case common
    when  name_you_want_1
      #do what you want to do,but make sure return some string,it will feedback to you
      #在这里执行你要执行的操作，但是要有字符串返回值，这将作为反馈邮件的正文发送给您
      return "the result of 1"
    when name_you_want_2
      #do what you want to do
      return "the result of 2"
      ...
    else
      #return "不支持的操作"
      return "can find your command"
    end
  end
end
  ```
