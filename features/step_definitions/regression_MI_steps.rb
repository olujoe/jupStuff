
Given(/^I should see the follwing items on the page:$/) do |table|
	table.hashes.each do |line|
		steps %Q{
			Then I should see "#{line['Image']}" with high accuracy "0.79"
		}
  	end
end

Given(/^I change the MI decription status to "(.*?)"$/) do |status|
	tries = 0
	#begin
		step 'I click on "MI_Description_Status2.png"'
		case status.downcase
			when "rough cut"
				step 'I click on "rough_cut.png"'
			when "raw"
				step 'I click on "raw.png"'
			when "finished"
				#begin
					step 'I click on "finished.png"'
				#rescue
					#steps %Q{
					#	And I wait for "2" seconds
					#    And I type "Finished"
					#    And I click on "white_space.png"
					#	And I wait for "2" seconds
					#}
				#end
			else
				fail("Code for this hasnt been entered- #{status}")
		end
		steps %Q{
			And I doubleclick on "qvl_Component_Button_Save.png"
			And I doubleclick on "qvl_Component_Button_Save.png"
			And I click on "qvl_Component_Button_Save.png"
			And I wait for "2" seconds
			And I wait for any not responding message to disappear
		}
	#rescue
	#	if tries < 2
	#		tries = tries + 1
	#		step 'I click on "white_space.png"'
	#		retry
	#	else
	#		fail "Unable to set the MI description status"
	#	end
	#end
end


Given(/^I check the make number section if in QA_W1$/) do 
	if($site == "QA_W1")
		steps %Q{
			
		    And I click on "make_number.png"
		    And I use TAB
		    And I type "12345"
		    And I use TAB
		    And I type "678"
		    And I use TAB
		    And I type "90"
		    Then I should see "description_additional_result2.png"

		}
	end
end


Given(/^I select the MI description time box$/) do 
	steps %Q{
		When I click on "MI_description_details_box.png"
		And I use TAB 
	}
end

Given(/^I change the MI decription outlet to world$/) do 
	steps %Q{
		When I click "50" pixels to the "right" of "description_outlet.png"
		And I use DELETE "20" times
	}
	if $site == "QA_WS"
		steps %Q{
			And I type "Training"
			And I click on "qvl_Component_Button_Save.png"
		}
	else
		steps %Q{
			And I type "World"
			And I click on "qvl_Component_Button_Save.png"
		}
	end
end

Given(/^I update the MI description component title to "(.*?)"$/) do |text|
	steps %Q{
		When I wait "2" seconds
		And I use TAB
		And I use CTRL A
		And I type "#{text}"
		And I click on "button_Ok.png"
	}
end

Given(/^I drag the page slider to the top$/) do 
	begin
		if(@screen.exists("slider.png",1))
			steps %Q{
				When I drag "slider.png" to "slider_top.png"
			}
		end
	rescue
	end
end

Given(/^I change the details to "(.*?)"$/) do |text| 
	steps %Q{
		When I click on "MI_description_details_box.png"
		And I use CTRL A
		And I type "#{text}"
		And I click on "qvl_Component_Button_Save.png"
	}
end

Given(/^I click on the print dropdown image$/) do
	bitmap = "print.png"
	region = @screen.exists("#{bitmap}",1).right(24)
	@screen.click(region)
end

Given(/^I should see the print preview doc 1$/) do
	if !@screen.exists "print_page.png", 5
		steps %Q{
			When I click on "excel.png" until "print_page.png" appears
		}
	end
	begin
		if !@screen.exists "MI_properties_print_result1.png", 5	
			fail("didnt find the doc")
		end
	rescue
	end
end

Given(/^I should see the print preview doc 3$/) do
	if !@screen.exists "print_page.png", 5
		steps %Q{
			When I click on "excel.png" until "print_page.png" appears
		}
		begin
			if !@screen.exists "test11.png", 5	
				fail("didnt find the doc")
			end
		rescue
		end
		#steps %Q{
		#	Then I should see "MI_archive_print_result1.png"
		#	Then I should see "MI_archive_print_result2.png"
		#	Then I should see "MI_archive_print_result3.png"
		#}
	end
	
end

Given(/^I should see the print preview doc 2$/) do
	if @screen.exists "print_page2.png", 5
	else
		steps %Q{
			When I click on "excel.png"
		}
	end
	steps %Q{
		Then I should see "MI_properties_print_result3.png"
		Then I should see "MI_properties_print_result4.png"
	}
end


Given(/^I should see the print preview doc 4$/) do
	if @screen.exists "print_page2.png", 5
	else
		steps %Q{
			When I click on "excel.png"
		}
	end
	steps %Q{
		Then I should see "MI_archive_print_result4.png"
		Then I should see "MI_archive_print_result5.png"
	}
end

Given(/^I expand the component window$/) do
	begin
		steps %Q{
			And Within region "media_component_region.png" click "MI_description_component_window_expand_2.png"
		}
	rescue
		steps %Q{
			And Within region "media_component_region.png" click "MI_description_component_window_expand.png"
			And Within region "media_component_region.png" click "MI_description_component_window_expand_4.png"
		}
	end
end

Given(/^I ensure the component is in the right state$/) do
	bitmap = "printregion.png"
	region = @screen.exists("#{bitmap}",1).below(25)
	if region.exists "MI_description_component_window_expand_2.png", 2
		region.click "MI_description_component_window_expand_2.png"
	end
end

Given(/^I use binding$/) do
	binding.pry
end