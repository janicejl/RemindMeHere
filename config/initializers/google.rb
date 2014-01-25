require 'yaml'

GOOGLE_CONFIG = YAML.load_file("#{::Rails.root}/config/google_apikey.yml")[::Rails.env]