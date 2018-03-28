
Given /^I set the rights to "(.*?)"$/ do |bitmap|

	retries = 0
	begin
		step 'I click on either "rights_quickfill3.png" or "rights_quickfill2.png"'
		case bitmap.downcase
			when /red/
				if $site == "QA_W1"
					step 'I click on "rights_dropdown_disney.png"'
				else
					step 'I click on "none-library_tape.png"'
				end
			when /amber/
				if $site == "QA_W1"
					step 'I click on "bbc_sport_dropdown.png"'
				else
					step 'I click on "a_library_tape.png"'
				end
			when /green/
				step 'I click on "bbc_news_dropdown.png"'
			else
				fail("Code for this rights colour hasnt been entered- #{item}")
		end
	rescue
		retries = retries + 1
		if(retries < 2)
			step 'I click on "new_Recording_Usage_Restriction.png"'
			retry
		end
	end

end


Given /^I set the traffic light rights to "(.*?)"$/ do |item|
	if $site == "QA_USA"
		steps %Q{
			And I set the traffic light rights to "#{item}" using the image
		}
	else
		#begin
		#	step 'I click on either "rights_quickfill.png" or "rights_quickfill2.png"'
		#	case item.downcase
		#		when "red"
		#			step 'I click on "rights_dropdown_disney.png" with noHighlight'
		#		when "amber"
		#			step 'I click on "rights_dropdown_bbc_sports.png" with noHighlight'
		#		when "green"
		#			step 'I click on "rights_dropdown_bbc_news.png" with noHighlight'
		#		else
		#			fail("Code for this rights colour hasnt been entered- #{item}")
		#	end
		#rescue
			steps %Q{
				And I set the traffic light rights to "#{item}" using the image
			}
		#end
	end
end


Given /^I set the traffic light rights to "(.*?)" using the image$/ do |item|
	region =""
	case item.downcase
		when "red"
			img = "rights_r.png"
		when "amber"
			img = "rights_a.png"
		when "green"
			img = "rights_g.png"
		else
			fail("Code for this rights colour hasnt been entered- #{item}")
	end

	begin
		region = @screen.find("qvl_Component_RightsTab_Rights_RED.PNG")
	rescue
		begin
			region = @screen.find("qvl_Component_RightsTab_Rights_AMBER.PNG")
		rescue
			begin
				region = @screen.find("qvl_Component_RightsTab_Rights_GREEN.PNG")
			rescue
				begin
					puts "rights1"
					region = @screen.find("qvl_Component_RightsTab_Rights.PNG")
				rescue
					puts "rights2"
					region = @screen.find("qvl_Component_RightsTab_Rights2.PNG")
				end
			end
		end
	end

	i=1
	while( (i < 6) and (!region.exists(img)) )
		region.click(0,0)
		i = i + 1
		sleep 1
	end

	if( !@screen.exists "new_recorded_item_titlebar.png" )

		steps %Q{
			And I use TAB
			And I type "Testing"
		}
		
		if( @screen.exists "empty_quickfill.png" )
			@screen.click "empty_quickfill.png"
			steps %Q{
				And I type "Testing"
			}
		end
		
		if( @screen.exists "empty_copyrights.png" )
			@screen.click "empty_copyrights.png"
			steps %Q{
				And I type "BBC News"
			}
		end
		
		if( @screen.exists "new_Recording_Usage_Restriction.png" )
			@screen.click "new_Recording_Usage_Restriction.png"
			steps %Q{
				And I type "Testing"
			}
		end

	end

end


Given /^I change the rights to "(.*?)"$/ do |bitmap|

	retries = 0
	begin
		step 'I click on either "rights_quickfill.png" or "rights_quickfill2.png"'
		case bitmap.downcase
			when /red/
				if $site == "QA_W1"
					step 'I click on "rights_dropdown_disney.png"'
				else
					step 'I click on "none-library_tape.png"'
				end
			when /amber/
				if $site == "QA_W1"
					step 'I click on "bbc_sport_dropdown.png"'
				else
					step 'I click on "a_library_tape.png"'
				end
			when /green/
				step 'I click on "rights_dropdown_bbc_news.png" with noHighlight'
			else
				fail("Code for this rights colour hasnt been entered- #{item}")
		end
	rescue
		retries = retries + 1
		if(retries < 2)
			step 'I click on "new_Recording_Usage_Restriction.png"'
			retry
		end
	end

end


When(/^I change the items default right to "(.*?)"$/) do |rights|
	steps %Q{
		When I click on "button_edit_item_default_right.png"
		And I set the traffic light rights to "#{rights}"
		And I click on "button_Ok.png"
	}

		#And I search for "regression" in "Current Last 1" and load "asset_rf70_regression.png" into QVL
		#And I click on "qvl_Button_Rights.png"
end

When(/^I restrict an item to "(.*?)"$/) do |rights|
	steps %Q{	
		And I click on "button_restrict_item.png"
	}

	if(rights == "red")
		steps %Q{
			And I set the rights to "qvl_Component_RightsTab_Rights_RED.PNG"
			And I use TAB
			And I type "Red Restriction"
		}
	end
		
	if(rights == "green")
		steps %Q{
			And I set the rights to "qvl_Component_RightsTab_Rights_GREEN.PNG"
			And I use TAB
			And I type "Green Restriction"
		}
	end
		
	if(rights == "amber")
		steps %Q{
			And I set the rights to "qvl_Component_RightsTab_Rights_AMBER.PNG"
			And I use TAB
			And I type "Amber Restriction"
		}
	end
		
	steps %Q{
		And I click on "button_Ok.png"
		And I wait "3" seconds
		And I click on "button_Search.png"
		And I doubleclick on "asset_rf70_regression.png"
		And I click on "qvl_Button_Rights.png"
	}
end


When(/^I restrict the item to "(.*?)"$/) do |rights|
	
	if(rights == "red")
		steps %Q{
			And I change the rights to "qvl_Component_RightsTab_Rights_RED.PNG"
			And I use TAB
			And I type "Red Restriction"
		}
	end
		
	if(rights == "green")
		steps %Q{
			And I change the rights to "qvl_Component_RightsTab_Rights_GREEN.PNG"
			And I use TAB
			And I type "Green Restriction"
		}
	end
		
	if(rights == "amber")
		steps %Q{
			And I change the rights to "qvl_Component_RightsTab_Rights_AMBER.PNG"
			And I use TAB
			And I type "Amber Restriction"
		}
	end
		
	steps %Q{
		And I click on "button_Ok.png"
	}
end



When(/^I restrict the item to "(.*?)" via traffic light$/) do |rights|

	steps %Q{
		And I click on "button_restrict_item.png"
		And I wait for "button_Cancel.png" to appear
	}
	region = @screen.exists("item_restricted_to.png",6).below(40)
	
	i = 0

	if(rights == "red")
		#while (!@screen.exists "qvl_Component_RightsTab_Rights_RED.PNG") & (i < 6)
		#	@screen.click(region)
		#	i = i + 1
		#end

		begin 
			steps %Q{
				And I should see "qvl_Component_RightsTab_Rights_RED_1.PNG" with high accuracy "0.97"
			}
		rescue
			if(i < 6)
				@screen.click(region)
				i = i + 1
				retry
			end
		end
		steps %Q{
			And I use TAB
			And I type "Red Restriction"
		}
	end
		
	if(rights == "green")
		steps %Q{
			And I set the rights to "qvl_Component_RightsTab_Rights_GREEN.PNG"
			And I use TAB
			And I type "Green Restriction"
		}
	end
		
	if(rights == "amber")
		steps %Q{
			And I set the rights to "qvl_Component_RightsTab_Rights_AMBER.PNG"
			And I use TAB
			And I type "Amber Restriction"
		}
	end
		
	steps %Q{
		And I click on "button_Ok.png"
	}
end


Given(/^I should see the component dialog$/) do
	steps %Q{
		And I should see "ScreenTitle_Component.PNG"
	}
end


Given(/^I should see the following traffic lights for corresponding scenarios:$/) do |table|
	ind = 1
	table.hashes.each do |line|

		lights = "QVL_rights_amber.png" if(line['Traffic light'] == "Amber")
		lights = "QVL_rights_green.png" if(line['Traffic light'] == "Green")
		lights = "QVL_rights_red.PNG" if(line['Traffic light'] == "Red")

		steps %Q{
			Given I click on "qvl_Button_Rights.png"
			Given I click on "MI_Rights_SummaryTab.png" 
			When I click on "button_edit_item_default_right.png"
			And I set the traffic light rights to "#{line['Deafult rights']}"
			And I click on "button_Ok.png"
			And I click on "MI_Rights_TimelineTab.PNG" 
			And I rightclick on "rights_timeline_mid_item.png" and click "add_rights_information.png"
    		And I wait for "ScreenTitle_Component.PNG" to appear
    		And I set the traffic light rights to "#{line['Component'].downcase}"
    		And I click on "button_Ok.png"
    		And I wait for "button_Cancel.png" to disappear
			Then I should see "#{lights}" with high accuracy "0.92"
		}
		ind = ind + 1
  	end
end


Given(/^I debug "(.*?)"$/) do |stuff|
	puts stuff
end


Given /^I wait for the component pop up to appear$/ do
    step 'I wait for "button_Cancel.png" to appear'
end


Given /^I load the red recording into QVL$/ do
    steps %Q{
		When I search for "rights/red rec" in "Current Last 12"
		Then I should see "asset_rights_red_rec.png"
		And I load asset "asset_rights_red_rec.png" into QVL
    }
end


Given /^I load the amber recording into QVL$/ do
    steps %Q{
		When I search for "rights/amber rec" in "Current Last 12"
		Then I should see "asset_rights_amber_rec.png"
		And I load asset "asset_rights_amber_rec.png" into QVL
    }
end


Given /^I load the green recording into QVL$/ do
    steps %Q{
		When I search for "rights/green" in "Current Last 1"
		Then I should see "asset_rights_green_rec.png"
		And I load asset "asset_rights_green_rec.png" into QVL
    }
end


Given /^I make a child clip from that, story "(.*?)", details "(.*?)"$/ do |story,details|
    steps %Q{
	    And I click on "qvl_Button_Clear.png"
    	And I click on "qvl_Button_Left_Arrow.png"
    	And I type "l"
    	And I type "l"
    	And I type "i"
    	And I click on "qvl_Button_Right_Arrow.png"
    	And I type "j"
    	And I type "j"
    	And I type "o"
    	And I wait for "2" seconds

		And I click on "qvl_Button_New.png"
	    And I click on "publish_selection.png"
		And I wait for "qvl_Radio_Button_Status_Finished.png" to appear
		And I type "News"
		And I click on "qvl_Radio_Button_Category_Sequence.png"
		And I click on "qvl_Textbox_Story.png"
		And I type "#{story}"
		And I click on "qvl_Textbox_Details.png"
		And I type "#{details}"
	    And I use TAB
	    And I type the current time
	    And I click on "captions_button.png"
	    And I click on "cations_box.png"
	    And I type "test"
	    And I click on "button_Ok.png"
	    And I unset the load item on publish checkbox
	    And I click on "publish_button.png"
	    And I wait for "button_Cancel.png" to disappear
	}
end


Given /^I load the "(.*?)" child clip$/ do |colour|
	colour = colour.downcase
    steps %Q{
		When I search for "rights/#{colour} child" in "Current Last 1"
		Then I should see "asset_rights_#{colour}_child.png"
		And I load asset "asset_rights_#{colour}_child.png" into QVL
    }
end


Given /^I make a whole clip length "(.*?)" rights component$/ do |colour|
	steps %Q{
		And I select the entire clip
    	And I click on "qvl_Button_New.png"
		And I click on "quick_component_option.png"
		And I click on "add_rights_information.png"
		And I wait for "ScreenTitle_Component.png" to appear

		And I set the traffic light rights to "#{colour}"
		

	}


end
=begin
And I click on "qvl_Button_Ok.png"
		And I wait for "tools_options_cancel-button.png" to disappear soon
		And I click on "qvl_Component_Button_Edit.png"
		And I wait for any not responding message to disappear
		And I clear any errors encountered
	    When I waitAndclick on "qvl_Rights_Component_Story_Dropdown.png"
	    And I type "auto"
		And I use TAB
	    And I type "rights"
		And I click on "MI_Description_Save.PNG"
=end

Given /^I create a rights component, in "(.*?)", out "(.*?)", copyrightholder "(.*?)", trafficlight "(.*?)"$/ do |input,output,copyright,trafficlight|
	sleep 2
	case trafficlight.downcase
		when "red"
			traffic = 4
		when "amber"
			traffic = 3
		when "green"
			traffic = 2
	end

	getItemID()
	
	link = "#{$config[$site]['create_rights_component']}&itemid=#{$readfileid}&trafficLight=#{traffic}&startOffset=#{input}&endOffset=#{output}&copyrightholder=#{copyright}"
	puts link
	xml_data = open(link).read

end


Given /^I create a rights component, from "(.*?)" %, to "(.*?)" %, copyrightholder "(.*?)", trafficlight "(.*?)"$/ do |from,to,copyright,trafficlight|
	sleep 2
	case trafficlight.downcase
		when "red"
			traffic = 4
		when "amber"
			traffic = 3
		when "green"
			traffic = 2
	end

	#getItemID()
	input = (from.to_f/100) * (32*27)
	output = (to.to_f/100) * (32*27)
	#puts input
	#puts output

	link = "#{$config[$site]['create_rights_component']}&itemid=#{$readfileid}&trafficLight=#{traffic}&startOffset=#{input.to_i}&endOffset=#{output.to_i}&copyrightholder=#{copyright}"
	puts link
	tries = 0
	begin
		puts "sending data"
		xml_data = open(link).read
	rescue
		if(tries < 5)
			tries = tries + 1
			sleep 2
			retry
		else
			fail "Unable to create a rights component after 5 tries. Please manually check the jsp link above"
		end

	end

end


Given /^I delete all keyframe components in the media$/ do 

	if($readfileid)

	else
		getItemID()
	end

	#$readfileid = 22077
	link = "#{$config[$site]['get_all_keyframes']}"
	deleteAllKeyframes(link,$readfileid)


end
#http://qa64w1rdir01.jupiter.bbc.co.uk/jupiter/qausa/mediaitem/componentOperations.jsp?username=bbcnewstest&
#itemid=22077&trafficLight=1&action=addComponent&startOffset=6&endOffset=15&copyrightholder=Reuters

Given /^I should see the red restriction$/ do 
	steps %Q{
		Then I should see "QVL_rights_red.png" 
    }
end

Given /^I should see the amber restriction$/ do 
	steps %Q{
		Then I should see either "traffic_light_amber.png" or "traffic_light_amber2.png"
    }
end

Given /^I should see the green restriction$/ do 
	steps %Q{
		Then I should see "QVL_rights_green.png" 
    }
end


Given /^I should see the red restriction text$/ do 
	steps %Q{
		Then I should see "red_restriction_text1.png"
		Then I should see "red_restriction_text2.png"
		Then I should see "red_restriction_text3.png"
    }
end

Given /^I should see the amber restriction text$/ do 
	steps %Q{
		Then I should see "amber_restriction_text1.png"
		Then I should see "amber_restriction_text2.png"
		Then I should see "amber_restriction_text3.png"
    }
end

Given /^I should see the green restriction text$/ do 
	steps %Q{
		Then I should see "green_restriction_text1.png"
		Then I should see "green_restriction_text2.png"
		Then I should see "green_restriction_text3.png"
    }
end


Given /^I should see the Reuters, itv sport copyright holder$/ do 
	steps %Q{
		Then I should see "itv_sport_and_reuters.png"
	}
end

Given /^I should see the Reuters copyright holder$/ do 
	steps %Q{
		Then I should see "reuters_copyright.png"
	}
end

Given /^I should see the itv sport copyright holder$/ do 
	steps %Q{
		Then I should see "itv_sport.png"
	}
end

Given /^I should see the bbc news, reuters copyright holder$/ do 
	steps %Q{
		Then I should see "bbcnews_reuters.png"
	}
end

Given /^I should see the bbc news, reuters and sky sport copyright holder$/ do 
	steps %Q{
		Then I should see "bbcnews_reuters_sky.png"
	}
end

Given /^I should see the bbc news, itv sport copyright holder$/ do 
	steps %Q{
		Then I should see "bbcnews_itvsport.png"
	}
end

Given /^I should see the bbc news copyright holder$/ do 
	steps %Q{
		Then I should see "bbc_news_rights.png"
	}
end

Given /^I should see the itv, Reuters and sky sports copyright holder$/ do 
	steps %Q{
		Then I should see "copyright_itv_reuters_sky.png"
	}
end

Given /^I should see the Reuters and sky sports copyright holder$/ do 
	steps %Q{
		Then I should see "copyright_reuters_sky.png"
	}
end

Given /^I should see the bbc, itv, Reuters and sky sports copyright holder$/ do 
	steps %Q{
		Then I should see "copyright_bbc_itv_reuters_sky.png"
	}
end

Given /^I should see the various summary rights$/ do 
	steps %Q{
		Then I should see "various_sumary_traffic_light.png"
		Then I should see "various.png"
	}
end


Given /^I get the media item id$/ do 
	getItemID()
end