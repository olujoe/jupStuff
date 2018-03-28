
#BITMAPTOLERANCELEVEL = 0.71
#BITMAPTOLERANCELEVEL_FOR_ASSERTION = 0.73
#BITMAPTOLERANCELEVEL_FOR_EXISTS = 0.79
BITMAPTOLERANCELEVEL = 0.70
BITMAPTOLERANCELEVEL_FOR_ASSERTION = 0.70
BITMAPTOLERANCELEVEL_FOR_EXISTS = 0.75
#WAITLONG = 750
#WAITMEDIUM = 250
#WAITSHORT = 100
WAITEXTRALONG = 1300
WAITLONG = 500
WAITMEDIUM = 220
WAITSHORT = 50


def calculate_wait (waitingTime)
	# determine if we wait for a long time e.g waiting for a recording to finish
	if waitingTime.include? "eventually"
		waitingOver = WAITLONG
		
	elsif waitingTime.include? "at_some_point"
		waitingOver = WAITEXTRALONG
		
	elsif waitingTime.include? "soon"
	waitingOver = WAITMEDIUM
		
	else
		waitingOver = WAITSHORT
	end

	if(ENV['debug'])
		puts waitingOver.to_s	
	end
	return waitingOver
end


Given /^Wait for loading cursor$/ do
	
end


When /^I wait for "(.*?)" to appear$/ do |bitmap|

	image = bitmap.split(",")
	number = image.length
	tries = 0

	waitingOver = WAITSHORT
	timeout = 0
	begin
		@screen.wait "#{image[tries]}", 5
	rescue
		if timeout > waitingOver
			fail("TimedOut - " + timeout.to_s + ":The following bitmap cannot be found: " + bitmap)
		else
			puts "#{image[tries]} Not Present"
			timeout += 5
			if(tries < number)
				tries = tries + 1
			else
				tries = 0
			end
			retry
		end
	end
end


When /^I wait for "(.*?)" to disappear(.*?)$/ do |bitmap,waitingTime|
	waitingOver = calculate_wait(waitingTime)
	timeout = 0
    bitmapStillThere = true
	
#    while bitmapStillThere
#		if @screen.waitVanish "#{bitmap}"
#			bitmapStillThere = false
#		end
#		puts "still there"
#	end
	if @screen.exists "#{bitmap}"
		
	    while bitmapStillThere			
			timeout = timeout + 10	

			if @screen.exists "#{bitmap}"

				#@region = @screen.exists "#{bitmap}"
				#@region.highlight(1)

				if @screen.waitVanish "#{bitmap}"
					bitmapStillThere = false
				else
					puts bitmap + " Still Present"
				end
						
				if !@screen.exists "#{bitmap}"
					bitmapStillThere = false
				end

				if timeout > waitingOver
					fail("TimedOut - " + timeout.to_s + ":The following bitmap cannot be found: " + bitmap)
				end
			else
				bitmapStillThere = false
			end
		end	
	end

	if(ENV['debug'])
		puts bitmap + " Disappeared"
	end
end


Then /^I wait "(.*?)" seconds$/ do |delay|
	sleep "#{delay}".to_i
end

Then /^I wait for "(.*?)" seconds$/ do |delay|
	sleep "#{delay}".to_i
end


Then /^I wait upto "(.*?)" seconds for "(.*?)" to vanish$/ do |delay, bitmap|
  @screen.waitVanish "#{bitmap}", "#{delay}".to_i
end


When /^I wait for either "(.*?)" or "(.*?)" to appear$/ do |bitmap,bitmap2|
	waitingOver = WAITLONG
	timeout = 0
	begin
		if( (@screen.exists "#{bitmap}") or (@screen.exists "#{bitmap2}") )
		else
			fail("didnt find either image")
		end
	rescue

		if timeout > waitingOver
			fail("TimedOut - " + timeout.to_s + ":The following bitmap cannot be found: " + bitmap)
		else
			puts bitmap + " Not Present"
			timeout += 10
			retry
		end
	end
end


Then /^I wait for any not responding message to disappear$/ do 
	region = @screen.exists("toolbar_top_region.png",6).above(100)
	begin
		region.waitVanish "not_responding.png",280
	rescue

	end
end