Feature: Application status
  As a monitor
  I would like to see status OK

  Scenario: Status reporting
  Given I browse to status
  Then I should see "OKAY"