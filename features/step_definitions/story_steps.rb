
When /^I should see the create story dialogue$/ do 
	steps %Q{
		And I should see "create_edit_story_dialogue.png"
	}
end


When /^I close the create story dialogue$/ do 
	#steps %Q{
	#	And I click on "button_Cancel.png"
	#	Then I should not see "create_edit_story_dialogue.png"
	#}

	top = @screen.exists("create_edit_story_section.png")
	reg = top.below()
	#reg.highlight(1)
	reg.doubleClick "button_Cancel.png" 
	steps %Q{
		Then I should not see "create_edit_story_dialogue.png"
	}
end


Then(/^I select the Tasks - Stories - New Story menu$/) do
	step 'I click on "top_task_button.png"'
	steps %Q{
		And I click on either "task_stories.png" or "task_stories_b.png"
		And I wait for "1" seconds
		And I use RETURN
		And I click on either "task_new_story.png" or "task_new_story_b.png"
	}
end


Then(/^I select the Tasks - Stories - Personal Searches$/) do
	step 'I click on "top_task_button.png"'
	steps %Q{
		And I click on either "task_stories.png" or "task_stories_b.png"
		And I wait for "1" seconds
		And I use RETURN
		And I click on either "personal_searches.png" or "personal_searches_b.png"
		And I use RETURN
	}
end



Then(/^I select the Tasks - Stories - New Story Search$/) do
	step 'I click on "top_task_button.png"'
	steps %Q{
		And I click on either "task_stories.png" or "task_stories_b.png"
		And I wait for "1" seconds
		And I use RETURN
		And I click on either "new_story_search.png" or "new_story_search_b.png"
	}
end


Then(/^I enter an invalid story into the story box$/) do
	step 'I click on "create_Recording_Dropdown_Story.png"'
	step 'I type "xyxyxy"'
	@screen.type("\t")
end


Then(/^I enter an invalid story into the arrival booking story box$/) do
	steps %Q{
		When I click on "create_Arrival_Booking_Dropdown_Story.png"
		And I type "xyxyxy"
	}
	@screen.type("\t")
end


When /^I open the create edit story dialogue$/ do 
	steps %Q{
		Given I click on "menu_New.png"	
		And I click on "menu_story.png"
		Then I should see the create story dialogue
	}
end


When /^I click on the more button$/ do 
	steps %Q{
		Given I click on "more_button.png"	
	}
end


When /^I click on the less button$/ do 
	steps %Q{
		Given I click on "button_less2.png"	
	}
end


When /^I delete story "(.*?)" if exists$/ do |name|
	steps %Q{
		Given I search for story "#{name}" in "Current"
	}
	begin
		if(@screen.exists "bbcnewst.png")
			steps %Q{
				And I rightclick on "bbcnewst.png" and click "context_Menu_Delete_Story.png"
				And I wait for "2" seconds
				And I click on "load_clip_failed_Yes_button.png"
			}
		end
	rescue
	end
end

When /^I set save copy to "(.*?)"$/ do |name|
	if(name.downcase() == "favourites")
		name = "f"
	end
	steps %Q{
		Given I click "40" pixels to the "right" of "save_copy_in.png"
		And I type "#{name}"
		And I use RETURN
	}
end


When /^I close the task dropdown$/ do 
	steps %Q{
		And I click on "open_task_button.png" if exists
	}
end


When /^I delete all saved test stories$/ do 
	steps %Q{
		Given I rightclick on "favourites_ooo.png" if exists
		And I click on "remove_item.png" if exists
		Given I select the Tasks - Stories - Personal Searches
		When I rightclick on "task_oooo.png" if exists
		And I click on "delete_search.png" if exists
		And I click on "button_Yes.png" if exists

		When I rightclick on "task_stories_vvvv.png" if exists
		And I click on "delete_search.png" if exists
		And I click on "button_Yes.png" if exists
		And I close the task dropdown
	}
end