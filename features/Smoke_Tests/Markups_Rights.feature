@smoke @markUpsRights
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
	
Scenario: Create a Rights component
	Given I create a timed video segment "" at in "4" sec and out "8" sec
    And I click on "quick_component_option.png"
    And I click on "add_rights_information.png"
    And I wait for "ScreenTitle_Component.png" to appear

    And I set the traffic light rights to "green"
    And I click on "qvl_Button_Ok.png"
    And I wait for "tools_options_cancel-button.png" to disappear soon
    And I click on "qvl_Component_Button_Edit.png"
    And I wait for any not responding message to disappear
    And I clear any errors encountered
    When I waitAndclick on "qvl_Rights_Component_Story_Dropdown.png"
    And I type "auto"
    And I use TAB
    And I type "rights"
    And I click on "MI_Description_Save.PNG"
    Then I should see either "qvl_Component_Rights_highlighted.png" or "qvl_Component_Rights2.png" 

Scenario: Delete Rights component
    Given I delete all keyframes
    Then I should not see "qvl_Component_Rights2.png"