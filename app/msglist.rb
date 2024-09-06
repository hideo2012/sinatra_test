require './model'

#  @messages = Message.all
puts "message count : #{Message.count}"  
puts "message add"  
Message.create!(
  name: 'hideo dayo..2',
  comment: 'this cmt made by seed'
)
puts "message count : #{Message.count}"  

