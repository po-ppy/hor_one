#_*_ coding:utf-8 _*_
require 'mail'

Mail.defaults do
  delivery_method :smtp, address: 'smtp.qq.com', port: 587, user_name: 'num@qq.com', password: 'password'
end

mail = Mail.new do
  from 'from@qq.com'
  to 'to@163.com'
  subject 'This is a test'
  body 'hahahahhahahahahahaha'
end

mail.deliver!
