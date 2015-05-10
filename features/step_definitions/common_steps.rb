Given(/^I am logged in$/) do
  step %{I browse to application}
  step %{I have a user account "test@example.com" with password "password"}
  step %{I fill in "Email" with "test@example.com"}
  step %{I fill in "Password" with "password"}
  step %{I click button "Login"}
end

Given(/^I click "(.*?)"$/) do |arg1|
  click_link(arg1)
end

Given(/^I click first "(.*?)"$/) do |arg1|
  click_link(arg1)
end


When(/^I have a user account "(.*?)" with password "(.*?)"$/) do |arg1, arg2|
  AdminUser.create(email: arg1, password: arg2, password_confirmation: arg2)
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  fill_in arg1, with: arg2
end

When(/^I fill in id "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  fill_in arg1, with: arg2
end

Then(/^I should see "(.*?)"$/) do |arg1|
  expect(page).to have_content(arg1)
end

When(/^I click button "(.*?)"$/) do |arg1|
  first(:button, arg1).click
    # click_button(arg1) # "Create Veteran"
end

Then(/^I save_and_open_page$/) do
  save_and_open_page # express the regexp above with the code you wish you had
end

Given(/^I select id "(.*?)" value "(.*?)"$/) do |arg1, arg2|
  select arg2, from: arg1
  # pending # express the regexp above with the code you wish you had
end