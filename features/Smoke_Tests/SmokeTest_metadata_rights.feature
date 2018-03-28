@smokeMetadataRights @smoke
Feature: Jupiter - 31 - Create Bookmark

Scenario: Setup
    Given I ensure Jupiter is ready for testing

Scenario: Get the test data
    Given I read the fileid file
    When I search for the read file id in "Media Item Id"
    Then I should see "asset_crashrecording.png"

Scenario: Load an asset into QVL
    Given I load asset "asset_crashrecording.png" into QVL

Scenario: Edit the items default right
    Given I click on "qvl_Button_Rights.png"
    When I click on "button_edit_item_default_right.png"
    And I set the traffic light rights to "red"
    And I click on "button_Ok.png"
    And I wait "3" seconds
    And I wait for "rights_red.png" to appear
    Then I should see "rights_red.png" with high accuracy "0.85"
    And I should see "QVL_rights_red.png" with high accuracy "0.85"

Scenario: Change rights item back to green
    Given I click on "qvl_Button_Rights.png"
    When I click on "button_edit_item_default_right.png"
    And I set the traffic light rights to "green"
    And I click on "button_Ok.png"

