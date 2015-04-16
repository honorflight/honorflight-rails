Feature: Create Guardian
  As an administrator
  I would like to manually enter Guardians

  Scenario: Entering a Guardian's information
    Given I am logged in
    And I click "Guardians"
    Then I should see "New Guardian"
    And I click "New Guardian"
    Then I fill in "First name" with "Jeff"
    And I fill in "Last name" with "Ancel"
    And I fill in "Phone" with "3148675309"
    And I fill in "Date of Birth" with "03/20/1922"
    And I click button "Create Guardian"
    Then I should see "Guardian was successfully created."
    And I should see "Jeff"
    And I should see "Ancel"

  Scenario: Entering incomplete or missing Guardian's information
    Given I am logged in
    And I click "Guardians"
    Then I should see "New Guardian"
    And I click "New Guardian"
    And I click button "Create Guardian"
    Then I should see "Birth date can't be blank"
    And I should see "First name can't be blank"
    And I should see "Last name can't be blank"
    And I should see "Phone can't be blank"
