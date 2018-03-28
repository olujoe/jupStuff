
Given(/^I save how many "(.*?)" there are in region "(.*?)"$/) do |bitmap, imageregion|

	step 'I click on "white_space.png"'
	region = @screen.exists("#{imageregion}").below()

	image = bitmap.split(",")
	number = image.length
	counts = 0
	number = 0

	image.each do |img|
		begin
			#number = number + region.findAll("#{image[counts]}").count
			original_score = 0
			region.findAll("#{image[counts]}").each do |potential_image|
				#puts potential_image.getScore()
				if (potential_image.getScore() >= original_score) || ((original_score - potential_image.getScore()) < 0.11)
					
					if (potential_image.getScore() >= original_score)
						original_score = potential_image.getScore()
					end
					number = number + 1
				end
			end

		rescue
		end
		counts = counts + 1
	end
	
	puts "Number found: '#{number}'"
	begin
		if $countresult
			$countresult2 = number
		else
			$countresult = number
		end
	rescue
		$countresult = number
	end
	
end

Then(/^I close the message popup$/) do
	begin
		bitmap = "close_folder.png"
		bitmap2 = "close_folder2.png"
		region1 = @screen.exists("qvl_and_results_region.png").below()
		region = region1.exists("#{bitmap}",1).right(-15)
		@screen.click(region)
		sleep 0.5
		begin
			if @region1.exists("#{bitmap2}")
				region = @region1.exists("#{bitmap}",1).right(-15)
				@screen.click(region)
			end
		rescue
		end
	rescue
	end

end

Then(/^I close the popup window$/) do
	begin
		bitmap = "button_Exceptions_Close.png"
		bitmap2 = "button_Close.png"
		region1 = @screen.exists("qvl_and_results_region.png").below()
		region = region1.exists("#{bitmap}",1).right(-15)
		@screen.click(region)
		sleep 0.5
		begin
			if @region1.exists("#{bitmap2}")
				region = @region1.exists("#{bitmap}",1).right(-15)
				@screen.click(region)
			end
		rescue
		end
	rescue
	end

end


Given(/^I send the item "(.*?)" to$/) do |items|
	tries = 0
	begin
		steps %Q{
			And I rightclick on "#{items}"
			And I click on "send_to2.png"
		}
	rescue
		if tries < 7
			steps %Q{
				And I click on "button_Search.png"
			}
			tries = tries + 1
			sleep 1
			retry
		else
			fail ("Rightclicking on item '#{items}' and clicking send to did not work after 7 tries")
		end
	end
end


Given(/^I select multiple "(.*?)" items$/) do |items|

	region = @screen.exists("qvl_and_results_region.png").below()
	destination = "wip_drag_section.png"

	source = region.exists("asset_default_test.png")
	@screen.dragDrop(source,destination)
	sleep 2

	source = region.exists("asset_default_test.png")
	@screen.dragDrop(source,destination)
	sleep 2

	source = region.exists("asset_default_test.png")
	@screen.dragDrop(source,destination)
	sleep 1

	@screen.click destination
	steps %Q{
		And I use CTRL A
	}
	#@screen.keyDown(Sikuli::KEY_SHIFT)
	#region.click items
	#region.click items
	#@screen.keyUp(Sikuli::KEY_SHIFT)
  	#region.type(Sikuli::KEY_SHIFT, Sikuli::DOWN_ARROW + Sikuli::DOWN_ARROW)

end


Then(/^there should be less messages in the inbox$/) do
	fail("Original count before delete is '#{$countresult}' and after delete is '#{$countresult2}'") unless $countresult > $countresult2
	$countresult = nil
	$countresult2 = nil
end

Then(/^there should be more messages in the inbox$/) do
	fail("Original count before making message 'read' is '#{$countresult}' and after making 'read' is '#{$countresult2}'") unless $countresult >$countresult2
	$countresult = nil
	$countresult2 = nil
end


Then(/^I get 2 media items with different names$/) do

	@@item1 = $automationfileid
	puts "item 1: #{@@item1}"
	#@@item1 = 257608
#=begin
	steps %Q{
		And I get an unfinished media item "auto", "description" and load the item to QVL
	}
		#And I duplicate an existing media item and load the item to QVL
		#And I go to the "Description" page
		#And I click on "qvl_Component_GeneralTab.png"
	    #And I wait for "MI_story.png" to appear
	    #And I click "20" pixels to the "right" of "MI_story.png"
	    #And I use CTRL A
	    #And I use BACKSPACE "19" times
	    #And I use DELETE "10" times
	    #And I type "auto"
	    #And I click "20" pixels to the "right" of "MI_details.png"
	    #And I use CTRL A
	    #And I use BACKSPACE "12" times
	    #And I type "description"
	    #And I use DELETE "18" times
	    #And I wait for "1" seconds 
	    #And I doubleclick on "qvl_Component_Button_Save.png"
	    #And I wait for "1" seconds 
	    #And I click on "Button_Yes.png" if exists

	#}
#Then I should see "qvl_asset_auto_description.png"

#=end
	@@item2 = $automationfileid
	puts "item 2: #{@@item2}"
	#@@item2 = 257609

end


Then(/^I load item default test into QVL$/) do
	steps %Q{
		And I search for "#{@@item1}" in "Media Item Id"
		And I wait "3" seconds
		And I load asset "asset_default_test.png" into QVL
		And I wait "3" seconds
	}
end


Then(/^I select the Tasks - Messaging menu$/) do

	#begin
		step 'I click on "top_task_button.png"'
=begin
		if !@screen.exists "task_messaging_inbox_b.png"
			puts "inbox 1 does not exists"
		else
			@region = @screen.exists "task_messaging_inbox_b.png"
			@region.highlight(7)
		end
		if !@screen.exists "task_messaging_inbox.png"
			puts "inbox 2 does not exists"
		end

		if !@screen.exists "task_messaging_inbox.png" and !@screen.exists "task_messaging_inbox_b.png"
			puts "inbox does not exists"
=end
			steps %Q{
				And I click on either "task_messaging.png" or "task_messaging_b.png"
				And I wait for "1" seconds
				And I use RETURN
			}
=begin
		else
			puts "inbox exists"
		end
=end
	#rescue
	#	steps %Q{
	#		And I type F7
	#	}
	#end
end

Then(/^I should remove all the old test messages$/) do
	begin
		limit = 1
		image = "xxxx_auto_description.png"	
		while @screen.exists image and limit < 9
		    step 'I rightclick on "'+image+'"'
		    step 'I click on "qvl_Component_KeepTab_Delete.png"'		    
		    step 'I click on "white_space2.png"'	    
		    limit = limit + 1
		    sleep 1
		end
	rescue
	end

	begin
		limit = 1
		image = "xxxx_auto_description_.png"	
		while @screen.exists image and limit < 9
		    step 'I rightclick on "'+image+'"'
		    step 'I click on "qvl_Component_KeepTab_Delete.png"'		    
		    step 'I click on "white_space2.png"'	    		    
		    limit = limit + 1
		    sleep 1
		end
	rescue
	end

	begin
		limit = 1
		image = "1111.png"	
		while @screen.exists image and limit < 9
		    step 'I rightclick on "'+image+'"'
		    step 'I click on "qvl_Component_KeepTab_Delete.png"'		    
		    step 'I click on "white_space2.png"'	    		    
		    limit = limit + 1
		    sleep 1
		end
	rescue
	end
	
	begin

		limit = 1
		image = "1111_.png"	
		while @screen.exists image and limit < 9
		    step 'I rightclick on "'+image+'"'
		    step 'I click on "qvl_Component_KeepTab_Delete.png"'		    
		    step 'I click on "white_space2.png"'	    		    
		    limit = limit + 1
		    sleep 1
		end
	rescue
	end
	
	begin

		limit = 1
		image = "0000.png"	
		while @screen.exists image and limit < 9
		    step 'I rightclick on "'+image+'"'
		    step 'I click on "qvl_Component_KeepTab_Delete.png"'		    
		    step 'I click on "white_space2.png"'	    		    
		    limit = limit + 1
		    sleep 1
		end
	rescue
	end
	
	begin

		limit = 1
		image = "0000_.png"	
		while @screen.exists image and limit < 9
		    step 'I rightclick on "'+image+'"'
		    step 'I click on "qvl_Component_KeepTab_Delete.png"'		    
		    step 'I click on "white_space2.png"'	    		    
		    limit = limit + 1
		    sleep 1
		end
	rescue
	end
	
end