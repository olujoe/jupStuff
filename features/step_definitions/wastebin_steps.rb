Then(/^I should see a black summary label in QVL$/) do
  	steps %Q{
  		And I should see "black_summary_label.png"
  	}
end


Then(/^asset "(.*?)" deletion date should be in 24hrs$/) do |item|

	steps %Q{
		And I click on "white_space2.png"
		And Within region "top_toolbar_region.png" rightclick "#{item}"
		And I click on "rightclick_copy.png"
		And I click on "shortcut.png"
		And I wait for "2" seconds
	}
	shortcut = Clipboard.paste.encode('utf-8')
	puts shortcut
	id = shortcut.split("]:")[1].split(">>")[0]
	puts id

	data = getMediaItemDates(id)
	deleteDate = data[1]

	puts "Deletion date: #{deleteDate}"

	currentTime = Time.now.utc.strftime("%Y-%m-%d")
	timeDiff = (Time.parse(deleteDate.split(" ")[0]) - Time.parse(currentTime)) / (60*60*24)
	timeDiff = timeDiff.abs.to_i

	puts "time diff: #{timeDiff}"
	fail("The deletion date is wrong, expecting '1 day' but got '#{timeDiff}' ") unless timeDiff < 3
	
end


Then(/^I empty the wastebin$/) do
	steps %Q{
		Given I go to the "wastebin" page
	}
	tries = 0
	begin
		if @screen.exists "deleted_item.png"
			steps %Q{
				And I wait for "1" seconds
				And I click on "deleted_item.png"
				And I use CTRL A
				And I rightclick on "deleted_item_b.png"
				And I click on "delete_permanently.png"
				And I click on "button_Ok4.png"
				And I wait for "2" seconds
			}
		end
	rescue
		if tries < 1
			tries = tries + 1
			retry
		else
			fail "Unable to empty the bin"
		end
	end
end
