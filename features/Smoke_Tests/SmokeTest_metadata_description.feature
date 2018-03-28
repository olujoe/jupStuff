@smokeMetadatDescription @smoke
Feature: Jupiter - Smoke test metadata description tab

Scenario: Setup
    Given I ensure Jupiter is ready for testing

Scenario: Get the test data
    Given I read the fileid file
    When I search for the read file id in "Media Item Id"
    Then I should see "asset_crashrecording.png"

Scenario: Load an asset into QVL
    Given I load asset "asset_crashrecording.png" into QVL

Scenario: Amend story name
    Given I click on "qvl_Button_Description.png"
	And I click on "MI_Description_GeneralTab_Unselected1.png" if exists
    And I click on "qvl_Description_Description_box.png"
    And I use CTRL A
    And I type "rf60 !$%^&*()-_+=`<>,.?'@;#~]}[{"
    And I click on "MI_Description_Save.PNG"
    Then I should not see "dlg_Error_Sign.png"
	
Scenario: Search Media Items    
    Given I search for the read file id in "Media Item Id"
    Then I should not see "edited_description.png"
    When I load asset "asset_crashrecording.png" into QVL

Scenario: Revert the media data back to its original
    Given I click on "qvl_Button_Description.png"
    And I wait "1" seconds
    And I click on "qvl_Description_Description_box.png"
    And I use CTRL A
    And I use BACKSPACE
    And I click on "MI_Description_Save.PNG"
    Then I should not see "dlg_Error_Sign.png"
