
Given /^I set the playout possition to play$/ do 
	steps %Q{
		And I click on "create_Departure_Booking_Dropdown_Allocated_To.png"
	}
	if $site == "QA_USA"
		steps %Q{
			And I type "Play"
		}
	elsif $site == "QA_WS"
		steps %Q{
			And I type "WS2020 Play"
		}
	else
		steps %Q{
			And I type "Z1 Play"
		}
	end
end

Given /^I set the playout to "(.*?)"$/ do |location|
	steps %Q{
		And I click on "departure_booking_to.png"
	}

	if((location == "Liya Monitor") or (location == "Liya's Monitor"))
		if $site == "QA_USA"
			steps %Q{
				And I type "Liya Monitor"
			}
		elsif $site == "QA_WS"
			steps %Q{
				And I type "Liya mon"
			}
		else
			steps %Q{
				And I type "Liya's Monitor"
			}
		end
	else
		steps %Q{
			And I type "#{location}"
		}
	end
end

Given /^I should see the departure booking dialogue$/ do 
	steps %Q{
		Then I should see "ScreenTitle_DeparturelBooking.PNG"
	}
end

Given /^I close the departure booking dialogue$/ do 
	steps %Q{
		Then I click on "button_Cancel.png"
	}
end

Given /^I open the departure booking dialogue$/ do 
	steps %Q{
		Given I click on "menu_New.png"	
		And I click on "departure_booking.png"
		Then I should see the departure booking dialogue
	}
end

Given /^I fill out the departure booking form "(.*?)"$/ do |name|
	steps %Q{
		And I set the playout possition to play
		And I set the playout to "Liya's Monitor"
		And I set the departure booking title to "#{name}"
		And I click on "departure_booking_automatic_selection.png"
		And I click "50" pixels to the "right" of "play_out_text.png"
		And I type "Yes (R)"
		And I use TAB
	}
end

Given /^I fill out the departure booking form "(.*?)" with a long duration$/ do |name|
	steps %Q{
		And I use TAB
		And I set the start time to "+1140" and end time to "+1220"
		And I set the playout possition to play
		And I set the playout to "Hardip mon1"
		And I set the departure booking title to "#{name}"
		And I click on "departure_booking_automatic_selection.png"
		And I click "50" pixels to the "right" of "play_out_text.png"
		And I type "Yes (R)"
		And I use TAB
	}
end


Given /^I set the departure booking title to "(.*?)"$/ do |name|
	steps %Q{
		And I click on "create_Departure_Booking_Textbox_Title.png"
		And I type "#{name}"
	}
end

Given /^I set the playout popup position to play$/ do 
	if $site == "QA_USA"
		steps %Q{
			And I type "Play"
		}
	elsif $site == "QA_WS"
		steps %Q{
			And I type "WS2020 Play"
		}
	else
		steps %Q{
			And I type "Z1 Play"
		}
	end
end



Given /^I set the playout popup playout to "(.*?)"$/ do |location|
	steps %Q{
		And I use TAB
	}
	if((location == "Liya Monitor") or (location == "Liya's Monitor"))
		if $site == "QA_USA"
			steps %Q{
				And I type "Liya Monitor"
			}
		elsif $site == "QA_WS"
			steps %Q{
				And I type "Liya mon"
			}
		else
			steps %Q{
				And I type "Liya's Monitor"
			}
		end
	else
		steps %Q{
			And I type "#{location}"
		}
	end
end


Given /^I select the booking "(.*?)"$/ do |item|
	steps %Q{
		When I rightclick on "#{item}"
		And I click on "white_space.png"
	
		And I doubleclick "40" pixels to the "left" of "#{item}"
	}
			#When I doubleclick on "#{item}"

end


Given /^I change the departure booking title to "(.*?)"$/ do |name|
	steps %Q{
		And I click "10" pixels to the "bottom" of "details_title.png"
		And I use CTRL A
		And I type "#{name}"
	}
end



Given /^I cancel all on-time bookings$/ do 
	x = 0
	while x == 0
		steps %Q{
			And I rightclick on "on-time.png" if exists
			And I click on "booking_Departure_Cancel_Booking.png" if exists
			And I click on "button_Search.png" 
		}
		sleep 2
		if(@screen.exists "on-time.png")
			x = 0
		else
			x = 1
		end
	end
end



Given /^I cancel all departure bookings$/ do 
	x = 0
	while x == 0
		begin
			steps %Q{
				And I rightclick on "on-time.png,booking_complete.png"
				And I click on "booking_Departure_Cancel_Booking.png" if exists
				And I click on "button_Search.png" 
			}
		rescue

		end
		sleep 2
		if(@screen.exists "on-time.png")
			x = 0
		else
			if(@screen.exists "booking_complete.png")
				x = 0
			else
				x = 1
			end
		end
		
	end
end