#_*_ coding:utf-8 _*_
require './lib/Hor_one'
include Hor_one

runme = Thread.new do

  while true do
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
  end

end

runme.join
