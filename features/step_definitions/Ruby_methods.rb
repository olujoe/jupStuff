def getCurrentTime()

	currentTime = Time.new
	currentTimeHourString = currentTime.hour.to_s 
	currentTimeMinString = currentTime.min.to_s 
	currentTimeSecString = currentTime.sec.to_s 
	if currentTimeHourString.length < 2
		currentTimeHourString = "0#{currentTimeHourString}"
	end 
	if currentTimeMinString.length < 2
		currentTimeMinString = "0#{currentTimeMinString}"
	end 
	if currentTimeSecString.length < 2
		currentTimeSecString = "0#{currentTimeSecString}"
	end
	return "#{currentTimeHourString}:#{currentTimeMinString}:#{currentTimeSecString}"
end


def renameMediaItem(mediaitemid,mistory,midetails)
	numberOfTries = 0
	begin
		
		changeMIName_url = "#{$config[$site]['renameMI']}#{mediaitemid}&metadata=%3Citemdetails%3E%3Cstoryname%3E#{mistory}%3C/storyname%3E%3Cdetail%3E#{midetails}%3C/detail%3E%3C/itemdetails%3E"
		puts changeMIName_url
		xml_data = open(changeMIName_url).read
		result = xml_data.split("<RC status=")[1].split(" call=")[0]
		puts result
	rescue
		numberOfTries = numberOfTries + 1
		if(numberOfTries < 4)
			sleep 3
			retry
		else
			raise "Unable to rename the media item ising method renameMediaItem"
		end
	end
end


def makeMediaItemFinished(mediaitemid)
	numberOfTries = 0
	begin
		changeMIName_url = "#{$config[$site]['renameMI']}#{mediaitemid}&metadata=%3Citemdetails%3E%3Cstatusname%3EFinished%3C/statusname%3E%3C/itemdetails%3E"
		#puts changeMIName_url
		xml_data = open(changeMIName_url).read
		result = xml_data.split("<RC status=")[1].split(" call=")[0]
		#fail unless result.downcase == "ok"

	rescue
		numberOfTries = numberOfTries + 1
		if(numberOfTries < 4)
			sleep 3
			retry
		else
			raise "Unable to rename the media item using method makeMediaItemFinished"
		end
	end
end


def getMediaItemDates(mediaId)
	uri = "#{$config[$site]['mediadetails']}#{mediaId}"
	xml_data = open(uri).read
	if(xml_data.include? "plannedDeletionDateTime")
		deletionDate = xml_data.split("<plannedDeletionDateTime>")[1].split("</plannedDeletionDateTime>")[0].gsub("T"," ").gsub("Z","")
	else
		deletionDate = ""
	end
	createdDate = xml_data.split("<creationDateTime>")[1].split("</creationDateTime>")[0].gsub("T"," ").gsub("Z","")
	#puts "deletionDate: #{deletionDate}"
	#puts "createdDate: #{createdDate}"
	return [createdDate,deletionDate]
end


def getMediaItemClipname(mediaId)
	uri = "#{$config[$site]['mediadetails']}#{mediaId}"
	xml_data = open(uri).read
	if(xml_data.include? "clipName>")
		clipName = xml_data.split("<clipName>")[1].split("</clipName>")[0]
	else
		clipName = ""
	end
	return clipName
end


def getMediaItemClipName(mediaId)
	uri = "#{$config[$site]['mediadetails']}#{mediaId}"
	xml_data = open(uri).read
	clipName = xml_data.split("<clipName>")[1].split("</clipName>")[0].strip
	return clipName
end


def createANewMediaItem()
	mediaitem = "#{$config[$site]['duplicateurl']}#{$config[$site]['duplicatedMediaItem']}"
	#mediaitem = "#{$config[$site]['duplicatedMediaItem']}"
	puts mediaitem
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

Given(/^I get the clipname$/) do
  	$clipname = getMediaItemClipName($automationfileid)
end

Then(/^I go to JOE Monitoring page$/) do
  $browser = Watir::Browser.new :chrome
  $browser.goto "http://qa64w1app07.jupiter.bbc.co.uk/jupGUI/jobs/"


end


def getConfigData(filename)
	data1 = $config['configfiles'][filename]
	data2 = YAML.load(File.read(data1))
	data = data2[$site]
end



class String
    def isInteger? 
      [                          # In descending order of likeliness:
        /^[-+]?[1-9]([0-9]*)?$/, # decimal
        /^0[0-7]+$/,             # octal
        /^0x[0-9A-Fa-f]+$/,      # hexadecimal
        /^0b[01]+$/              # binary
      ].each do |match_pattern|
        return true if self =~ match_pattern
      end
      return false
    end
end

class WebLog
	def self.log
		if @logger.nil?
			#@logger = Logglier.new("http://qa64w1.davina.jupiter.bbc.co.uk/jex/olu/logger.php", :format => :json)
			@logger = Logglier.new("http://qa64w1.davina.jupiter.bbc.co.uk/jex/olu/logger.php")
			@logger.level = Logger::DEBUG
			@logger.datetime_format = '%Y-%m-%d %H:%M:%S '
		end
		@logger
	end
end

class StepTimer
  def self.start(stepname)
	end

	def self.stop(stepname)
	end
end

class Jlogs
	def self.jlogs(file_name, line_num, msg)
		WebLog.log.info "{\"file\": "+"\""+ file_name +"\""+", \"line\": "+"\""+ line_num +"\""+", \"time\": "+"\""+Time.now.strftime("%H:%M:%S")+"\""+", \"msg\":"+" \"#{msg}\"}"
	end
end


def getItemID
	#get the item id
	#if(!$readfileid)
		steps %Q{
			When I rightclick on "qvl_Volume2.png" 
			And I click on "rightclick_copy.png"
			And I click on "shortcut.png"
			Then I wait "3" seconds
		}
		shortcut = Clipboard.paste.encode('utf-8')
		$readfileid = shortcut.split("]:")[1].split(">>")[0].split(".")[0]
	#end
end


def deleteAllKeyframes(changeMIName_url,mid)
	numberOfTries = 0
	#begin
	puts "#{changeMIName_url}#{mid}"
		xml_data = open("#{changeMIName_url}#{mid}").read
		result = xml_data.split("<keyframes>")[1].split("</keyframes>")[0]
		keyframes = result.split("<keyframe")

		keyframes.each do |item|
			if(item.length > 1)
				ids = item.split("<id>")[1].split("</id>")[0]
				puts ids
				puts "#{$config[$site]['delete_keyframes']}#{mid}&componentid=#{ids}"
				xml_data = open("#{$config[$site]['delete_keyframes']}#{mid}&componentid=#{ids}").read

			end
		end

		#fail unless result.downcase == "ok"

	#rescue
	#	numberOfTries = numberOfTries + 1
	#	if(numberOfTries < 4)
	#		sleep 3
	#		retry
	#	else
	#		raise "Unable to get all the keyframes for the media item"
	#	end
	#end
end


def random_string(length)

    # All lowercase letters.
    letters = "abcdefghijklmnopqrstuvwxyz0123456789"

    # Empty Array for letters we add.
    word = Array[]

    # Add all random letters.
    length.times do

        # Get random index within string.
        r = rand 0..35

        # Get letter for index.
        letter = letters[r]

        # Push to our array.
        word.push(letter)
    end

    # Return random string joined together.
    result = word.join("")
end


def upadetNewQAAPI(scenario_tags,status)

	#puts " ******* upadetNewQAAPI ****** scenario_tags: #{scenario_tags} *** status: #{status} ******"
	result_url = "http://zgbwcqalamp01.jupiter.bbc.co.uk/jupiter/feature_file_result.php?project"
	env = $site.gsub("_"," ").gsub("-"," ").gsub("  "," ").strip

	# store the screnario result
	if(!$feature_status)
	    $feature_status = ""
	end

	if(status == false) || (status == "")
	    if($feature_status != "fail")
	        $feature_status = "pass"
	    else
	    	#puts "Found a FAILURE"
	    end
	end

	if(!$test_feature_file)
	    $test_feature_file = ""
	end

	if(scenario_tags == false) || (scenario_tags == "")

		# we are at the end of the test run
		# send the last saved data
		#puts "**************End of Test Run Sending Results*********************"
	    #puts "sending. #{$saved_result}"

	    if((!$saved_result) || ($saved_result == ""))
			#puts "**************No result*********************"

	    	test_tags_new = ""

	   		$test_tags.split(",").each do |tt|
	        	test_tags_new = test_tags_new + tt.split('"')[1].split('"')[0] + " "
	    	end

	    	test_feature_file = $test_tags.split(",")[0].split("/").last.split(":")[0]

			project = "Jupiter"
		    filename = test_feature_file
		    result = "fail"
		    duration = ""
		    $feature_tags = test_tags_new

		    uri = "#{result_url}=#{project}&filename=#{filename}&result=#{result}&duration=#{duration}&env=#{env}&tags=#{$feature_tags}"
		    uri = uri.gsub(" ", "%20")
		    #puts "saving. #{uri}"
		    $saved_result = uri

	    end

	    tries = 0
	    begin
	        xml_data = open($saved_result).read
	        if(xml_data.include? 'Pass')
	            #puts "pass"
	        elsif(xml_data.include? '500')
	            #puts "fail"
	        else
	            #puts "Cannot Post result to qa tool, check Webservice"
	        end
	    rescue
	        if tries < 3 
	            tries = tries + 1
	            sleep 2
	            retry
	        else
	            puts "Unable to post the qa tool after '#{tries}' attempts"
	        end
	    end

	    $feature_status = ""

	else

		$test_tags = scenario_tags
	    test_tags_new = ""

	    scenario_tags.split(",").each do |tt|
	        test_tags_new = test_tags_new + tt.split('"')[1].split('"')[0] + " "
	    end

	    test_feature_file = scenario_tags.split(",")[0].split("/").last.split(":")[0]
		#puts "***$test_feature_file:#{$test_feature_file}***"

		if(status == "")

			# we are in the begining of a scenario
			# check if we are still in the same feature file

	      	if( ($test_feature_file != test_feature_file) && ($test_feature_file != ""))
	         
			    #puts "**************NEW Feature file Sending Results*********************"
	            #puts "sending. #{$saved_result}"

	            #$feature_end_time = Time.now
	            #$feature_start_time = Time.now
	            #feature_duration = 
	            #if($saved_result)

	            tries = 0
	            begin
	                xml_data = open($saved_result).read
	                #puts xml_data
	                if(xml_data.include? 'Pass')
	                    #puts "pass"
	                elsif(xml_data.include? '500')
	                   # puts "fail"
	                else
	                   # puts "Cannot Post result to qa tool, check Webservice"
	                end
	            rescue
	                if tries < 3 
	                    tries = tries + 1
	                    sleep 2
	                    retry
	                else
	                    puts "Unable to post the qa tool after '#{tries}' attempts"
	                end
	            end

	            # send the starting feature file test data to the server
	            #puts "************** Sending the start run for feature file data **************"
			    project = "Jupiter"
			    filename = test_feature_file
			    result = ""
			    duration = ""
			    $feature_tags = test_tags_new

			    uri = "#{result_url}=#{project}&filename=#{filename}&result=#{result}&duration=#{duration}&env=#{env}&tags=#{$feature_tags}"
			    uri = uri.gsub(" ", "%20")
			    puts uri

	            tries = 0
	            begin
	                xml_data = open(uri).read
	                #puts xml_data
	                if(xml_data.include? 'Pass')
	                    #puts "pass"
	                elsif(xml_data.include? '500')
	                   # puts "fail"
	                else
	                   # puts "Cannot Post result to qa tool, check Webservice"
	                end
	            rescue
	                if tries < 3 
	                    tries = tries + 1
	                    sleep 2
	                    retry
	                else
	                    puts "Unable to post the qa tool after '#{tries}' attempts"
	                end
	            end

	            $feature_status = ""
	        else
	        	#puts "************** nothing **************"
	        	$test_status = "started"
	        	if($test_feature_file == "")
	        		#puts "************** Sending the start run for feature file data **************"

	        		# send the starting feature file test data to the server

				    project = "Jupiter"
				    filename = test_feature_file
				    result = ""
				    duration = ""
				    $feature_tags = test_tags_new

				    uri = "#{result_url}=#{project}&filename=#{filename}&result=#{result}&duration=#{duration}&env=#{env}&tags=#{$feature_tags}"
				    uri = uri.gsub(" ", "%20")
				    puts uri
				    
		            tries = 0
		            begin
		                xml_data = open(uri).read
		                #puts xml_data
		                if(xml_data.include? 'Pass')
		                    #puts "pass"
		                elsif(xml_data.include? '500')
		                   # puts "fail"
		                else
		                   # puts "Cannot Post result to qa tool, check Webservice"
		                end
		            rescue
		                if tries < 3 
		                    tries = tries + 1
		                    sleep 2
		                    retry
		                else
		                    puts "Unable to post the qa tool after '#{tries}' attempts"
		                end
		            end


	        	end
	        end

		else

		    #puts "************** Same file **************"
		    project = "Jupiter"
		    filename = test_feature_file
		    result = $feature_status
		    duration = ""
		    $feature_tags = test_tags_new

		    uri = "#{result_url}=#{project}&filename=#{filename}&result=#{result}&duration=#{duration}&env=#{env}&tags=#{$feature_tags}"
		    uri = uri.gsub(" ", "%20")
		    #puts "saving. #{uri}"
		    $saved_result = uri
		    $feature_duration = 0

		end

	    $test_feature_file = test_feature_file

	end
=begin

		# not in the begin section 

	  # store the screnario result
	  if(!$feature_status)
	    $feature_status = ""
	  end

	  if(status == false) || (status == "")
	      if($feature_status != "fail")
	          $feature_status = "pass"
	      end
	  end
	  
	  if(!$test_feature_file)

	    $test_feature_file = ""

	  else
	     
	      #if(scenario_tags == "")
	          $test_tags = scenario_tags
	          test_tags_new = ""

	          scenario_tags.split(",").each do |tt|
	              test_tags_new = test_tags_new + tt.split('"')[1].split('"')[0] + " "
	          end

	          test_feature_file = scenario_tags.split(",")[0].split("/").last.split(":")[0]
	      #else
	      #	test_feature_file = "--"
	      #end

	puts "***$test_feature_file:#{$test_feature_file}***"


	      if($test_feature_file != test_feature_file)
	         
	          # new feature
	          puts "**************NEW Feature file Sending Results*********************"

	          #puts "sending previous result"
	          puts "sending. #{$saved_result}"

	          #$feature_end_time = Time.now
	          #$feature_start_time = Time.now
	          #feature_duration = 
	          #if($saved_result)

	              tries = 0
	              begin
	                  xml_data = open($saved_result).read
	                  #puts xml_data
	                  if(xml_data.include? 'Pass')
	                  		puts "pass"
	                  elsif(xml_data.include? '500')
	                  		puts "fail"
	                  else
	                    puts "Cannot Post result to qa tool, check Webservice"
	                  end
	              rescue
	                  if tries < 3 
	                      tries = tries + 1
	                      sleep 2
	                      retry
	                  else
	                      puts "Unable to post the qa tool after '#{tries}' attempts"
	                  end
	              end
	          # end

	          $feature_status = ""

	      end


	      #puts "Same file"
	      project = "Jupiter"
	      filename = test_feature_file
	      result = $feature_status
	      duration = ""
	      env = $site.gsub("_","-").gsub("  "," ").strip
	      $feature_tags = test_tags_new

	      uri = "http://localhost/jupiter/feature_file_result.php?project=#{project}&filename=#{filename}&result=#{result}&duration=#{duration}&env=#{env}&tags=#{$feature_tags}"
	      uri = uri.gsub(" ", "%20")
	      #puts "saving. #{uri}"
	      $saved_result = uri
	      $feature_duration = 0


	  end
	 
	  #if(scenario_tags == "")
	      test_feature_file = scenario_tags.split(",")[0].split("/").last.split(":")[0]
	      $test_feature_file = test_feature_file
	  #end
=end
end