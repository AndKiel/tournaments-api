Apipie.configure do |config|
  config.app_name                = 'Untitled Tournaments'
  config.app_info                = 'API for tournament management application.'
  config.copyright               = '&copy; 2017 Andrzej Kiełtyka'
  config.api_base_url            = ''
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*_controller.rb"
  config.doc_base_url            = '/docs'
  config.show_all_examples       = false
  config.translate               = false
  config.validate                = false
end
