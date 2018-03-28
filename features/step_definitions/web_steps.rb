Given(/^I open the Jupiter Web GUI$/) do
  visit 'http://qa64w1app07.jupiter.bbc.co.uk/jupGUI/jobs/?username=earatl01#'
end

Then(/^the job for the media item should have status "([^"]*)"$/) do |expected_status|
	eventually(timeout: 120) do
	  jobs = all('div[type=jobstatus]')
	  latest_job = jobs[0]
	  status = latest_job['status']
	  status == expected_status
	end
end

#require 'wrong'

#Before do
#  extend Wrong
#end
