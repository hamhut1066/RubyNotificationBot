require 'cinch'
require 'redis'

require_relative 'config'
Dir['plugins/**'].each do |d|
  require_relative d
end

$redis = Redis.new

bot = Cinch::Bot.new do
  configure do |c|
    puts BotConfig::BASE_DIR
    c.user = BotConfig::NICK
    c.password = BotConfig::PASSWORD
    c.server = BotConfig::SERVER
    c.port = BotConfig::PORT
    c.channels = BotConfig::CHANNELS.map { |x| "#" + x}
    c.plugins.prefix = BotConfig::PREFIX
    c.plugins.plugins = [Reader, Saver, Getter]
  end
end

bot.start

