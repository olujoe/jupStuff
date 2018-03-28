
When(/^I close the jupiter archive pop up if exists$/) do

	if(@screen.exists "jupiter_archive_popup.png")
			steps %Q{
				And I click on "jupiter_archive_popup.png"
				And I use RETURN
			}
	end
end


When(/^I enter a valid shelf for value$/) do
	if $site == "QA_WS"
		step 'I type "News"'
	else
		step 'I type "BBC3"'
	end
end


Then(/^the status should be "(.*?)"$/) do |status|
	case status.downcase
		when "online"
			step 'I should see "archive_Search_Status_Online.png"'
		when "shelf"
			step 'I should see "archive_Search_Status_Shelf.png"'
		when "onlin + shelf"
			step 'I should see "archive_Search_Status_Online_And_Shelf.png"'
		when "online + shelf + offline"
			step 'I should see "archive_Search_Status_Online_Shelf_Offline.png"'
		when "offline"
			step 'I should see "archive_Search_Status_Offline.png"'
		else
			fail("The code for this item status '#{status}' hasnt been implemented. Please add it")
	end

end


Then(/^the created date and time for the "(.*?)" media should be "(.*?)"$/) do |media,time|

	case media.downcase
		when "new"
			mediaId = $automationfileid
		when "published"
			mediaId = $publishedfileid
		when "placeholder"
			mediaId = $publishedfileid
		else
			fail("The code for this item create type '#{media}', hasnt been implemented. Please add it")
	end

	data = getMediaItemDates(mediaId)
	$createdTime = data[0]
	createdTime = data[0]
	case time
		when "now"
			currentTime = Time.now.utc.strftime("%Y-%m-%d %H:%M:%S")
			timeDiff = Time.parse(currentTime) - Time.parse(createdTime)
			fail("Wrong time got for created time, current time is '#{currentTime}' media item created time is '#{createdTime}'") unless timeDiff < 240
		else
			fail("The code for the created date '#{time}' hasnt been implemented. Please add it")
	end

end


Then(/^the deletion date for the "(.*?)" media should be as specified in the config$/) do |media|
	
	case media.downcase
		when "new"
			mediaId = $automationfileid
			arg1 = "#{$config[$site]['jlib_deletion_period_new']}"
			expectedDeletionPeriod = arg1.to_i
		when "published"
			mediaId = $publishedfileid
			arg1 = "#{$config[$site]['jlib_deletion_period_published']}"
			expectedDeletionPeriod = arg1.to_i
		when "placeholder"
			mediaId = $publishedfileid
			arg1 = "#{$config[$site]['jlib_deletion_period_placeholder']}"
			expectedDeletionPeriod = arg1.to_i
		when "restored"
			mediaId = $publishedfileid
			arg1 = "#{$config[$site]['jlib_deletion_period_restored']}"
			expectedDeletionPeriod = arg1.to_i
		else
			fail("The code for this item create type '#{media}', hasnt been implemented. Please add it")
	end

	data = getMediaItemDates(mediaId)
	deletionDate = data[1]
	currentTime = Time.now.utc.strftime("%Y-%m-%d %H:%M:%S")
	timeDiff = Time.parse(deletionDate) - Time.parse(currentTime)
	expectedDiff = (timeDiff - (arg1.to_f * 60 * 60)).abs
	deletionPeriod = (expectedDiff / (60 * 60)).round
	puts deletionPeriod
	puts expectedDeletionPeriod
	if (media.downcase == "restored")
		fail("Wrong time got for deletion date, current time is '#{currentTime}' media item deletionDate is '#{deletionDate}', deletion period is '#{deletionPeriod}hrs' instead of lower than '#{arg1}hrs'") unless deletionPeriod < (expectedDeletionPeriod + 1)
	else
		fail("Wrong time got for deletion date, current time is '#{currentTime}' media item deletionDate is '#{deletionDate}', deletion period is '#{deletionPeriod}hrs' instead of '#{arg1}hrs'") unless deletionPeriod < (expectedDeletionPeriod + 1)
	end
end


Then(/^I publish a clip$/) do 
	steps %Q{
    	And I click on "qvl_Button_Clear.png"
   		And I click on "qvl_Button_Left_Arrow.png"
   		And I type "i"
   		And I wait "2" seconds
   		And I click on "qvl_Button_Right_Arrow.png"
   		And I wait "2" seconds
   		And I type "o"   
   		And I click on "qvl_Button_Publish.png"

		And I click on "qvl_Radio_Button_Status_Finished.png"
		And I click on "qvl_Radio_Button_Category_Sequence.png"
		And I click on "qvl_Textbox_Story.png"
		And I type "auto"
		And I click on "qvl_Textbox_Details.png"
		And I type "description"
	    And I use TAB
	    And I type the current time

		And I click on "qvl_Button_Publish_And_Deliver.png"
	    And I wait for the deliver popup to appear 
		And I click on "delivery_Button_Deliver.png"
		
		And I wait for "button_remove.png" to disappear
		And I handle any publish name errors
		And I wait "2" seconds
	}

	begin
		steps %Q{
			And I doubleclick on "delivery_queue_control_popup.png,delivery_queue_control_popup2.png" 
		}
	rescue
	end

	steps %Q{
		And I type Alt C
		And I click on "button_Close2.png" if exists
   	}
   	#And I click on "qvl_Button_Deliver.png" if exists
end
#And I wait for "qvl_DeliveryQ_window.png" to appear 
#		And I click on "qvl_Button_Close.png" if exists
#	And I ensure that the jupiter delivery queue control window is displayed


Then(/^I save the published "(.*?)" clips id$/) do |item|
	steps %Q{	
	    And I open the cliplist
	    And I rightclick on "#{item}" and click "rightclick_copy.png"
	    When I click on "shortcut.png"
	    And I wait "3" seconds
	    And I save the published item id
		And I load asset "b_#{item}" into QVL
	}
end


Then(/^I save the published item id$/) do
	shortcut = Clipboard.paste.encode('utf-8')
	id = shortcut.split("]:")[1].split(">>")[0]
	puts id
	$publishedfileid = id 
end


Then(/^I create a placeholder$/) do
	steps %Q{	
		Given I click on "menu_New.png"
		When I click on "placeholder.png"
		And I click on "new_placeholder_story.png"
	    And I type "auto"
	    And I use TAB
	    And I type "placeholder"
	    And I use TAB
	}

	starttime = 0
	currentTime = Time.new
	currentTimeOffset = currentTime + "#{starttime}".to_i
	currentTimeOffsetHourString = currentTimeOffset.hour.to_s   
	currentTimeOffsetMinString = currentTimeOffset.min.to_s

	if currentTimeOffsetHourString.length == 1
	  currentTimeOffsetHourString = "0" + currentTimeOffsetHourString
	end

	if currentTimeOffsetMinString.length == 1
	  currentTimeOffsetMinString = "0" + currentTimeOffsetMinString
	end   

	startcurrentTimeOffsetString = currentTimeOffsetHourString + currentTimeOffsetMinString

	if startcurrentTimeOffsetString.length == 3
	  startcurrentTimeOffsetString = "0" + startcurrentTimeOffsetString
	end  

	@screen.type "#{startcurrentTimeOffsetString}"

	steps %Q{
	    And I click on "new_placeholder_description.png"
	    And I type "test placeholder"
	    And I use TAB
	    And I type "placeholder"
		And I click on "sequence.png"
		And I click on "qvl_Button_Publish2.png"
		And I wait for "qvl_Button_Publish2.png" to disappear
		And I open the cliplist
		Then I should see "asset_auto_placeholder.png"
	}
end



Then(/^I publish a clip to the placeholder$/) do

	steps %Q{
	    Given I click on "qvl_Button_Clear.png"
   		And I click on "qvl_Button_Left_Arrow.png"
   		And I type "i"
   		And I wait "2" seconds
   		And I click on "qvl_Button_Right_Arrow.png"
   		And I wait "2" seconds
   		And I type "o"   
   		And I click on "qvl_Button_Publish.png"


   		And I go to the "publish existsing item" tab
	    And I click on publish popup "asset_auto_placeholder.png" item
	    And I click on "re-publish.png"
	    And I wait for the publish existing tab to disapear


		And I click on "qvl_Radio_Button_Status_Finished.png"
		And I click on "button_Ok.png"
	    And I click on "qvl_Button_Deliver.png" if exists
	    And I wait for "button_remove.png" to disappear
	    And I handle any publish name errors

		Then I should see "asset_placeholder_finished.png"
	}

end


Then(/^the created date for the "(.*?)" media should remain the same$/) do |media|

	case media.downcase
		when "new"
			mediaId = $automationfileid
			expectedDeletionPeriod = 5
		when "published"
			mediaId = $publishedfileid
			expectedDeletionPeriod = 5
		when "placeholder"
			mediaId = $publishedfileid
			expectedDeletionPeriod = 25
		else
			fail("The code for this item create type '#{media}', hasnt been implemented. Please add it")
	end

	data = getMediaItemDates(mediaId)
	createdTime = data[0]
	fail("Meida creation date is not the same. Expecting '#{$createdTime}' but found '#{createdTime}' ") unless createdTime == $createdTime

end


Given(/^I get and save an online items creation and deletion dates$/) do
	#$automationfileid = "243993"
	data = getMediaItemDates($automationfileid)
	@@createdDate = data[0]
	@@deletionDate = data[1]
	puts @@createdDate
	puts @@deletionDate
end


Given(/^I send a shelf item to online \+ shelf \+ offline$/) do

	steps %Q{
		And I restore a shelf item
		When I rightclick on "archive_Search_Status_Online_And_Shelf.png" and click "context_Menu_Keep_Decision.png"
	    And I click on "archive_Search_Checkbox_Offline.png"
		And I click on "archive_Search_Checkbox_Keep_On_Shelf.png"
	    And I click on "button_OK.png" if exists
	    And I wait for "3" seconds
	    And I wait for "button_cancel.png" to disappear
    	And I click on "button_Search.png" until "archive_Search_Status_Online_Shelf_Offline.png" appears eventually

	}

end

Given(/^I send an online item to online \+ shelf$/) do
	steps %Q{
		When I rightclick on "archive_Search_Status_Online.png" and click "context_Menu_Keep_Decision.png"
		And I wait for "keep_decision_popup.png" to appear

		And I click on either "archive_Search_Checkbox_Keep_On_Shelf.png" or "archive_Search_Checkbox_Keep_On_Shelf2.png"
		And I click "40" pixels to the "right" of "for.png"
	}
	if $site == "QA_WS"
		steps %Q{
			And I type "News"
		}
	else
		steps %Q{
			And I type "BBC3"
		}
	end
	steps %Q{
		And I click on "archive_Search_Textbox_Comments.png"
		And I type "testing"
		And I click on "button_Ok.png"
		And I wait for "button_Cancel.png" to disappear

    	And I click on "button_Search.png" until "archive_Search_Status_Online_Shelf.png" appears eventually
    	And I wait for "1" seconds	
	}

end



Given(/^I send an online item to offline$/) do
	steps %Q{
		When I rightclick on "archive_Search_Status_Online.png" and click "context_Menu_Keep_Decision.png"
	    And I click on "archive_Search_Checkbox_Offline.png"
	    And I click on "button_OK.png"
	    And I wait for "3" seconds
	    And I wait for "button_cancel.png" to disappear
    	And I click on "button_Search.png" until "archive_Search_Status_Online_Offline.png" appears eventually
    	And I wait for "1" seconds
		And I rightclick on "archive_Search_Status_Online_Offline.png" 
		And I click on "delete.png"
		And I delete online
	    And I wait for "2" seconds
	}
	begin
		steps %Q{
			And I click on "button_Ok2.png" if exists
			And I click on "button_Ok2.png" if exists
			And I close the Jupiter - Archive popup
			And I click on "button_Search.png"
	    }
	rescue
	end

	retries = 0
	begin

	    tries = 0
	    while ( (@screen.exists "archive_Search_Status_Online_Offline.png") and (tries < 8) )
	    	steps %Q{
	    		And I rightclick on "archive_Search_Status_Online_Offline.png" 
				And I click on "delete.png"
				And I delete online
			    And I wait for "2" seconds
				And I click on "button_Ok2.png" if exists
				And I click on "button_Ok2.png" if exists
				And I close the Jupiter - Archive popup
				And I wait for "5" seconds
				And I click on "button_Search.png"
	    	}
		    tries = tries + 1
		end

	rescue

		if retries < 3
			retries = retries + 1
			retry
		else
			fail "Unable to delete the online instance of an online + offline item"
		end

	end

end


Then(/^the created date should remain the same$/) do
	data = getMediaItemDates($automationfileid)
	createdDate = data[0]
	timeDiff = Time.parse(@@createdDate) - Time.parse(createdDate)
	puts "created time diff: #{timeDiff}"
	fail("The created date has changed, expecting '#{@@createdDate}' but got '#{createdDate}' ") unless timeDiff < 1
end


Then(/^the deletion date should remain the same$/) do
	data = getMediaItemDates($automationfileid)
	deletionDate = data[1]
	timeDiff = Time.parse(@@deletionDate) - Time.parse(deletionDate)
	puts "deletionDate time diff: #{timeDiff}"
	fail("The deletion date has changed, expecting '#{@@deletionDate}' but got '#{deletionDate}' ") unless timeDiff < 1
end


Given(/^I send an online \+ offline item to offline$/) do

	#@@createdDate = "2015-03-31 12:07:44"
	#@@deletionDate = "2015-04-02 10:07:44"
	retrys = 0
	begin
		steps %Q{
			Given I rightclick on "archive_Search_Status_Online_Offline.png" and click "delete.png"
			And I delete online
			And I click on "button_Search.png"
			And I wait for "archive_Search_Status_Offline.png" to appear
	    }
	rescue
		if !@screen.exists "archive_Search_Status_Offline.png"
			if (retrys < 5)
				sleep 20
				retrys = retrys + 1
				retry
			else
				fail("Unable to delete the online instance of a media item. Probably awaiting a joe job")
			end
		end
	end

end


Then(/^there should be no deletion date$/) do
	data = getMediaItemDates($automationfileid)
	deletionDate = data[1]
	puts "deletionDate: #{deletionDate}"
	fail("The deletion date is wrong, expecting '' but got '#{deletionDate}' ") unless deletionDate == ""
end


Then(/^the status should be online \+ shelf$/) do
	step 'I should see "archive_Search_Status_Online_And_Shelf.png"'
end

Then(/^the status should be online \+ offline$/) do
	step 'I should see "archive_Search_Status_Online_Offline.png"'
end

Then(/^the status should be online \+ shelf \+ offline$/) do
	step 'I should see "archive_Search_Status_Online_Shelf_Offline.png"'
end


Then(/^the created date should be now$/) do
	data = getMediaItemDates($automationfileid)
	createdDate = data[0]

	currentTime = Time.now.utc.strftime("%Y-%m-%d %H:%M:%S")
	timeDiff = Time.parse(createdDate) - Time.parse(currentTime)
	timeDiff = timeDiff.abs

	puts "time diff: #{timeDiff}"
	fail("The created date has changed, expecting '#{now}' but got '#{createdDate}' ") unless timeDiff < 1
end


Then(/^the online deletion date should be the next date after midnight$/) do
  	step 'the deletion date for the "new" media should be as specified in the config' # express the regexp above with the code you wish you had
end


Given(/^I delete the online instance of an online \+ shelf item$/) do
	steps %Q{
		Given I rightclick on "archive_Search_Status_Online_And_Shelf.png" and click "delete.png"
		And I delete online
		And I click on "button_Search.png" until "archive_Search_Status_Shelf.png" appears
    }
end


Given(/^I delete the online instance of an online \+ offline item$/) do
	steps %Q{
		Given I rightclick on "archive_Search_Status_Online_Offline.png" and click "delete.png"
		And I delete online
		And I click on "button_Search.png" until "archive_Search_Status_Offline.png" appears
    }
end


Given(/^I delete the offline instance of an shelf \+ offline item$/) do
	steps %Q{
		Given I rightclick on "archive_Search_Status_Shelf_Offline.png" and click "delete_offline.png"
		And I delete offline
		Then I should not see "archive_Search_Status_Shelf_Offline.png"
    }
end


Then(/^the status should be shelf$/) do
	step 'I should see "archive_Search_Status_Shelf.png"'
end

Then(/^the status should be shelf and offline$/) do
	step 'I should see "archive_Search_Status_Shelf_Offline.png"'
end


Then(/^the online deletion date should not exist$/) do
	data = getMediaItemDates($automationfileid)
	deletionDate = data[1]
	puts "deletionDate: #{deletionDate}"
	fail("The deletion date is wrong, expecting '' but got '#{deletionDate}' ") unless deletionDate == ""
end


Given(/^I restore a shelf item$/) do
	steps %Q{
		Given I rightclick on "archive_Search_Status_Shelf.png" and click "archive_Rightclick_Restore.png"
	}
	if($site == "QA_USA")
		steps %Q{
			And I click on "button_OK7.png"
			And I click on "button_Search.png" until "archive_Search_Status_Online_And_Shelf.png" appears
		}
	else
		steps %Q{
			And I click on "button_restore2.png" if exists
			And I click on "button_Ok4.png" if exists
			And I click on "button_restore2.png" if exists
			And I click on "button_Ok4.png" if exists
			And I click on "button_Search.png" until "archive_Search_Status_Online_And_Shelf.png" appears soon
	    }
	end
end


Given(/^I restore a shelf and offline item$/) do
	steps %Q{
		Given I rightclick on "archive_Search_Status_Shelf_Offline.png" and click "archive_Rightclick_Restore.png"
		And I click on "button_Ok4.png" if exists
		And I click on "button_restore2.png" if exists
		And I click on "button_Ok4.png" if exists
		And I click on "button_Search.png" until "archive_Search_Status_Online_Shelf_Offline.png" appears
    }
end


Given(/^I delete the shelf instance of an online \+ shelf item$/) do
	steps %Q{
		Given I rightclick on "archive_Search_Status_Online_And_Shelf.png" and click "delete.png"		
		And I delete shelf
		And I click on "button_Search.png" until "archive_Search_Status_Online.png" appears
    }
end

Given(/^I delete the shelf instance of an online \+ shelf \+ offline item$/) do
	steps %Q{
		Given I rightclick on "archive_Search_Status_Online_Shelf_Offline.png" and click "delete.png"		
		And I delete shelf
		And I click on "button_Search.png" until "archive_Search_Status_Online_Offline.png" appears
    }
end



Given(/^I delete the online instance of an online \+ shelf \+ offline item$/) do
	steps %Q{
		Given I rightclick on "archive_Search_Status_Online_Shelf_Offline.png" and click "delete.png"		
		And I delete online
		And I click on "button_Search.png" until "archive_Search_Status_Shelf_Offline.png" appears
    }
end


Then(/^the status should be online$/) do
	step 'I should see "archive_Search_Status_Online.png"'
end


Then(/^the shelf deletion date should not exist$/) do
  #pending # express the regexp above with the code you wish you had
end


Given(/^I restore an offline item$/) do
  	steps %Q{
  		And I empty the clip list
		Given I rightclick on "archive_Search_Status_Offline.png" and click "archive_Rightclick_Restore.png"	
		And I click on "button_no.png" if exists
		And I click on "original_media_item.png" if exists
		And I wait for "3" seconds
		And I click on "button_restore2.png" if exists
		And I wait for "2" seconds
		And I click on "button_restore2.png" if exists
		And I click on "button_Ok4.png" if exists

		And I click on "button_Search.png" until "archive_Search_Status_Online_Offline.png" appears
	    And I load asset "asset_auto_description.png" into QVL

	}
=begin
  #pending # express the regexp above with the code you wish you had
  		And I wait for "qvl_Button_Publish2.png" to appear

		And I click on "new_placeholder_story.png"
	    And I type "auto"
	    And I use TAB
	    And I type "description"
	    And I click on "new_placeholder_description.png"
	    And I type "test item"
	    And I use TAB
	    And I type "test"
		And I click on "sequence.png"
		And I click on "qvl_Button_Publish2.png"
		Then I should not see "button_Cancel.png"
		And I save the published "asset_auto_description.png" clips id
=end

end


Then(/^the shelf deletion date should remain the same$/) do
  #pending # express the regexp above with the code you wish you had
end


Then(/^the shelf deletion date should in (\d+)days$/) do |arg1|
  #pending # express the regexp above with the code you wish you had
end