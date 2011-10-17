require 'less/css'
require 'rails/generators/named_base'

module Less::Generators
  class ScaffoldBase < Rails::Generators::NamedBase
    def copy_stylesheet
      dir  = ::Rails::Generators::ScaffoldGenerator.source_root
      file = File.join(dir, 'scaffold.css')
      create_file 'app/assets/stylesheets/scaffold.css.less', File.read(file)
    end
  end
end

