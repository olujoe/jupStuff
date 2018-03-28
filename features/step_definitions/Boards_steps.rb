ENV['HTTP_PROXY'] = ENV['http_proxy'] = nil

Given(/^I start a crash recording for item "(.*?)", "(.*?)"$/) do |story, details|
	steps %Q{
		Given I open the new recording dialogue
		And I set all the default crash recording 1 options
		And I click on "create_Recording_Dropdown_Story.png"
		And I use CTRL A
		And I use DELETE
		And I type "#{story}"
		And I click "20" pixels to the "bottom" of "details.png"
		And I use CTRL A
		And I use DELETE
		And I type "#{details}"
		
		#And I set the rights to "green"

		And I click on "button_Record.png"
		And I click on "button_Yes.png" if exists
		And I wait "2" seconds
	}
end

Given(/^I go to the boards page "(.*?)"$/) do |arg1|
  
	get_browser()
	$board = YAML.load(File.read('features/config/boards.yml'))

	case arg1
		when "arrival"
			$browser.goto $board[$site]["pages"]["arrival"]
		when "boards"
			$browser.goto $config[$site]["boards"]
	end

end

Then(/^I should see the item "(.*?)", "(.*?)"$/) do |story, details|
	retries = 0
	@result = "n"
	begin
		@result = "n"
		$browser.table(:id => "resultsTable").rows.each do |rows|

			if(rows.text.downcase.include? story.downcase)
				
				if($browser.url.include? "departuresJEX")
					if((rows.text.downcase.strip.include? story.downcase) && (rows.text.downcase.strip.include? details.downcase))
						@result = "y"
						break
					end

				else

					if((rows[4].text.downcase.strip == story.downcase) && (rows[5].text.downcase.strip == details.downcase))
						@result = "y"
						break
					end

				end
			end
		end

		if(@result == "n")
			fail "Didnt find the booking in the boards page"
		end

	rescue
		if retries < 30
			sleep 2
			retries = retries + 1
			retry
		else
			fail "Didnt find the booking in the boards page after several retries"
		end
	end

end


Then(/^I check for the completed "(.*?)", "(.*?)" data$/) do |story, details|
	retries = 0
	@result = "n"
	begin
		@result = "n"
		length = $browser.table(:id => "resultsTable").rows.length - 1
		rows = $browser.table(:id => "resultsTable")[length]

		if(rows.text.downcase.include? story.downcase)
			
			if((rows.text.downcase.strip.include? story.downcase) && (rows.text.downcase.strip.include? details.downcase) && (rows.text.downcase.strip.include? "complete"))
				@result = "y"
				break
			end

		end

		if(@result == "n")
			fail "Didnt find the booking in the boards page"
		end

	rescue
		if retries < 30
			sleep 2
			$browser.refresh
			retries = retries + 1
			retry
		else
			fail "Didnt find the booking in the boards page after several retries"
		end
	end

end


Then(/^I should see the delivery item "(.*?)", "(.*?)"$/) do |story, details|
	retries = 0
	@result = "n"
	begin
		@result = "n"
				
		if(($browser.text.downcase.include? story.downcase) && ($browser.text.downcase.include? details.downcase))
			@result = "y"
			break
		end

		if(@result == "n")
			fail "Didnt find the booking in the boards page"
		end

	rescue
		if retries < 30
			sleep 2
			retries = retries + 1
			retry
		else
			fail "Didnt find the booking in the boards page after several retries"
		end
	end
end



Then(/^I should see the text "(.*?)" on the page$/) do |story|
	retries = 0
	@result = "n"
	begin
		@result = "n"
				
		if $browser.text.downcase.include? story.downcase
			@result = "y"
			break
		end

		if(@result == "n")
			fail "Didnt find the booking in the boards page"
		end

	rescue
		if retries < 30
			sleep 2
			retries = retries + 1
			retry
		else
			fail "Didnt find the text on the page after several retries"
		end
	end
end


Then(/^I close the browser$/) do 
	begin
		$browser.close
	rescue
	end
end


Given(/^the webpage should have the right headings for "(.*?)"$/) do |page|
	case page
		when "arrival"
			#$browser.goto $board[$site]["pages"]["arrival_heading"]
			heading = $board[$site]["pages"]["arrival_heading"]
			actual = $browser.table(:id => "resultsTable")[0].text.strip
			if actual != heading
				fail "The #{page} heading is wrong on #{$browser.url}, expecting '#{heading}', but found '#{actual}'"
			end
		when "now and next"
			heading = $board[$site]["pages"]["now_next"]
			actual = $browser.table(:id => "resultsTable")[0].text.strip
			if actual != heading
				fail "The #{page} heading is wrong on #{$browser.url}, expecting '#{heading}', but found '#{actual}'"
			end
	end
end


Then(/^I click on the link "(.*?)"$/) do |text|
	$browser.link(:text=> text).click

end


Then(/^I should see the page "(.*?)"$/) do |heading|
	if($browser.h1.text != heading)
		fail "The page heading is not what we are expecting. Expecting '#{heading}' but found '#{$browser.h1.text}'"
	end
end

Then(/^I should see the sub heading "(.*?)"$/) do |heading|
	found = "no"
	$browser.h2s.each do |subheading|
		if(subheading.text.strip == heading)
			found = "yes"
		end
	end

	if(found != "yes")
		fail "The page sub heading is not what we are expecting. Expecting '#{heading}'"
	end

end



Then(/^there should be "(.*?)" results tables$/) do |total|
	num = $browser.tables(:id => "resultsTable").length
	if(num != total.to_i)
		fail "The page should have '#{total}' results table but found '#{num}'"
	end
end
	

Then(/^I should see the correct arrival board index links on the page$/) do 
	index = 1
	$browser.links.each do |rows|

		linktext = rows.text.gsub("<br>","").gsub("\n"," ").gsub("  "," ").strip
		expected_linktext = $board[$site]["board_index_link"][index]

		if($board[$site]["board_index_link"][index])
			if(linktext != expected_linktext )
				fail "Wrong link found on the boards page. Expection link number '#{index}' to be '#{expected_linktext}' but its '#{linktext}'"
			end
			index = index + 1
		end

	end
end



Then(/^I should see the correct quantel editor use links on the page$/) do 
	index = 1
	$browser.links.each do |rows|

		linktext = rows.text.gsub("<br>","").gsub("\n"," ").gsub("  "," ").strip
		expected_linktext = $board[$site]["editors_in_use_links"][index]

		if($board[$site]["editors_in_use_links"][index])
			if(linktext != expected_linktext )
				fail "Wrong link found on the boards page. Expection link number '#{index}' to be '#{expected_linktext}' but its '#{linktext}'"
			end
			index = index + 1
		end

	end
end


Then(/^I should see the grouped editor totals page$/) do 
	if($browser.text.include? "No results")
	else
		steps %Q{
			And I should see the text "Product" on the page
			And I should see the text "Count" on the page
			And I should see the text "Grouped Editor Totals over last 7 days" on the page
		}	
	end
end


Then(/^I should see the editors in use totals page$/) do 
	if($browser.text.include? "No results")
	else
		steps %Q{
			And I should see the text "PC Asset" on the page
			And I should see the text "Group" on the page
			And I should see the text "Location" on the page
			And I should see the text "Phone" on the page
			And I should see the text "Longest Running Editors (started in the last 7 days)" on the page
		}	
	end
end


Then(/^I should see the sQ CutX totals page$/) do 
	if($browser.text.include? "No results")
	else
		steps %Q{
			And I should see the text "Product" on the page
			And I should see the text "Count" on the page
			And I should see the text "Grouped Editor Totals over last 7 days" on the page
		}	
	end
end


Then(/^I should see the sQ EditX totals page$/) do 
	if($browser.text.include? "No results")
	else
		steps %Q{
			And I should see the text "Product" on the page
			And I should see the text "Count" on the page
			And I should see the text "Grouped Editor Totals over last 7 days" on the page
		}	
	end
end


Then(/^I close the jex window$/) do 
	steps %Q{
		And I click on "jex_close.png"
	}
end


Then(/^I should see the transfers main sites page and contents$/) do 
	
	#binding.pry
	if($browser.iframes.length != 4)
		fail "Expecting to find 4 iframes in the transfers (main sites) page"
	end
	if($browser.text != "Transfers (Main Sites)\nWest 1\nSalford\nMillbank\nCardiff")
		fail "Expecting to find the headings 'Transfers (Main Sites)\nWest 1\nSalford\nMillbank\nCardiff' in the transfers (main sites) page but found '#{$browser.text}' "
	end

	number = $browser.links.length
	x = 0

	while x < number
		sites = $browser.links[x]

		$browser.goto sites.href
		if($browser.text.include? "No results")
		else
			if($browser.table(:id => "resultsTable").rows[0].text != "TYP Start End User Title Source Dest Status")
				fail "Expecting to find the headings 'TYP Start End User Title Source Dest Status' in the transfers (main sites) page iframe but found '#{$browser.table(:id => 'resultsTable').rows[0].text}' "
			end
			if($browser.table(:id => "resultsTable").rows.length < 2)
				fail "Expecting to find more than 1 row of data in the transfers (main sites) page iframe but found '#{$browser.table(:id => 'resultsTable').rows.length}' "
			end
		end
		$browser.back
		sleep 2
		x = x + 1

	end

end


