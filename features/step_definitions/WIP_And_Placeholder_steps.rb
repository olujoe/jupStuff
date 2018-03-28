

Given(/^I click on the top task button \-> Archive \+ \-> Work in progress$/) do
	steps %Q{
		And I click on "top_task_button.png"
		And I select the Tasks - Archive menu
		And I click on either "work_in_progress.png" or "work_in_progress_blue.png"
	}
	
end


Given(/^I type the current time$/) do
	currentTime = Time.new
	currentTimeHourString = currentTime.hour.to_s 
	currentTimeMinString = currentTime.min.to_s 
	if currentTimeHourString.length < 2
		currentTimeHourString = "0#{currentTimeHourString}"
	end 
	if currentTimeMinString.length < 2
		currentTimeMinString = "0#{currentTimeMinString}"
	end
	@screen.type "#{currentTimeHourString}#{currentTimeMinString}"
end


Then(/^I should see "(.*?)" in the wip section$/) do |item|
	region = @screen.exists("wip_section2.png").below()
	region.exists "#{item}" 
end


Then(/^I should not see "(.*?)" in the wip section$/) do |item|
	region = @screen.exists("wip_section2.png").below()
	!region.exists "#{item}" 
end


Given(/^I click on the top task dropdown -> Work in progress$/) do
	steps %Q{
		And I select the Tasks dropdown menu
		And I click on "work_in_progress.png"
	}
end


Then(/^I should "(.*?)" the WIP section$/) do |action|
	if action == "see"
		steps %Q{
			And I should see "wip_top.png"
		}
	else
		steps %Q{
			And I should not see "wip_top.png"
		}
	end
end


Then(/^I select the Tasks - Archive menu$/) do
	if !@screen.exists "task_archive_open.png", 4	
		bitmap = "task_archive_link.png"
		begin
			region = @screen.exists("#{bitmap}",1)
			@screen.click(region)
			@screen.type("\n")
		rescue
			puts "Did not find the right plus image"
		end
	end
end



Then(/^I select the Tasks dropdown menu$/) do
	bitmap = "top_task_button.png"
	region = @screen.exists("#{bitmap}",1).right(-16)
	@screen.click(region)
end


Given(/^the WIP section is visible$/) do
	if !@screen.exists "wip_top.png", 2	
		@screen.type(Sikuli::KEY_F5, Sikuli::KEY_SHIFT)
		sleep 2
	end
	if !@screen.exists "wip_top.png", 2	
		@screen.type(Sikuli::KEY_F5, Sikuli::KEY_SHIFT)
		sleep 2
	end	
	if !@screen.exists "wip_top.png", 2	
		@screen.type(Sikuli::KEY_F5, Sikuli::KEY_SHIFT)
	end
end


When(/^I rightclick in the WIP section and add a new folder$/) do
	steps %Q{
  		And I rightclick on "work_in_progress_section.png" and click "new_folder.png"
  		And I click on "work_in_progress_section.png"
  	}
end


Then(/^I should see the "(.*?)" folder in the WIP section$/) do |name|
	if name == "new"
		steps %Q{
			And I should see "wip_created_new_folder.png"
		}
	elsif name == "renamed"
		steps %Q{
			And I should see either "wip_created_renamed_folder.png" or "wip_created_renamed_folder_1.png"
		}
	end
end


Then(/^I add 2 other wip folders$/) do 
	steps %Q{
  		And I rightclick on "work_in_progress_section2.png" and click "new_folder.png"
		And I type "XXFolder1"
		And I use RETURN
  		And I rightclick on "work_in_progress_section2.png" and click "new_folder.png"
		And I type "AAFolder2"
		And I use RETURN
		Then I should see "wip_result1.png"
	}
end

When(/^I have the 2 folders in the WIP section$/) do
	steps %Q{
		And the WIP section is visible
  	}
  	begin
		steps %Q{
	  		And I should see "work_in_progress_1.png"
	  	}
  	rescue

  	end
end


When(/^I select the whole video frames$/) do
	steps %Q{
		And I click on "qvl_Button_Left_Arrow.png"
		And I wait "1" seconds
		And I type "i"
		And I wait "1" seconds
		And I click on "qvl_Button_Right_Arrow.png"
		And I wait "1" seconds
		And I type "o"
		And I wait "2" seconds
  	}
end


When(/^I should see the republish existing item tab$/) do
	steps %Q{
  		And I wait for "publish_popup.png" to appear
  		And I should see "publish_to_existsing_item.png"
  	}
end


When(/^I click on publish popup "(.*?)" item$/) do |name|
	top = @screen.exists("publish_popup_region.png")
	reg = top.below()
	reg.click "#{name}" 
end


When(/^I should see the following search result "(.*?)"$/) do |name|
	sleep 2
	top = @screen.exists("qvl_and_results_region.png")
	reg = top.below()
	#reg.highlight(1)
	reg.exists "#{name}", 5 
end


When(/^I should see the default placeholder details$/) do
	steps %Q{
		And I should see "placeholder_details2.png"
		And I should see "placeholder_details3.png"
	}
end


When(/^I set the placeholders outlet to "(.*?)"$/) do |name|
	bitmap = "description_outlet.png"
	region = @screen.exists("#{bitmap}").right(27)
	@screen.click(region)
	#step 'I use CTRL A'
	step 'I type "'+name+'"'
	step 'I click on "qvl_Component_Button_Save.png"'
end


When(/^I set the placeholders category to "(.*?)"$/) do |name|
	bitmap = "description_outlet.png"
	region = @screen.exists("#{bitmap}").left(47)
	@screen.click(region)
	#step 'I use CTRL A'
	step 'I type "'+name+'"'
	step 'I click on "qvl_Component_Button_Save.png"'
end


When(/^I should not see the following search result "(.*?)"$/) do |name|
	top = @screen.exists("qvl_and_results_region.png")
	reg = top.below()
	#reg.highlight(1)
	!reg.exists "#{name}", 5 
end


Given /^I empty the wip folder$/ do

	#if !@screen.exists "wip_top.png"
		@screen.click "favourites_Wip.png"
		#sleep 1
	#end
	#if !@screen.exists "wip_top.png"
		#@screen.click "favourites_Wip.png"
		#sleep 1
	#end
	no = 1
	begin
		#top = @screen.exists("wip_section2.png")
		#reg = top.below()
		#reg.click "white_space.png"

		steps %Q{
			And I click "30" pixels to the "bottom" of "wip_top.png"
			And I use CTRL A
		    And I use DELETE
		    And I wait for "2" seconds
		}


		region1 = @screen.exists("delete_item_popup.png")
		region = region1.below(300)
		region.highlight(5)
		begin
			region.click "button_Yes.png" 
			step 'I wait for "button_no2.png" to disappear'
		rescue
		end

	rescue
		if(no < 2)
			no = no + 1
			retry
		end
	end
end


Given /^I create the folder "(.*?)" in the wip section$/ do |folder|
	steps %Q{
  		And I rightclick on "work_in_progress_section.png" and click "new_folder.png"
		And I type "#{folder}"
		And I use RETURN
	}
end


Given /^I click on "(.*?)" in the wip section$/ do |bitmap|
	top = @screen.exists("wip_section2.png")
	reg = top.below(500)
	image = bitmap.split(",")
	number = image.length
	tries = 0
	begin
		reg.click "#{image[tries]}" 
	rescue
		if tries < number 
			tries = tries + 1
			retry
		else
			fail("Did not find the images: '#{bitmap}' in the region")
		end
	end
	#reg.click bitmap
end

Given /^I rightclick on "(.*?)" in the wip section$/ do |bitmap|
	
	top = @screen.exists("wip_section2.png")
	reg = top.below(500)
	image = bitmap.split(",")
	number = image.length
	tries = 0
	begin
		reg.rightClick "#{image[tries]}" 
	rescue
		if tries < number 
			tries = tries + 1
			retry
		else
			fail("Did not find the images: '#{bitmap}' in the region")
		end
	end

end

Given /^I expand all wip folders$/ do
	top = @screen.exists("wip_section2.png")
	reg = top.below(500)

	steps %Q{
		And I click on "wip_created_aafolder2_folder2.png"
		And I wait for "1" seconds
		And I use RETURN
		And I click on "wip_created_xx_folder2.png"
		And I wait for "1" seconds
		And I use RETURN
		And I click on "white_space.png"
	}

	#num = 0
	#for x in reg.findAll("wip_plus.png")
	#	num = num + 1
	#end

	#while @screen.exists("wip_plus.png")
	#	reg.click "wip_plus.png"
		#num = num - 1
	#	sleep 2
	#end


end


When(/^I enter a valid outlet value$/) do
	if $site == "QA_WS"
		step 'I type "News"'
	else
		step 'I type "BBC3"'
	end
end

Given /^I write to screen "(.*?)"$/ do |folder|
	puts "--------------------------------------------------"
	puts folder
	puts "--------------------------------------------------"
end