
Then(/^I click on New -> Recording$/) do 
	steps %Q{
		And I click on "menu_New.png"
		And I waitAndclick on "recording.png"
    	And I wait for "tools_new_recording_item.png" to appear
	}
end


Then(/^I select the Tasks - Record Playout - New Recordings$/) do
	steps %Q{
		And I click on "top_task_button.png"
		And I click on either "task_record_playout.png" or "task_record_playout_b.png"
		And I wait for "1" seconds
		And I use RETURN
		And I click on either "task_new_recording.png" or "task_new_recording_b.png"
	}
end

Then(/^I should see the new recording dialogue$/) do 
	steps %Q{
    	And I should see "tools_new_recording_item.png"
	}
end

Then(/^I close the new recording dialogue$/) do 
	steps %Q{
    	And I click on "button_Cancel.png"
		And I should not see "tools_new_recording_item.png"
	}
end


Then(/^I fill the story and details arrival booking fields$/) do 
	
	steps %Q{		
		When I click on "create_Arrival_Booking_Dropdown_Story.png"
		And I type "auto"
		When I doubleclick on "create_Arrival_Booking_Textbox_Details.png"
		And I type "rec"
	}
end


Then(/^I create a standby recording$/) do 
	steps %Q{	
		Given I open the new recording dialogue
		When I set all the default crash recording 1 options
		And I click the standby button
		Then I should see "tools_new_recording_item_standby_record-playout_end.png" soon
	}
end


Then(/^I should see the hidden recording$/) do 
	steps %Q{	
		Then I should see "recording2.png"
		Then I should see "auto3.png"
		Then I should see "recording_red.png"
	}
end

Then /^I stop all recordings and check the state$/ do
	begin
		steps %Q{
			And I click on "recording_Stop_Button.png" if exists
			And I wait "4" seconds
			And I should see "ready_to_record.png"
			And I click on "recording_Complete_Button.png" if exists
			And I wait "1" seconds
		}
	rescue
	end
	
end


Then(/^I abort the clip and choose to keep the media item$/) do 
	sleep 2
	steps %Q{	
		When I rightclick on "tools_new_recording_item_standby_record-playout_greenarrow.png"
	}
	begin
		steps %Q{
			And I click on "rcm_stop.png"
			And I click on "abort.png"
			And I click on "button_Yes.png"
		}
	rescue
		steps %Q{	
			When I rightclick on "tools_new_recording_item_standby_record-playout_greenarrow.png"
			And I click on "rcm_stop.png"
			And I click on "abort.png"
			And I click on "button_Yes.png"
		}
	end
end

Then(/^I abort the clip and choose not to keep the media item$/) do 
	sleep 4
	steps %Q{	
		When I rightclick on "tools_new_recording_item_standby_record-playout_greenarrow.png"
	}
	begin
		steps %Q{
			And I click on "rcm_stop.png"
			And I click on "abort.png"
			And I click on "button_no.png"
		}
	rescue
		steps %Q{	
			When I rightclick on "tools_new_recording_item_standby_record-playout_greenarrow.png"
			And I click on "rcm_stop.png"
			And I click on "abort.png"
			And I click on "button_no.png"
		}
	end
end


Then /^I stop all recordings and playouts$/ do
	begin
		timeout = 0
		while @screen.exists "recording_Stop_Button.png" and timeout < 4
			steps %Q{
				And I click on "recording_Stop_Button.png" if exists
				And I wait "3" seconds
				And I click on "recording_Complete_Button.png" if exists
				And I wait "1" seconds
			}
			timeout = timeout + 1
		end

		timeout = 0
		while @screen.exists "recording_Complete_Button.png" and timeout < 4
			steps %Q{
				And I click on "recording_Complete_Button.png" if exists
				And I wait "1" seconds
			}
			timeout = timeout + 1
		end
	rescue
	end
	
end

When(/^I open the side monitors$/) do
	step 'I click on "side_monitors.png,side_monitors2.png" until "record_playout_summary.png,record_playout_summary2.png,record_playout_summary3.png" appears'
end
