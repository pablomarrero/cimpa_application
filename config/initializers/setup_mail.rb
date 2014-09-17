ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default_url_options = {:host => 'cimpa.info'}
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => "mail.gandi.net",
  :port => 587,
  :domain => "cimpa.info",
  :user_name => "info@cimpa.info",
  :password => "bBs1LH2vc2z6Mf",
  :authentication => "plain",
  :openssl_verify_mode  => 'none'
}
