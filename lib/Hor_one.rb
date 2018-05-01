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

  def get_one
    emails = Mail.all
    if emails.length < 0
      return 
    end
    #emails = Mail.find(what: :last, count: 15, order: :dec)
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
    when "sign"
      #do yiban sign
      return sign(@name_ybid)

    when "ecard"
      #do nfc copy water_card
      "充值相关"
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
