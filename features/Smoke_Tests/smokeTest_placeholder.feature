@smokeplaceholder @smoke
Feature: Jupiter - Smoke test metadata description tab

Scenario: Setup
    Given I ensure Jupiter is ready for testing

Scenario: create placeholder
	Given I click on "menu_New.png"
	When I click on "placeholder.png"
    And I wait for "new_placeholder_story.png" to appear
    #And I type "BBC3"
	And I click on "new_placeholder_story.png"
    And I type "rf70"
    #And I use TAB
    And I click on "details_box.png"
    And I type "placeholder"
    #And I use TAB
    And I click "10" pixels to the "bottom" of "time_box.png"
    And I type the current time
    And I click on "new_placeholder_description.png"
    And I type "test placeholder"
    #And I use TAB
    And I click "30" pixels to the "right" of "in_words.png"
    And I type "placeholder"
	And I click on "sequence.png"
	And I click on "qvl_Button_Publish2.png"
	Then I should not see "button_Cancel.png"

Scenario: check that the placeholder is created
	Given I click on "favourites_Cliplist.png" until "clip_list_top.png" appears'
	Then I should see "asset_placeholder.png"
    And I should see "time_000.png" with high accuracy "0.92"

Scenario: Get the test data
    Given I read the fileid file
    When I search for the read file id in "Media Item Id"
    Then I should see "asset_crashrecording.png"
    And I load asset "asset_crashrecording.png" into QVL

Scenario: Create a clip 

    Given I select the entire clip
    And I click on "qvl_Button_New.png"
    And I wait for "publish_selection.png" to appear
    And I click on "publish_selection.png"
    And I wait for "qvl_Radio_Button_Status_Finished.png" to appear
    And I type "News"
	#And I click on "new_placeholder_story.png"
    #And I type "rf70"
    #And I use TAB
    #And I type "publishedplaceholder"
    #And I click on "new_placeholder_description.png"
    #And I type "published placeholder"
	#And I click on "sequence.png"

	And I click on "publish_to_existsing_item.png"
    And Within region "publish_popup_region.png" click "asset_placeholder2.png"
	#And I click on "asset_placeholder2.png"
	And I click on "republish_button.png"
    And I wait "2" seconds
	And I click on "qvl_Radio_Button_Status_Finished.png"
    #And I click on "button_Ok.png"
    And I click on "publish_ok_button.png"
    And I click on "qvl_Button_Deliver.png" if exists
    And I wait for "button_remove.png" to disappear
    And I handle any publish name errors
    #And I ensure that the jupiter delivery queue control window is displayed
    #And I wait for "qvl_DeliveryQ_window.png" to appear 
    #And I click on "qvl_Button_Close.png" if exists

@zzx
Scenario: Check finished item
    And I click on "button_close_underlined.png" if exists
	Then I should see "asset_placeholder_finished.png"
    #And I should see "time_004.png" with high accuracy "0.8"
