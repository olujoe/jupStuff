@smoke @launchApplication
Feature: Jupiter - Start Application

Scenario: Jupiter Starts OK
    Given I ensure Jupiter is not running
    When I start the jupiter application
    Then Jupiter should running in the foreground