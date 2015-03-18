# Mailer that sends notifications to admin people
# based on their user settings
class AdminPersonMailer < ApplicationMailer
  before_action :configure_smtp_settings

  def veteran_form_submission_email(person, admin_user)
    @person = person
    @admin_user = admin_user
    @url = "http://#{settings.host}#{admin_person_path(@person)}"
    mail(to: @admin_user.email, subject: 'A Veteran App Has been Submitted')
  end
end
