
Then(/^I deliver item "(.*?)" to ITA dual file destination$/) do |item|
	steps %Q{
		And I rightclick on "#{item}" and click "RCM_deliver.png"
		Then I should see "qvl_TX_Destination_window.PNG"
		And I empty the delivery list
		And I add a delivery item

		When I click on "white_space2.png"

		When I rightclick on "ita_dual_file_result.png"
		When I click on "white_space2.png"
		When I click on "ita_dual_file_result.png" if exists
		And I click on "selected_checkbox.png"
		
		And I click on "button_deliver.png"
		And I wait for "button_Cancel.png" to disappear
		And I wait for "button_Cancel.png" to disappear
	}
end


Then(/^I close the tx destination popup$/) do
	steps %Q{
		And I click on "button_Cancel.png"
		And I wait for "button_remove.png" to disappear
	}
end


Then(/^I empty all test files from the delivery location$/) do
	url = $config['Delivery']['location']
	#binding.pry
	allfiles = Dir.entries(url)
	allfiles.each do |file|
		if (file.include? ".mpg") or (file.include? ".xml")
			File.delete(url+"\\"+file)
		end
	end

end


Then(/^I should not have any files in the delivery location$/) do
	url = $config['Delivery']['location']
	counts = 0
	allfiles = Dir.entries(url)
	allfiles.each do |file|
		if (file.include? ".mpg") or (file.include? ".xml")
			counts = counts + 1
		end
	end

	fail "Expected to find '0' files in the delivery location but found '#{counts}'" if counts > 0
end


Then(/^I open the delivery queue$/) do
	tries = 0
	#begin
		if !@screen.exists "delivery_queue_control_popup.png"

			steps %Q{
				Given I open the task menu section
			}

			if (@screen.exists "ita_dual_file_folder.png") 
				steps %Q{
					Given I doubleclick on "ita_dual_file_folder.png" 
				}
			else

				steps %Q{
					And I click on "deliver_export_folder.png" if exists
					And I doubleclick on "deliver_export_folder_b.png" until "deliveryQueues_folder.png" appears
					And I click on "deliveryQueues_folder.png" if exists
					And I doubleclick on "deliveryQueues_folder_b.png" until "dubbing_folder.png" appears
					And I click on "dubbing_folder.png" if exists
					And I doubleclick on "dubbing_folder_b.png" 
					And I use RETURN
				}

				sleep 1
				if (@screen.exists "ita_dual_file_folder.png")
					steps %Q{
						And I doubleclick on either "ita_dual_file_folder.png" or "ita_dual_file_folder_b.png"
					}
				else
					steps %Q{
						And I doubleclick on "dubbing_folder_b.png" 
						And I use RETURN
						And I doubleclick on either "ita_dual_file_folder.png" or "ita_dual_file_folder_b.png"
					}
				end

			end

			
			for x in @screen.findAll "taskbar_Icon.png"
			
				@screen.click x
				sleep 2
				if !@screen.exists "menu_New.png"
					@screen.click x
				end

				if @screen.exists "delivery_queue_control_popup.png"
					break
				end

			end


		end

		if !@screen.exists "delivery_queue_control_popup.png"
			retryOpenDeliveryQue()
		end
		if !@screen.exists "delivery_queue_control_popup.png"
			retryOpenDeliveryQue()
		end
=begin
	rescue
		if tries < 2
			tries = tries + 1
			steps %Q{
				And I close all popups
			}
			retry
		else
			fail "Unable to open the delivery queue"
		end
	end
=end
end



Then(/^I open the bbc left delivery queue$/) do
	sleep 2
	if !@screen.exists "delivery_queue_control_popup.png"

		steps %Q{
			Given I open the task menu section
		}

		if (@screen.exists "ita_dual_file_folder.png") 
			steps %Q{
				Given I doubleclick on "bbc_left_file_folder.png" 
			}
		else

			steps %Q{
				And I click on "deliver_export_folder.png" if exists
				And I doubleclick on "deliver_export_folder_b.png" until "deliveryQueues_folder.png" appears
				And I click on "deliveryQueues_folder.png" if exists
				And I doubleclick on "deliveryQueues_folder_b.png" until "dubbing_folder.png" appears
				And I click on "dubbing_folder.png" if exists
				And I doubleclick on "dubbing_folder_b.png" 
				And I use RETURN
			}

			sleep 1
			if (@screen.exists "bbc_left_file_folder.png")
				steps %Q{
					And I doubleclick on either "bbc_left_file_folder.png" or "bbc_left_file_folder_b.png"
				}
			else
				steps %Q{
					And I doubleclick on "dubbing_folder_b.png" 
					And I use RETURN
					And I doubleclick on either "bbc_left_file_folder.png" or "bbc_left_file_folder_b.png"
				}
			end

		end

		for x in @screen.findAll "taskbar_Icon.png"
			@screen.click x
			sleep 2
			if !@screen.exists "menu_New.png"
				@screen.click x
			end

			if @screen.exists "delivery_queue_control_popup.png"
				break
			end
		end

	end

	if !@screen.exists "delivery_queue_control_popup.png"
		retryOpenDeliveryQue()
	end
	if !@screen.exists "delivery_queue_control_popup.png"
		retryOpenDeliveryQue()
	end
end


def retryOpenDeliveryQue()

	if !@screen.exists "delivery_queue_control_popup.png"

		if @screen.findAll("taskbar_Icon.png").count > 1

			for x in @screen.findAll "taskbar_Icon.png"
				@screen.click x
				sleep 2
				if !@screen.exists "menu_New.png"
					@screen.click x
				end

				if @screen.exists "delivery_queue_control_popup.png"
					break
				end
			end

		else

			steps %Q{
				Given I open the task menu section
			}

			if (@screen.exists "ita_dual_file_folder.png") 
				steps %Q{
					Given I doubleclick on "ita_dual_file_folder.png" 
				}
			else

				steps %Q{
					And I click on "deliver_export_folder.png" if exists
					And I doubleclick on "deliver_export_folder_b.png" until "deliveryQueues_folder.png" appears
					And I click on "deliveryQueues_folder.png" if exists
					And I doubleclick on "deliveryQueues_folder_b.png" until "dubbing_folder.png" appears
					And I click on "dubbing_folder.png" if exists
					And I doubleclick on "dubbing_folder_b.png" 
					And I use RETURN
				}

				sleep 1
				if (@screen.exists "ita_dual_file_folder.png")
					steps %Q{
						And I doubleclick on either "ita_dual_file_folder.png" or "ita_dual_file_folder_b.png"
					}
				else
					steps %Q{
						And I doubleclick on "dubbing_folder_b.png" 
						And I use RETURN
						And I doubleclick on either "ita_dual_file_folder.png" or "ita_dual_file_folder_b.png"
					}
				end

			end
			
			for x in @screen.findAll "taskbar_Icon.png"
				@screen.click x
				sleep 2
				if !@screen.exists "menu_New.png"
					@screen.click x
				end

				if @screen.exists "delivery_queue_control_popup.png"
					break
				end
			end

		end

	end

end

Given /^I should see the "(.*?)" result$/ do |bitmap|
	tries = 0
	begin
		if !@screen.exists bitmap
			steps %Q{
				And I go to the "transmissions" tab
				And I wait for "1" seconds
				And I go to the "general" tab
				Then I should see "#{bitmap}" now
			}
		end
	rescue
		if tries > 3
			fail("The following bitmap cannot be found: " + bitmap )
		else
			tries = tries + 1
			sleep 1
			retry
		end
	end
end


Then(/^I empty the delivery list$/) do
	tries = 0
	begin
		if((@screen.exists "ita_dual_file_result.png") || (@screen.exists "file_bbc_left2.png"))
			steps %Q{
				And I click on either "ita_dual_file_result.png" or "file_bbc_left2.png"
				And I use CTRL A
				And I wait for "1" seconds
				And I click on "button_remove2.png"
			}
		end
		if(@screen.exists "file_rbm_cbbc.png")
			steps %Q{
				And I click on "file_rbm_cbbc.png"
				And I use CTRL A
				And I wait for "1" seconds
				And I click on "button_remove2.png"
			}
		end

		if(@screen.exists "normal.png")
			steps %Q{
				And I rightclick on "normal.png"
				And I use RETURN
				And I use CTRL A
				And I wait for "1" seconds
				And I click on "button_remove2.png"
			}
		end
	rescue
		if tries < 3
			tries = tries + 1
			steps %Q{
				When I click on either "white_space2.png" or "white_space.png"
			}
			retry
		else
			fail "Unable to empty the delivery list"
		end
	end

end


Then(/^I add a delivery item$/) do
	steps %Q{
		When I click on "qvl_Button_Add.png"
		And I click on "destination_dropdown.png" 
		And I click on "ITA_dual_file.png"
		And I click on "button_Ok.png"
		And I wait for "ita_dual_file_result.png" to appear
		And I click on either "white_space2.png" or "white_space.png"
	}
end


Then(/^I add a bbc left delivery item$/) do
	steps %Q{
		When I click on "qvl_Button_Add.png"
		And I click on "destination_dropdown.png" 
		And I click on "file_bbc_left3.png"
		And I click on "button_Ok.png"
		And I wait for "file_bbc_left_result.png" to appear
		And I click on either "white_space2.png" or "white_space.png"
	}
end


Then(/^I add a delivery destination$/) do
	steps %Q{
		When I click on "qvl_Button_Add.png"
		And I click on "destination_dropdown.png" 
	}
	if $site == "QA_W1"
		steps %Q{
			And I click on "file_bbc_left3.png" 
		}
	elsif $site == "QA_WS"
		steps %Q{
			And I use DOWNARROW
			And I use RETURN
		}
	else
		steps %Q{
			And I type "File 1"
			And I use RETURN
		}
	end
	steps %Q{
		And I wait for "1" seconds
		And I click on "button_Ok.png"
		And I click on either "white_space2.png" or "white_space.png"
	}
end

Then(/^I add a RBM CBBC delivery item$/) do
	steps %Q{
		When I click on "qvl_Button_Add.png"
		And I click on "destination_dropdown.png" 
		And I click on "rbm_cbbc.png"
		And I click on "button_Ok.png"
		And I wait for "rbm_cbbc2.png" to appear
		And I click on either "white_space2.png" or "white_space.png"
	}
end


Then(/^I change the item status to finished$/) do
	steps %Q{
		When I go to the "Description" page
		And I go to the "general" tab 
		And I change the MI decription status to "Finished"
		And I go to the "media search result" page
		And I wait for "2" seconds
		When I click on "white_space2.png"
	}
end


Then(/^I enter a programme id$/) do
	steps %Q{
		
	    And I go to the "Archive" page
	    And I go to the "Catalogue" tab
	    And I click "40" pixels to the "right" of "programme_id.png"
	    And I type "QATEST"
	    And I use TAB
	    And I type "01"
		And I click on "MI_Archive_SaveButton.PNG"
		And I wait for any not responding message to disappear

	}
end



Then(/^I change the item status to finished with name change$/) do
	steps %Q{
		When I go to the "Description" page
		And I go to the "general" tab 
	    And I click "20" pixels to the "right" of "MI_details.png"
	    And I use CTRL A
	    And I use BACKSPACE "15" times
	    And I wait for "1" seconds 
	    And I type "finished"
	    And I wait for "1" seconds 
	    And I use DELETE "18" times
	    And I wait for "1" seconds 
	    And I doubleclick on "qvl_Component_Button_Save.png"
	    And I wait for any not responding message to disappear

	    And I go to the "Archive" page
	    And I go to the "Catalogue" tab
	    And I click "40" pixels to the "right" of "programme_id.png"
	    And I type "QATEST"
	    And I use TAB
	    And I type "01"
		And I click on "MI_Archive_SaveButton.PNG"
		And I wait for any not responding message to disappear

	    When I go to the "Description" page
		And I change the MI decription status to "Finished"
		And I go to the "media search result" page
		And I wait for "2" seconds
		When I click on "white_space2.png"
	}
end


Then(/^I get media items with name auto-description$/) do

	steps %Q{
		And I duplicate an existing media item and load the item to QVL
		And I go to the "Description" page
		And I click on "qvl_Component_GeneralTab.png"
	    And I wait for "MI_story.png" to appear
	    And I click "20" pixels to the "right" of "MI_story.png"
	    And I use CTRL A
	    And I use BACKSPACE "19" times
	    And I use DELETE "10" times
	    And I type "auto"
	    And I click "20" pixels to the "right" of "MI_details.png"
	    And I use CTRL A
	    And I use BACKSPACE "12" times
	    And I type "description"
	    And I use DELETE "15" times
	    And I wait for "1" seconds 
	    And I doubleclick on "qvl_Component_Button_Save.png"
	    And I click on "Button_Yes.png" if exists
	    And I wait for "2" seconds 

	}

end

Then(/^I get media items with name auto-del$/) do

	steps %Q{
		And I duplicate an existing media item and load the item to QVL
		And I go to the "Description" page
		And I click on "qvl_Component_GeneralTab.png"
	    And I wait for "MI_story.png" to appear
	    And I click "20" pixels to the "right" of "MI_story.png"
	    And I use CTRL A
	    And I use BACKSPACE "19" times
	    And I use DELETE "10" times
	    And I type "auto"
	    And I click "20" pixels to the "right" of "MI_details.png"
	    And I use CTRL A
	    And I use BACKSPACE "12" times
	    And I type "del"
	    And I use DELETE "15" times
	    And I wait for "1" seconds 
	    And I doubleclick on "qvl_Component_Button_Save.png"
	    And I click on "Button_Yes.png" if exists
	    And I wait for "2" seconds 

	}

end


Then(/^I create a component for the media item$/) do
	# create a component
	steps %Q{
		And I click on "qvl_Button_Clear.png"
		And I click on "qvl_Button_Left_Arrow.png"
	    And I wait "1" seconds
	    And I type "i"
	    And I click on "qvl_Button_Right_Arrow.png"
	    And I wait "1" seconds
	    And I type "o"
	    And I click on "qvl_Button_New.png"
		And I wait for any not responding message to disappear
		And I click on "qvl_Dropdown_Component.png" with noHighlight
	    And I clear any errors encountered
	    And I click on "qvl_Component_Button_Edit.png"
	    And I clear any errors encountered
	    And I waitAndclick on "qvl_Rights_Component_Story_Dropdown.png"
	    And I type "auto"
	    And I use TAB
	    And I type "auto"
	    And I waitAndclick on "qvl_Component_Button_Save.png"

	}
end


Then(/^I create a second component for the media item$/) do
	# create a component
	steps %Q{
		And I click on "qvl_Button_Clear.png"
		And I click on "qvl_Button_Left_Arrow.png"
	    And I wait "1" seconds
	    And I type "i"

	    And I wait "1" seconds	
	    And I type "l"    
	    And I type "l"    
	    And I type "l"    
	    And I type "l"    
	    And I wait "1" seconds
	    And I type "o"
	    And I click on "qvl_Button_New.png"
		And I wait for any not responding message to disappear
		And I click on "qvl_Dropdown_Component.png" with noHighlight
	    And I clear any errors encountered
	    And I click on "qvl_Component_Button_Edit.png"
	    And I clear any errors encountered
	    And I waitAndclick on "qvl_Rights_Component_Story_Dropdown.png"
	    And I type "auto"
	    And I use TAB
	    And I type "test"
	    And I waitAndclick on "qvl_Component_Button_Save.png"

	}
end


Then(/^I enter "(.*?)" into the redbee programme field$/) do |text|
	steps %Q{
		And I click "20" pixels to the "right" of "programme_id_section.png"
	    And I use CTRL A
	    And I use BACKSPACE "19" times
	    And I use DELETE "10" times
	    And I type "#{text}"
	}
end


Then(/^I enter "(.*?)" into the redbee programme version field$/) do |text|
	steps %Q{
		And I click "20" pixels to the "right" of "programme_id_section.png"
		And I wait for "1" seconds
	    And I use TAB
	    And I use CTRL A
	    And I use BACKSPACE "3" times
	    And I use DELETE "2" times
	    And I type "#{text}"
	}
end

Then(/^I select the second component part$/) do
	steps %Q{
	    And I click on "delivery_second_component_part.png"
	}
end

Then(/^I should see the overlapping parts error message$/) do
	steps %Q{
	    And I should see "overlapping_parts_error.png"
		Then I should see "error_triangle.png"
	}
end


Then(/^I clear the redbee destination folder$/) do
	url = $config['Delivery']['redbee_location']
	allfiles = Dir.entries(url)
	allfiles.each do |file|
		if(!file.include? ".tmp") and (file.length > 4)

			nee = url+"\\"+file
			nee = nee.gsub("\\\\","\\")

			if(File.directory?(nee))
				
				folder = Dir.entries(nee)
				folder.each do |eachfile|

					if(!eachfile.include? ".tmp") and (eachfile.length > 4)
						puts "Deleting: "+nee+"\\"+eachfile
						File.delete(nee+"\\"+eachfile)
					end

				end

			end

			#puts "Deleting: "+nee
			command = `rmdir "#{nee}"`
			puts command
		end
	end

end



Then(/^I open the RBM delivery queue$/) do

	tries = 0
	begin
		if !@screen.exists "delivery_queue_control_popup.png"

			steps %Q{
				Given I open the task menu section
			}

			if (@screen.exists "rbm_four_file_folder.png") 
				steps %Q{
					Given I doubleclick on "rbm_four_file_folder.png" 
				}
			else

				steps %Q{
					And I click on "deliver_export_folder.png" if exists
					And I doubleclick on "deliver_export_folder_b.png" until "deliveryQueues_folder.png" appears
					And I click on "deliveryQueues_folder.png" if exists
					And I doubleclick on "deliveryQueues_folder_b.png" until "dubbing_folder.png" appears
					And I click on "dubbing_folder.png" if exists
					And I doubleclick on "dubbing_folder_b.png" 
					And I use RETURN
				}

				sleep 1
				if (@screen.exists "rbm_four_file_folder.png")
					steps %Q{
						And I doubleclick on either "rbm_four_file_folder.png" or "rbm_four_file_folder_b.png"
					}
				else
					steps %Q{
						And I doubleclick on "dubbing_folder_b.png" 
						And I use RETURN
						And I doubleclick on either "rbm_four_file_folder.png" or "rbm_four_file_folder_b.png"
					}
				end

			end

			sleep 2

			for x in @screen.findAll "taskbar_Icon.png"
				@screen.click x
				sleep 2
				if !@screen.exists "menu_New.png"
					@screen.click x
				end

				if @screen.exists "delivery_queue_control_popup.png"
					break
				end
			end

		end

		if !@screen.exists "delivery_queue_control_popup.png"
			retryOpenRBMDeliveryQueue()
		end
		if !@screen.exists "delivery_queue_control_popup.png"
			retryOpenRBMDeliveryQueue()
		end
	rescue
		if tries < 3
			tries = tries + 1
			retry
		else
			fail "Unable to open the delivery queue"
		end
	end
end

def retryOpenRBMDeliveryQueue()

	if !@screen.exists "delivery_queue_control_popup.png"

		if @screen.findAll("taskbar_Icon.png").count > 1

			for x in @screen.findAll "taskbar_Icon.png"
				@screen.click x
				sleep 2
				if !@screen.exists "menu_New.png"
					@screen.click x
				end

				if @screen.exists "delivery_queue_control_popup.png"
					break
				end
			end

		else

			steps %Q{
				Given I open the task menu section
			}

			if (@screen.exists "rbm_four_file_folder.png") 
				steps %Q{
					Given I doubleclick on "rbm_four_file_folder.png" 
				}
			else

				steps %Q{
					And I click on "deliver_export_folder.png" if exists
					And I doubleclick on "deliver_export_folder_b.png" until "deliveryQueues_folder.png" appears
					And I click on "deliveryQueues_folder.png" if exists
					And I doubleclick on "deliveryQueues_folder_b.png" until "dubbing_folder.png" appears
					And I click on "dubbing_folder.png" if exists
					And I doubleclick on "dubbing_folder_b.png" 
					And I use RETURN
				}

				sleep 1
				if (@screen.exists "rbm_four_file_folder.png")
					steps %Q{
						And I doubleclick on either "rbm_four_file_folder.png" or "rbm_four_file_folder_b.png"
					}
				else
					steps %Q{
						And I doubleclick on "dubbing_folder_b.png" 
						And I use RETURN
						And I doubleclick on either "rbm_four_file_folder.png" or "rbm_four_file_folder_b.png"
					}
				end

			end
			
			for x in @screen.findAll "taskbar_Icon.png"
				@screen.click x
				sleep 2
				if !@screen.exists "menu_New.png"
					@screen.click x
				end

				if @screen.exists "delivery_queue_control_popup.png"
					break
				end
			end

		end

	end

end


Then(/^I should see the item folder in the delivery destination$/) do
	url = $config['Delivery']['redbee_location']
	allfiles = Dir.entries(url)
	number = 0
	allfiles.each do |file|
		if(!file.include? ".tmp") and (file.length > 4)
			number = number + 1
			currentTime = Time.now.utc.strftime("%Y_%m_%d")
			filename = "QATEST#01_#{currentTime}_"
			fail("Filename found in RBM delivery folder does not have the right name. Expecting '#{filename}' but found '#{file}'") if !file.include? filename
		end
	end
	#fail("Expecting to find 2 folders but found '#{number}' in the redbee delivery folder") if number != 2
end



Then(/^I should see a mxf and xml files with the correct labels in the delivery folder$/) do
	url = $config['Delivery']['redbee_location']
	allfiles = Dir.entries(url)
	allfiles.each do |file|
		if(!file.include? ".tmp") and (file.length > 4)
			nee = url+"\\"+file
			nee = nee.gsub("\\\\","\\")
			folder = Dir.entries(nee)

			number = 0
			folder.each do |eachfile|
				if(!eachfile.include? ".tmp") and (eachfile.length > 4)
					number = number + 1
					filename1 = "QATEST#01.mxf"
					filename2 = "QATEST#01.xml"
					fail("wrong xml or mxf file type/name found. Found '#{eachfile}' but expecting either '#{filename1}' or '#{filename2}' ") if !((eachfile == filename1) or (eachfile == filename2))
				end
			end
			fail("Expecting to find 2 files but found '#{number}' in the redbee delivery folder") if number != 2

		end
	end
end



Then(/^the redbee xml files should contain the correct values for "(.*?)"$/) do |vals|
	
	if vals == "test1"
		xml =[
			"<fbd:intended_channel>5015</fbd:intended_channel>",
			"<fbd:HD>true</fbd:HD>",
			"<fbd:scan_type>i</fbd:scan_type>",
			"<fbd:aspect_ratio>16F16</fbd:aspect_ratio>",
			"<fbd:uid>QATEST/01</fbd:uid>",
			'<fbd:file name="QATEST#01.mxf" type="video" checksum',
			"<fbd:programme_start>10:00:00:00</fbd:programme_start>",
			"<fbd:programme_end>10:01:",
			#'<fbd:part sequence="1" part_start="10:00:00:00" part_end="10:00:',
			"<fbd:series_title>Test Series Title</fbd:series_title>",
			"<fbd:programme_title>Test Programme Title</fbd:programme_title>",
			"<fbd:technical_review_pass>false</fbd:technical_review_pass>",
			"<fbd:harding_pass>false</fbd:harding_pass>",
			"<fbd:editor_signature>Test Editor Signature</fbd:editor_signature>",
			"<fbd:sourceApplication>West1 Jupiter</fbd:sourceApplication>",
			"<fbd:sourceReference>Jupiter name: DEFAULT/FINISHED"
		]

		notcontain = [
			'<fbd:part sequence="2"',
			"<fbd:series_title>QA Test Series</fbd:series_title>",
			"<fbd:programme_title>QA Test Programme</fbd:programme_title>",
			"<fbd:editor_signature>QA Editor Signature</fbd:editor_signature>"
		]
	else
		xml =[
			"<fbd:intended_channel>5015</fbd:intended_channel>",
			"<fbd:HD>true</fbd:HD>",
			"<fbd:scan_type>i</fbd:scan_type>",
			"<fbd:aspect_ratio>16F16</fbd:aspect_ratio>",
			"<fbd:uid>QATEST/01</fbd:uid>",
			'<fbd:file name="QATEST#01.mxf" type="video" checksum',
			"<fbd:programme_start>10:00:00:00</fbd:programme_start>",
			#{}"<fbd:programme_end>10:00:08:00</fbd:programme_end>",
			"<fbd:programme_end>10:01:",
			#'<fbd:part sequence="1" part_start="10:00:00:00" part_end="10:00:',
			"<fbd:series_title>QA Test Series</fbd:series_title>",
			"<fbd:programme_title>QA Test Programme</fbd:programme_title>",
			"<fbd:technical_review_pass>false</fbd:technical_review_pass>",
			"<fbd:harding_pass>false</fbd:harding_pass>",
			"<fbd:editor_signature>QA Editor Signature</fbd:editor_signature>",
			"<fbd:sourceApplication>West1 Jupiter</fbd:sourceApplication>",
			"<fbd:sourceReference>Jupiter name: DEFAULT/FINISHED"
		]

		notcontain = [
			'<fbd:part sequence="2"',
			"<fbd:series_title>Test Series Title</fbd:series_title>",
			"<fbd:programme_title>Test Programme Title</fbd:programme_title>",
			"<fbd:editor_signature>Test Editor Signature</fbd:editor_signature>"
		]
	end

	url = $config['Delivery']['redbee_location']
	allfiles = Dir.entries(url)
	allfiles.each do |file|

		currentTime = Time.now.utc.strftime("%Y_%m_%d")
		filename = "QATEST#01_#{currentTime}_"

		if(!file.include? ".tmp") and (file.length > 4) and (file.include? filename)
			nee = url+"\\"+file
			nee = nee.gsub("\\\\","\\")
			folder = Dir.entries(nee)

			folder.each do |eachfile|

				if(eachfile.include? ".xml") 
					xmlfile = nee + "\\" + eachfile
					text = File.read(xmlfile)

					# check that the xml has the expected data
					xml.each do |data|
						fail("The redbee delivery xml '#{xmlfile}' is missing '#{data}' data") if !(text.include? data)
					end

					# check that the xml does not contain the not expected data
					notcontain.each do |data|
						fail("The redbee delivery xml '#{xmlfile}' should not have '#{data}' data") if (text.include? data)
					end

				end

			end

		end
	end
end


Then(/^I open the delivery history section$/) do
	if(@screen.exists "delivery_queue.png")
		steps %Q{
			And I click on "button_fetch.png"
		}
	else
		steps %Q{
			And I click on "queue_open_history_button.png"
			And I click on "show_queue_from_arrows.png"
			And I click on "show_queue_from_arrows.png"
			And I click on "button_fetch.png"
		}
	end
end

Then(/^I unpause the delivery queue$/) do

	if(@screen.exists "queue_paused.png")
		steps %Q{
			Given I click on "more_button.png" if exists
			And I click on "unpauseQ_button.png"
		}
	end

end

Then(/^I pause the delivery queue$/) do

	if(!@screen.exists "queue_paused.png")
		steps %Q{
			Given I click on "more_button.png" if exists
			And I click on "pauseQ_button.png"
		}
	end

end