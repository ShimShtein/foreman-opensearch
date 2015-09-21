require 'deface'

module ForemanOpensearch
  class Engine < ::Rails::Engine
    engine_name 'foreman_opensearch'

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/overrides"]

    # Add any db migrations
    initializer 'foreman_opensearch.load_app_instance_data' do |app|
      app.config.paths['db/migrate'] += ForemanOpensearch::Engine.paths['db/migrate'].existent
    end

    initializer 'foreman_opensearch.register_plugin', after: :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_opensearch do
        requires_foreman '>= 1.4'
      end
    end

    # Precompile any JS or CSS files under app/assets/
    # If requiring files from each other, list them explicitly here to avoid precompiling the same
    # content twice.
    assets_to_precompile =
      Dir.chdir(root) do
        Dir['app/assets/javascripts/**/*', 'app/assets/stylesheets/**/*'].map do |f|
          f.split(File::SEPARATOR, 4).last
        end
      end
    initializer 'foreman_opensearch.assets.precompile' do |app|
      app.config.assets.precompile += assets_to_precompile
    end
    initializer 'foreman_opensearch.configure_assets', group: :assets do
      SETTINGS[:foreman_opensearch] = { assets: { precompile: assets_to_precompile } }
    end

    # Include concerns in this config.to_prepare block
    config.to_prepare do
    end

    rake_tasks do
      Rake::Task['db:seed'].enhance do
        ForemanOpensearch::Engine.load_seed
      end
    end

    initializer 'foreman_opensearch.register_gettext', after: :load_config_initializers do |_app|
      locale_dir = File.join(File.expand_path('../../..', __FILE__), 'locale')
      locale_domain = 'foreman_opensearch'
      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
    end
  end
end
