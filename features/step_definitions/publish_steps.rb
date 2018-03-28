
Then(/^I select the entire clip$/) do
	steps %Q{
	    Given I click on "qvl_Button_Clear.png"
	    And I click on "qvl_Button_Left_Arrow.png"
	    And I type "i"
	    And I wait for "1" seconds
	    And I click on "qvl_Button_Right_Arrow.png"
	    And I type "o"
	    And I wait for "1" seconds
	}
end

Then(/^I set the load item on publish checkbox$/) do
	
	begin
		steps %Q{
			And I should see "load_item_on_publish_checked.png" with high accuracy "0.98" now
		}
	rescue
		@screen.click "load_item_on_publish.png"
	end

end

Then(/^I unset the load item on publish checkbox$/) do
	begin
		steps %Q{
			And I should see "load_item_on_publish_unchecked.png" with high accuracy "0.98" now
		}
	rescue
		@screen.click "load_item_on_publish.png"
	end
end

Then(/^I wait for the publish existing tab to disapear$/) do
	steps %Q{
		And I wait for "publish_to_existsing_item.png" to disappear
	}

end

Then(/^I pubslish the etire clip to media "(.*?)" detail "(.*?)"$/) do |story,name|
	steps %Q{
		And I select the entire clip
		And I click on "qvl_Button_New.png"
	    And I click on "publish_selection.png"
		And I wait for "qvl_Radio_Button_Status_Finished.png" to appear
		And I type "News"
		And I click on "qvl_Radio_Button_Category_Sequence.png"
		And I click on "qvl_Textbox_Story.png"
		And I type "#{story}"
		And I click on "qvl_Textbox_Details.png"
		And I type "#{name}"
	    And I use TAB
	    And I type the current time
	    And I set the load item on publish checkbox
	    And I click on "publish_button.png"
	    And I wait for "2" seconds
	    And I use RETURN
	    And I wait for "button_Cancel.png" to disappear
	}

end