require 'yaml'

module BotConfig
  config = YAML.load_file('config.yaml')
  BASE_DIR = config['base_dir']
  SERVER = config['server']
  CHANNELS = config['channels']
  PREFIX = config['prefix']
  PORT  = config['port']
  NICK  = config['nick']
  PASSWORD  = config['password']
end
