Given /^I create a component at in "(.*?)" sec and out "(.*?)" sec, description "(.*?)" via api$/ do |inpoint,outpoint,desc|
	#http://qa64w1app05.jupiter.bbc.co.uk:8082/mediaitem/addnonrightscomponent.jsp?itemid=302461&startoffset=0&endoffset=4&username=bbcnewstest&storyname=auto&title=test

	mediaitem = "#{$config[$site]['createcomponent']}itemid=#{$automationfileid}&startoffset=#{inpoint}0&endoffset=#{outpoint}0&username=bbcnewstest&description=#{desc}"
	puts mediaitem
	numberOfTries = 0
	begin
		uri = "#{mediaitem}"
		xml_data = open(uri).read
		fail unless xml_data.downcase.include? "ok"
	rescue
		numberOfTries = numberOfTries + 1
		if(numberOfTries < 2)
			sleep 3
			retry
		else
			raise "Unable to create a component for the media item"
		end
	end

end


Given /^I create a timed video segment "(.*?)" at in "(.*?)" sec and out "(.*?)" sec$/ do |item,inpoint,outpoint|
	res = 0
	begin	
		step 'I wait for any not responding message to disappear'
	    step 'I click on "qvl_Button_Clear.png"'
	    step 'I click on "qvl_Button_Left_Arrow.png"'
	    sleep 2

	    number = inpoint.to_i / 2
	    inlength = number.to_i
	    puts inlength

	    inlength.times do
	    	step 'I type "l"'
	    	sleep 2
	    end
	    sleep 2
	    step 'I type "i"'
	    sleep 2
	    if(item.downcase != "keyframe")
	    	outnumber1 = outpoint.to_i - inpoint.to_i 

		    outnumber = outnumber1 / 2
		    outlength = outnumber.to_i
		    puts "outlength: #{outlength}"

		    outlength.times do
		    	step 'I type "l"'
		    	sleep 1
		    end    
		    sleep 1	
		    step 'I type "o"'
		end
		step 'I wait "2" seconds'
		step 'I click on "qvl_Button_New.png"'
   		step 'I wait for any not responding message to disappear'

		case item.downcase
			when "component"
				step 'I click on "qvl_Dropdown_Component.png" with noHighlight'
				step 'I wait for any not responding message to disappear'
				fail "failed" if @screen.exists "qvl_Dropdown_Component.png"
			when "keyframe"
				step 'I click on "qvl_Button_Keyframes.png" with noHighlight'
			when 'bookmark'
				step 'I click on "qvl_Dropdown_Bookmark.png" with noHighlight'
			when 'recommend'
				steps %Q{
					And I click on "quick_component_option.png"
					And I click on "recommend_selection_to_keep.png"
				}
			when ""
			else
				fail("Please add the code for creating: #{item}")
		end
		step 'I wait for any not responding message to disappear'
		if item.downcase != ""
			step 'I wait "2" seconds'
			#step 'I wait for either "qvl_Component_ArchiveTab_Keyframes.png" or "qvl_Component_ArchiveTab_Keyframes2.png" to appear'
		end
#=begin
	rescue
		if res < 2
			res = res + 1
			puts "Meta data creation failed, retrying..."
			retry
		else
			fail("unable to create component")
		end
	end
#=end
end


Given /^I create a timed video segment "(.*?)" at in "(.*?)" and out "(.*?)"$/ do |item,inpoint,outpoint|
 	step 'I click on "qvl_Button_Clear.png"'
    step 'I click on "qvl_Button_Left_Arrow.png"'

    number = inpoint.to_i / 2
    inlength = number.to_i

    inlength.times do
    	step 'I type "l"'
    	sleep 1
    end
    step 'I type "i"'
    sleep 2

    if(item.downcase != "keyframe")
    	outnumber1 = outpoint.to_i - inpoint.to_i 

	    outnumber = outnumber1 / 2
	    outlength = outnumber.to_i
	    puts "outlength: #{outlength}"

	    outlength.times do
	    	step 'I type "l"'
	    	sleep 1
	    end    	
	    step 'I type "o"'
	end
	sleep 2
	step 'I click on "qvl_Button_New.png"'
   	step 'I wait for any not responding message to disappear'
	case item.downcase
		when "component"
			step 'I click on "qvl_Dropdown_Component.png" with noHighlight'
			step 'I wait for "qvl_Rights_Component_Story_Dropdown.png" to appear'
		when "keyframe"
			step 'I click on "qvl_Button_Keyframes.png" with noHighlight'
		when 'bookmark'
			step 'I click on "qvl_Dropdown_Bookmark.png" with noHighlight'
		when 'partial restore'
			step 'I click on "partial_restore.png" with noHighlight'
			sleep 2
			step 'I click on "button_restore3.png"'
		when /private clip/
			step 'I click on "make_private_clip.png" with noHighlight'
		when ""
		else
			fail("Please add the code for creating: #{item}")
	end
end


Given /^I create a timed video segment "(.*?)" at in "(.*?)" sec and out "(.*?)" sec, description "(.*?)"$/ do |item,inpoint,outpoint,description|
	res = 0
	begin    
	    step 'I click on "qvl_Button_Clear.png"'
	    step 'I click on "qvl_Button_Left_Arrow.png"'
	    sleep 2
	    number = inpoint.to_i / 2
	    inlength = number.to_i

	    inlength.times do
	    	step 'I type "l"'
	    	sleep 1
	    end
	    step 'I type "i"'
	    sleep 1

	    if( item.downcase != "make private clip")
			outnumber1 = outpoint.to_i - inpoint.to_i 

		    outnumber = outnumber1 / 2
		    outlength = outnumber.to_i
		    puts "outlength: #{outlength}"

		    outlength.times do
		    	step 'I type "l"'
		    	sleep 1
		    end    	
		    sleep 1
		    step 'I type "o"'
			step 'I wait "2" seconds'
		end

		case item.downcase
			when "component"
				step 'I doubleclick on "qvl_Button_New.png"'
   				step 'I wait for any not responding message to disappear'
				step 'I click on "qvl_Dropdown_Component.png" with noHighlight'
				step 'I wait "2" seconds'
				step 'I clear any errors encountered'
				step 'I click on "qvl_Component_Button_Edit.png"'
				step 'I clear any errors encountered'
				step 'I wait for "qvl_Rights_Component_Story_Dropdown.png" to appear'
			    step 'I waitAndclick on "qvl_Rights_Component_Story_Dropdown.png"'
			    step 'I type "rfstory"'
				step 'I wait "2" seconds'
				step 'I use TAB'
			    step 'I type "rfstoryTitle"'
			    step 'I click on "MI_Description_Save.PNG"'
				step 'I wait "2" seconds'
			when "keyframe"
				step 'I doubleclick on "qvl_Button_New.png"'
   				step 'I wait for any not responding message to disappear'
				step 'I click on "qvl_Button_Keyframes.png" with noHighlight'
				step 'I wait "2" seconds'
				step 'I clear any errors encountered'
				step 'I click on "qvl_Component_Button_Edit.png"'
				step 'I clear any errors encountered'
			    step 'I waitAndclick on "qvl_Bookmark_Description.png"'
			    step 'I type "'+description+'"'
				step 'I wait "2" seconds'
			    step 'I click on "MI_Description_Save.PNG"'
				step 'I wait "2" seconds'
			when 'bookmark'
				step 'I doubleclick on "qvl_Button_New.png"'
   				step 'I wait for any not responding message to disappear'
				step 'I click on "qvl_Dropdown_Bookmark.png" with noHighlight'
				step 'I wait "2" seconds'
				step 'I clear any errors encountered'
				step 'I click on "qvl_Component_Button_Edit.png"'
				step 'I clear any errors encountered'
			    step 'I waitAndclick on "qvl_Bookmark_Description.png"'
			    step 'I type "'+description+'"'
				step 'I wait "2" seconds'
			    step 'I click on "MI_Description_Save.PNG"'
				step 'I wait "2" seconds'
			when 'partial restore'
				step 'I doubleclick on "qvl_Button_New.png"'
   				step 'I wait for any not responding message to disappear'
				step 'I click on "partial_restore.png" with noHighlight'
				sleep 2
				step 'I click on "button_restore3.png" if exists'
				#step 'I wait for "button_send.png" to appear'
				#step 'I click on "button_send.png"'
			    steps %Q{
					And I wait for "qvl_Button_Publish2.png" to appear
					And I type "News"
					And I waitAndclick on "new_placeholder_story.png"
				    And I type "auto"
				    And I use TAB
				    And I type "#{description}"
				    And I click on "new_placeholder_description.png"
				    And I type "test placeholder"
				    And I use TAB
				    And I type "placeholder"
					And I click on "sequence.png"
					And I click on "qvl_Button_Publish2.png"
					Then I should not see "button_Cancel.png"
				}
			when 'make private clip'
		    	if(outpoint == "end")
		    		step 'I click on "qvl_Timeline_forward.png"' 	
				    step 'I type "o"'
				    sleep 2
		    	else
			    	outnumber1 = outpoint.to_i - inpoint.to_i 

				    outnumber = outnumber1 / 2
				    outlength = outnumber.to_i
				    puts "outlength: #{outlength}"

				    outlength.times do
				    	step 'I type "l"'
				    	sleep 1
				    end    	
				    step 'I type "o"'
				    sleep 2
				end
			    step 'I click on "qvl_Button_New.png"'
   				step 'I wait for any not responding message to disappear'
				step 'I click on "qvl_Dropdown_Make_Private_Clip.png" with noHighlight'
				step 'I click on "private_cliplist_namebox.png"'
				step 'I use CTRL A'
			    step 'I type "rfstory/rfdet/1414-'+description+'"'
				step 'I click on "button_Ok.png"'
			else
				fail("Please add the code for creating: #{item}")
		end
	rescue
		if res < 2
			res = res + 1
			puts "Meta data creation failed, retrying..."
			retry
		else
			fail("unable to create component")
		end
	end

end


Given /^I create a new video segment "(.*?)" at in "(.*?)" and out "(.*?)"$/ do |item,inpoint,outpoint|
    step 'I click on "qvl_Button_Clear.png"'
    step 'I click on "timeline_start2.png" if exists'
    step 'I click on "qvl_Timeline_'+inpoint.gsub(":","_")+'.png"'
    step 'I click on "qvl_Button_In.png"'
    if(item.downcase != "keyframe")
	    step 'I click on "qvl_Timeline_'+outpoint.gsub(":","_")+'.png"'
	    step 'I click on "qvl_Button_Out.png"'
	end
	step 'I click on "qvl_Button_New.png"'
   	step 'I wait for any not responding message to disappear'
	case item.downcase
		when "component"
			step 'I click on "qvl_Dropdown_Component.png" with noHighlight'
			step 'I wait for "qvl_Rights_Component_Story_Dropdown.png" to appear'
		when "keyframe"
			step 'I click on "qvl_Button_Keyframes.png" with noHighlight'
		when 'bookmark'
			step 'I click on "qvl_Dropdown_Bookmark.png" with noHighlight'
		else
			fail("Please add the code for creating: #{item}")
	end
end


Given /^I delete all irrelevant keyframes before dopesheet$/ do 
	step 'I remove all keyframes keep decisions'			
	bitmap = "qvl_Component_Dopesheet.png"
	@region = @screen.exists "#{bitmap}"
	if !@screen.exists "qvl_Component_ArchiveTab_Keyframes.png"
		step 'I click on "qvl_Button_Description.png"'
		step 'I click on "qvl_Button_keyframes.png"'
	end

	while !@screen.exists "#{bitmap}"
		@screen.wait "qvl_Component_ArchiveTab_Keyframes.png", 5
	    step 'I click on "qvl_Component_ArchiveTab_Keyframes.png"'
	    step 'I click on "qvl_Component_Button_Delete.PNG"'
	end

end

Given /^I delete all keyframes$/ do 

	begin
		step 'I remove all keyframes keep decisions'
		#puts "puts8"		
		bitmap = "qvl_Component_ArchiveTab_Keyframes.png"
		bitmap2 = "qvl_Component_ArchiveTab_Keyframes2.png"
		bitmap3 = "created.png"
		bitmap4 = "created_blue.png"
=begin
		limit = 1
		while @screen.exists "#{bitmap}" and limit < 7
			#puts "puts9"
			@screen.wait bitmap, 5
		    step 'I click on "qvl_Component_ArchiveTab_Keyframes.png"'
		    step 'I click on "qvl_Component_Button_Delete.PNG"'
		    if @screen.exists "button_Ok4.png"
		    	#puts "puts10"
				step 'I click on "button_Ok4.png"'
				step 'I click on "qvl_Button_Description.png"'
				step 'I click on "qvl_Button_keyframes.png"'
		    	#break
		    end
		    step 'I wait for "qvl_Component_ArchiveTab_Keyframes2.png" to disappear'
		    limit = limit + 1
		end
		#puts "puts12"
		step 'I click on "button_Ok4.png" if exists'
		step 'I click on "button_Ok.png" if exists'
		#puts "puts13"

		limit = 1
		while @screen.exists "#{bitmap2}" and limit < 7
			#puts "puts14"
			@screen.wait "qvl_Component_ArchiveTab_Keyframes2.png", 5
		    step 'I click on "qvl_Component_ArchiveTab_Keyframes2.png"'
		    step 'I click on "qvl_Component_Button_Delete.PNG"'
		    if @screen.exists "button_Ok4.png"
		    	#puts "puts15"
				step 'I click on "button_Ok4.png"'
				step 'I click on "qvl_Button_Description.png"'
				step 'I click on "qvl_Button_keyframes.png"'
		    	#break
		    	#puts "puts16"
		    end
			step 'I click on "qvl_Button_Description.png"'
			step 'I click on "qvl_Button_keyframes.png"'
		    #puts "puts17"
		    limit = limit + 1
		end
=end
		limit = 1
		while @screen.exists "#{bitmap3}" and limit < 7
			#puts "puts14"
			@screen.wait "created.png", 5
		    step 'I click on "created.png"'
		    step 'I click on "qvl_Component_Button_Delete.PNG"'
		    if @screen.exists "button_Ok4.png"
		    	#puts "puts15"
				step 'I click on "button_Ok4.png"'
				step 'I click on "qvl_Button_Description.png"'
				step 'I click on "qvl_Button_keyframes.png"'
		    	#break
		    	#puts "puts16"
		    end
			step 'I click on "qvl_Button_Description.png"'
			step 'I click on "qvl_Button_keyframes.png"'
			sleep 1
		    #puts "puts17"
		    limit = limit + 1
		end

		limit = 1
		while @screen.exists "#{bitmap4}" and limit < 7
			#puts "puts14"
			@screen.wait "created_blue.png", 5
		    step 'I click on "created_blue.png"'
		    step 'I click on "qvl_Component_Button_Delete.PNG"'
		    if @screen.exists "button_Ok4.png"
		    	#puts "puts15"
				step 'I click on "button_Ok4.png"'
				step 'I click on "qvl_Button_Description.png"'
				step 'I click on "qvl_Button_keyframes.png"'
		    	#break
		    	#puts "puts16"
		    end
			step 'I click on "qvl_Button_Description.png"'
			step 'I click on "qvl_Button_keyframes.png"'
			sleep 1
		    #puts "puts17"
		    limit = limit + 1
		end

	rescue
	end
end

Given /^I remove all keyframes keep decisions$/ do 
	#puts "puts2"
	while @screen.exists "qvl_Component_Result_keep.png"
		#puts "puts3"
		step 'I click on "qvl_Component_Result_keep.png"'
		step 'I wait for "keep_online.png" to appear'
	    step 'I rightclick on "keep_online.png" and click "qvl_Keyframe_Delete.png"'
		step 'I click on "qvl_Button_Ok.png"'

		step 'I click on "qvl_Button_Description.png"'
		step 'I click on "qvl_Button_keyframes.png"'
		#puts "puts4"
	end
	#puts "puts5"
	while @screen.exists "qvl_Component_Result_keep2.png"
		#puts "puts6"
		step 'I click on "qvl_Component_Result_keep2.png" with noHighlight'
		step 'I wait for "keep_online.png" to appear'
	    step 'I rightclick on "keep_online.png" and click "qvl_Keyframe_Delete.png"'
		step 'I click on "qvl_Button_Ok.png"'

		step 'I click on "qvl_Button_Description.png"'
		step 'I click on "qvl_Button_keyframes.png"'
		#puts "puts7"
	end
	#puts "all keep dec deleted"
end


Given(/^I change the keyframe view to "(.*?)"$/) do |state|
	step 'I click on "qvl_Button_View.PNG"'
	if(state.downcase == "story board")
		step 'I click on "story_board.png"'
	else
    	step 'I click on "list_view.png"'
	end
end


Given(/^I delete all the cached keyframe files on the computer$/) do

	envdir = "C:#{ENV['HOMEPATH']}\\AppData\\Local\\Temp\\Jupiter\\Keyframes"
	FileUtils.rm_rf Dir.glob("#{envdir}/*")

	#step 'I click on "windows_TaskBar_Start.png"'
	#step 'I click on "computer.png"'
	#step 'I click on "computer_address_bar.png"'
	#step 'I type "#{envdir}"'
	#step 'I use RETURN'

	#if @screen.exists "tmp_file.png"
	#	step 'I click on "tmp_file.png"'
	#	step 'I use CTRL A'
	#	step 'I rightclick on "tmp_file_blue.png" and click "qvl_Keyframe_Delete.png"' 
	#	step 'I click on "button_Yes.png"'
	#end

	#bitmap = "close_folder.png"
	#region = @screen.exists("#{bitmap}",1).right(-15)
	#@screen.click(region)
end



Given(/^I e cached keyframe files on the computer$/) do
=begin
	if( @screen.exists "taskbar_keyframe.png" )
		step 'I click on "taskbar_keyframe.png" until "keyframes_folder.png" appears'
	else
		step 'I click on "windows_TaskBar_Start.png"'
		step 'I click on "jupiter_keyframes_folder.png"'
	end
	if @screen.exists "tmp_file.png"
		step 'I click on "tmp_file.png"'
		step 'I use CTRL A'
		step 'I rightclick on "tmp_file_blue.png" and click "qvl_Keyframe_Delete.png"' 
		step 'I click on "button_Yes.png"'
	end
=end
	envdir = "C:#{ENV['HOMEPATH']}\\AppData\\Local\\Temp\\Jupiter\\Keyframes"
	FileUtils.rm_rf Dir.glob("#{envdir}/*")

end

Given(/^I open the cached keyframe folder on the computer$/) do
	#if( @screen.exists "taskbar_keyframe.png" )
	#	step 'I click on "taskbar_keyframe.png" until "keyframes_folder.png" appears'
	#else
	#	step 'I click on "windows_TaskBar_Start.png"'
	#	step 'I click on "jupiter_keyframes_folder.png"'
	#end
=begin
	envdir = "#{ENV['HOME']}\\AppData\\Local\\Temp\\Jupiter\\Keyframes"
	step 'I click on "windows_TaskBar_Start.png"'
	step 'I click on "computer.png"'
	step 'I click on "computer_address_bar.png"'
	step 'I type "#{envdir}"'
	step 'I use RETURN'
=end
end

Given(/^I should see the "(.*?)" in the cached keyframe folder on the computer$/) do |item|
	envdir = "C:#{ENV['HOMEPATH']}\\AppData\\Local\\Temp\\Jupiter\\Keyframes"
	puts envdir

	numb = Dir[File.join(envdir, '**', '*.tmp')].count { |file| File.file?(file) }
	if numb < 1 
		fail "Didnt find any .tmp file in the keyframe folder. found '#{numb}' "
	end
	#step 'I click on "windows_TaskBar_Start.png"'
	#step 'I click on "computer.png"'
	#step 'I click on "computer_address_bar.png"'
	#step 'I type "#{envdir}"'
	#step 'I use RETURN'
	#steps %Q{
	#	Then I should see "#{item}"
	#}

	#bitmap = "close_folder.png"
	#region = @screen.exists("#{bitmap}",1).right(-15)
	#@screen.click(region)
	
end

Given(/^I should not see the "(.*?)" in the cached keyframe folder on the computer$/) do |item|
	
	sleep 2
	envdir = "C:#{ENV['HOMEPATH']}\\AppData\\Local\\Temp\\Jupiter\\Keyframes"

	numb = Dir[File.join(envdir, '**', '*.tmp')].count { |file| File.file?(file) }
	if(numb)
		if numb > 0 
			fail "found '#{numb}' .tmp files in the keyframe folder when we are not expecting to. expecting 0"
		end
	end

	#step 'I click on "windows_TaskBar_Start.png"'
	#step 'I click on "computer.png"'
	#step 'I click on "computer_address_bar.png"'
	#step 'I type "#{envdir}"'
	##step 'I use RETURN'
	#steps %Q{
	#	Then I should not see "#{item}"
	#	And I should see "cant_find_folder.png"
	#	And I use RETURN
	#}

	#bitmap = "close_folder.png"
	#region = @screen.exists("#{bitmap}",1).right(-15)
	#@screen.click(region)
	
end


Given(/^I open a new notepad session$/) do
	if !@screen.exists "taskbar_notepad.png"
		step 'I click on "windows_TaskBar_Start.png"'
		step 'I wait for "1" seconds'
		step 'I type "notepad"'
		step 'I click on "notepad_start_logo.png"'
		step 'I wait for "notepad_top.png" to appear'
	else
		step 'I click on "taskbar_notepad.png" until "notepad_top.png" appears'
		step 'I click on "notepad_top.png"'
		step 'I use CTRL A'
		step 'I use BACKSPACE'
	end
end


Given(/^I close Jupiter$/) do
	step 'I click on "close_jupiter.png"'
end

Given(/^I create a new keyframe if there are no cached keyframes$/) do
	step 'I open the cached keyframe folder on the computer'
	if( @screen.exists "tmp_file.png" )
		step 'I click on "taskbar_Icon.png"'
	else
		step 'I search for "rfstory" in "All Material" and load "asset_26237.png" into QVL'
		step 'I click on "qvl_Button_keyframes.png"'
		step 'I delete all keyframes'
		step 'I create a new video segment "keyframe" at in "00:00:10" and out "00:00:10"'
	    step 'I waitAndclick on "qvl_Bookmark_Description.png"'
	    step 'I type "Testing keyframe"'
	    step 'I click on "MI_Description_Save.PNG"'
	end
end

Given /^I start Jupiter$/ do
	#step 'I click on "windows_TaskBar_Start.png"'
	step 'I click on "windows_TaskBar_Start.png"'
	step 'I wait for "1" seconds'
	step 'I type "Jupiter"'
	step 'I click on "jupiter_start_logo2.png"'
	step 'I wait for "menu_New.png" to appear'
	step 'I click on "window_Maximize.png" if exists'
end

Given /^I open the cliplist$/ do
	if( !@screen.exists "clip_list_top.png" )
		step 'I click on "favourites_Cliplist.png,favourites_Cliplist_highlighted.png" until "clip_list_top.png,clip_list_top2.png" appears'
		step 'I should see "clip_list_top.png"'
	end
end

Given /^I clear the cliplist$/ do
	while( @screen.exists "clip_list_item.png")
		step 'I rightclick on "clip_list_item.png" and click "wip_Remove.png"' 
		sleep 2
	end
end

Given /^I highlight a region$/ do
	
	#top = @screen.exists("result_region.png")
	#reg = top.below()
	#@region = Region(50, 50, 200, 200)
	 @resultRegion.highlight(3)
	 @qvlRegion.highlight(3)


end

Given /^I should see the email popup where required$/ do
	begin
		steps %Q{
			Then I should see either "outlook_popup.png" or "outlook_popup2.png"
			And I click on "button_Ok4.png"
		}
	rescue
	end
end


Given /^I select the component keywords section$/ do
	steps %Q{
		And I click "200" pixels to the "right" of "component_keyword.png"
		And I use CTRL A
		And I use DELETE
	}
end


Given /^I ensure the keyframes page has loaded correctly$/ do
	begin
		steps %Q{
			And I should see "keyframe_page.png"
		}
	rescue
		steps %Q{
			And I click on "qvl_Button_Description.png"
			And I wait for "1" seconds
			And I click on "qvl_Button_Keyframes.png"
		}
	end
	begin
		steps %Q{
			And I delete all system data
		}
	rescue
	end
end


Given /^I click on the keyframes section image "(.*?)"$/ do |bitmap|
	top = @screen.exists("keyframe_region.png")
	reg = top.below()
	reg.click "#{bitmap}" 
end


Given /^I expand all component columns$/ do
	6.times do
		steps %Q{
			And I doubleclick "5" pixels to the "right" of "column_dots.png"
		}
	end
end

