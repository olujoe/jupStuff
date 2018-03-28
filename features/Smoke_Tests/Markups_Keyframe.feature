@smoke @markUpsKeyframe
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
    
Scenario: Create a Manual Keyframe
    Given I create a timed video segment "keyframe" at in "2" sec and out "4" sec
    And I click on "qvl_Component_Button_Edit.png"
    And I waitAndclick on "qvl_Bookmark_Description.png"
    And I type "rfdescription"
    And I click on "qvl_Component_Button_Save.png"
    Then I should see "qvl_Keyframe_Description_rfdescription.png"

Scenario: Delete the keyframe
    Given I click on "qvl_Component_Button_Delete.png"
    Then I should not see "qvl_Keyframe_Description_rfdescription.png"