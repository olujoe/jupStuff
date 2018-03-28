Given /^I click away$/ do 
	steps %Q{
		And I click on either "white_space.png" or "white_space2.png"
	}
end

Given /^I click on "(.*?)" if exists(.*)$/ do |bitmap, controlParameter|

	#puts "clicking on '#{bitmap}'"
	if @screen.exists "#{bitmap}", 3
    	@region = @screen.exists "#{bitmap}"

		if(ENV['debug'])
    		puts @region.getScore()
    	end

    	begin

	        if @region.getScore() > BITMAPTOLERANCELEVEL_FOR_EXISTS
				if controlParameter.include? "noHighlight"
					# do nothing - Jupiter has some quirks with the Create Keyframe / Components screen and the highlight causes a problem
				else
					if(ENV['debug'])
						@region.highlight(1)
					end
				end
	    		@screen.click "#{bitmap}"
	        else
	           puts "Bitmap Exists = " + bitmap + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL_FOR_EXISTS.to_s + " - Score = " + @region.getScore().to_s
	        end
	    rescue

	    end
	else
		puts "Bitmap = " + bitmap + " does Not Exist"
	end
end


Given /^I waitAndclick on "(.*?)"$/ do |bitmap|
	begin	
		@screen.wait "#{bitmap}", 20
	    @screen.click "#{bitmap}"
	rescue
    	fail("The following bitmap cannot be found: " + bitmap)
	end
end

Given /^I waitAndclick on "(.*?)" if exists$/ do |bitmap|
	begin	
		@screen.wait "#{bitmap}", 20
	    @screen.click "#{bitmap}"
	rescue
    	#fail("The following bitmap cannot be found: " + bitmap)
	end
end


Given /^I click on dropdown "(.*?)"$/ do |bitmap|
	begin
		@screen.wait "#{bitmap}", 10
		@region = @screen.exists "#{bitmap}"
		#@region.highlight(1)
	    @screen.click "#{bitmap}"
	rescue
    	fail("The following bitmap cannot be found: " + bitmap + "\n")
	end
end


Given /^I click on dropdown "(.*?)" and click "(.*?)"$/ do |bitmap, bitmap2|
	begin
		@screen.wait "#{bitmap}", 10
		@region = @screen.exists "#{bitmap}"
	
	    if @region.getScore() > BITMAPTOLERANCELEVEL
		  #@region.highlight(1)
	      @screen.click "#{bitmap}"	
		else
		    puts @region.getScore()
	        fail("The following bitmap cannot be found: " + bitmap + "\n")
	    end	
		
	    @region = @screen.exists "#{bitmap2}" 
		if(ENV['debug'])	  
			puts @region.getScore()	
		end
		  
	    if @region.getScore() > BITMAPTOLERANCELEVEL
		  @screen.click "#{bitmap2}"
		else
	      fail("Bitmap = " + bitmap2 + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL.to_s + " - Score = " + @region.getScore().to_s)
	    end		
	
	rescue
    	fail("The following bitmap cannot be found: " + bitmap + "\n")
	end
end


Given /^I click on "(.*?)"$/ do |bitmap|
	retries = 0
	tries = 0
	image = bitmap.split(",")
	number = image.length
	begin

		mainimage = image[tries].strip

		if @screen.exists "#{mainimage}", 10	
			@region = @screen.exists "#{mainimage}"
			#puts @region.getScore()
			if @region.getScore() > BITMAPTOLERANCELEVEL
				if(ENV['debug'])
					@region.highlight(1)
				end
				@screen.click "#{mainimage}"
			else
		      fail("Bitmap = " + mainimage + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL.to_s + " - Score = " + @region.getScore().to_s)
			end
		else
		   fail("The following bitmap cannot be found: " + mainimage )
		end

	rescue
		
		if tries < number - 1
			tries = tries + 1
		else
			tries = 0
		end

		if retries < (4 * number)
			retries = retries + 1
			retry
		else
			fail("The following bitmap cannot be found: " + bitmap )
		end

	end
	#step "Wait for loading cursor"
end


Given /^I click on "(.*?)" "(.*?)" times$/ do |bitmap,number|
	number.to_i.times do |x|
		steps %Q{
			And I click on "#{bitmap}"
		}
	end
end


Given /^I clickAndHold on "(.*?)"$/ do |bitmap|
	#step "Wait for loading cursor"
	#begin
	#   @value = @screen.exists "#{bitmap}", 10
	#   puts @value	
		if @screen.exists "#{bitmap}", 10	
			@region = @screen.exists "#{bitmap}"
			#puts @region.getScore()
			if @region.getScore() > BITMAPTOLERANCELEVEL
				if(ENV['debug'])
					@region.highlight(1)
				end
				@screen.click_and_hold(6,"#{bitmap}")
			else
		      fail("Bitmap = " + bitmap + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL.to_s + " - Score = " + @region.getScore().to_s)
			end
		else
		   fail("The following bitmap cannot be found: " + bitmap )
		end
	#end
	step "Wait for loading cursor"
end

Given /^I click on "(.*?)" with noHighlight$/ do |bitmap|

    if @screen.exists "#{bitmap}", 10	
		@region = @screen.exists "#{bitmap}"
		#puts @region.getScore()
		if @region.getScore() > BITMAPTOLERANCELEVEL
			@screen.click "#{bitmap}"
		else
	      fail("Bitmap = " + bitmap + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL.to_s + " - Score = " + @region.getScore().to_s)
		end
	else
	   fail("The following bitmap cannot be found: " + bitmap )
    end
  #end
end

Given /^I click on "(.*?)" until "(.*?)" appears(.*)$/ do |bitmap, bitmap2, waitingTime|
	timeout = 0	
	waitingOver = calculate_wait(waitingTime)
	#puts waitingOver.to_s
	tries = 0
	tries2 = 0
	image = bitmap.split(",")

	#if !@screen.exists "#{bitmap2}" 
		begin
		   	
		   	bitmap2report = bitmap

			begin
				
				mainimage = image[tries].strip
			    @region = @screen.exists "#{mainimage}"
				if @region.getScore() > BITMAPTOLERANCELEVEL
					if(ENV['debug'])
				   		puts mainimage + " Clicked"
				   		@region.highlight(1)
				   	end
				   	@screen.click "#{mainimage}"
				else
					fail "Didnt find image: #{mainimage}"
				end

			rescue
				if tries < image.length
					tries = tries + 1

					puts ("The following image(s) cannot be found: " + bitmap + " retrying") if(ENV['debug'])
					retry

				else
					tries = 0
					puts ("The following image(s) cannot be found: " + bitmap + " Exiting loop") if(ENV['debug'])
					fail("The following image(s) cannot be found: " + bitmap + " Exiting loop") 
				end
			end

			
			if waitingTime == "now"
				sleep 0.5
			else
				sleep 3
			end

			bitmap2report = bitmap2
			image2 = bitmap2.split(",")

			begin
				
				mainimage2 = image2[tries2].strip
				@screen.wait "#{mainimage2}", 10
				@region = @screen.exists "#{mainimage2}"
				#puts @region.getScore()
				
				if @region.getScore() > BITMAPTOLERANCELEVEL_FOR_EXISTS
					if(ENV['debug'])
				   		puts "Bitmap found - " +mainimage2
				   	end
				else
					fail("Throw Exception - Force Rescue Block")
				end

			rescue

				if tries2 < image2.length
					tries2 = tries2 + 1
					puts ("The following image(s) cannot be found: " + mainimage2 + " retrying")  if(ENV['debug'])
					retry

				else
					tries2 = 0
					puts ("The following image(s) cannot be found: " + bitmap2 + " Exiting loop") if(ENV['debug'])
					fail("The following image(s) cannot be found: " + bitmap2 + " Exiting loop")
				end

			end
			  
		rescue
			if timeout > waitingOver
				fail("TimedOut - " + timeout.to_s + ":The following bitmap cannot be found: " + bitmap2report)
			else
				timeout = timeout + 10
				#puts "Timeout= " + timeout.to_s
				retry	 
			end  
		end
	#end
end

Given /^I doubleclick on "(.*?)" until "(.*?)" appears(.*)$/ do |bitmap, bitmap2, waitingTime|
	timeout = 0	
	waitingOver = calculate_wait(waitingTime)
	#puts waitingOver.to_s
	
	#if !@screen.exists "#{bitmap2}" 
		begin
		   bitmap2report = bitmap
		   @region = @screen.exists "#{bitmap}"
			if @region.getScore() > BITMAPTOLERANCELEVEL
				if(ENV['debug'])
			   		puts bitmap + " Clicked"
			   end
			   if(ENV['debug'])
			   		@region.highlight(1)
			   	end
			   @screen.doubleClick "#{bitmap}"
			end
			
			sleep 3
			
			bitmap2report = bitmap2
			@screen.wait "#{bitmap2}", 10
			@region = @screen.exists "#{bitmap2}"
			#puts @region.getScore()
			
			if @region.getScore() > BITMAPTOLERANCELEVEL_FOR_EXISTS
				if(ENV['debug'])
			   		puts "Bitmap found - " +bitmap2
			   	end
			else
				fail("Throw Exception - Force Rescue Block")
			end
			  
		rescue
			if timeout > waitingOver
				fail("TimedOut - " + timeout.to_s + ":The following bitmap cannot be found: " + bitmap2report)
			else
				timeout = timeout + 10
				#puts "Timeout= " + timeout.to_s
				retry	 
			end  
		end
	#end
end


Given /^I type "(.*?)" until "(.*?)" appears(.*)$/ do |button, bitmap2|
	timeout = 0	
	waitingOver = 30
	begin
	    step 'I type F4'
		sleep 3
		bitmap2report = bitmap2
		@screen.wait "#{bitmap2}", 10
		@region = @screen.exists "#{bitmap2}", 10		
		if @region.getScore() > BITMAPTOLERANCELEVEL_FOR_EXISTS
			if(ENV['debug'])
		   		puts "Bitmap found - " +bitmap2
		   	end
		else
			fail("Throw Exception - Force Rescue Block")
		end
	rescue
		if timeout > waitingOver
			fail("TimedOut - " + timeout.to_s + ":The following bitmap cannot be found: " + bitmap2report)
		else
			timeout = timeout + 10
			retry	 
		end  
	end
end


Given /^I click on "(.*?)" until "(.*?)" disappears(.*)$/ do |bitmap, bitmap2, waitingTime|
	timeout = 0
	waitingOver = calculate_wait(waitingTime)	
	#puts waitingOver.to_s

	begin	
		while timeout < waitingOver
			bitmap2report = bitmap
			@region = @screen.exists "#{bitmap}"
			if @region.getScore() > BITMAPTOLERANCELEVEL
				#puts bitmap + " Clicked"
				if(ENV['debug'])
					@region.highlight(1)
				end
				@screen.click "#{bitmap}"
			end

			sleep 1			
			bitmap2report = bitmap2
			@screen.wait "#{bitmap2}", 5		

			timeout += 5
			puts "Timeout= " + timeout.to_s
		end	  
    rescue
		puts "Bitmap Disappeared - " +bitmap2	
	end
	
	if timeout > waitingOver
		fail("TimedOut - " + timeout.to_s + ":The following bitmap has not Disappeared: " + bitmap2report )
	end
end


Given /^I click on "(.*?)" if "(.*?)" exists$/ do |bitmap, bitmap2|
	#begin
	    @screen.wait "#{bitmap2}", 5
	    if @screen.exists "#{bitmap2}"
			step 'I click on "'+bitmap+'"'
	    end
	#rescue
	#	fail("The following bitmap cannot be found: " + bitmap + "\n")
	#end
end


Given /^I click on "(.*?)" if "(.*?)" not exists$/ do |bitmap1, bitmap2|
    if !(@screen.exists "#{bitmap2}")
		step 'I click on "'+bitmap1+'"'
    #else
      ## do nothing if Jupiter already open
      	#step 'I click on "'+bitmap2+'"'
    end
end


Given /^I doubleclick on "(.*?)"$/ do |bitmap|
	tries = 0
	retries = 0
	images = bitmap.split(",")
	number = images.length
	begin
		image = images[tries].strip
		@screen.wait "#{image}",3
		@region = @screen.exists "#{image}"
		if(ENV['debug'])
			@region.highlight(1)
		end
		@screen.doubleClick "#{image}"
	rescue

		if tries < number - 1
			tries = tries + 1
		else
			tries = 0
		end

		if retries < (4 * number)
			retries = retries + 1
			retry
		else
			fail("The following bitmap cannot be found: " + bitmap )
		end
	end
end


Given /^I rightclick on "(.*?)" and click "(.*?)"$/ do |bitmap, bitmap2|
	#begin
		@screen.wait "#{bitmap}", 10
		@region = @screen.exists "#{bitmap}",3	  
		#puts @region.getScore()
 
	#rescue
	#	retry 
	#end

	#@screen.wait "#{bitmap}", 20
	if @region.getScore() > BITMAPTOLERANCELEVEL 
		if(ENV['debug'])
			puts bitmap + " RightClicked"
		end
		@screen.rightClick "#{bitmap}"
	else
		fail("Bitmap = " + bitmap + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL.to_s + " - Score = " + @region.getScore().to_s)
	end

	@screen.wait "#{bitmap2}", 5
	@region = @screen.exists "#{bitmap2}" 	  
	#puts @region.getScore()	

	if @region.getScore() > BITMAPTOLERANCELEVEL
		if(ENV['debug'])
			puts bitmap2 + " Clicked"
		end
		@screen.click "#{bitmap2}"
	else 
		fail("Bitmap = " + bitmap2 + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL.to_s + " - Score = " + @region.getScore().to_s )
	end	
end


Given /^I rightclick on "(.*?)"$/ do |bitmap|

	#@screen.wait "#{bitmap}", 10
	images = bitmap.split(",")
	number = images.length
	tries = 0
	begin
		image = images[tries].strip
		@region = @screen.exists "#{image}"  
		#puts @region.getScore()
		if @region.getScore() > BITMAPTOLERANCELEVEL 
			if(ENV['debug'])
				puts image + " RightClicked"
			end
			@screen.rightClick "#{image}"
		else
			#if(ENV['debug'])
				puts "Bitmap = " + image + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL.to_s + " - Score = " + @region.getScore().to_s
			#end
			puts ("Bitmap = " + image + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL.to_s + " - Score = " + @region.getScore().to_s)
			fail("Bitmap = " + image + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL.to_s + " - Score = " + @region.getScore().to_s)
		end

	rescue
		if tries < number 
			tries = tries + 1
			retry
		else
			fail("Did not find the images: '#{bitmap}' in the region")
		end

	end

end


Given /^I rightclick on "(.*?)" if exists$/ do |bitmap|

	if @screen.exists "#{bitmap}"	

		@screen.wait "#{bitmap}", 10
		@region = @screen.exists "#{bitmap}"  

		if @region.getScore() > BITMAPTOLERANCELEVEL 
			if(ENV['debug'])
				puts bitmap + " RightClicked"
			end
			@screen.rightClick "#{bitmap}"
		else
			fail("Bitmap = " + bitmap + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL.to_s + " - Score = " + @region.getScore().to_s)
		end
	end
	
end


When /^I click on "(.*?)" in the region$/ do |bitmap|
  t=r.find "#{bitmap}".getCenter().offset(0,0)
  @screen.click(t)
end


Given /^I doubleclick on either "(.*?)" or "(.*?)"$/ do |bitmap, bitmap2|
	res = 0
	begin
		if @screen.exists "#{bitmap}"
			@region = @screen.exists "#{bitmap}"
			#@region.highlight(1)
			@screen.doubleClick "#{bitmap}"
		else
			@region = @screen.exists "#{bitmap2}"
			#@region.highlight(1)
			@screen.doubleClick "#{bitmap2}"
		end
	rescue
		if res < 5
			res = res + 1
			retry
		else
			fail("The following bitmap cannot be found: " + bitmap + " or " + bitmap2)
		end
	end
end


Given /^I click on either "(.*?)" or "(.*?)"$/ do |bitmap,bitmap2|
	res = 0
	begin	
	
		#   @value = @screen.exists "#{bitmap}", 10
		#   puts @value	
		if @screen.exists "#{bitmap}"	
			@region = @screen.exists "#{bitmap}"
			#puts @region.getScore()
			if @region.getScore() > BITMAPTOLERANCELEVEL
				#@region.highlight(1)
				@screen.click "#{bitmap}"
			else
				#begin	
		      	#	fail("Bitmap = " + bitmap + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL.to_s + " - Score = " + @region.getScore().to_s)
				#rescue
					if @screen.exists "#{bitmap2}"	
						@region = @screen.exists "#{bitmap2}"
						#puts @region.getScore()
						if @region.getScore() > BITMAPTOLERANCELEVEL
							#@region.highlight(1)
							@screen.click "#{bitmap2}"
						else
					      fail("Bitmap = " + bitmap2 + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL.to_s + " - Score = " + @region.getScore().to_s)
						end
					else
					   fail("The following bitmaps cannot be found: " + bitmap + " or " + bitmap2)
					end
				#end
			end
		elsif @screen.exists "#{bitmap2}"	
			@region = @screen.exists "#{bitmap2}"
			#puts @region.getScore()
			if @region.getScore() > BITMAPTOLERANCELEVEL
				#@region.highlight(1)
				@screen.click "#{bitmap2}"
			else
		      fail("Bitmap = " + bitmap2 + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL.to_s + " - Score = " + @region.getScore().to_s)
			end

		else
		   fail("The following bitmaps cannot be found: " + bitmap + " or " + bitmap2)
		end
		step "Wait for loading cursor"

	rescue
		if res < 5
			res = res + 1
			retry
		else
			fail("The following bitmaps cannot be found: " + bitmap + " or " + bitmap2)
		end
	end
	
end


Given /^I click "(.*?)" pixels to the "(.*?)" of "(.*?)"$/ do |pixels,position,image|
	nooftries = 0
	case position.downcase
		when "right"
			begin
				region = @screen.exists("#{image}",6).right(pixels.to_i)
			rescue
				if nooftries < 3
					nooftries = nooftries + 1
					retry
				else
					fail "Cant find the image #{image}"
					nooftries = nooftries + 1
				end
			end
		when "left"
			begin
				region = @screen.exists("#{image}",6).left(pixels.to_i)
			rescue
				if nooftries < 3
					nooftries = nooftries + 1
					retry
				else
					fail "Cant find the image #{image}"
					nooftries = nooftries + 1
				end
			end
		when "bottom"
			begin
				region = @screen.exists("#{image}",6).below(pixels.to_i)
			rescue
				if nooftries < 3
					nooftries = nooftries + 1
					retry
				else
					fail "Cant find the image #{image}"
					nooftries = nooftries + 1
				end
			end
		when "top"
			begin
				region = @screen.exists("#{image}").above(pixels.to_i)
			rescue
				if nooftries < 3
					nooftries = nooftries + 1
					retry
				else
					fail "Cant find the image #{image}"
					nooftries = nooftries + 1
				end
			end
		#end
			#fail("Code for this 'click position' hasnt been entered- #{position}")
	end
	@screen.click(region)
end




Given /^I doubleclick "(.*?)" pixels to the "(.*?)" of "(.*?)"$/ do |pixels,position,image|
	nooftries = 0
	case position.downcase
		when "right"
			begin
				region = @screen.exists("#{image}",6).right(pixels.to_i)
			rescue
				if nooftries < 3
					nooftries = nooftries + 1
					retry
				else
					fail "Cant find the image #{image}"
					nooftries = nooftries + 1
				end
			end
		when "left"
			begin
				region = @screen.exists("#{image}",6).left(pixels.to_i)
			rescue
				if nooftries < 3
					nooftries = nooftries + 1
					retry
				else
					fail "Cant find the image #{image}"
					nooftries = nooftries + 1
				end
			end
		when "bottom"
			begin
				region = @screen.exists("#{image}",6).below(pixels.to_i)
			rescue
				if nooftries < 3
					nooftries = nooftries + 1
					retry
				else
					fail "Cant find the image #{image}"
					nooftries = nooftries + 1
				end
			end
		when "top"
			begin
				region = @screen.exists("#{image}").above(pixels.to_i)
			rescue
				if nooftries < 3
					nooftries = nooftries + 1
					retry
				else
					fail "Cant find the image #{image}"
					nooftries = nooftries + 1
				end
			end
		#end
			#fail("Code for this 'click position' hasnt been entered- #{position}")
	end
	@screen.doubleClick(region)
end

Given /^I click on the OK button$/ do 
	res = 0
	begin
		if @screen.exists "button_OK4.png", 2
			@screen.doubleClick "button_OK4.png"
		else
			region = @screen.exists "button_OK.png",2
			@screen.doubleClick(region)
		end
	rescue
		if res < 5
			retry
		else
			res = res + 1
		end
	end
end


Given(/^Within region "(.*?)" click "(.*?)"$/) do |regionImage, clickImage|
	region = @screen.exists("#{regionImage}").below()
	image = clickImage.split(",")
	number = image.length
	tries = 0
	begin
		region.click "#{image[tries]}" 
	rescue
		if tries < number 
			tries = tries + 1
			retry
		else
			fail("Did not find the images: '#{clickImage}' in the region")
		end

	end
end


Given(/^Within region "(.*?)" rightclick "(.*?)"$/) do |regionImage, clickImage|
	region = @screen.exists("#{regionImage}").below()
	image = clickImage.split(",")
	number = image.length
	tries = 0
	begin
		region.rightClick "#{image[tries]}" 
	rescue
		if tries < number 
			tries = tries + 1
			retry
		else
			fail("Did not find the images: '#{clickImage}' in the region")
		end

	end
end


Given(/^Within region "(.*?)" doubleclick "(.*?)"$/) do |regionImage, clickImage|
	region = @screen.exists("#{regionImage}").below()
	image = clickImage.split(",")
	number = image.length
	tries = 0
	begin
		region.doubleClick "#{image[tries]}" 
	rescue
		if tries < number 
			tries = tries + 1
			retry
		else
			fail("Did not find the images: '#{clickImage}' in the region")
		end

	end

end


Given(/^Within region "(.*?)" click "(.*?)" if exists$/) do |regionImage, clickImage|
	
	region = @screen.exists("#{regionImage}").below()
	#region.highlight(1)
	begin
		region.click "#{clickImage}" 
	rescue
	end

end


Given /^I rightclick on either "(.*?)" or "(.*?)"$/ do |bitmap,bitmap2|
	#step "Wait for loading cursor"
	
	#   @value = @screen.exists "#{bitmap}", 10
	#   puts @value	
	if @screen.exists "#{bitmap}", 5	
		@region = @screen.exists "#{bitmap}"
		#puts @region.getScore()
		if @region.getScore() > BITMAPTOLERANCELEVEL
			#@region.highlight(1)
			@screen.rightClick "#{bitmap}"
		else
			#begin	
	      	#	fail("Bitmap = " + bitmap + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL.to_s + " - Score = " + @region.getScore().to_s)
			#rescue
				if @screen.exists "#{bitmap2}", 5	
					@region = @screen.exists "#{bitmap2}"
					#puts @region.getScore()
					if @region.getScore() > BITMAPTOLERANCELEVEL
						#@region.highlight(1)
						@screen.rightClick "#{bitmap2}"
					else
				      fail("Bitmap = " + bitmap2 + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL.to_s + " - Score = " + @region.getScore().to_s)
					end
				else
				   fail("The following bitmaps cannot be found: " + bitmap + " or " + bitmap2)
				end
			#end
		end
	elsif @screen.exists "#{bitmap2}", 2	
		@region = @screen.exists "#{bitmap2}"
		#puts @region.getScore()
		if @region.getScore() > BITMAPTOLERANCELEVEL
			#@region.highlight(1)
			@screen.rightClick "#{bitmap2}"
		else
	      fail("Bitmap = " + bitmap2 + " does Not Score Above Required Limit of " + BITMAPTOLERANCELEVEL.to_s + " - Score = " + @region.getScore().to_s)
		end

	else
	   fail("The following bitmaps cannot be found: " + bitmap + " or " + bitmap2)
	end
	step "Wait for loading cursor"
end


Then /^I click "(.*?)" in the recommend to keep section$/ do |text|
	region = @screen.exists("recommend_to_keep_popup.png").below(200)
	region.highlight(1)
	region.click text
	bitmap = "button_Cancel.png"
	waitingOver = calculate_wait("now")
	timeout = 0
    bitmapStillThere = true

    while bitmapStillThere			
		timeout += 10			
		if region.waitVanish "#{bitmap}",5
			bitmapStillThere = false
		else
			puts bitmap + " Still Present"
		end
				
		if !region.exists "#{bitmap}",5
			bitmapStillThere = false
		end

		if timeout == waitingOver
			fail("TimedOut - " + timeout.to_s + ":The following bitmap can still be found: " + bitmap)
		end
	end	

end


When /^I "(.*?)" the best media checkbox$/ do |action|
 	
 	unticked = "best_media_unticked.png"
 	ticked = "best_media_ticked.png"

 	@region = @screen.exists unticked
 	#puts @region.getScore()
	if @region.getScore() > 0.93
		if(action == "tick")
			@screen.click unticked
		else
			#@screen.click ticked
		end
	else
		if(action == "tick")
			#@screen.click unticked
		else
			@screen.click ticked
		end
	end

	steps %Q{
		And I wait for any not responding message to disappear
	}
end


When /^I "(.*?)" the archive checkbox$/ do |action|
 	
 	unticked = "description_archive_unticked.png"
 	unticked2 = "description_archive_unticked2.png"
 	ticked = "description_archive_ticked.png"

 	if(@screen.exists unticked)
 		
 		@region = @screen.exists unticked
 		if @region.getScore() > 0.93
			if(action == "tick")
				@screen.click unticked
			else
				#@screen.click ticked
			end
		else
			if(action == "tick")
				#@screen.click unticked
			else
				@screen.click ticked
			end
		end

 	elsif(@screen.exists unticked2)

 		@region = @screen.exists unticked2
 		if @region.getScore() > 0.93
			if(action == "tick")
				@screen.click unticked
			else
				#@screen.click ticked
			end
		else
			if(action == "tick")
				#@screen.click unticked
			else
				@screen.click ticked
			end
		end

 	else

 		if(action == "tick")
			#@screen.click unticked
		else
			@screen.click ticked
		end

 	end

 	
 	#puts @region.getScore()
	

	steps %Q{
		And I wait for any not responding message to disappear
	}
end