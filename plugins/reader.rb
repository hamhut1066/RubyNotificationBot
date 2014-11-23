require 'cinch'
require 'httpsimple'


class Reader
  include Cinch::Plugin


  match /(.*)/i

  def execute(msg, query)
    words = query.split(/\W+/)
    words.each{ |x| 
      if is_registered(x)
        # add code here to push to remote server
        response = HttpSimple.post "http://notifications.aoeu.me/1/api/push", :name => msg.user.nick, :msg => query
        puts response
        # $redis.lpush "msg_#{msg.user.nick}", "#{query}"
        msg.reply "added for #{x}"
      end
    }
  end

  def is_registered(nick)
    $redis.sismember "registered_users", nick
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
    $redis.sadd "registered_users", msg.user.nick
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
