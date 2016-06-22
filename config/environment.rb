# Load the Rails application.
require File.expand_path('../application', __FILE__)

ActionMailer::Base.smtp_settings = {
  :user_name => 'postmaster@incentru.com',
  :password => 'ea19d5bd2efa9b95b219285b953b879e',
  :domain => 'www.incentru.com',
  :address => 'smtp.mailgun.org',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

# Initialize the Rails application.
Rails.application.initialize!
