
Given /^I go to the "(.*?)" page$/ do |page|
	sleep 1
	case page.downcase
		when /description/
			no = 1
			begin
				step 'I doubleclick on "description_link.png"'
				step 'I click on "description_link.png" until "media_bar.png" appears'
				sleep 1
				step
			rescue
				if (no < 3)
					step 'I click on "description_link.png" if exists'
					no = no + 1
				end
			end
		when /keyframe/
			step 'I type Shift F6'
			sleep 1
			step 'I type Shift F6'
			sleep 1
		when /properties/
			begin
				steps %Q{
					And I click on "button_continue.png" if exists
				}
				step 'I doubleclick on "qvl_Button_Properties.png"'
				step 'I click on "qvl_Button_Properties.png" if exists'
				sleep 1
			rescue
			end
		when "archive"
			begin
				steps %Q{
					And I click on "MI_Archive_Button.PNG,MI_Archive_Button_selected.PNG" until "locations_editorial.png" appears
				}
			rescue
				steps %Q{
					And I doubleclick on "MI_Archive_Button.PNG,MI_Archive_Button_selected.PNG"
				}
			end
		when "recommendations inbox"

			step 'I click on "top_task_button.png"'

			top = @screen.exists("task_menu_section.png")
			reg = top.below(700)

			if !(reg.exists "task_recommendations.png") and !(reg.exists "task_recommendations_b.png")
				reg.doubleClick "task_archive.png"
			end
			begin
				reg.doubleClick "task_recommendations.png" 
			rescue
				reg.doubleClick "task_recommendations_b.png"
			end

		when "media search result"
			step 'I click on "qvl_Button_Media_Search_Results.png" if exists'
		when /relationship/
			step 'I click on "qvl_Button_Relationships.png" if exists'
		when /rights/
			step 'I type F10'
			step 'I type F10'
			sleep 1
			step 'I type F10'
			step 'I type F10'
		when /caption/
			begin
				steps %Q{
					And I type Shift F9
					Then I should see "captions_page.png"
				}
			rescue
				steps %Q{
					And I type Shift F9
				}
			end
		when "inbox"
			steps %Q{
				And I click on "bbc_top.png"
				When I type F7
				And I type F7
				Then I should see "inbox_top2.png"
				And I click on "white_space2.png"
			}
		when "wastebin"
			steps %Q{
				Given I click on "favourites_wastebin.png"
			}
		else
			fail("Code for this 'go to page' hasnt been entered- #{page}")
	end
end

Given /^I go to the "(.*?)" tab$/ do |page|
	case page.downcase
		when "catalogue"
			step 'I click on "MI_Archive_Catalogue.PNG" if exists'
		when "transcript"
			step 'I click on "MI_Archive_Transcript.PNG" if exists'
		when "general"
			step 'I click on "MI_Description_GeneralTab_Unselected1.png" if exists'
		when "publish existsing item"
			step 'I click on "publish_to_existsing_item.png" if exists'
		when "items"
			step 'I click on "items.png" if exists'
		when "timeline"
			step 'I click on "MI_Rights_TimelineTab.PNG"'
		when "summary"
			step 'I click on "MI_Rights_SummaryTab.png"'
		when "recommendations"
			step 'I click on "recommendations.png" if exists'
		when "sequence"
			step 'I click on "sequence_tab.png" if exists'
		when "shots"
			step 'I click on "shots.png" if exists'
		when "made from"
			step 'I click on "made_from_tab.png" if exists'
		when "used by"
			step 'I click on "used_by_tab.png" if exists'
		when "transmissions"
			step 'I click on "transmissions_tab.png" if exists'
		when "technical"
			step 'I click on "technical_tab.png" if exists'
		when "timeline"
			step 'I click on "timeline_tab.png" if exists'
		when "history"
			step 'I click on "MI_Rights_HistoryTab.PNG" if exists'
		else
			fail("Code for this 'go to tab' hasnt been entered- #{page}")
	end
end

Given /^I open the media search section$/ do
=begin
	if !@screen.exists "search_Media_TitleBar.png"	
		step 'I type F4'
		sleep 1
		if !@screen.exists "search_Media_TitleBar.png"	
			step 'I type F4'
		end
	end
	if !@screen.exists "search_Media_TitleBar.png"	
		step 'I type F4'
		sleep 1
	end
=end
	#x = 0
	#while( (!@screen.exists "media_search.png") && (x < 5) )
	#	step 'I type F4'
	#	sleep 1
	#	x = x + 1
	#end
	if !@screen.exists "favourites_section.png"
		step 'I click on "favourites.png"'
	end
	step 'I click on "favourites_New_Media_Search.png" until "button_New.png" appears'


end

Given /^I open the story search section$/ do
=begin	
	if !@screen.exists "story_search_TitleBar.png"	
		steps %Q{
    		Given I click on "menu_New.png"
    		And I click on "story_search.png"
		}
		sleep 1
		if !@screen.exists "story_search_TitleBar.png"	
			steps %Q{
	    		Given I click on "menu_New.png"
	    		And I click on "story_search.png"
			}
		end
	end
=end

	#if !@screen.exists "favourites_section.png"
	#	step 'I click on "favourites.png"'
	#end
	#step 'I click on "favourites_New_Story_Search.png" until "story_search_TitleBar.png" appears'
	if !@screen.exists "story_search_TitleBar.png"	
		steps %Q{
			Given I click on "menu_New.png"
			And I click on "story_search.png"
		}
	end

end

Given /^I open the new recording dialogue$/ do
	nooftries = 0
	begin
		if !@screen.exists "button_View_booking.png"	
			steps %Q{
	    		Given I click on "menu_New.png"
	    		And I click on "recording.png"
			}

			begin
				steps %Q{
		    		Given I wait for "button_View_booking.png" to appear
				}
			rescue

				steps %Q{
		    		Given I click on "favourites_New_Recording.png"
	    			Then I should see "button_View_booking.png"
				}
				
			end

		end
	rescue
		if(nooftries < 3)
			nooftries = nooftries + 1
			retry
		else
			fail("Unable to open the new recording dialog")
		end
	end
end

Given /^I open the new booking search section$/ do
	if !@screen.exists "booking_search_titlebar.png"	
		steps %Q{
    		And I type Shift F4
		}
		sleep 1
		if !@screen.exists "booking_search_titlebar.png"
			steps %Q{
    			And I type Shift F4
			}
		end
	end
end

Given /^I open the current recording dialogue$/ do
	if !@screen.exists "current_recordings_titlebar.png"	
		steps %Q{
    		Given I click on "top_task_button.png"
		}
		if !@screen.exists "task_current_recording.png"
			steps %Q{
				And I doubleclick on either "record_playout.png" or "record_playout2.png"
			}
		end
		steps %Q{
			And I click on "task_current_recording.png"
		}		
	end
end

Given /^I open the new story dialogue$/ do
	begin
		step 'I click on "favourites_New_Story.png" until "create_story_titlebar.png" appears'
	rescue
		puts "rescueing"
		if !@screen.exists "create_story_titlebar.png"	
			steps %Q{
	    		Given I click on "top_task_button.png"
			}
			if !@screen.exists "task_new_story.png"
				steps %Q{
					And I doubleclick on either "tasks_stories.png" or "tasks_stories2.png"
				}
			end
			steps %Q{
				And I doubleclick on either "task_new_story.png" or "task_new_story_b.png"
			}		
		end
	end
end


Given /^I go to the Rights -> Summary page$/ do
	steps %Q{
		And I go to the "Rights" page
		And I go to the "Summary" tab
	}
end