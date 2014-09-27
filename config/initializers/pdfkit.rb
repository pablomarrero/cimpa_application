# Modify asset host config setting in `config/application.rb`
# Or create a new initializer: `config/initializers/wkhtmltopdf.rb`
CimpaApplication::Application.config.action_controller.asset_host = "http://localhost:3000"
PDFKit.configure do |config|
  config.default_options = {
    :page_size => 'Legal',
    :orientation => 'landscape',
    :print_media_type => true
  }
end
