#_*_ coding:utf-8 _*_
require '/home/poppy/hor_one/lib/Hor_one'
include Hor_one
runme = Thread.new do
  10.times do |i|
    puts i
    get_one
    if is_new?
      execute_one
    end 
  end
end
#runme.join
