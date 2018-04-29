#_*_ coding:utf-8 _*_
require 'mail'
require './config/mail_config.rb'

emails = Mail.find(what: :first, count: 10, order: :dec)
emails.each do |email|
  puts email.subject
end
