module Polymer
  module Rails
    class Engine < ::Rails::Engine
      config.assets.precompile += %w( polymer/polymer.js )

      initializer :polymer_html_import do
        helpers = %q{ include AssetTagHelper }
        ::ActionView::Helpers::AssetTagHelper.module_eval(helpers)
        ::Rails.application.assets.context_class.class_eval(helpers)
      end

      initializer :add_preprocessors do |app|
        app.assets.register_mime_type "text/html", ".html"
        app.assets.register_preprocessor "text/html", Polymer::Rails::DirectiveProcessor
      end

    end
  end
end
