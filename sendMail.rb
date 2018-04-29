#_*_ coding:utf-8 _*_
require 'mail'
require './config/mail_config.rb'

mail = Mail.new do
  from '18821701674@163.com'
  to '18821701674@163.com'
  subject 'hello 3'
  body 'if you a boy?'
end

#10.times.each do |i|
#  mail.subject "this is 1"
  mail.deliver!
#end
