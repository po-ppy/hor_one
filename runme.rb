#_*_ coding:utf-8 _*_
require './lib/Hor_one'
include Hor_one

runme = Thread.new do

  while true do
    begin
      flash_emails
      get_one
      #if is_new?
       # execute_one
      #end
      while is_new?
        execute_one
        get_one
      end 
      sleep 120

    rescue Exception => e
      puts e.message
      sleep 10
      retry
    end
  end

end

runme.join
