Feature: Create veteran
  As an administrator
  I would like to manually enter veterans

  Scenario: Entering a veteran's information
    Given I am logged in
    And I click "Veterans"
    Then I should see "New Veteran"
    And I click "New Veteran"
    Then I fill in "First name" with "Jeff"
    And I fill in "Last name" with "Ancel"
    And I fill in "Phone" with "3148675309"
    And I fill in "Date of Birth" with "03/20/1922"
    And I fill in "Email" with "test1@example.com"
    And I fill in "Work email" with "test2@example.com"
    And I fill in "Cell phone" with "3147038888"
    And I fill in "Work phone" with "3147038888"
    And I fill in "Application date" with "05/15/2015"
    And I click button "Create Veteran"
    Then I should see "Veteran was successfully created."
    And I should see "Jeff"
    And I should see "Ancel"
    And I should see "3/20/1922"    
    And I should see "May 15, 2015"

  Scenario: Entering incomplete or missing veteran's information
    Given I am logged in
    And I click "Veterans"
    Then I should see "New Veteran"
    And I click "New Veteran"
    And I click button "Create Veteran"
    Then I should see "Birth date can't be blank"
    And I should see "First name can't be blank"
    And I should see "Last name can't be blank"
    And I should see "Phone can't be blank"

  Scenario: Editting a veteran should not require previously entered information
    Given I am logged in
    And I click "Veterans"
    Then I should see "New Veteran"
    And I click "New Veteran"
    Then I fill in "First name" with "Jeff"
    And I fill in "Last name" with "Ancel"
    And I fill in "Phone" with "3148675309"
    And I fill in "Date of Birth" with "03/20/1922"
    And I fill in "Email" with "test1@example.com"
    And I fill in "Work email" with "test2@example.com"
    And I fill in "Cell phone" with "3147038888"
    And I fill in "Work phone" with "3147038888"
    And I click button "Create Veteran"
    Then I should see "Veteran was successfully created."
    And I should see "Jeff"
    And I should see "Ancel"
    Then I click "Edit Veteran"
    And I fill in "First name" with "Jeff1"
    And I click button "Update Veteran"
    Then I should see "Veteran was successfully updated."
