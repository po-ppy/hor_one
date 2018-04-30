#_*_ coding:utf-8 _*_
require './Hor_one'
include Hor_one
while true do
  sleep(2)
  get_one
  if is_new?
    execute_one
  end
end
#emails = Mail.all
#emails = Mail.find(what: :last, count: 15, order: :dec)
#emails.sort! do |a,b|
#  b.date <=> a.date
#end
#emails.each do |email|
#  puts "#{email.date.to_s}-->#{email.subject}"
#end

#get_one
#execute_one
#puts "%%%#{@last_one.body.to_s.chomp}%%%"
#
