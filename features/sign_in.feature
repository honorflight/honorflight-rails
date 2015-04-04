Feature: Login
  Scenario: sign in
  Given I browse to application
  When I have a user account "test@example.com" with password "password"
  When I fill in "Email" with "test@example.com"
  And I fill in "Password" with "password"
  And I click button "Login"
  Then I should see "Signed in successfully."
  And I should see "People"
  And I should see "Dashboard"