#!/usr/bin/env ruby

require 'cinch'
require_relative 'config'

config = BotConfig.new
bot = Cinch::Bot.new do
    configure do |c|
        c.server = config::server
        c.channels = config::channels
    end
end

bot.start

