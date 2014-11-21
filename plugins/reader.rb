require 'cinch'


class Reader
  include Cinch::Plugin

  match /(.*)/i

  def execute(msg, query)
    words = query.split(/\W+/)
    words.each{ |x| 
      unless get_user(x).nil?
        $redis.lpush "msg_#{msg.user.nick}", "#{query}"
        msg.reply "added for #{x}"
      end
    }
  end

  def get_user(nick)
    begin
      $redis.hget "users", "#{nick}"
    rescue Exception => e
      return nil
    end
  end
end

class Saver
  include Cinch::Plugin

  match /\.save/

  def execute(msg)
    $redis.hset "users", "#{msg.user.nick}", "y"
    msg.reply "#{msg.user.nick}, successfully added"
  end
end

class Getter
  include Cinch::Plugin

  match /\.last/i

  def execute(msg)
    begin
      tmp = $redis.rpop "msg_#{msg.user.nick}"
      msg.reply "#{tmp}"
    rescue Exception => e
    end
  end
end
