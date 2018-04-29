#_*_ coding:utf-8 _*_
require 'mail'
require './config/mail_config.rb'

module Hor_one
  @last_one = nil  

  def get_one
    emails = Mail.all
    if emails.length < 0
      return 
    end
    emails = Mail.find(what: :last, count: 15, order: :dec)
    puts emails.length
    emails.each do |email|
      #if @last_one == email || email.subject != "command" || email.subject != "common"
      #  puts email.subject
      #  next
      #else
      #  @last_one = email
      #  puts "ok"
      #  puts @last_one.subject
      #  break
      #end
      if email.subject == 'common' || email.subject == 'command'
        if @last_one == nil
          puts "last_one is nil"
          @last_one = email
          puts @last_one.subject
          break
        elsif @last_one == email
          next
        end
      else
        next
      end
    end
  end

  def one_is_null?
    return @last_one == nil
  end

  def execute_one
    if @last_one.subject == 'common'
      #do some common job
      result = do_common_job @last_one.body
    else
      #do some commmand job
    end
    feedback result
  end

  def do_command_job(command)
    system command
  end
  
  def do_common_job(common)
    case common
    when '签到'
      #do yiban sign
      "应该是签到的"

    when '充值'
      #do nfc copy water_card
    else
      "不支持的命令"
    end
  end

  def feedback(info)
    if info == nil || info == ''
      info == "nothing"
    end
    if one_is_null? 
      puts "in feedback last_one is nil"
    end
    temp = @last_one.from
    puts temp
    mail = Mail.new do
      from "18821701674@163.com"
      to temp
      subject "结果反馈"
      body info
    end
    mail.deliver
  end

end
