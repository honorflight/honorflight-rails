When(/^I save the veteran$/) do
  within("#veteran_submit_action") do
    click_button("Create Veteran")
  end
end