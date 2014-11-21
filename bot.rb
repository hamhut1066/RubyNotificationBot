#!/usr/bin/env ruby

require 'cinch'
require 'redis'
require_relative 'config'
require_relative 'plugins/reader'

config = BotConfig.new
$redis = Redis.new
bot = Cinch::Bot.new do
  configure do |c|
    puts config::server
    c.server = config::server
    c.channels = config::channels.map{ |x| "#" + x}
    c.plugins.prefix = config::prefix
    c.plugins.plugins = [Reader, Saver]
  end
end

bot.start

