require 'rails'

module Less  
  module Rails
    class Railtie < ::Rails::Railtie
      
      module LessContext
        attr_accessor :less_config
      end
      
      config.less = ActiveSupport::OrderedOptions.new
      config.less.paths = []
      config.less.compress = ::Rails.env != 'development'
      
      config.before_initialize do |app|
        require 'less'
        require 'less-rails'
        Sprockets::Engines #force autoloading
        Sprockets.register_engine '.less', Less::Rails::LessTemplate
      end
      
      initializer 'less-rails.before.load_config_initializers', :before => 'load_config_initializers', :group => :all do |app|
        raise 'The less-rails plugin requires the asset pipeline to be enabled.' unless app.config.assets.enabled
      end
      
      initializer 'less-rails.after.load_config_initializers', :after => 'load_config_initializers', :group => :all do |app|
        app.assets.context_class.extend(LessContext)
        app.assets.context_class.less_config = app.config.less
      end
      
    end
  end
end

