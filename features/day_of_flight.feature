Feature: Day of Flight
  Scenario: View day of flight
    Given I am logged in
    Then I should see "Day Of Flight"

  Scenario: Create a day of flight
    Given I am logged in
    And I click "Day Of Flight"
    And I click "New Day Of Flight"
    And I select id "day_of_flight_flies_on_1i" value "2015"
    And I select id "day_of_flight_flies_on_2i" value "February"
    And I select id "day_of_flight_flies_on_3i" value "14"
    And I click button "Create Day of flight"
    Then I should see "Day of flight was successfully created."