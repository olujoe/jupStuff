
Given /^I should delete all "(.*?)" data$/ do |bitmap|
	begin
		if @screen.exists "#{bitmap}"
			step 'I click on "'+bitmap+'"'
			step 'I use CTRL A'
			@screen.rightClick "selected_items.png"
			step 'I click on "delete.png"'
			step 'I delete online'
			step 'I click on "button_Ok4.png" if exists'
		end
	rescue
	end
end


When /^I delete all "(.*?)" result found$/ do |item|
	times = 0
	begin
		while (@screen.exists "#{item}") and (times < 6)
		    step 'I rightclick on "'+item+'" and click "delete.png"'
		    step 'I delete online'
			step 'I click on "button_Search.png"'
		    sleep 3
		    times = times + 2
		end
	rescue
	end
end




When /^I delete the recommendations "(.*?)" folder if exists$/ do |item|
	begin
		steps %Q{
			Given I rightclick on "#{item}"
		    And I click on "qvl_Keyframe_Delete.png"
		    And I click on "button_Yes.png,button_yes2.png"
		    And I wait for "2" seconds
		    And I use RETURN
			Then I should not see "#{item}"
		}
	rescue
		steps %Q{
		    And I click on "button_Cancel7.png" if exists
		}
	end
end


When /^I delete online$/ do
    step 'I wait for "qvl_DeleteOnline_window.png" to appear'
	step 'Within region "delete_item_popup_top.png" click "delete_online_checkbox.png"'
	step 'I click on "button_delete.png"'
	step 'I click on "button_Ok4.png"'
	sleep (3)
	step 'I click on "button_Ok2.png" if exists'
	step 'I click on "button_Ok4.png" if exists'
	begin
		if @screen.exists "jupiter_delete_popup.png"
			@screen.click "jupiter_delete_popup.png"
			step 'I use RETURN'
		end
	rescue
	end
end

When /^I delete placeholder$/ do
    step 'I wait for "qvl_DeleteOnline_window.png" to appear'
	step 'Within region "delete_item_popup_top.png" click "placeholder_checkbox.png"'
	#step 'I click on "placeholder_checkbox.png"'
	step 'I click on "button_delete.png"'
	step 'I click on "button_Ok4.png"'
	sleep (3)
	step 'I click on "button_Ok4.png" if exists'
	begin
		if @screen.exists "jupiter_delete_popup.png"
			@screen.click "jupiter_delete_popup.png"
			step 'I use RETURN'
		end
	rescue
	end
end


When /^I delete shelf$/ do
    step 'I wait for "qvl_DeleteOnline_window.png" to appear'
	step 'Within region "delete_item_popup_top.png" click "archive_Search_Checkbox_Shelf.png,archive_Search_Checkbox_Shelf2.png"'
	#step 'I click on "archive_Search_Checkbox_Shelf.png"'
	step 'I click on "button_delete.png"'
	step 'I click on "button_Ok4.png"'
	sleep (3)
	step 'I click on "button_Ok2.png" if exists'
	step 'I click on "button_Ok4.png" if exists'
	begin
		if @screen.exists "jupiter_delete_popup.png"
			@screen.click "jupiter_delete_popup.png"
			step 'I use RETURN'
		end
	rescue
	end
end


When /^I delete offline$/ do
	steps %Q{
		And I click on "immediate_delete.png"
		And I enter "test" in the delete reason section
		And I click on "button_delete.png"
		And I click on "tools_new_recording_item_warning_yes.png"
		And I click on "button_Ok4.png"
	}
end

When /^I delete online and shelf$/ do
    step 'I wait for "qvl_DeleteOnline_window.png" to appear'
	step 'Within region "delete_item_popup_top.png" click "archive_Search_Checkbox_Shelf.png"'
	step 'Within region "delete_item_popup_top.png" click "delete_online_checkbox.png,delete_online_checkbox2.png"'
	#step 'I click on "archive_Search_Checkbox_Shelf.png"'
	#step 'I click on "delete_online_checkbox.png"'
	step 'I click on "button_delete.png"'
	step 'I click on "button_Ok4.png"'
	sleep (1)
	step 'I click on "button_Ok4.png" if exists'
	begin
		if @screen.exists "jupiter_delete_popup.png"
			@screen.click "jupiter_delete_popup.png"
			step 'I use RETURN'
		end
	rescue
	end
end


When(/^I empty the side monitors$/) do
	step 'I click on "side_monitors.png,side_monitors2.png" until "record_playout_summary.png,record_playout_summary2.png,record_playout_summary3.png" appears'
	step 'I click on "recording_Stop_Button.png" if exists'
	step 'I click on "recording_Complete_Button.png" if exists'
end


Given /^I go to the keyframes page and delete all system data$/ do
	tries = 0
	begin
		step 'I go to the "keyframes" page'
		bitmap = "system_generated_keyframe.png"
		bitmap2 = "system_generated_keyframe_blue.png"
		limit = 1
		
		while @screen.exists bitmap and limit < 9

		    step 'I click on "'+bitmap+'"'
		    step 'I click on "qvl_Component_Button_Delete.PNG"'		    
		    step 'I click on "button_Ok.png" if exists'
		    step 'I use RETURN'
		    step 'I wait for "'+bitmap2+'" to disappear'
		    limit = limit + 1

		end
		
		limit = 1
		while @screen.exists bitmap2 and limit < 3

		    step 'I click on "'+bitmap2+'"'
		    step 'I click on "qvl_Component_Button_Delete.PNG"'
		    step 'I click on "button_Ok.png" if exists'
		    step 'I use RETURN'
		    step 'I wait for "'+bitmap2+'" to disappear'
		    limit = limit + 1

		end
		#steps %Q{
    	#	And I delete all keyframes
    	#}
	rescue
		if tries < 3
			retry 
		else
			tries = tries + 1
		end
	end
	
end



Given /^I delete all system data$/ do
	begin
		bitmap = "system_generated_keyframe.png"
		bitmap2 = "system_generated_keyframe_blue.png"
		limit = 1
		
		while @screen.exists bitmap and limit < 9
		    
		    if @screen.exists "button_Ok.png"
		    	@screen.click "button_Ok.png"
		    end
		    step 'I click on "'+bitmap+'"'
		    step 'I click on "qvl_Component_Button_Delete.PNG"'		    
		    if @screen.exists "button_Ok.png"
		    	@screen.click "button_Ok.png"
		    end
		    step 'I wait for "'+bitmap2+'" to disappear'
		    limit = limit + 1

		end
		
		limit = 1
		while @screen.exists bitmap2 and limit < 3
		    
		    if @screen.exists "button_Ok.png"
		    	@screen.click "button_Ok.png"
		    end
		    step 'I click on "'+bitmap2+'"'
		    step 'I click on "qvl_Component_Button_Delete.PNG"'
		    if @screen.exists "button_Ok.png"
		    	@screen.click "button_Ok.png"
		    end
		    step 'I wait for "'+bitmap2+'" to disappear'
		    limit = limit + 1

		end

	rescue
	end
	
end
