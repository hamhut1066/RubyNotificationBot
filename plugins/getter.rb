require 'cinch'

class Getter
  include Cinch::Plugin

  match /\.last/

  def execute(msg)
    begin
      tmp = $redis.rpop "msg_#{msg.user.nick}"
      msg.reply "#{tmp}"
    rescue Exception => e
    end
  end
end
