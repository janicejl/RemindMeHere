require 'yaml'

FACEBOOK_CONFIG = YAML.load_file("#{::Rails.root}/config/facebook_secret.yml")[::Rails.env]