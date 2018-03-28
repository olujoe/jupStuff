
Given /^I get the cliplist item id$/ do
	steps %Q{
		Given I rightclick on "asset_send_to_shelf.png" and click "rightclick_copy.png"
	    When I click on "shortcut.png"
	    Then I wait "3" seconds
	}
	shortcut = Clipboard.paste.encode('utf-8')
	id = shortcut.split("]:")[1].split(">>")[0]
	puts id
	$readfileid = id
end

#Added another cliplist to handle more images
Given /^I get the cliplist itemid$/ do

	shortcut = Clipboard.paste.encode('utf-8')
	#id = shortcut.split("]:")[1].split(">>")[0]
	id = shortcut.split(']:')[1].split('>>')[0]
	puts id
	$read_fileid = id
end



Then(/^I enter the new placeholder for reingest details$/) do
	steps %Q{
	    And I wait for "new_placeholder_story.png" to appear
	    And I enter a valid outlet value
	    And I click on "new_placeholder_story.png"
	    And I type "auto"
	    And I use TAB
	    And I type "placeholders"
	    And I use TAB
	    And I type the current time
	    And I click on "new_placeholder_description.png"
	    And I type "test placeholder"
	    And I use TAB
	    And I type "placeholder"
	    And I click on "sequence.png"
	    And I click on "qvl_Button_Publish2.png"
	    Then I should not see "button_Cancel.png"
		And I click on "button_Ok4.png"
		And I click on "button_Ok4.png"
	}
end


Then(/^I ensure "(.*?)" is in the cliplist$/) do |item|
	if !@screen.exists "clip_list_top.png"
		step 'I click on "favourites_Cliplist.png" until "clip_list_top.png" appears'
	end
	step 'I rightclick on "'+item+'" and click "add_to_cliplist_2.png"'
end


Then(/^I should see "(.*?)" in the cliplist$/) do |clickImage|
	region = @screen.exists("cliplist_region.png").below()
	begin
		region.exists "#{clickImage}"
	rescue
		if tries < number 
			tries = tries + 1
			retry
		else
			fail("Did not find the images: '#{clickImage}' in the region")
		end

	end

end


Then(/^I should see either "(.*?)" in the cliplist$/) do |clickImage|
	region = @screen.exists("cliplist_region.png").below()
	image = clickImage.split(",")
	number = image.length
	tries = 0
	begin
		region.exists "#{image[tries]}"
	rescue
		if tries < number 
			tries = tries + 1
			retry
		else
			fail("Did not find the images: '#{clickImage}' in the region")
		end

	end

end

    
Given(/^I rightclick on the cliplists "(.*?)" item$/) do |name|
	top = @screen.exists("cliplist_region.png")
	reg = top.below()
	reg.highlight(1)
	reg.rightClick "#{name}" 
end
    
Given(/^I click on the cliplists "(.*?)" item$/) do |name|
	top = @screen.exists("cliplist_region.png")
	reg = top.below()
	#reg.highlight(1)
	reg.click "#{name}" 
end


When /^I empty the clip list$/ do
	
	if !@screen.exists "favourites_section.png"
		step 'I click on "favourites.png"'
	end
	if(@screen.exists "clip_list_top.png")
		steps %Q{
			And I click "80" pixels to the "bottom" of "clip_list_top.png"
			And I use CTRL A
			And I use DELETE
		}
	else
		steps %Q{
			And I click on "favourites_Cliplist.png"
		}
		sleep 1
		if(!@screen.exists "clip_list_top.png")
			steps %Q{
				And I click on "favourites_Cliplist.png"
			}
		end
		steps %Q{
			And I click "80" pixels to the "bottom" of "clip_list_top.png"
			And I use CTRL A
			And I use DELETE
		}
	end
	
end


When /^I empty the opened clip list$/ do
	top = @screen.exists("cliplist_region.png")
	reg = top.below()
	reg.click "white_space2.png" 
	step 'I use CTRL A'
	step 'I use DELETE'
    
end

Given(/^the cliplist section is visible$/) do
	if !@screen.exists "clip_list_top.png"
		step 'I click on "favourites_Cliplist.png" until "clip_list_top.png" appears'
	end
end


Then(/^I select the Tasks - Editing menu$/) do
	if !@screen.exists "task_editing_open.png"	
		bitmap = "task_editing_link.png"
		bitmap2 = "task_editing_link_b.png"
		if @screen.exists bitmap
			@screen.doubleClick bitmap
		elsif @screen.exists bitmap2
			@screen.doubleClick bitmap2
		end
	end
end


Then(/^I select the Tasks - Media menu$/) do
	if !@screen.exists "task_advanced_media_search.png"	
		step 'I doubleclick on either "task_media.png" or "task_media_b.png"'
		#bitmap = "task_advanced_media_search.png"
		#@screen.click bitmap
	end
end


Then(/^I should see the following cliplist columns when i scroll right:$/) do |table|
	table.hashes.each do |line|
		if(line['columns'] == "*")
			image = "cl-star.png"
		else
			lines = line['columns'].gsub(" ","_")
			image = "cl-#{lines}.png"
		end

		if !@screen.exists image
			40.times do 
				@screen.type(Sikuli::RIGHT_ARROW)
			end

			if !@screen.exists image
				fail("Did not find the cliplist column '#{line}'")
			end
		end
	end

	150.times do 
		@screen.type(Sikuli::LEFT_ARROW)
	end
end


Then(/^I should find "(.*?)" in the cliplist when i scroll right$/) do |image|
	
	top = @screen.exists("cliplist_region.png")
	reg = top.below()
	#reg.click "white_space2.png"

	exists = false
	counts = 0

	if (!reg.exists image)

		while !exists  && (counts < 4)
			if !reg.exists image
				40.times do 
					@screen.type(Sikuli::RIGHT_ARROW)
				end
			
			else
				exists = true
			end
			counts = counts + 1
		end

	end

	150.times do 
		@screen.type(Sikuli::LEFT_ARROW)
	end
end


Then(/^I scroll to the left "(.*?)" times$/) do |number|
	number.to_i.times do 
		@screen.type(Sikuli::LEFT_ARROW)
	end
end


Then(/^I should see the correct copyright information in the clipboard$/) do
	shortcut = Clipboard.paste.encode('utf-8')
	result = ["ITEM NAME: default/test/","DESCRIPTION:","LOCATIONS:","IN WORDS:","OUT WORDS:","DURATION:","ASTONS:"]
	
	result.each do |value|
		if !shortcut.include? value
			fail "Copy right information is missing the following: '#{value}'. found: '#{shortcut}'"
		end
	end

end


Then(/^I open the cliplist2$/) do
	steps %Q{
		And the cliplist section is visible
	}
end