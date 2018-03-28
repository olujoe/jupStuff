
Then /^I should see either "(.*?)" or "(.*?)"(.*)$/ do |bitmap, bitmap2, waitingTime|
	
	waitingOver = calculate_wait(waitingTime)

	nearly_not_quite = false
	timeout = 0
	image = []
	image[0] = bitmap
	image[1] = bitmap2
	number = image.length
	tries = 0

    #puts "Locate Bitmap " + bitmap + " or " + bitmap2
    begin

		if @screen.exists image[tries]
			@region = @screen.exists image[tries]
			#puts "#{image[tries]}:" + @region.getScore()
			
			if @region.getScore() > BITMAPTOLERANCELEVEL_FOR_ASSERTION
			else 
				nearly_not_quite = true
				fail("Throw Exception - Force Rescue Block")
			end
		
		end
			
	rescue
		if tries < number 
			tries = tries + 1
		else
			tries = 0
		end

		if timeout > waitingOver
			if nearly_not_quite == true 
				puts "Bitmap = " + bitmap + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL_FOR_ASSERTION.to_s + " - Score = " + @region.getScore().to_s
			end
			fail("TimedOut - " + timeout.to_s + ":The following bitmap cannot be found: " + bitmap)
		end
		
		
		timeout += 5
		retry	   		
	end

end

=begin
Then /^I should see "(.*?)"(.*)$/ do |bitmap, controlParameter|
	#puts "NH = " +controlParameter

	# allow user to specify how long to wait
	waitingTime = ""
	if controlParameter.include? "soon"
	   waitingTime = "soon"
	elsif controlParameter.include? "eventually"
	   waitingTime = "eventually"
	end
	waitingOver = calculate_wait(waitingTime)
	
	nearly_not_quite = false
	timeout = 0
	begin
		if(ENV['debug'])
	    	puts "Locate Bitmap " + bitmap
	    end 
		if @screen.exists "#{bitmap}"		
			@region = @screen.exists "#{bitmap}"
			#if(ENV['debug'])
				puts @region.getScore()
			#end
					
			# the assertion has to be almost spot on
			
			if @region.getScore() > BITMAPTOLERANCELEVEL_FOR_ASSERTION
				if controlParameter.include? "noHighlight"
					# do nothing - Jupiter has some quirks with the Create Keyframe / Components screen and the highlight causes a problem
				else
					if(ENV['debug'])
						@region.highlight(1)
					end
				end
			else 
				nearly_not_quite = true
				puts ("Bitmap = " + bitmap + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL_FOR_ASSERTION.to_s + " - Score = " + @region.getScore().to_s)
				fail("Throw Exception - Force Rescue Block")
			end
		else
			fail("Throw Exception - Force Rescue Block")
		end
		
	rescue
		sleep(1)
		if(ENV['debug'])
			puts "Rescuing - " + timeout.to_s 
		end
		if timeout == waitingOver
			fail("TimedOut - " + timeout.to_s + " :The following bitmap cannot be found: " + bitmap)
		end
		
		if nearly_not_quite == true 
			fail("Bitmap = " + bitmap + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL_FOR_ASSERTION.to_s + " - Score = " + @region.getScore().to_s)
		end
		
		timeout += 5
		retry	   		
	end
end
=end

Then /^I should see "(.*?)"(.*)$/ do |bitmap, controlParameter|

	#retries = 0
	tries   = 0
	image   = bitmap.split(",")
	number  = image.length

	# allow user to specify how long to wait
	waitingTime = ""
	if controlParameter.include? "soon"
	   waitingTime = "soon"
	elsif controlParameter.include? "eventually"
	   waitingTime = "eventually"
	end
	waitingOver = calculate_wait(waitingTime)
	
	nearly_not_quite = false
	timeout = 0
	begin

		mainimage = image[tries].strip
		
		if(ENV['debug'])
	    	puts "Locate Bitmap " + bitmap
	    end 
		if @screen.exists "#{mainimage}"		
			@region = @screen.exists "#{mainimage}"
			#if(ENV['debug'])
				puts @region.getScore()
			#end
					
			# the assertion has to be almost spot on
			
			if @region.getScore() > BITMAPTOLERANCELEVEL_FOR_ASSERTION
				if controlParameter.include? "noHighlight"
					# do nothing - Jupiter has some quirks with the Create Keyframe / Components screen and the highlight causes a problem
				else
					if(ENV['debug'])
						@region.highlight(1)
					end
				end
			else 
				nearly_not_quite = true
				puts ("Bitmap = " + mainimage + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL_FOR_ASSERTION.to_s + " - Score = " + @region.getScore().to_s)
				fail("Throw Exception - Force Rescue Block")
			end
		else
			fail("Throw Exception - Force Rescue Block")
		end
		
	rescue

		if tries < number - 1
			tries = tries + 1
		else
			tries = 0
		end

		#if retries < (4 * number)
		#	retries = retries + 1
		#	retry
		#else
		#	fail("The following bitmap cannot be found: " + bitmap )
		#end

		sleep(1)
		if(ENV['debug'])
			puts "Rescuing - " + timeout.to_s 
		end
		if timeout == waitingOver
			fail("TimedOut - " + timeout.to_s + " :The following bitmap cannot be found: " + bitmap)
		end
		
		if nearly_not_quite == true 
			fail("Bitmap = " + bitmap + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL_FOR_ASSERTION.to_s + " - Score = " + @region.getScore().to_s)
		end
		
		timeout += 5
		retry	   		
	end
end


Then /^I should see "(.*?)" with high accuracy "(.*?)"(.*)$/ do |bitmap, accuracy, controlParameter|
	#puts "NH = " +controlParameter
	new_BITMAPTOLERANCELEVEL_FOR_ASSERTION = accuracy.to_f
	# allow user to specify how long to wait
	waitingTime = ""
	if controlParameter.include? "soon"
	   waitingTime = "soon"
	elsif controlParameter.include? "eventually"
	   waitingTime = "eventually"
	elsif controlParameter.include? "now"
	   waitingTime = "now"
	end
	waitingOver = calculate_wait(waitingTime)

	if controlParameter.include? "nowait"
		waitingOver = 0
	end

	nearly_not_quite = false
	timeout = 0
	images = bitmap.split(",")
	number = images.length
	tries = 0

	begin
		image = images[tries].strip
		if(ENV['debug'])
	    	puts "Locate Bitmap " + image
	    end 
		if @screen.exists "#{image}"	

			@region = @screen.exists "#{image}"
			if(ENV['debug'])
				puts @region.getScore()
			end
					
			# the assertion has to be almost spot on
			
			if @region.getScore() > new_BITMAPTOLERANCELEVEL_FOR_ASSERTION
				if controlParameter.include? "noHighlight"
					# do nothing - Jupiter has some quirks with the Create Keyframe / Components screen and the highlight causes a problem
				else
					if(ENV['debug'])
						@region.highlight(1)
					end
				end
			else 
				nearly_not_quite = true
				puts "Accuracy is : #{@region.getScore()}"
				fail("Throw Exception - Force Rescue Block")
			end
		else
			fail("Throw Exception - Force Rescue Block")
		end
		
	rescue
		sleep(1)

		if tries < number - 1
			tries = tries + 1
		end

		if(ENV['debug'])
			puts "Rescuing - " + timeout.to_s 
		end
		
		if nearly_not_quite == true 
			puts ("Bitmap = " + bitmap + " does Not Score Above Required Limit of " + new_BITMAPTOLERANCELEVEL_FOR_ASSERTION.to_s + " - Score = " + @region.getScore().to_s)
		end
		
		if timeout >= waitingOver
			fail("TimedOut - " + timeout.to_s + ":The following bitmap cannot be found: " + bitmap)
		else
			timeout += 2
			retry	  
		end 		
	end
end



Then /^I should see the following "(.*?)" with high accuracy "(.*?)"(.*)$/ do |bitmap, accuracy, controlParameter|
	#puts "NH = " +controlParameter
	new_BITMAPTOLERANCELEVEL_FOR_ASSERTION = accuracy.to_f
	# allow user to specify how long to wait
	waitingTime = ""
	if controlParameter.include? "soon"
	   waitingTime = "soon"
	elsif controlParameter.include? "eventually"
	   waitingTime = "eventually"
	elsif controlParameter.include? "now"
	   waitingTime = "now"
	end
	waitingOver = calculate_wait(waitingTime)

	if controlParameter.include? "nowait"
		waitingOver = 0
	end
	nearly_not_quite = false
	timeout = 0
	begin
		if(ENV['debug'])
	    	puts "Locate Bitmap " + bitmap
	    end 
		if @screen.exists "#{bitmap}"	

			@region = @screen.exists "#{bitmap}"
			if(ENV['debug'])
				puts @region.getScore()
			end
					
			# the assertion has to be almost spot on
			
			if @region.getScore() > new_BITMAPTOLERANCELEVEL_FOR_ASSERTION
				if controlParameter.include? "noHighlight"
					# do nothing - Jupiter has some quirks with the Create Keyframe / Components screen and the highlight causes a problem
				else
					if(ENV['debug'])
						@region.highlight(1)
					end
				end
			else 
				nearly_not_quite = true
				fail("Throw Exception - Force Rescue Block")
			end
		else
			fail("Throw Exception - Force Rescue Block")
		end
		
	rescue
		sleep(1)
		if(ENV['debug'])
			puts "Rescuing - " + timeout.to_s 
		end
		
		if nearly_not_quite == true 
			fail("Bitmap = " + bitmap + " does Not Score Above Required Limit of " + new_BITMAPTOLERANCELEVEL_FOR_ASSERTION.to_s + " - Score = " + @region.getScore().to_s)
		end
		
		if timeout >= waitingOver
			fail("TimedOut - " + timeout.to_s + ":The following bitmap cannot be found: " + bitmap)
		else
			timeout += 5
			retry	  
		end 		
	end
end


Then /^I should see approximately "(.*?)(.*)"$/ do |bitmap, controlParameter|
	#puts "NH = " +controlParameter

	# allow user to specify how long to wait
	waitingTime = ""
	if controlParameter.include? "soon"
	   waitingTime = "soon"
	elsif controlParameter.include? "eventually"
	   waitingTime = "eventually"
	end
	waitingOver = calculate_wait(waitingTime)
	
	nearly_not_quite = false
	timeout = 0
	begin
		if(ENV['debug'])
	    	puts "Locate Bitmap " + bitmap
	    end 
		if @screen.exists "#{bitmap}"		
			@region = @screen.exists "#{bitmap}"
			if(ENV['debug'])
				puts @region.getScore()
			end
					
			# the assertion has to be almost spot on
			
			if @region.getScore() > BITMAPTOLERANCELEVEL
				if controlParameter.include? "noHighlight"
					# do nothing - Jupiter has some quirks with the Create Keyframe / Components screen and the highlight causes a problem
				else
					if(ENV['debug'])
						@region.highlight(1)
					end
				end
			else 
				nearly_not_quite = true
				fail("Throw Exception - Force Rescue Block")
			end
		else
			fail("Throw Exception - Force Rescue Block")
		end
		
	rescue
		sleep(1)
		if(ENV['debug'])
			puts "Rescuing - " + timeout.to_s 
		end
		if timeout == waitingOver
			fail("TimedOut - " + timeout.to_s + ":The following bitmap cannot be found: " + bitmap)
		end
		
		if nearly_not_quite == true 
			fail("Bitmap = " + bitmap + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL_FOR_ASSERTION.to_s + " - Score = " + @region.getScore().to_s)
		end
		
		timeout += 5
		retry	   		
	end
end


Then /^I should not see "(.*?)"$/ do |bitmap|
	begin
		@screen.waitVanish "#{bitmap}", 5
	rescue Exception => e
	    #puts "Exception was raised: #{e.class}"
	    fail("The following bitmap was found: " + bitmap)
	end
end


Then /^I should see either "(.*?)" or "(.*?)" in the "(.*?)" region(.*)$/ do |bitmap,bitmap2,regionimg,controlParameter|
	retries = 0
	begin
		begin
			steps %Q{
				And I should see "#{bitmap}" in the "#{regionimg}" region
			}
		rescue
			steps %Q{
				And I should see "#{bitmap2}" in the "#{regionimg}" region
			}
		end
	rescue
		if retries < 5
			sleep(2)
			retries = retries + 1
			retry
		else
			fail "Did not find either '#{bitmap}' or '#{bitmap2}' in '#{regionimg}' region"
		end
	end
end


Then /^I should see "(.*?)" in the "(.*?)" region(.*)$/ do |bitmap,regionimg,controlParameter|

	# allow user to specify how long to wait
	waitingTime = ""
	if controlParameter.include? "soon"
	   waitingTime = "soon"
	elsif controlParameter.include? "eventually"
	   waitingTime = "eventually"
	end
	waitingOver = calculate_wait(waitingTime)
	if controlParameter == ""
		waitingOver = 10;
	end
	
	nearly_not_quite = false
	timeout = 0
	images = bitmap.split(",")
	number = images.length
	tries = 0

	begin
		if(ENV['debug'])
	    	puts "Locate Bitmap " + images[tries].strip
	    end 

	    @region = @screen.exists("#{regionimg}",6).below()

		if @region	
			#if(ENV['debug'])
			#	puts @region.getScore()
			#end
			@imageRegion = @region.exists("#{images[tries].strip}",6)
			# the assertion has to be almost spot on
			
			if @imageRegion.getScore() > BITMAPTOLERANCELEVEL_FOR_ASSERTION
				if controlParameter.include? "noHighlight"
					# do nothing - Jupiter has some quirks with the Create Keyframe / Components screen and the highlight causes a problem
				else
					if(ENV['debug'])
						@imageRegion.highlight(1)
					end
				end
			else 
				nearly_not_quite = true
				fail("Throw Exception - Force Rescue Block")
			end
		else
			fail("Throw Exception - Force Rescue Block")
		end
		
	rescue
		sleep(1)
		if tries < (number - 1)
			tries = tries + 1
		else
			tries = 0
		end
		if(ENV['debug'])
			puts "Rescuing - " + timeout.to_s 
		end
		if timeout == waitingOver
			fail("TimedOut - " + timeout.to_s + ":The following bitmap cannot be found: " + bitmap)
		end
		
		if nearly_not_quite == true 
			fail("Bitmap = " + bitmap + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL_FOR_ASSERTION.to_s + " - Score = " + @region.getScore().to_s)
		end
		
		timeout += 2
		retry	   		
	end
end