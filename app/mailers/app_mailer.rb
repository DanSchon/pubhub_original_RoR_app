class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user 
    mail to: user.email, from: "info@pubhub.com", subject: "Welcome to PubHub!"
  end
end