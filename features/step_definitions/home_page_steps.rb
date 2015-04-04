Given(/^I browse to application$/) do
  visit(root_path)
end

Then(/^I should see login$/) do
  expect(page).to have_content("Login")
end
