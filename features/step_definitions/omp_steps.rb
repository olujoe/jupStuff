
Then(/^I empty the omp log file$/) do 
	files = "//zgbwcfs3005.jupiter.bbc.co.uk/QA/Jenkins/Jupiter/omp.txt"
	f = File.open(files,'w')
	f.write("")
end


Then(/^I create all the required omp media files from item "(.*?)" for "(.*?)"$/) do |sourcefile,destination|

	ompfile_sound = ["BK","MO","LT","RT","ST"]
	ompfile_prefix = "IMX"
	ompfile_story = "BTOMP"

	ompfile_sound.each do |sound|

		createOmpNewMediaItem(sourcefile)

		description = "File delivery (#{destination}) via FDA - Sound Format (#{sound})"
		clipname = "#{ompfile_prefix}#{destination}#{sound}"

		files = "//zgbwcfs3005.jupiter.bbc.co.uk/QA/Jenkins/Jupiter/omp.txt"
		f = File.open(files,'a')
		logdata = "#{$automationfileid} - #{ompfile_story}/#{ompfile_prefix}#{destination}#{sound} - #{description}\n"
		f.write(logdata)
		f.close

		steps %Q{

			And I search for "#{$automationfileid}" in "Media Item Id"
			And I wait "3" seconds
			And I load asset "asset_default_test.png" into QVL
			And I wait "3" seconds

			And I go to the "Description" page
			And I click on "qvl_Component_GeneralTab.png"
		    And I wait for "MI_story.png" to appear
		    And I click "20" pixels to the "right" of "MI_story.png"
		    And I use CTRL A
		    And I use BACKSPACE "19" times
		    And I use DELETE "10" times
		    And I type "#{ompfile_story}"
		    And I click "20" pixels to the "right" of "MI_details.png"
		    And I use CTRL A
		    And I use BACKSPACE "12" times
		    And I type "#{clipname}"
		    And I use DELETE "15" times
		    And I wait for "1" seconds 

		    And I click on "qvl_Description_Description_box.png"
		    And I type "#{description}"
		    And I go to the "technical" tab
		    And I click "40" pixels to the "right" of "technical_sound.png"
		    And I use DELETE "2" times
		    And I use BACKSPACE "2" times

		}

		case sound
			when "BK"

			when "MO"
				@screen.type "Mono"
			when "LT"
				@screen.type "Left"
			when "RT"
				@screen.type "Right"
			when "ST"
				@screen.type "Stereo"
		end

		steps %Q{
			And I wait for "1" seconds 
			And I click on "qvl_Component_GeneralTab.png"
			And I change the MI decription status to "Finished"
		    And I doubleclick on "qvl_Component_Button_Save.png"
		    And I click on "Button_Yes.png" if exists
		    And I wait for "2" seconds 
		}

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
		    And I type "#{ompfile_story}"
		    And I use TAB
		    And I type "#{ompfile_story}"
		    And I waitAndclick on "qvl_Component_Button_Save.png"
		}

	end

end


def createOmpNewMediaItem(sourcefile)
	mediaitem = "#{$config[$site]['duplicateurl']}#{sourcefile}"
	#puts mediaitem
	numberOfTries = 0
	begin
		uri = "#{mediaitem}"
		xml_data = open(uri).read
		$automationfileid = xml_data.split("itemid=\"")[1].split("\" newmediaitemlength")[0]
	rescue
		numberOfTries = numberOfTries + 1
		if(numberOfTries < 4)
			sleep 3
			retry
		else
			raise "Unable to duplicate the media item"
		end
	end

	puts $automationfileid
	return $automationfileid
end