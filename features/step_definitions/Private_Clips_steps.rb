Given(/^I change the private clips name to "(.*?)"$/) do |name|
	currentTimeOffset = Time.new
	currentTimeOffsetHourString = currentTimeOffset.hour.to_s   
	currentTimeOffsetMinString = currentTimeOffset.min.to_s
	currentTimeOffsetSecString = currentTimeOffset.sec.to_s

	if currentTimeOffsetHourString.length == 1
	  currentTimeOffsetHourString = "0" + currentTimeOffsetHourString 
	end

	if currentTimeOffsetMinString.length == 1
	  currentTimeOffsetMinString = "0" + currentTimeOffsetMinString
	end   

	times = currentTimeOffsetHourString + currentTimeOffsetMinString + currentTimeOffsetSecString

	steps %Q{
		And I wait for "button_Cancel.png" to appear
		And I click "30" pixels to the "bottom" of "private_clip_name.png"
		And I use CTRL A
		And I type "auto/#{name}/#{times}-test"
	}
	
end
