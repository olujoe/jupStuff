# encoding: UTF-8

Then(/^binding.pry$/) do
	binding.pry
end


Given /^I ensure Jupiter is in the foreground$/ do
	begin
		if !@screen.exists "menu_New.png"
			step 'I click on "taskbar_Icon.png" if "menu_New.png" not exists'
			step 'I click on "window_Maximize.png" if exists'
			step 'I should see "menu_New.png"'
	  	end
	rescue
    end
end

Given /^I ensure Jupiter is ready for testing$/ do
	if @screen.exists "teamviewer_sponsored_session.png"
		step 'I click on "teamviewer_sponsored_session_ok_button.png"'
    puts "Teamviewer popup was Open but is now closed!"
  end
	if !@screen.exists "menu_New.png"
		if !@screen.exists "taskbar_Icon.png"
			step 'I doubleclick on "windows_TaskBar_Start.png"'
			step 'I wait for "1" seconds'
			step 'I type "Jupiter"'
			step 'I doubleclick on "jupiter_start_logo2.png"'
			begin
			step 'I wait for "menu_New.png" to appear'
			rescue
			end
		end
		step 'I click on "taskbar_Icon.png" if "menu_New.png" not exists'
		step 'I click on "window_Maximize.png" if exists'
		step 'I should see "menu_New.png"'
  end
  	if $site != "West1"
		if(@screen.exists "qa_usa.png")
			$site = "QA_USA"
			puts "Running on QA USA"
		elsif(@screen.exists "qa_ws.png")
			$site = "QA_WS"
			puts "Running on QA WS"
		elsif(@screen.exists "qa_w1.png")
			$site = "QA_W1"
			puts "Running on QA W1"
		else
			fail "Dont know what site i am running on, i'm too stupid"
		end
		$site = "QA_WS"
	end
	nooftries = 0
	begin
		if @screen.exists "button_Cancel.png"
			step 'I click on "button_Cancel.png"'
		end
		if @screen.exists "button_Cancel2.png"
			step 'I click on "button_Cancel2.png"'
		end
		if @screen.exists "button_Cancel3.png"
			step 'I click on "button_Cancel3.png"'
		end
		if @screen.exists "button_Ok.png"
			step 'I click on "button_Ok.png"'
		end
		if @screen.exists "button_Ok4.png"
			step 'I click on "button_Ok4.png"'
		end
		if @screen.exists "button_Yes.png"
			step 'I click on "button_Yes.png"'
		end
		if @screen.exists "dlg_Error_Sign.png"
			step 'I click on "button_Close.png"'
		end
		if @screen.exists "existing_Keyframe_Warning.png"
			step 'I click on "button_Close.png"'
		end
		if @screen.exists "error_x2.png"
			steps %Q{
				And I click on "button_continue.png"
			}
		end
		if @screen.exists "search_Close_Button.png"
			timeout = 0
			while @screen.exists "search_Close_Button.png" and timeout < 4
				step 'I click on "search_Close_Button.png"'
				sleep 1
				timeout = timeout + 1
			end
		end
		if @screen.exists "search_Close_Button.png"
			timeout = 0
			while @screen.exists "search_Close_Button2.png" and timeout < 4
				step 'I click on "search_Close_Button2.png"'
				sleep 1
				timeout = timeout + 1
			end
		end
		if @screen.exists "button_Exceptions_Close.png"
		  #@screen.click "button_Exceptions_Close.png"
		end
		if !@screen.exists "favourites_section.png"
			step 'I click on "favourites.png"'
		end
	rescue
		if(ENV['debug'])
			puts "Jupiter already set"
		end
		if(nooftries < 2)
			nooftries = nooftries + 1
			retry
		end
	end
	#@screen.click "jupiter_top.png"

end


Given /^I close Search Windows$/ do
	timeout = 0
	while @screen.exists "search_Close_Button.png" and timeout < 4
		@screen.click "search_Close_Button.png"
		sleep 1
		timeout = timeout + 1
	end
end


When /^I uncheck all check boxes$/ do
  for x in @screen.findAll "jupiterCheckboxTicked.png"
    @screen.click "jupiterExportButton.png"
  end
end


When /^I scroll to the top of the manual inbox folders$/ do
	begin
	  	steps %Q{
	  		And I click on "recommendations_manual.png" if exists
	  		And I click on "inbox_multifolders.png"
	  	}
	rescue
		begin
			region = @screen.exists("recommendations_inbox_region.png").below()
			20.to_i.times do
				region.click "scroll_left_arrow.png"
			end
			steps %Q{
		  		And I click on "inbox_multifolders.png"
		  	}
		rescue

		end
	end

  	5.to_i.times do 
    	@screen.type(Sikuli::PAGE_UP)
  	end
end


When /^I scroll to the bottom of the manual inbox folder list$/ do
	begin
	  	steps %Q{
	  		And I click on "inbox_multifolders.png"
	  	}
	  	5.to_i.times do 
	    	@screen.type(Sikuli::PAGE_DOWN)
	  	end
	rescue
	end
end


Then /^I close all popups$/ do 
	begin
		if @screen.exists "button_Cancel.png"
		  step 'I click on "button_Cancel.png"'
		end
		if @screen.exists "button_Ok.png"
		  step 'I click on "button_Ok.png"'
		end
		if @screen.exists "button_Yes.png"
		  step 'I click on "button_Yes.png"'
		end
		if @screen.exists "dlg_Error_Sign.png"
		  step 'I click on "button_Close.png"'
		end
		if @screen.exists "existing_Keyframe_Warning.png"
		  step 'I click on "button_Close.png"'
		end
		if @screen.exists "search_Close_Button.png"
		  while @screen.exists "search_Close_Button.png"
			step 'I click on "search_Close_Button.png"'
			sleep 1
		  end
		end
		#if @screen.exists "button_Exceptions_Close.png"
		#  while @screen.exists "button_Exceptions_Close.png"
		#	@screen.click "button_Exceptions_Close.png"
		#	sleep 1
		#  end
		#end
	rescue
		puts "Jupiter is ready"
		retry
	end
end


Given /^I handle any publish name errors$/ do
	if @screen.exists "identical_clip.png", 6	
		steps %Q{
			And I click on "button_Ok4.png"
			And I click on "select_publish_popup.png"
			And I click "10" pixels to the "bottom" of "time_text.png" 
			And I use CTRL A
			And I type a random 2 digit number under 24
			And I type sequence and a random 2 digit number
			And I click on "qvl_Button_Publish_And_Deliver.png"
		}
	end
end


Given /^I ensure that the jupiter delivery queue control window is displayed$/ do
	if( !@screen.exists"qvl_DeliveryQ_window.png")
		steps %Q{
			And I click on "jupiter_delivery_icon.png"
		}
	end
	step 'I click on "taskbar_Icon.png" if "menu_New.png" not exists'
	step 'I ensure Jupiter is ready for testing'
end


Given /^I take a screenshot of the entire screen$/ do
	#screen = @screen
	#file = screen.capture(screen.getBounds())

	#puts file
	#myfiles = "//zgbwcfs3005.jupiter.bbc.co.uk/QA/Jenkins/Jupiter/destFile.png"

	#ImageIO.write(file, "png", myfiles);

	Win32::Screenshot::Take.of(:foreground).write("test.png")


end


Given /close all side panel windows$/ do
	begin
		timeout = 1
		if @screen.exists "search_Close_Button.png"
			while @screen.exists "search_Close_Button.png" and timeout < 4
				step 'I click on "search_Close_Button.png"'
				sleep 1
				timeout = timeout + 1
			end
		end
	rescue
	end
end


Given(/^I ensure Jupiter is not running$/) do
	if @screen.exists "taskbar_Icon.png"
		step 'I rightclick on "taskbar_Icon.png" and click "close_window.png"'
    	step 'I should not see "taskbar_Icon.png"'
	end
end


When(/^I start the jupiter application$/) do
	step 'I click on "windows_TaskBar_Start.png"'
	step 'I wait for "1" seconds'
	step 'I type "Jupiter"'
	step 'I click on "jupiter_start_logo2.png"'
	step 'I wait for "menu_New.png,bbc_top.png" to appear'
end


Then(/^Jupiter should running in the foreground$/) do
    step 'I should see "menu_New.png"'
end


Then(/^I select the add to cliplist checkbox$/) do
	begin
		step 'I should see "add_to_cliplist.png" with high accuracy "0.98" nowait'
		step 'I click on "add_to_cliplist.png"'
	rescue
	end
end


Given /^I change the resource if the resource error exist$/ do
	if @screen.exists "error_resource.png"	
		step 'I click on "button_Ok.png"'
		step 'I waitAndclick on "record_from.png"'
		if !@screen.exists "freesat_1_Sync.png"	
			step 'I type "Freesat 3"'
		else
			step 'I type "Freesat 2"'
		end
		step 'I click on "button_Record.png"'
		step 'I click on "button_Yes.png" if exists'
	end
end


Given /^I select the story outlet group "(.*?)"$/ do |item|
	step 'I click on "search_story_outlet_group.png"'
	if(item == "sport")
		step 'I click on "search_story_outlet_group_sport.png"'
	elsif item == "biz"
		step 'I click on "search_story_outlet_group_biz.png"'
	end
end


Given /^I set the current time plus "(.*?)" seconds$/ do |offset|

   currentTime = Time.new
   #puts CurrentTime  
   currentTimeOffset = currentTime + "#{offset}".to_i
   #puts CurrentTimeOffset
   
   currentTimeOffsetHourString = currentTimeOffset.hour.to_s   
   currentTimeOffsetMinString = currentTimeOffset.min.to_s
   
   if currentTimeOffsetHourString.length == 1
      currentTimeOffsetHourString = "0" + currentTimeOffsetHourString
   end

   if currentTimeOffsetMinString.length == 1
      currentTimeOffsetMinString = "0" + currentTimeOffsetMinString
   end   
   
   $currentTimeOffsetString = currentTimeOffsetHourString + currentTimeOffsetMinString
	if(ENV['debug'])
   		puts $currentTimeOffsetString
    end
end


Given /^I examine "(.*?)"$/ do |bitmap|
	begin
		@region = @screen.find "#{bitmap}"
		puts "text is: " + @region.text()
	end
end


Given /^I enter "(.*?)" in the delete reason section$/ do |text|
	steps %Q{
		And I click on "reason_section.png"
		And I wait "2" seconds
		And I type "#{text}"
	}
end


Given /^I put the pointer at the begining of the Timeline$/ do
	@screen.click "timeline_start.png"
end

Given /^I should see at least one record found$/ do
	step 'I should not see "no_record_found.png"'
end


Given /^I ensure there are no popups open or error boxes$/ do
	begin
		if @screen.exists "button_Cancel.png"
		  step 'I click on "button_Cancel.png"'
		end
		if @screen.exists "button_Cancel2.png"
		  step 'I click on "button_Cancel2.png"'
		end
		if @screen.exists "button_Ok.png"
		  step 'I click on "button_Ok.png"'
		end
		if @screen.exists "button_Yes.png"
		  step 'I click on "button_Yes.png"'
		end
		if @screen.exists "dlg_Error_Sign.png"
		  step 'I click on "button_Close.png"'
		end
		if @screen.exists "existing_Keyframe_Warning.png"
		  step 'I click on "button_Close.png"'
		end
		if @screen.exists "search_Close_Button.png"
		  while @screen.exists "search_Close_Button.png"
			step 'I click on "search_Close_Button.png"'
			sleep 1
		  end
		end
		if @screen.exists "button_Exceptions_Close.png"
		  step 'I click on "button_Exceptions_Close.png"'
		end
	rescue
		puts "Jupiter already set"
	end
end



Given /^I load asset "(.*?)" into QVL$/ do |bitmap|
	#steps %Q{
	#	And I doubleclick on "#{bitmap}"
	#}
	myretries = 0 

	images = bitmap.split(",")
	number = images.length
	tries = 0

	begin
		image = images[tries].strip
		puts "trying #{image}"
		steps %Q{
			And I doubleclick on "#{image}"
			And I wait "5" seconds
	    	And I wait for "qvl_Loading_Clip.png" to disappear now
			And I wait "3" seconds
		}
		if @screen.exists "button_Yes.png"
		  step 'I click on "button_Yes.png"'
		end
		if @screen.exists "load_clip_failed_Yes_button.png"
		  step 'I click on "load_clip_failed_Yes_button.png"'
		  step 'I click on "white_space.png"'
		  step 'I doubleclick on "#{image}"'
		end		
	rescue
		puts "failed"
		if myretries < number * 2
			myretries = myretries + 1
			
			if tries < (number - 1)
				tries = tries + 1
			else
				tries = 0
			end

			retry
		else
			fail("Unable to load the search item '#{bitmap}'")
		end	
	end
end


Given /^I wait for the deliver popup to appear$/ do
	bitmap = "qvl_TX_destination_window.PNG"
	waitingOver = 60
	timeout = 0
	begin
		@screen.wait "#{bitmap}", 30
	rescue
		if @screen.exists "tx_destination_toolbar_icon.png"
			step 'I click on "tx_destination_toolbar_icon.png"'
		else
			if @screen.exists "tx_destination_popup_top.png"
				step 'I click on "tx_destination_popup_top.png"'
			else
				step 'I click on "select_publish_popup.png"'
				step 'I click on "tx_destination_toolbar_icon.png" if exists'
			end
		end
	end

	begin
		@screen.wait "#{bitmap}", 5
		step 'I click on "qvl_TX_destination_window.PNG"'
		puts "pop up found 1"
		step 'I click on "deliver.png"'
	rescue
		step 'I click on "select_publish_popup.png"'
	end

	begin
		@screen.wait "#{bitmap}", 5
		#step 'I click on "#{bitmap}"'
		puts "pop up found 2"
		step 'I click on "deliver.png"'
	rescue
		if @screen.exists "tx_destination_toolbar_icon.png"
			step 'I click on "tx_destination_toolbar_icon.png"'
		else
			if @screen.exists "tx_destination_popup_top.png"
				step 'I click on "tx_destination_popup_top.png" if exists'
			else
				step 'I click on "select_publish_popup.png"'
			end
		end
	end
	
	if !@screen.exists "menu_New.png"
		if !@screen.exists "taskbar_Icon.png"
			step 'I doubleclick on "windows_TaskBar_Start.png"'
			step 'I wait for "1" seconds'
			step 'I type "Jupiter"'
			step 'I click on "jupiter_start_logo2.png"'
			begin
			step 'I wait for "menu_New.png" to appear'
			rescue
			end
		end
		step 'I click on "taskbar_Icon.png" if "menu_New.png" not exists'
		step 'I click on "window_Maximize.png" if exists'
		step 'I should see "menu_New.png"'
	end

end


Then(/^I save the automation edit item id$/) do
	shortcut = Clipboard.paste.encode('utf-8')
	id = shortcut.split("]:")[1].split(">>")[0]
	puts id
	$automationfileid = id 
end


Then(/^I should have the text "(.*?)" in the clipboard$/) do |text|
	shortcut = Clipboard.paste.encode('utf-8')
	if(!shortcut.include? text)
		fail("The cliplist text did not include '#{text}', it was: '#{shortcut}'")
	end
end


Then(/^I should get the items id$/) do
	shortcut = Clipboard.paste.encode('utf-8')
	id = shortcut.split("]:")[1].split(">>")[0]
	
	puts id
	files = "//zgbwcfs3005.jupiter.bbc.co.uk/QA/Jenkins/Jupiter/itemid.txt"
	f = File.open(files,'w')
	f.write(id)

=begin
	begin
		f = File.new(files, "w")
		f.write(id) 
	rescue
		f = File.new(files, "w")
		f.write(id) 
	end    #=> 10
=end
	f.close   
end


Then(/^I read the fileid file$/) do
	
	#File.write('Q:/Jenkins/Jupiter/itemid.txt', '12345')
	files = "//zgbwcfs3005.jupiter.bbc.co.uk/QA/Jenkins/Jupiter/itemid.txt"

	file = File.new(files, "r")
	text = file.gets
	file.close

	#begin
	#	text = File.read(files)
	#rescue
	#	text = File.read(files)
	#end
	puts text
	$readfileid = text   

end


Then(/^I get the automation edit media id$/) do
	
	files = "//zgbwcfs3005.jupiter.bbc.co.uk/QA/Jenkins/Jupiter/automation_edit.txt"
	file = File.new(files, "r")
	text = file.gets
	file.close
	$automationfileid = text   

end


Then(/^I get the automation media id$/) do
	
	files = "//zgbwcfs3005.jupiter.bbc.co.uk/QA/Jenkins/Jupiter/automation.txt"
	file = File.new(files, "r")
	text = file.gets
	file.close
	$automationfileid = text 
	puts "automationid = '#{$automationfileid}'"
end


Then(/^I get the test item "(.*?)" id and load it into QVL$/) do |item|

	case item.downcase
		when "rfstory"
			result = "asset_26237.png"
		when "clone_master"
			result = "asset_automation_test.png"
			text = $config[$site]['duplicatedMediaItem'].to_s
			if($site == "QA_USA")
				result = "asset_automation_test.png"
			end
			result2 = "asset_automation_test_caps.png"
		when 'metadataitem'
			result = "asset_26237.png"
		when /test/
			result = "asset_26237.png"
		else
			fail("This test item does not exist on file. Please add the text file with the item id")
	end

	if (item.downcase != "clone_master")
		files = "//zgbwcfs3005.jupiter.bbc.co.uk/QA/Jenkins/Jupiter/#{item}.txt"
		file = File.new(files, "r")
		text = file.gets
		file.close
	end
	puts text
	$readfileid = text  
	retries = 0 
	begin

		steps %Q{
			And I search for the read file id in "Media Item Id"
		}

		if(result2)
			steps %Q{
				Then I should see either "#{result}" or "#{result2}"
				And I load asset "#{result},#{result2}" into QVL
			}
		else
			steps %Q{
				Then I should see "#{result}"
				And I load asset "#{result}" into QVL
			}

		end

	rescue
		if retries < 2
			retires = retries + 1
			retry
		else
			fail("Unable to load the search item")
		end
	end

end


Then(/^I close the message dialog$/) do
	bitmap = "close_folder.png"
	region = @screen.exists("#{bitmap}",1).right(-15)
	@screen.click(region)
end

Then(/^I take a screenshot$/) do
	
	@screen.type(Sikuli::KEY_PRINTSCREEN)
	sleep 4
	@screen.click(200,200)
	#binding.pry

	#screen = @screen
	#file = screen.capture(screen.getBounds())
	#puts file

end

Then(/^I clear any errors encountered$/) do
 	sleep 2
 	begin
		steps %Q{
			And I wait for any not responding message to disappear
			And I click on "button_continue.png" if exists
			And I click on "button_continue2.png" if exists
			And I click on "button_Ok4.png" if exists
			And I click on "qvl_Component_Button_Edit.png"
		}
		begin
			@screen.exists "qvl_Component_Button_Edit.png"	
		rescue
			steps %Q{
				And I click on "button_continue.png" if exists
				And I click on "button_continue2.png" if exists
				And I click on "button_Ok4.png" if exists
				And I click on "qvl_Component_Button_Edit.png"
			}
		end
	rescue
		if @screen.exists "error_x2.png"
			steps %Q{
				And I click on "button_continue.png"
			}
		end

	end
	steps %Q{
		And I wait for the popup to disappear
	}
end


Then(/^I wait for the popup to disappear$/) do
	begin
		region = @screen.exists("qvl_and_results_region.png").below(505)
		region.waitVanish "close_folder2.png",60
	rescue
	end
end


Then(/^I handle the restore process$/) do
	if($site == "QA_USA")
		steps %Q{
			And I click on "button_Yes.png"
			And I click on "button_Ok4.png" if exists
			And I wait for "1" seconds
			And I click on "button_Ok4.png" if exists
		}
	else

		steps %Q{
			And I click on "button_no.png" if exists
			And I click on "button_restore.png" if exists
			And I click on "button_restore.png" if exists
			And I click on "tools_new_recording_item_warning_yes.png" if exists
			And I click on "button_Ok4.png" if exists
			And I wait for "1" seconds
			And I click on "button_Ok4.png" if exists
		}
	end
end


Then(/^I close the Jupiter - Archive popup$/) do
	begin
		region = @screen.exists("top_video_payer_bar.png").below(705)
		region.click("button_Exceptions_Close.png")
	rescue
	end

end


Then(/^I get "(.*?)" media ID$/) do |item|
	
	steps %Q{
		Given I rightclick on "#{item}" and click "rightclick_copy.png"
		When I click on "shortcut.png"
		And I wait "3" seconds
	}

	shortcut = Clipboard.paste.encode('utf-8')
	$automationfileid = shortcut.split("]:")[1].split(">>")[0]
	puts $automationfileid
	
end

Then(/^I change the media item status to finished$/) do
	makeMediaItemFinished($automationfileid)
end


Then(/^I open the task menu section$/) do
	
	steps %Q{
		Given I click on "top_task_button.png,top_task_button_pressed.png" until "task_menu_section2.png" appears
		And I click on either "white_space2.png" or "white_space.png"
	}

end