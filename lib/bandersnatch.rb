require 'yaml'
require 'erb'
require 'amqp'
require 'mq'
require 'bunny'
require 'uuid4r'
require 'active_support'
require 'redis'

module Bandersnatch
  lib_dir = File.dirname(__FILE__) + '/bandersnatch/'
  Dir["#{lib_dir}/*.rb"].each do |libfile|
    autoload File.basename(libfile)[/(.*)\.rb/, 1].capitalize, libfile
  end

  def self.configuration
    yield config
  end

  protected

  def self.config
    @config ||=
      begin
        conf = Configuration.new
        conf.logger = Logger.new(STDOUT)
        conf.config_file = File.expand_path(File.dirname(__FILE__) + '/../config/bandersnatch.yml')
        conf.environment = ENV['RAILS_ENV'] || "development"
        conf
      end
  end

end
