#!/usr/bin/env ruby

require 'cinch'

bot = Cinch::Bot.new do
    configure do |c|
        c.server = "localhost"
        c.channels = ["#bottest"]
    end

    on :message, "hello" do |m|
        m.reply "Hello, #{m.user.nick}"
    end

    on :message, "hi" do |m|
        m.reply "Hi, #{m.user.nick}"
    end
end

bot.start

