module RadbearRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      desc 'Used to install the rad_common depencency files and create migrations.'

      def create_initializer_file
        # initializers
        template '../../../../../spec/dummy/config/initializers/rad_common.rb', 'config/initializers/rad_common.rb'

        # templates

        # active_record templates
        copy_file '../../../../../spec/dummy/lib/templates/active_record/model/model.rb', 'lib/templates/active_record/model/model.rb'

        # haml` templates
        copy_file '../../../../../spec/dummy/lib/templates/haml/scaffold/_form.html.haml', 'lib/templates/haml/scaffold/_form.html.haml'
        copy_file '../../../../../spec/dummy/lib/templates/haml/scaffold/edit.html.haml', 'lib/templates/haml/scaffold/edit.html.haml'
        copy_file '../../../../../spec/dummy/lib/templates/haml/scaffold/index.html.haml', 'lib/templates/haml/scaffold/index.html.haml'
        copy_file '../../../../../spec/dummy/lib/templates/haml/scaffold/new.html.haml', 'lib/templates/haml/scaffold/new.html.haml'
        copy_file '../../../../../spec/dummy/lib/templates/haml/scaffold/show.html.haml', 'lib/templates/haml/scaffold/show.html.haml'

        # rails templates
        copy_file '../../../../../spec/dummy/lib/templates/rails/scaffold_controller/controller.rb', 'lib/templates/rails/scaffold_controller/controller.rb'

        # rspec templates
        copy_file '../../../../../spec/dummy/lib/templates/rspec/integration/request_spec.rb', 'lib/templates/rspec/integration/request_spec.rb'
        copy_file '../../../../../spec/dummy/lib/templates/rspec/scaffold/controller_spec.rb', 'lib/templates/rspec/scaffold/controller_spec.rb'

        gsub_file 'config/environments/production.rb', '#config.force_ssl = true', 'config.force_ssl = true'

        inject_into_class 'config/application.rb', 'Application' do <<-'RUBY'

    # added by radbear_rails
    config.generators do |g|
      g.helper false
      g.stylesheets false
      g.javascripts false
      g.view_specs false
      g.helper_specs false
      g.routing_specs false
    end

        RUBY
        end

        inject_into_file 'config/routes.rb', after: 'Application.routes.draw do' do <<-'RUBY'

  mount RadCommon::Engine => '/rad_common'

        RUBY
        end
      end
    end
  end
end
