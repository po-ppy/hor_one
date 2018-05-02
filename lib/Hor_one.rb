#_*_ coding:utf-8 _*_
$LOAD_PATH.unshift __dir__
require 'mail'
#require File.dirname(__FILE__)+'/sign/new_sign.rb'
#require File.dirname(__FILE__)+'/config/mail_config.rb'
require 'sign/new_sign'
require 'config/mail_config'


module Hor_one
  @last_one = nil  
  @pre_one = nil
  @emails = nil

  def flash_emails
    @emails = Mail.all
  end

  def get_one
    #emails = Mail.all
    if @emails.length == nil
      return 
    end
    #emails = Mail.find(what: :last, count: 15, order: :dec)
    @emails.each do |email|
      #if @last_one == email || email.subject != "command" || email.subject != "common"
      #  puts email.subject
      #  next
      #else
      #  @last_one = email
      #  puts "ok"
      #  puts @last_one.subject
      #  break
      #end
      if email.subject.to_s.chomp == 'common' || email.subject.to_s.chomp == 'command'
        if @last_one == nil
          @last_one = email
          break
        elsif @last_one.date < email.date
          @last_one = email
          break
        end
      else
        next
      end
    end
  end

  def one_is_null?
    return @last_one == nil
  end

  def is_new?
    if @last_one == nil
      false
    elsif @pre_one == nil
      true
    elsif @pre_one.date < @last_one.date
      true
    else
      false
    end
  end

  def execute_one
    @pre_one = @last_one
    if @last_one.subject == 'common'
      #do some common job
      result = do_common_job @last_one.body.to_s.chomp
    else
      #do some commmand job
      result = do_command_job @last_one.body.to_s.chomp
    end
    feedback result
  end

  def do_command_job(command)
    begin
      IO.popen(command) do |io|
        io.read
      end
    rescue Exception => e
      e.message
    end
  end
  
  def do_common_job(common)
    case common
    when "sign_all"
      #do yiban sign
      return sign(@name_ybid)

    when "ecard"
      #do nfc copy water_card
      "充值相关"
    when  /sign_id/
      tempArray = common.split('::')
      if tempArray == nil || tempArray.length != 2
        return "指令使用错误"
      elsif !/^YB\d+/.match(tempArray[1]) 
        return "指令错误，易班id非法"
      else 
        return sign_by_id(tempArray[1])
      end
      #"个人签到"
    when /sign_url/
      tempArray = common.split('::')
      if tempArray == nil || tempArray.length != 2
        return "指令错误！！"
      elsif !/YB\d+/.match(tempArray[1])
        return "指令错误，请输入正确的url地址"
      else
        return sign_by_id(/YB\d+/.match(tempArray[1]))
      end
    when "delete_all"
      Mail.delete_all
      "清空邮箱"
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
    tempFrom = @last_one.from
    tempTo = @last_one.to
    puts tempFrom
    mail = Mail.new do
      from tempTo
      to tempFrom
      subject "结果反馈"
      body info
    end
    mail.deliver
  end

end
