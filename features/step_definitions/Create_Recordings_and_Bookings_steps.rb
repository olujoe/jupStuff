
When /^I duplicate an existing media item "(.*?)" times$/ do |number|
	numb = number.to_i
	numb.times do 
		createANewMediaItem()
	end
end

When /^I duplicate an existing media item and load the item to QVL$/ do
	createANewMediaItem()
	nos = 0
	#begin
		step 'I search for "'+$automationfileid+'" in "Media Item Id"'
		step 'I wait "3" seconds'
		step 'I load asset "asset_default_test.png" into QVL'
		step 'I wait "3" seconds'
	#rescue
	#	if(nos < 2)
	#		nos = nos + 1
	#		retry
	#	else
	#		fail("Unable to duplicate and load the item to QVL")
	#	end
	#end
end




When /^I get a finished media item "(.*?)", "(.*?)" and load the item to QVL$/ do |story,details|
	tries = 1
	begin

		createANewMediaItem()

		step 'I search for "'+$automationfileid+'" in "Media Item Id"'
		step 'I wait "3" seconds'
		step 'I load asset "asset_default_test.png" into QVL'
		step 'I wait "3" seconds'

		renameMediaItem($automationfileid,story,details)
		makeMediaItemFinished($automationfileid)

=begin
		steps %Q{
			And I duplicate an existing media item and load the item to QVL
			And I go to the "Description" page
			And I click on "qvl_Component_GeneralTab.png"
		    And I wait for "MI_story.png" to appear
		    And I click "20" pixels to the "right" of "MI_story.png"
		    And I use CTRL A
		    And I use BACKSPACE "12" times
		    And I type "auto"
		    And I click "40" pixels to the "right" of "MI_details2.png"
		    And I use CTRL A
		    And I use BACKSPACE "12" times
		    And I type "recording"
		    And I use DELETE "12" times
		    And I wait for "2" seconds 
		    And I doubleclick on "qvl_Component_Button_Save.png"
		    And I click on "button_Search.png"
		    And I wait for "3" seconds
		}
=end
	rescue

		if tries < 2
			steps "Given I ensure Jupiter is ready for testing"
			tries = tries + 1
			retry
		else
			fail "Unable to create a new item and rename it"
		end
	end

end



When /^I get a finished media item "(.*?)", "(.*?)"$/ do |story,details|
	tries = 1
	begin

		createANewMediaItem()

		step 'I wait "3" seconds'

		renameMediaItem($automationfileid,story,details)
		makeMediaItemFinished($automationfileid)

	rescue

		if tries < 2
			steps "Given I ensure Jupiter is ready for testing"
			tries = tries + 1
			retry
		else
			fail "Unable to create a new item and rename it"
		end
	end

end


When /^I get an unfinished media item "(.*?)", "(.*?)"$/ do |story,details|
	tries = 1
	begin

		createANewMediaItem()
		renameMediaItem($automationfileid,story,details)
		
	rescue

		if tries < 2
			steps "Given I ensure Jupiter is ready for testing"
			tries = tries + 1
			retry
		else
			fail "Unable to create a new item and rename it"
		end
	end

end


When /^I make the media item finished$/ do 
	makeMediaItemFinished($automationfileid)
end


When /^I get an unfinished media item "(.*?)", "(.*?)" and load the item to QVL$/ do |story,details|
	tries = 1
	begin

		createANewMediaItem()

		step 'I search for "'+$automationfileid+'" in "Media Item Id"'
		step 'I wait "3" seconds'
		step 'I load asset "asset_default_test.png" into QVL'
		step 'I wait "3" seconds'

		renameMediaItem($automationfileid,story,details)
		
	rescue

		if tries < 2
			steps "Given I ensure Jupiter is ready for testing"
			tries = tries + 1
			retry
		else
			fail "Unable to create a new item and rename it"
		end
	end

end


When /^I duplicate an existing media item, rename it and load the item to QVL$/ do
	tries = 1
	begin
		steps %Q{
			And I duplicate an existing media item and load the item to QVL
			And I go to the "Description" page
			And I click on "qvl_Component_GeneralTab.png"
		    And I wait for "MI_story.png" to appear
		    And I click "20" pixels to the "right" of "MI_story.png"
		    And I use CTRL A
		    And I use BACKSPACE "12" times
		    And I type "auto"
		    And I wait for "2" seconds 
		    And I click "40" pixels to the "right" of "MI_details2.png"
		    And I use CTRL A
		    And I use BACKSPACE "12" times
		    And I type "recording"
		    And I use DELETE "12" times
		    And I wait for "2" seconds 
		    And I doubleclick on "qvl_Component_Button_Save.png"
		    And I click on "button_Search.png"
		    And I wait for "3" seconds
		}
	rescue

		if tries < 2
			steps "Given I ensure Jupiter is ready for testing"
			tries = tries + 1
			retry
		else
			fail "Unable to create a new item and rename it"
		end
	end

end


When /^I search for the duplicated media item and load the item to QVL$/ do
	step 'I search for "'+$automationfileid+'" in "Media Item Id"'
	step 'I load asset "asset_default_test.png" into QVL'
	step 'I wait "3" seconds'
end

When /^I create a new media item and load the item to QVL$/ do
	steps %Q{	
		Given I create a recording for story "auto", details "decsription", rights "BBC News", duration "9" 
	    And I open the cliplist
	    And I rightclick on the cliplists "asset_auto_description.png" item
	    And I click on "rightclick_copy.png"
	    When I click on "shortcut.png"
	    And I wait "3" seconds
	    And I save the automation edit item id
	    And I should close all side panel windows
	    When I search for the automation media id in "Media Item Id"
	    And I load asset "asset_auto_description.png" into QVL
	}
end


Then /^I should create a chunked arrival booking$/ do 

	steps %Q{
		Given I open the arrival booking window
	    When I set the start time to "+180" and end time to "+540"
	    And I set all the default arrival booking 2 options
	}


	#step 'I click on "menu_New.png"'
	#step 'I waitAndclick on "menu_Arrival_Booking.png"'
    #step 'I wait for "ScreenTitle_NewArrivalBooking.png" to appear'
	#step 'I set the current time plus "140" seconds'
	#step 'I type time'
	#step 'I use TAB'
	#step 'I use TAB'
	#step 'I set the current time plus "500" seconds'
	#step 'I type time'
	#step 'I wait "1" seconds'
	#step 'I click on "create_Arrival_Booking_Dropdown_Allocated_To.png"'
	#step 'I type "Z1 Record"'
	#step 'I wait "1" seconds'
	#step 'I click on "create_Arrival_Booking_Dropdown_From.png"'
	#step 'I wait "1" seconds'
	#step 'I type "Freesat2 sync"'
	#step 'I wait "1" seconds'
	#step 'I click on "arrival_booking_primary_dropdown2.png"'
	#step 'I wait "2" seconds'
	#step 'I type "News"'
	#step 'I wait "2" seconds'
	#step 'I doubleclick on "create_Arrival_Booking_Dropdown_Story.png"'
	#step 'I wait "1" seconds'
	#step 'I type "rfstory3"'
	#step 'I wait "1" seconds'
	#step 'I click on "create_Arrival_Booking_Textbox_Details.png"'
	#step 'I type "ArrivalBookingChunked"'
	#step 'I click on "create_Arrival_Booking_Textbox_Description.png"'
	#step 'I type "ArrivalBookingChunkedDescription"'
    #step 'I click on "create_Arrival_Booking_Dropdown_Quick_Fill.png"'
    #step 'I type "BBC"'
	#step 'I doubleclick on "arrival_Booking_Automatic_Selection.png"'
	step 'I click on "arrival_Booking_ChunkedBtn.png"'
	step 'I wait "1" seconds'
	step 'I click on "button_yes2.png" if exists'
	step 'I wait "1" seconds'
	step 'I click on "arrival_Booking_ChunkedIrregular.png" until "arrival_Booking_ChunkedAssetRowOne.png" appears'
	step 'I rightclick on "arrival_Booking_ChunkedAssetRowOne.png" and click "arrival_Booking_ChunkedAssetRowOneSplit.png"'
	step 'I wait "1" seconds'
	step 'I rightclick on "arrival_Booking_ChunkedAssetRowOne.png" and click "arrival_Booking_ChunkedAssetRowOneSplit.png"'
	step 'I wait "1" seconds'
	step 'I rightclick on "arrival_Booking_ChunkedAssetRowOne.png" and click "arrival_Booking_ChunkedAssetRowOneSplit.png"'
	step 'I click on "arrival_Booking_ChunkedOkBtn.png"'
	step 'I click on "button_Ok.png"'
	step 'I wait "1" seconds'
	step 'I click on "button_yes2.png" if exists'
	step 'I wait "1" seconds'
    step 'I wait for "ScreenTitle_NewArrivalBooking.png" to disappear'
    step 'I should not see "ScreenTitle_NewArrivalBooking.png"'

end


Given /^I create a recording for story "(.*?)", details "(.*?)", rights "(.*?)", duration "(.*?)"$/ do |story,details,rights,duration|

	step 'I open the new recording dialogue'
	step 'I set all the default crash recording 1 options'
	step 'I click on "create_Recording_Dropdown_Story.png"'
	step 'I use CTRL A'
	step 'I use DELETE'
	step 'I type "'+story+'"'
	#step 'I wait "2" seconds'
	#step 'I click on "new_Recording_Dropdown_Outlet.png"'
	#step 'I type "BBC3"'
	step 'I click "20" pixels to the "bottom" of "details.png"'
	step 'I use CTRL A'
	step 'I use DELETE'
	step 'I type "'+details+'"'
	#step 'I click on "create_Recording_Rights_Dropdown.png"'
	#step 'I type "'+rights+'"'
	step 'I click on "create_Recording_Dropdown_Copyright.png"'
	step 'I use CTRL A'
	step 'I use DELETE'
	step 'I type "'+rights+'"'
	#step 'I click on "create_Recording_Textbox_Description.png"'
	#step 'I type "Testing"'
	#step 'I set the rights to "green"'

	#step 'I click on "new_Recording_Usage_Restriction.png"'
	#step 'I type "Testing Rights"'
	#step 'I select the add to cliplist checkbox'
	#step 'I set the record from to "Freesat2 sync"'

	step 'I click on "button_Record.png"'
	step 'I click on "button_Yes.png" if exists'
	#step 'I change the resource if the resource error exist'
	step 'I should not see "button_Record.png"'
	step 'I wait "'+duration+'" seconds'
	step 'I click on "recording_Stop_Button.png"'
	step 'I wait "5" seconds'
	step 'I click on "recording_Complete_Button.png"'
	step 'I wait "5" seconds'
	step 'I should not see "recording_Complete_Button.png"'

end


Given /^I start a crash recording$/ do
	steps %Q{
		And I open the new recording dialogue
		And I set all the default crash recording 1 options
		And I click on "button_Record.png"
		And I click on "button_Yes.png" if exists
	}
end


Given /^I start a new crash recording$/ do
	steps %Q{
		And I open the new recording dialogue
		And I set all the default crash recording 2 options
		And I click on "button_Record.png"
		And I click on "button_Yes.png" if exists
	}
end

=begin
Given /^I start a new crash recording 3$/ do
	steps %Q{
		And I open the new recording dialogue
		And I set all the default crash recording 3 options
		And I click on "button_Record.png"
		And I click on "button_Yes.png" if exists
	}
end

Given /^I start a new crash recording 4$/ do
	steps %Q{
		And I open the new recording dialogue
		And I set all the default crash recording 4 options
		And I click on "button_Record.png"
		And I click on "button_Yes.png" if exists
	}
end

Given /^I start a new crash recording 5$/ do
	steps %Q{
		And I open the new recording dialogue
		And I set all the default crash recording 5 options
		And I click on "button_Record.png"
		And I click on "button_Yes.png" if exists
	}
end

Given /^I start a new crash recording 6$/ do
	steps %Q{
		And I open the new recording dialogue
		And I set all the default crash recording 6 options
		And I click on "button_Record.png"
		And I click on "button_Yes.png" if exists
	}
end
=end

Given /^I start a new crash recording (.*?)$/ do |num|
	steps %Q{
		And I open the new recording dialogue
		And I set all the default crash recording #{num} options
		And I click on "button_Record.png"
		And I click on "button_Yes.png" if exists
	}
end


Given /^I create a recording for story "(.*?)", details "(.*?)", rights "(.*?)", duration "(.*?)" if "(.*?)" does not exist$/ do |story,details,rights,duration,result|
	if !@screen.exists result
		step 'I create a recording for story "'+story+'", details "'+details+'", rights "'+rights+'", duration "'+duration+'"'
	end
end

Then /^a chunked booking should be created if one doesnt exist$/ do 
	if @screen.exists "arrival_Booking_ChunkedBookingComplete.png"
	else
		step "I should create a chunked arrival booking"
		step 'I wait "600" seconds'
	end
end

Then /^I should create a recording for story "(.*?)", details "(.*?)", rights "(.*?)", duration "(.*?)" if "(.*?)" doesnt exist$/ do |story,details,rights,duration,asset|
	if !@screen.exists asset
		puts "It does not exist"
		step 'I create a recording for story "'+story+'", details "'+details+'", rights "'+rights+'", duration "'+duration+'"'
	end
end


Given /^I delete all completed and failed bookings$/ do
	begin
		while @screen.exists "arrival_Booking_ChunkedBookingComplete.png", 10	
			step 'I rightclick on "arrival_Booking_ChunkedBookingComplete.png" and click "booking_Departure_Cancel_Booking.png"'
			step 'I click on "button_Search.png"'
			sleep 3
		end
	rescue
	end
end


Given /^I delete all failed bookings$/ do
	begin
		while @screen.exists "arrival_Booking_ChunkedBookingComplete.png", 10	
			step 'I rightclick on "arrival_Booking_ChunkedBookingComplete.png" and click "booking_Departure_Cancel_Booking.png"'
			step 'I click on "button_Search.png"'
			sleep 3
		end
	rescue
	end
end

Then /^I create a chunked crash recording$/ do 
	
	steps %Q{
		When I open the new recording dialogue
		And I set all the default crash recording 1 options
		And I click on "button_Record.png"
		And I click on "button_Yes.png" if exists 
		When I wait "1" seconds
		And I click on "button_Yes.png" if exists
		Then I should not see "button_Record.png"
		
		When I wait "7" seconds
		And I rightclick on "recording_window.png" and click "recording_chunk.png"
		And I click on the OK button
		
		And I wait "3" seconds
		And I rightclick on "recording_window.png" and click "recording_chunk.png"
		And I click on the OK button

		And I wait "2" seconds
		And I click on "recording_Stop_Button.png"
		And I wait "4" seconds
		And I click on "recording_Complete_Button.png"
		And I wait "7" seconds
		Then I should not see "recording_Complete_Button.png"
	}

end

Then /^I set the record from to "(.*?)"$/ do |text|
	steps %Q{
		And I click on "record_from.png"
		And I use DELETE
		And I type "#{text}"
		And I use TAB
	}
end

Then /^I should see the outlook pop up if exists$/ do
	begin
		steps %Q{
			Then I should see "outlook_popup.png"
		}
	rescue

	end
end

Then /^I set all the default crash recording (\d+) options$/ do |number|
	config = getConfigData("recording")
	#puts config[0]
	data = config['crashrecording'+number]

	data.each do |key, value|
		case key.downcase
			when "outlet"
				begin
					steps %Q{
						And I click on either "new_Recording_Dropdown_Outlet.png" or "new_Recording_Dropdown_Outlet2.png"
						And I type "#{value}"
						And I click on "white_space.png"
					}
				rescue
					steps %Q{
						And I type "#{value}"
						And I click on "white_space.png"
					}

				end
			when "status"
				if(value.downcase() == "raw")
					steps %Q{
						And I click on "status_raw.png"
					}
				end
			when "category"
				if(value.downcase() == "recording")
					steps %Q{
						And I click on "recording_new.png"
					}
				end
			when "position"
				steps %Q{
					And I click "20" pixels to the "bottom" of "record_position.png"
					And I type "#{value}"
					And I click on "white_space.png"
				}
			when "record_from"
				steps %Q{
					And I set the record from to "#{value}"
				}
			when "rights"
				puts getCurrentTime()
				steps %Q{
					And I set the traffic light rights to "#{value}"
				}
				puts getCurrentTime()
			when "story"
				steps %Q{
					When I click on "create_Recording_Dropdown_Story.png"
					And I type "#{value}"
				}
			when "details"
				steps %Q{
					When I doubleclick on "create_Recording_Textbox_Details.png"
					And I type "#{value}"
				}
			when "description"
				steps %Q{
					When I click on "create_Recording_Textbox_Description.png"
					And I type "#{value}"
				}
			when "copyrights"
				steps %Q{
					When I click on "create_Recording_Dropdown_Copyright.png"
					And I type "#{value}"
				}
			when "restrictions"
				steps %Q{
					When I click on "new_Recording_Usage_Restriction.png"
					And I use CTRL A
					And I use DELETE
					And I type "#{value}"
				}
			when "quickfill"
				steps %Q{
					And I click "20" pixels to the "bottom" of "rights_quick_fill.png"
					And I wait for "1" seconds
					And I use CTRL A
					And I use CTRL A
					And I use DELETE
					And I type "#{value}"					
				}
			when "archive"
				if(value == "Yes")
					steps %Q{
						And I click on "search_archive_radio_button.png" until "archive_ticked2.png" appears
					}
				end
			when "agency"
				if(value == "Yes")
					steps %Q{
						And I click on "search_archive_radio_button.png" until "archive_ticked2.png" appears
					}
				end
			when "cliplist"
				if(value == "Yes")
					steps %Q{
						And I select the add to cliplist checkbox
					}
				end
			when "sidebar"
			when "wip"

			else
				puts "Config Option (crash recording - #{key}) found with no supporting code"
		end
	end
		
end


Then /^I stop all recordings and reset jupiter$/ do

	steps %Q{
		And I click on "recording_Stop_Button.png" if exists
		And I wait "4" seconds
		And I click on "recording_Complete_Button.png" if exists
		And I wait "1" seconds
		And I should close all side panel windows
	}
	
end

