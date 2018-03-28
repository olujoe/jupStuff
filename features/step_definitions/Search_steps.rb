
Given /^I delete favourites "(.*?)" or "(.*?)"$/ do |image,image2|
	if @screen.exists image
		steps %Q{
			Given I rightclick on "#{image}"
			And I click on "remove_item.png"
			Then I should not see "#{image}"
		}
	end
	if @screen.exists image2
		steps %Q{
			Given I rightclick on "#{image2}"
			And I click on "remove_item.png"
			Then I should not see "#{image2}"
		}
	end
end


Given /^I search for "(.*?)" in "(.*?)"$/ do |search,location|
	tries = 0
	begin
		step 'I open the media search section'
		step 'I wait "1" seconds'
		step 'I close all search options'
		step 'I doubleclick on "button_New.png"'

		if(location == "All Material")
			step 'I click on "search_Media_Checkbox_All_Material.png"'
			step 'I click on "search_Media_Textbox.png"'
			step 'I type "'+search+'"'
		elsif(location == "Current Last 1")
			step 'I click on "search_Media_Checkbox_Current_Unticked.png"'
			step 'I click on "search_Options_Current_Last_1.PNG"'
			step 'I click on "search_Media_Textbox.png"'
			step 'I type "'+search+'"'
		elsif(location == "Current Last 12")
			step 'I click on "search_Media_Checkbox_Current_Unticked.png"'
			step 'I click on "search_Options_Current_Last_12.png"'
			step 'I click on "search_Media_Textbox.png"'
			step 'I type "'+search+'"'
		elsif(location == "Archive Offline")
			step 'I doubleclick on "search_archive_radio_button.png"'
			step 'I click on "offline_radio_button.png"'
			step 'I click on "search_Media_Textbox.png"'
			step 'I type "'+search+'"'
		elsif(location == "Media Item Id")
		    
		    steps %Q{
		    	And I click on "search_Option_More_Link.png" if exists
		    }

		    begin
				step 'I click on "search_Options_Media_Item_Id_Open.png" if exists'
			rescue

			end
		    step 'I click on the media item id textbox'
			step 'I type "'+search+'"'
		else
			raise("This search step hasnt been implemented '#{location}'")
		end

		step 'I click on "button_Search.png"'
	rescue
		if tries < 2
			tries += 1
			retry
		else
			fail "Unable to search for #{search} in #{location} after 2 tries"
		end		
	end	
end


Given /^I click on the media item id textbox$/ do 
	begin 
		step 'I click on "search_Options_Media_Item_Id_Textbox.png"'
	rescue
		step 'I click on "search_Media_More_Search_Options.png" if exists'
		begin
			step 'I click on "search_Options_Media_Item_Id_Open.png" until "search_Options_Media_Item_Id_Textbox.png" appears'
		rescue
		end
		step 'I click on "search_Options_Media_Item_Id_Textbox.png"'
	end
end


Given /^I search for story "(.*?)" in "(.*?)"$/ do |search,location|

	step 'I open the story search section'
	step 'I click on "button_New.png"'

	if(location == "Current")
		if !@screen.exists "story_search_current_selected.png"
			step 'I click on "story_search_current.png"'
		end
	elsif(location == "Future")
		step 'I click on "story_search_future.png"'
	elsif(location == "Past week")
		step 'I click on "story_search_past.png"'
	end

	step 'I click on "search_Story_Search_Textbox.png"'
	step 'I type "'+search+'"'
	step 'I click on "button_Search.png"'

end


Given /^I search for "(.*?)" in "(.*?)" and load "(.*?)" into QVL$/ do |search,location,result|
	steps %Q{
		And I search for "#{search}" in "#{location}"
		And I click on "button_Search.png" until "#{result}" appears'
		And I load asset "#{result}" into QVL
	}
end


Given /^I make a booking search for "(.*?)" in "(.*?)"$/ do |search,location|
	

	if !@screen.exists "create_Arrival_Booking_searchlabel.png"	
		step 'I click on "menu_New.png"'
		step 'I waitAndclick on "menu_Booking_Search.png"'
	end
	step 'I click on "button_New.png"'
	if(location == "Arrivals")
		step 'I click on "create_Arrival_Booking_ArrivalCheckBox.png" if exists'
	elsif(location == "Departures")
		step 'I click on "search_Booking_Arrivals_Checkbox.png" if exists'
		step 'I click on "search_Booking_Departures_Checkbox.png" if exists'
	elsif(location == "Arrivals Now & Next")
		#step 'I click on "create_Arrival_Booking_ArrivalCheckBox.png" if exists'
		step 'I click on "now_and_next.png" if exists'
	elsif(location == "Departures Now & Next")
		step 'I click on "search_Booking_Arrivals_Checkbox.png" if exists'
		step 'I click on "search_Booking_Departures_Checkbox.png" if exists'
		step 'I click on "now_and_next.png" if exists'
	elsif(location == "Departures Today")
		step 'I click on "search_Booking_Arrivals_Checkbox.png" if exists'
		step 'I click on "search_Booking_Departures_Checkbox.png" if exists'
		step 'I click on "today_checkbox.png" if exists'
	elsif(location == "Arrivals Today")
		step 'I click on "create_Arrival_Booking_ArrivalCheckBox.png" if exists'
		step 'I click on "today_checkbox.png" if exists'
	elsif(location == "Arrivals Hidden")
	    steps %Q{
	    	And I click on "search_Option_More_Link_bookings.png" if exists
	    }
	    if !@screen.exists "hidden_checkbox.png"
	    	steps %Q{
	    		And I click on "booking_type.png"
	    	}
	    end
	     steps %Q{
	    	And I click on "hidden_checkbox.png"
	    }
	end
	
	step 'I click on "search_Booking_Textbox.png"'
	step 'I type "'+search+'"'
	#step 'I click on "arrival_Booking_SearchToday.png"'
	step 'I click on "button_Search.png"'

end


Given /^I make a booking search for "(.*?)" in "(.*?)" expecting "(.*?)"$/ do |search,location,result|
	
	if !@screen.exists "create_Arrival_Booking_searchlabel.png"	
		step 'I click on "menu_New.png"'
		step 'I waitAndclick on "menu_Booking_Search.png"'
	end
	step 'I click on "button_New.png"'
	if(location == "Arrivals")
		#step 'I click on "create_Arrival_Booking_ArrivalCheckBox.png" if exists'
	elsif(location == "Departures")
		step 'I click on "search_Booking_Departures_Checkbox.png" if exists'
	elsif(location == "Arrivals Now & Next")
		step 'I click on "now_and_next.png" if exists'
	elsif(location == "Arrivals Today")
		#step 'I click on "create_Arrival_Booking_ArrivalCheckBox.png" if exists'
		step 'I click on "today_checkbox.png" if exists'
	end
	step 'I click on "search_Booking_Textbox.png"'
	step 'I type "'+search+'"'
	step 'I click on "arrival_Booking_SearchToday.png"'
	step 'I click on "button_Search.png" until "'+result+'" appears'
	step 'I should see "'+result+'"'

end


When(/^I search for the read file id in "(.*?)"$/) do |arg1|
	step 'I search for "'+$readfileid+'" in "'+arg1+'"'
end


When(/^I search for the automation media id in "(.*?)"$/) do |arg1|
	step 'I search for "'+$automationfileid+'" in "'+arg1+'"'
end


When(/^I search for the duplicated media item$/) do 
	step 'I search for "'+$automationfileid+'" in "Media Item Id"'
end


When(/^I close all search options$/) do
	timeout = 0
	while @screen.exists "close_searches.png" and timeout < 4
		step 'I click on "close_searches.png"'
		sleep 1
		timeout = timeout + 1
	end
end


When(/^I rightclick on "(.*?)" in the search result section$/) do |name|
	sleep 1
	top = @screen.exists("qvl_and_results_region.png")
	reg = top.below()
	reg.highlight(1)
	reg.exists "#{name}"
	reg.rightClick "#{name}" 
end


When(/^I scroll down the result list until "(.*?)" appears$/) do |arg1|
	begin
		search_region = @screen.exists("search_result_section2.png").below()
	rescue
		search_region = @screen.exists("qvl_and_results_region.png").below()
	end

	#search_region.click("bbc_news_text2.png")
	@screen.click(search_region)

	tries = 0
	while ( (tries < 8) and (!search_region.exists arg1) )
		steps %Q{
			And I use DOWNARROW
			And I use DOWNARROW
			And I use DOWNARROW
			And I use DOWNARROW
			And I use DOWNARROW
			And I use DOWNARROW
		}
		tries = tries + 1
		sleep 0.3
	end
end
