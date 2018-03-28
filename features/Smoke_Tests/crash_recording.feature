@smoke @crashRecordingToClipList
Feature: Jupiter - Create a crash recording

Scenario: Setup
    Given I ensure Jupiter is ready for testing
	#And I search for "crashrecording" in "Current Last 1"
	#Then I should delete all "asset_crashrecording.png" data
	And I empty the side monitors
	And I should close all side panel windows
	And I empty the clip list

Scenario: create a crash recording
	When I create a recording for story "rf70", details "crashrecording", rights "BBC News", duration "10" 

	#When I open the new recording dialogue
	#And I click on "create_Recording_Dropdown_Story.png"
	#And I type "rf70"
	##And I click on "create_Recording_Click_Off.png"
	##And I wait "3" seconds
	#And I click on "new_Recording_Dropdown_Outlet.png"
	#And I type "BBC3"
	#And I doubleclick on "create_Recording_Textbox_Details.png"
	#And I type "crashrecording"
	#And I click on "create_Recording_Textbox_Description.png"
	#And I type "Testing"
	#And I set the rights to "green"
	#And I click on "create_Recording_Dropdown_Copyright.png"
	#And I use CTRL A
	#And I type "BBC News"
	#And I select the add to cliplist checkbox
	#And I doubleclick on "button_Record.png"
	##And I click on "button_Yes.png"
	#And I click on "button_Yes.png" if exists
	#Then I should not see "button_Record.png"
	
	#When I wait "10" seconds
	#And I click on "recording_Stop_Button.png"
	##And I click on "recording_Stop_Button.png" if exists
	#And I wait "4" seconds
	#And I click on "recording_Complete_Button.png"
	#And I wait "7" seconds
	#Then I should not see "recording_Complete_Button.png"
	#And I wait "5" seconds

	And I should close all side panel windows
	#And I search for "crashrecording" in "Current Last 1"
	#Then I should see "asset_crashrecording.png" soon

Scenario: The new item should be in the clip list
	Given I click on "favourites_Cliplist.png" until "clip_list_top.png" appears
	Then I should see "item_in_cliplist.png"

@C653646
Scenario: Get the clip id
	Given I rightclick on the cliplists "asset_crashrecording.png" item
	#Given I rightclick on "asset_crashrecording.png" 
	And I click on "rightclick_copy.png"
	When I click on "shortcut.png"
	And I wait "6" seconds
	Then I should get the items id
