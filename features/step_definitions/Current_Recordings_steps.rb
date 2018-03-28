
Then(/^I select the Tasks - Record Playout - Current Recordings$/) do
	step 'I click on "top_task_button.png"'
	steps %Q{
		And I click on either "task_record_playout.png" or "task_record_playout_b.png"
		And I wait for "1" seconds
		And I use RETURN
		And I click on either "task_current_recording.png" or "task_current_recordings_b.png"
		And I use RETURN
	}
end

Then(/^I should see the current recording dialogue$/) do
	steps %Q{
		And I should see "current_recordings_dialogue.png"
	}
end

Then(/^I close the current recording dialogue$/) do
	steps %Q{
		And I click on "button_Close2.png"
		And I should not see "current_recordings_dialogue.png"
	}
end

Then(/^I select the Tasks - System Monitoring - Resource Monitoring - By Booking - Current Recordings$/) do
	step 'I click on "top_task_button.png"'
	steps %Q{
		And I click on either "task_system_monitoring.png" or "task_system_monitoring_b.png"
		And I wait for "1" seconds
		And I use RETURN
		And I click on either "task_resource_monitoring.png" or "task_resource_monitoring_b.png"
		And I wait for "1" seconds
		And I use RETURN
		And I click on either "task_by_booking.png" or "task_by_booking_b.png"
		And I wait for "1" seconds
		And I use RETURN
	}

	steps %Q{
		And Within region "task_system_monitoring_section.png" click "task_current_recording.png"
	}
end

Then(/^I select the Current Recordings window$/) do

	for x in @screen.findAll "taskbar_current_recordings.png"
		@screen.click x
		sleep 2
		if !@screen.exists "menu_New.png"
			@screen.click x
		end

		if @screen.exists "current_recordings_dialogue.png"
			break
		end
	end

	if !@screen.exists "current_recordings_dialogue.png"

		for x in @screen.findAll "taskbar_current_recordings.png"
			@screen.click x
			sleep 2
			if !@screen.exists "menu_New.png"
				@screen.click x
			end

			if @screen.exists "current_recordings_dialogue.png"
				break
			end
		end
	end

end

Then(/^I should see the recording in the sidebar$/) do
	steps %Q{
		Then I should see "tools_new_recording_item_standby_record-playout.png"
		And I should see "tools_new_recording_item_standby_record-playout_greenarrow.png"
		And I should see the following "recording_Stop_Button.png" with high accuracy "0.65"
	}
end


Then(/^I should see the resource reservation popup$/) do
	steps %Q{
		Then I should see "resource_reservation_dialogue.png"
		And I should see either "resource_reservations_headings.png" or "resource_reservations_headings2.png"
		And I should see either "resource_reservations_results.png" or "resource_reservations_results_ws.png"
	}
end

Then(/^I close the resource reservation popup$/) do

	steps %Q{
		And I click on "resource_reservations_headings_top.png"
		And I use TAB
		And I use RETURN 
	}
	#begin
	#	steps %Q{
	#		And Within region "resource_reservations_headings.png" click "button_Close2.png"
	#	}
	#rescue
	#	steps %Q{
	#		And Within region "resource_reservations_headings2.png" click "button_Close2.png"
	#	}
	#end
end

Then(/^I select the Tasks - Record Playout - Current Playouts$/) do
	step 'I click on "top_task_button.png"'
	steps %Q{
		And I click on either "task_record_playout.png" or "task_record_playout_b.png"
		And I wait for "1" seconds
		And I use RETURN
		And I click on either "task_current_playout.png" or "task_current_playout_b.png"
		And I use RETURN
	}
end

Then(/^I should see the current playout dialogue$/) do
	steps %Q{
		And I should see "current_playout_dialogue.png"
	}
end

Then(/^I close the current playout dialogue$/) do
	steps %Q{
		And I click on "button_Close2.png"
		And I should not see "current_playout_dialogue.png"
	}
end


Then(/^I select the Tasks - System Monitoring - Resource Monitoring - By Booking - Current Playouts$/) do
	step 'I click on "top_task_button.png"'
	steps %Q{
		And I click on either "task_system_monitoring.png" or "task_system_monitoring_b.png"
		And I wait for "1" seconds
		And I use RETURN
		And I click on either "task_resource_monitoring.png" or "task_resource_monitoring_b.png"
		And I wait for "1" seconds
		And I use RETURN
		And I click on either "task_by_booking.png" or "task_by_booking_b.png"
		And I wait for "1" seconds
		And I use RETURN
	}
	steps %Q{
		And Within region "task_system_monitoring_section.png" click "task_current_playout.png"
	}
end


Then(/^I open the current playout dialogue$/) do
	steps %Q{
		Given I select the Tasks - Record Playout - Current Playouts
		Then I should see the current playout dialogue
	}
end


Then(/^I select the Current Playout window$/) do
	if !@screen.exists "current_playout_dialogue.png"
		for x in @screen.findAll "taskbar_current_playout.png"
			@screen.click x
			sleep 2
			if !@screen.exists "menu_New.png"
				@screen.click x
			end

			if @screen.exists "current_playout_dialogue.png"
				break
			end
		end

		if !@screen.exists "current_playout_dialogue.png"

			for x in @screen.findAll "taskbar_current_playout.png"
				@screen.click x
				sleep 2
				if !@screen.exists "menu_New.png"
					@screen.click x
				end

				if @screen.exists "current_playout_dialogue.png"
					break
				end
			end
		end
	end
end


Then(/^I should see the playout in the sidebar$/) do
	steps %Q{
		Then I should see either "playout_sidebar1.png" or "playout_sidebar1_1.png"
		And I should see "playout_sidebar2.png"
	}
end


Then(/^I should see the resource reservation for departure booking popup$/) do
	steps %Q{
		Then I should see "resource_reservation_dialogue1.png"
		And I should see either "resource_reservations_headings1.png" or "resource_reservations_headings1_2.png"
		And I should see either "resource_reservations_results1.png" or "resource_reservations_results2.png"
	}
end

Then(/^I close the resource reservation departure bookingpopup$/) do
	begin
		steps %Q{
			And Within region "resource_reservations_headings1.png" click "button_Close2.png"
		}
	rescue
		steps %Q{
			And Within region "resource_reservations_headings1_2.png" click "button_Close2.png"
		}
	end
end


When(/^I open the side monitor section$/) do
	if !@screen.exists "record_playout_summary.png"
		steps %Q{
			And I click on either "side_monitors.png" or "side_monitors1.png"
		}
	else

	end
	#Given Within region "top_toolbar_region.png" click "side_monitors.png,side_monitors1.png"

	#step 'I click on "side_monitors.png" until "record_playout_summary.png" appears'
end

When(/^I stop any playouts or recordings$/) do
	step 'I click on "recording_Complete_Button2.png" if exists'
	sleep 2
	step 'I click on "recording_Complete_Button2.png" if exists'
	sleep 2
	step 'I click on "recording_Complete_Button2.png" if exists'
end