Ratemypup::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!

  config.eager_load = false

  config.cache_classes = true

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true
  # Generate digests for assets URLs
  config.assets.digest = false

  # Log error messages when you accidentally call methods on nil
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test
  config.action_mailer.perform_deliveries = true
  # Raise exception on mass assignment protection for Active Record models
  # config.active_record.mass_assignment_sanitizer = :strict

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

  config.middleware.use RackSessionAccess::Middleware
  
  config.action_mailer.default_url_options = { :host => 'cs169-intro-hyu596.c9users.io' }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true 
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :domain => "gmail.com",
    :authentication => :plain,
    :user_name => "yuhongzhan0407@gmail.com",
    :password => "Jeff4728",
    :enable_starttls_auto => false
  }
end
