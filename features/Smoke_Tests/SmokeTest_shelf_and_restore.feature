@smokeSendToShelf @smoke
Feature: Jupiter - 48 - Send a media item to shelf

Scenario: Setup
    Given I ensure Jupiter is ready for testing

Scenario: Get the test data
    Given I read the fileid file
    When I search for the read file id in "Media Item Id"
    Then I should see "asset_crashrecording.png"

Scenario: Load an asset into QVL
    Given I load asset "asset_crashrecording.png" into QVL
    
Scenario: Select Keep On Shelf check-box
	Then I should see "archive_Search_Status_Online.png"
	#When I rightclick on "archive_Search_Status_Online.png" and click "context_Menu_Keep_Decision.png"
	#And I wait "2" seconds
	#And I click on "archive_Search_Checkbox_Keep_On_Shelf.png"
	#And I use TAB
	#And I type "BBC3"
	#And I click on "archive_Search_Textbox_Comments.png"
	#And I type "testing"
	#And I click on "button_Ok.png"
	#Then I should not see "button_Ok.png"
	Given I send an online item to online + shelf
	
Scenario: Search Media Items
	Given I click on "button_Search.png" until "archive_Search_Status_Online_And_Shelf.png" appears eventually
	Then I should see "archive_Search_Status_Online_And_Shelf.png"

Scenario: Delete Online
	Given I rightclick on "archive_Search_Status_Online_And_Shelf.png" and click "delete.png"
	#And I click on "delete_online_checkbox.png"
	#And I click on "button_delete.png"
	#And I click on "button_Ok4.png"
	#And I click on "button_Ok4.png"
	And I delete online
	Then I should not see "archive_Search_Status_Online_And_Shelf.png"
	
Scenario: Search Media Items
	Given I click on "button_Search.png" until "archive_Search_Status_Shelf.png" appears eventually
	Then I should see "archive_Search_Status_Shelf.png"

Scenario: Select Restore from Shelf checkbox
	And I click on "button_Search.png" until "archive_Search_Status_Shelf.png" appears
	Then I should see "archive_Search_Status_Shelf.png"

	Given I rightclick on "archive_Search_Status_Shelf.png" and click "archive_Rightclick_Restore.png"
	And I click on "button_restore.png" if exists
	And I click on "button_restore.png" if exists
	#When I waitAndclick on "button_OK4.png"
	And I wait for "2" seconds
	And I close the jupiter archive pop up if exists
	And I click on "button_Ok4.png" if exists
	#And I click on "button_no.png"
	#And I click on "button_restore.png"
	#When I waitAndclick on "button_OK4.png"
	And I click on "button_Search.png" until "archive_Search_Status_Online_And_Shelf.png" appears eventually
	Then I should see "archive_Search_Status_Online_And_Shelf.png"

Scenario: Delete shelf
	Given I rightclick on "archive_Search_Status_Online_And_Shelf.png" and click "delete.png"
	And I click on "archive_Search_Checkbox_Shelf.png"
	And I click on "button_delete.png"
	And I click on "button_Ok4.png"
	And I click on "button_Ok4.png"
	And I click on "button_Search.png"
	Then I should not see "archive_Search_Status_Online_And_Shelf.png"
	