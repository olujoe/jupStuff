
Given(/^I open the arrival booking window$/) do
	tries = 0
	begin
		step 'I click on "menu_New.png"'
		step 'I waitAndclick on "menu_Arrival_Booking.png"'
    	step 'I wait for "ScreenTitle_NewArrivalBooking.png" to appear'
	rescue
		if tries < 3
			tries = tries + 1
			retry
		else
			fail "failed to open the arrival booking screen after 3 tries"
		end
	end
end

Given(/^I open the departure booking window$/) do
	step 'I click on "menu_New.png"'
	step 'I waitAndclick on "menu_Departure_Booking.png"'
    step 'I wait for "create_Departure_Booking_Dropdown_Allocated_To.png" to appear'
end

When(/^I click the cancel button$/) do
	step 'I click on "button_Cancel2.png"'
end

Then(/^the arrival booking window should close$/) do
	step 'I should not see "ScreenTitle_NewArrivalBooking.png"'
end

When(/^I click the close x button$/) do
	step 'I click on "button_Exceptions_Close.png"'
end

When(/^I fill all arrival booking fields except the details field$/) do
	steps %Q{

		And I set all the default arrival booking 1 options
	}

	step 'I click on "details_filled.png"'
	step 'I use CTRL A'
	step 'I use DELETE'

	#step 'I click on "create_Arrival_Booking_Dropdown_Allocated_To.png"'
	#step 'I type "Z1 Record"'
	#step 'I click on "create_Arrival_Booking_Dropdown_From.png"'
	#step 'I type "Freesat2 sync"'
	#step 'I click on "create_Arrival_Booking_Dropdown_Story.png"'
	#step 'I type "rfstory3"'
	#step 'I wait "3" seconds'
	#step 'I click on "arrival_Booking_Primary_Dropdown.png"'
	#step 'I wait "1" seconds'
	#step 'I type "BBC3"'
	##step 'I click on "create_Arrival_Booking_Textbox_Details.png"'
	##step 'I type "rfdetails"'
	#step 'I doubleclick on "create_Arrival_Booking_Textbox_Description.png"'
	#step 'I type "rfdescription"'
    #step 'I click on "create_Arrival_Booking_Dropdown_Quick_Fill.png"'
    #step 'I type "BBC"'
	#step 'I click on "new_Recording_Usage_Restriction.png"'
	#step 'I click on "new_Recording_Usage_Restriction.png"'
	#step 'I type "Testing Rights"'
	
end

When(/^I fill all arrival booking fields$/) do
	steps %Q{
    	When I set the start time to "+310" and end time to "+370"
		And I set all the default arrival booking 1 options
	}
	#step 'I set the start time to "+280" and end time to "+340"'
	#step 'I click on "create_Arrival_Booking_Dropdown_Allocated_To.png"'
	#step 'I type "Z1 Record"'
	#step 'I click on "create_Arrival_Booking_Dropdown_From.png"'
	#step 'I type "Freesat2 sync"'
	#step 'I click on "create_Arrival_Booking_Dropdown_Story.png"'
	#step 'I type "rfstory3"' 
	#step 'I wait "3" seconds'
	#step 'I click on "arrival_Booking_Primary_Dropdown.png"'
	#step 'I wait "1" seconds'
	#step 'I type "BBC3"'
	#step 'I doubleclick on "create_Arrival_Booking_Textbox_Details.png"'
	#step 'I type "rfdetails"'
	#step 'I click on "create_Arrival_Booking_Textbox_Description.png"'
	#step 'I type "rfdescription"'
    #step 'I click on "create_Arrival_Booking_Dropdown_Quick_Fill.png"'
    #step 'I type "BBC"'
	#step 'I click on "new_Recording_Usage_Restriction.png"'
	#step 'I click on "new_Recording_Usage_Restriction.png"'
	#step 'I type "Testing Rights"'
	#step 'I click on "arrival_Booking_Automatic_Selection.png"'
end

When(/^I fill all arrival booking fields except time$/) do 
	steps %Q{
		And I set all the default arrival booking 1 options
	}
	#	desc = "rfdetails"
	#step 'I click on "create_Arrival_Booking_Dropdown_Allocated_To.png"'
	#step 'I type "Z1 Record"'
	#step 'I click on "create_Arrival_Booking_Dropdown_From.png"'
	#step 'I type "Freesat2 sync"'
	#step 'I click on "create_Arrival_Booking_Dropdown_Story.png"'
	#step 'I type "rfstory3"'
	#step 'I wait "3" seconds'
	#step 'I click on "arrival_Booking_Primary_Dropdown.png"'
	#step 'I wait "1" seconds'
	#step 'I type "BBC3"'
	#step 'I doubleclick on "create_Arrival_Booking_Textbox_Details.png"'
	#step 'I type "'+desc+'"'
	#step 'I click on "create_Arrival_Booking_Textbox_Description.png"'
	#step 'I type "rfdescription"'
    #step 'I click on "create_Arrival_Booking_Dropdown_Quick_Fill.png"'
    #step 'I type "BBC"'
	#step 'I click on "new_Recording_Usage_Restriction.png"'
	#step 'I click on "new_Recording_Usage_Restriction.png"'
	#step 'I type "Testing Rights"'
	#step 'I click on "arrival_Booking_Automatic_Selection.png"'
end

Given(/^I set the start time to "(.*?)" and end time to "(.*?)"$/) do |starttime,endtime|

	currentTime = Time.new
	currentTimeOffset = currentTime + "#{starttime}".to_i
	currentTimeOffsetHourString = currentTimeOffset.hour.to_s   
	currentTimeOffsetMinString = currentTimeOffset.min.to_s

	if currentTimeOffsetHourString.length == 1
	  currentTimeOffsetHourString = "0" + currentTimeOffsetHourString
	end

	if currentTimeOffsetMinString.length == 1
	  currentTimeOffsetMinString = "0" + currentTimeOffsetMinString
	end   

	startcurrentTimeOffsetString = currentTimeOffsetHourString + currentTimeOffsetMinString

	if startcurrentTimeOffsetString.length == 3
	  startcurrentTimeOffsetString = "0" + startcurrentTimeOffsetString
	end  

	sleep 1
	@screen.type "#{startcurrentTimeOffsetString}"

	currentTime = Time.new
	currentTimeOffset = currentTime + "#{endtime}".to_i
	currentTimeOffsetHourString = currentTimeOffset.hour.to_s   
	currentTimeOffsetMinString = currentTimeOffset.min.to_s

	if currentTimeOffsetHourString.length == 1
	  currentTimeOffsetHourString = "0" + currentTimeOffsetHourString
	end

	if currentTimeOffsetMinString.length == 1
	  currentTimeOffsetMinString = "0" + currentTimeOffsetMinString
	end   

	startcurrentTimeOffsetString = currentTimeOffsetHourString + currentTimeOffsetMinString

	steps %Q{
		And I click "50" pixels to the "right" of "end.png"
	}
	sleep 1
	@screen.type "#{startcurrentTimeOffsetString}"
end

Given(/^I set the regular interval to 5mins$/) do
	step 'I click on "arrival_Booking_ChunkedRegular.png"'
	step 'I click on "arrival_Booking_Chunked_Interval.png"'
	step 'I click on "arrival_Booking_Chunked_Interval_5.png"'
end

Given /^I change the copyright "(.*?)" to "(.*?)"$/ do |current,final|
	step 'I click on "bbc_news.png"'
	step 'I click on "bbc_news_blue.png"'
	step 'I click on "'+final.downcase.gsub(" ","_")+'.png"'
end


Given /^I ensure that the search section is scrolled to the left$/ do 
	steps %Q{
		And I click on "bbcnewstest2.png" if exists
		And I scroll to the left
		And I scroll to the left
	}
end


Given(/^I stop the recording$/) do
	steps %Q{
		And I click on "recording_Stop_Button.png"
		And I wait "5" seconds
		And I click on "recording_Complete_Button.png"
		And I wait "5" seconds
		Then I should not see "recording_Complete_Button.png"
	}
end

Given(/^I click on the search results section$/) do
	step 'I click on "horizontal_scroll_bar.png"'
end


Then /^I set all the default arrival booking (\d+) options$/ do |number|
	config = getConfigData("bookings")
	data = config['arrivalbooking'+number]
	puts "site = '#{$site}"

	if $site == "QA_WS"
		steps %Q{
			And I click "40" pixels to the "right" of "zone.png"
			And I type "Asia/Kolkata"
		}
	end

	data.each do |key, value|
		case key.downcase
			when "status"
				
			when "record"
				steps %Q{
					And I click "40" pixels to the "right" of "record.png"
					And I type "#{value}"
					And I click on "white_space.png"
				}
			when "allocated_to"
				steps %Q{
					And I click on "create_Arrival_Booking_Dropdown_Allocated_To.png"
					And I type "#{value}"
				}
			when "from"
				steps %Q{
					And I click on "create_Arrival_Booking_Dropdown_From.png"
					And I type "#{value}"
				}
			when "automatic"
				if(value)
					steps %Q{
						And I click on "arrival_Booking_Automatic_Selection.png"
					}
				end
			when "rights"
				steps %Q{
					And I set the rights to "#{value}"
				}
			when "story"
				steps %Q{
					When I click on "create_Arrival_Booking_Dropdown_Story.png"
					And I type "#{value}"
				}
			when "details"
				steps %Q{
					When I doubleclick on "create_Arrival_Booking_Textbox_Details.png"
					And I type "#{value}"
				}
			when "description"
				steps %Q{
					When I click on "create_Arrival_Booking_Textbox_Description.png"
					And I type "#{value}"
				}
			when "copyrights"
				steps %Q{
					When I click on "create_Recording_Dropdown_Copyright.png"
					And I type "#{value}"
				}
			when "primary"
				steps %Q{
					When I click on "arrival_booking_primary_dropdown2.png"
					And I type "#{value}"
					And I click on "white_space.png"
				}
			when "restrictions"
				steps %Q{
					When I click on "new_Recording_Usage_Restriction.png"
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
			when "timezone"
				steps %Q{
					And I click "40" pixels to the "right" of "zone.png"
					And I type "#{value}"
				}
			else
				puts "Config Option (crash recording - #{key}) found with no supporting code"
		end
	end
		
end



Then /^I set all the default departure booking (\d+) options$/ do |number|
	config = getConfigData("bookings")
	data = config['departurebooking'+number]

	data.each do |key, value|
		case key.downcase		
			when "playout"
				steps %Q{
					And I click on "playout_dropdown.png"
					And I type "#{value}"
					And I click on "white_space.png"
				}
			when "allocated_to"
				steps %Q{
					And I click on "create_Departure_Booking_Dropdown_Allocated_To.png"
					And I type "#{value}"
				}
			when "to"
				steps %Q{
					And I click on "create_Departure_Booking_Dropdown_To.png"
					And I type "#{value}"
				}
			when "automatic"
				if(value)
					steps %Q{
						And I click on "departure_booking_automatic_selection.png"
					}
				end
			when "title"
				steps %Q{
					When I click on "create_Departure_Booking_Textbox_Title.png"
					And I type "#{value}"
				}
			#when "timezone"
			#	begin
			#		steps %Q{
			#			When I click on "40" pixels to the "right" of "time_zone.png"
			#			And I type "#{value}"
			#		}
			#	rescue
			#	end
			else
				puts "Config Option (crash recording - #{key}) found with no supporting code"
		end
	end
		
end


Then /^I create an arrival booking$/ do
	steps %Q{
		And I open the arrival booking window
		When I fill all arrival booking fields
		And I click on "button_Ok.png"
		And I click on the search results section
	}
end


Then /^I create an arrival booking if non exists$/ do

	steps %Q{
		And I make a booking search for "" in "Arrivals Today"
		And I wait for "2" seconds
	}

	region = @screen.exists("qvl_and_results_region.png").below()
	if( region.exists "rfdetails.png" )
		#@region.highlight(3)
		#@screen.click(region)


	else
		steps %Q{
			And I open the arrival booking window
			When I fill all arrival booking fields
			And I click on "button_Ok.png"
			And I click on the search results section
		}
	end

end


Then /^I enter the timezone if required$/ do
	if $site == "QA_WS"
		steps %Q{
			And I click "40" pixels to the "right" of "zone.png"
			And I type "Europe/London (daylight savings observed)"
		}
	end

	if $site == "QA_W1"
		steps %Q{
			And I click "40" pixels to the "right" of "zone.png"
			And I type "Europe/London (daylight savings observed)"
		}
	end
end

