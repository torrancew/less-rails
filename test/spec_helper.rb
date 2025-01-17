require 'rubygems'
require 'bundler'
Bundler.require
require 'less/rails'
require 'minitest/spec'
require 'minitest/autorun'
require 'dummy_app/init'

module Less
  module Rails
    class Spec < MiniTest::Spec
      
      before do
        reset_config_options
        reset_caches
      end
      
      
      private
      
      def dummy_app
        Dummy::Application
      end
      
      def dummy_config
        dummy_app.config
      end
      
      def dummy_assets
        dummy_app.assets
      end
      
      def dummy_asset(name)
        dummy_assets[name].to_s.strip
      end
      
      def reset_config_options
        dummy_config.less.paths = []
        dummy_config.less.compress = true
      end
      
      def reset_caches
        dummy_assets.version = SecureRandom.hex(32)
        dummy_assets.cache.clear
      end
      
    end
  end
end

