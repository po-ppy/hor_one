#_*_ coding:utf-8 _*_
require './lib/Hor_one'
include Hor_one

runme = Thread.new do

  while true do
    sleep 1
    get_one
    if is_new?
      execute_one
    end 
  end

end

runme.join
