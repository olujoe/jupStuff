When /^I save the clipname$/ do
	#$automationfileid=272345
$clipname = getMediaItemClipname($automationfileid)
  
end

When /^I should see the Completed status$/ do
    status = "false"
	sleep 3
	limit=10

	begin
		$browser.div(:id, "fullJobsView").divs.each do | dive |

			if(dive.attribute_value('type') == "jobstatus" )
				thetext = dive.text
				thestatus = dive.attribute_value('status').to_s
				
	             if (thetext.include? $clipname ) 
	             	puts "--#{thestatus}--"
	             	status = "true"
	             	puts "yes"
	                if thestatus == "Completed"
	                	puts "it's completed"
	                	break
	                else
	                	fail "status is not complete. its '#{thestatus}'"
	                end
	             end
			end

		end
	rescue
    	if limit > 0 
    		limit = limit - 1
    		sleep 1
    		retry
    	else
    		fail "status is not complete after trying 10 times. '#{10 - limit}'" 
    	end
	end
		
  	if status == "false"
  		fail "did not find the job with the clipname '#{$clipname}'"
  	end
end



When(/^I click on Clipname$/) do
 $browser.h2(:text, /#{$clipname}/).click
end

Then(/^I should see Technical details$/) do

	$browser.button(:id => "btnDetailsTechView").exists?
  
end


When(/^I click on Technical, job and metadata$/) do
  $browser.button(:id => "btnDetailsTechView").click
  $browser.link(:text => "&nbsp;job").click
  $browser.link(:text => "&nbsp;metadata").click
end

Then(/^I should see md(\d+) Data$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end