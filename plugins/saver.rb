require 'cinch'

class Saver
  include Cinch::Plugin

  match %r{.save}

  def execute(msg)
    $redis.hset "users", "#{msg.user.nick}", "y"
    $redis.sadd "registered_users", msg.user.nick
    msg.reply "#{msg.user.nick}, successfully added"
  end
end

