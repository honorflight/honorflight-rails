# Mailer that sends notifications to admin people
# based on their user settings
class AdminPersonMailer < ApplicationMailer
  def veteran_form_submission_email(person, admin_user)
    @person = person
    @admin_user = admin_user
    @url = "http://#{settings.host}" + send("admin_#{@person.class.to_s.downcase}_path".to_sym, @person)
    mail(to: @admin_user.email, subject: "A #{@person.class.to_s} App Has been Submitted")
  end
end
