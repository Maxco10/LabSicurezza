# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'


# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.


Rails.application.config.assets.precompile += %w( bootstrap.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )

Rails.application.config.assets.precompile += %w( bootstrap-responsive.css )
Rails.application.config.assets.precompile += %w( bootstrap.css )
Rails.application.config.assets.precompile += %w( bootstrap-responsive.min.css )
Rails.application.config.assets.precompile += %w( bootstrap.min.css )

Rails.application.config.assets.precompile += %w( themes/css/bootstrappage.css )
Rails.application.config.assets.precompile += %w( themes/css/flexslider.css )
Rails.application.config.assets.precompile += %w( themes/css/jquery.fancybox.css )
Rails.application.config.assets.precompile += %w( themes/css/main.css )
Rails.application.config.assets.precompile += %w( themes/js/css/style.css )

Rails.application.config.assets.precompile += %w( themes/js/common.js )
Rails.application.config.assets.precompile += %w( themes/js/jquery-1.7.2.min.js )
Rails.application.config.assets.precompile += %w( themes/js/jquery.fancybox.js )
Rails.application.config.assets.precompile += %w( themes/js/jquery.scrolltotop.js )
Rails.application.config.assets.precompile += %w( themes/js/superfish.js )
Rails.application.config.assets.precompile += %w( themes/js/jquery.flexslider-min.js )

