require 'yaml'



class BotConfig
    attr_reader :base_dir, :server, :channels
    def initialize
        config = YAML.load_file('config.yaml')
        @base_dir = config['base_dir']
        @server = config['server']
        @channels = config['channels']
    end
end
