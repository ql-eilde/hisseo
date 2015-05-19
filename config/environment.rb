# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
	address: "smtp.gmail.com",
    port: "587",
    domain: "gmail.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: ENV['GMAIL_USERNAME_DEV'],
    password: ENV['GMAIL_PASSWORD_DEV']
}
