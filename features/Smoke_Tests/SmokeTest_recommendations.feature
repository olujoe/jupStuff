@smokeRecommendations @smoke
Feature: Jupiter -Smoke Tests - Recommendations

Scenario: Setup
    Given I ensure Jupiter is ready for testing

Scenario: Get the test data
    Given I read the fileid file
    When I search for the read file id in "Media Item Id"
    Then I should see "asset_crashrecording.png"

Scenario: Load an asset into QVL
    Given I load asset "asset_crashrecording.png" into QVL

Scenario: Select RecommendToKeep
	Given I rightclick on "asset_crashrecording.png" and click "context_Menu_Recommend_To_Keep.png"
	Then I should see "recommend_To_Keep_Reason.png"
	
Scenario: Complete RecommendToKeep dialogue box
	Given I click on "recommend_To_Keep_Reason.png"
	When I type "rfReason"
	And I click on "recommend_To_Keep_Date.png"
	And I click on "qvl_Component_KeepTab_Date_Today.png"
	And I use TAB
	And I click on "button_Ok.png"
	Then I should not see "button_Ok.png"
	
Scenario: Check the keep date has been added
	When I click on "qvl_Button_Properties.png"
	And I wait "2" seconds
	And I click on "recommendations_tab.png" if exists
	And I wait "2" seconds
	Then I should see either "today3.png" or "keep_online_today.png"

Scenario: Select Keep Decision
	Given I rightclick on "keep_online2.png" 
	And I click on "decision.png"
	Then I should see "checkbox_Enable_Keep_Online.png"
	
Scenario: Complete Keep Decision dialogue box
	Given I click on "checkbox_Enable_Keep_Online.png"
	And I click on "checkbox_Enable_Keep_Online_dateDrop.png"
	And I click on "qvl_Component_KeepTab_Date_Today.png"
	And I doubleclick on "button_Ok3.png"
	And I click on "early_decision_popup_ok_button.png" if exists
	Then I should not see "checkbox_Enable_Keep_Online.png"
	And I should see "keep_online_decision_result.png"
	#And I should see "deletion_online_text.png"
	
