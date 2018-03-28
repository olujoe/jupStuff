@smoke @markupsComponents
Feature: Jupiter - Create Markups

Scenario: Jupiter Starts OK
    Given I ensure Jupiter is ready for testing

Scenario: Get the test data
    Given I read the fileid file
    When I empty the clip list
    And I should close all side panel windows
    When I search for the read file id in "Media Item Id"
    Then I should see "asset_crashrecording.png"
    And I ensure "asset_crashrecording.png" is in the cliplist

Scenario: Load an asset into QVL
    Given I load asset "asset_crashrecording.png" into QVL
	And I click on "qvl_Button_Keyframes.png"
    And I go to the keyframes page and delete all system data

Scenario: Create a component
    Given I create a timed video segment "component" at in "2" sec and out "6" sec
    And I clear any errors encountered
    Given I click on "qvl_Component_Button_Edit.png"
    And I waitAndclick on "qvl_Rights_Component_Story_Dropdown.png"
    And I type "rfstory"
    And I waitAndclick on "qvl_Component_Button_Save.png"
    Then I should see "qvl_Component_Story_Dropdown_rfstory.png"

Scenario: Delete the component
    Given I click on "qvl_Component_Button_Delete.png"
    Then I should not see "qvl_Component_Story_Dropdown_rfstory.png"