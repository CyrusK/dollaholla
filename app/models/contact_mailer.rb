class ContactMailer < ActionMailer::Base
  default to: # my email address
  
  def contact_email(name, email, body, last, phone, country, pin_id)
    @name = name
    @email = email
    @body = body
    @last = last
    @phone = phone
    @country = country
    @pin_id = pin_id

    mail(from: email, subject: 'Contact Request', to: 'info@incentru.com')

  end
end
