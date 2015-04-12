@wip
Feature: Create volunteer
  As an administrator
  I would like to manually enter volunteer

  Scenario: Entering a volunteer's information
    Given I am logged in
    And I click "Volunteers"
    Then I should see "New Volunteer"
    And I click "New Volunteer"
    Then I fill in "First name" with "Jeff"
    And I fill in "Last name" with "Ancel"
    And I fill in "Phone" with "3148675309"
    And I fill in "Date of Birth" with "03/20/1922"
    And I click button "Create Volunteer"
    Then I should see "Volunteer was successfully created."
    And I should see "Jeff"
    And I should see "Ancel"
