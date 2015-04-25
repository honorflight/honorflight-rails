Feature: Day of Flight
  Scenario: View day of flight
    Given I am logged in
    Then I should see "Day Of Flight"

  @wip
  Scenario: Create a day of flight
    Given I am logged in
    And I click "Day Of Flight"
    And I click "New Day Of Flight"
    And I save_and_open_page
    And I fill in "day_of_flight[flies_on]" with "05/22/2015"
    And I click button "Create Day of flight"
    Then I should see "Day of flight was successfully created."