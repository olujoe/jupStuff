##################################################
# Video pipeline job monitoring file for Jupiter
# Written by Olugbenga Ogunbusola
# October 2015, May 2016, June 2016
##################################################

ENV['HTTP_PROXY'] = ENV['http_proxy'] = nil

def buildUpdateXML(payload_in)
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "buildUpdateXML started")
	#out="<itemdetails>"
	out="%3Citemdetails%3E"
	payload_in.each do |x,y|
		if (y != "")
			#out+="<" + x + ">" + y + "</" + x + ">"
			out+="%3C" + x + "%3E" + y + "%3C/" + x + "%3E"
		end
	end
	#out+="</itemdetails>"
	out+="%3C/itemdetails%3E"
	return out
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "buildUpdateXML end")
end

def changeMediaItemName(mediaitemid,mistory,midetails,statusname)
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "changeMediaItemName stated")
	buildUpdateXML_out = buildUpdateXML({
			"statusname" => "#{statusname}",
			"storyname" => "#{mistory}",
			"detail" => "#{midetails}"
	})
	numberOfTries        = 0
	begin
		changeMIName_url   = "#{$config[$site]['renameMI']}#{mediaitemid}&metadata=#{buildUpdateXML_out}"
		url                = "#{changeMIName_url}"
		puts url
		xml_data           = open(url).read
		puts xml_data
		result             = xml_data.split("<RC status=")[1].split("/>")[0]
		puts result
	rescue
		numberOfTries      = numberOfTries + 1
		if(numberOfTries < 4)
			sleep 3
			retry
		else
			#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "changeMediaItemName fail")
			raise "Unable to rename the media item"
		end
	end
	if ("#{statusname}" == "Placeholder")
		$place_mediaitemid = mediaitemid
	end
	$changedclipname     = "#{mistory}/#{midetails}"
	return $changedclipname
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "changeMediaItemName end")
end

#This method was copied from createANewMediaItem to create duplicate, media items from zz_reserved
def createANewJLIBMediaItem(n)
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "createANewJLIBMediaItem started")
	reserved             = $config[$site]["zz_reserved"].split(",")
	reserved             = eval reserved.to_s.gsub('"', '')
	dupMediaItem         = reserved[n]
	puts reserved.inspect
	puts dupMediaItem.inspect
	mediaitem            = "#{$config[$site]['duplicateurl']}#{dupMediaItem}"
	puts mediaitem
	numberOfTries        = 0
	begin
		uri                = "#{mediaitem}"
		xml_data           = open(uri).read
		$jlib_mediaitemid  = xml_data.split("itemid=\"")[1].split("\" newmediaitemlength")[0]
		$jlib_duration     = xml_data.split('" newmediaitemlength="')[1].split('" seedlength=')[0]
	rescue
		numberOfTries      = numberOfTries + 1
		if(numberOfTries < 4)
			sleep 3
			retry
		else
			raise "Unable to duplicate the media item"
		end
	end
	puts $jlib_mediaitemid
	puts $jlib_duration
	return $jlib_mediaitemid, $jlib_duration
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "createANewJLIBMediaItem end")
end

def mpp_check()
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "mpp_check started")
	counter             = 1
	mppjobfinish        = "false"
	begin
		counter          += 1
		#mpp_check_url = "http://qa64w1app06.jupiter.bbc.co.uk:8082/supportAllInstance/getMPPQueue.jsp"
		mpp_check_url     = $config[$site]["mppcheckurl"]
		xml_data          = open(mpp_check_url).read
		itemids           = []
		if(xml_data.include? "results")
			results         = xml_data.split("<RESULTS>")[1].split("</RESULTS>")[0].strip
			item            = results.split("<ITEM>")[1..-1]
			item.each do |eachitem|
				itemids.push(eachitem.split("<ITEMID>")[1].split("</ITEMID>")[0].strip.to_i)
			end
			itemids         = itemids.sort
			puts itemids.inspect
		end

		if (itemids.include?($read_fileid))
			fail "mpp job on MI #{$read_fileid} In Progress"
			mppjobfinish    = "false"
		else
			pass "mpp job on MI #{$read_fileid} Complete"
			mppjobfinish    = "true"
		end
	rescue
		puts counter
		if (mppjobfinish  == "false")
			puts itemids.inspect
			puts "mppjobfinish = false"
			#if counter > 900
			#	fail "we just wanted to stop it here"
			#else
			sleep 10
			retry
			#end
		else
			puts "mppjobfinish = true"
			puts itemids.inspect
		end
	end
	sleep 1
	puts "mpp_check complete for MI #{$read_fileid}, goodbye!"
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "mpp_check end")
end

def zzperform_delete_MI(mi_name)
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "zzperform_delete_MI started")
	mi = []
	#WEST1 zz_reserved: "5638687,5594962,5638659,5638730,5638932,5638703,5594972,5594975,5638676,5638777"
	#QAW1  zz_reserved: "298858,298857,298856,298855,298852,298850,298846,298845,298862,298851"
	reserved = $config[$site]["zz_reserved"].split(",")
	reserved = eval reserved.to_s.gsub('"', '')
	puts reserved.inspect
	puts "All non reserved #{mi_name} MI's excluded from the list above will now be deleted..."

	#delMI = "http://qa64w1app05.jupiter.bbc.co.uk:8082/mediaitem/mediaitemsearchGui.jsp?text=zzperform&order=creationdatetime"
	zzperformdt = "#{$config[$site]['delMI']}#{mi_name}&order=creationdatetime"
	xml_data = open(zzperformdt).read
	itemids    = []
	if(xml_data.include? "MediaItems")
		mediaItems = xml_data.split("<MediaItems>")[1].split("</MediaItems>")[0].strip
		mediaitem = mediaItems.split("<mediaitem>")[1..-1]
		mediaitem.each do |eachMediaitem|
			itemids.push(eachMediaitem.split("<ITEMID>")[1].split("</ITEMID")[0].strip.to_i)
		end
		itemids = itemids.sort
		puts itemids.inspect
		mi = itemids - reserved
		puts mi.inspect
	end

	mi.each do |m|
		#delOnlineShelfMIurl = "http://qa64w1app01.jupiter.bbc.co.uk:8082/mediaitem/markForDeletion.jsp?userid=bbcnewstest&itemid=#{m}&includeonline=true&includeshelf=true"
		delOnlineShelfMIurl = $config[$site]["delOnlineShelfMIurl"]+"#{m}&includeonline=true&includeshelf=true"

		open(delOnlineShelfMIurl).read
		puts "An Online Shelf delete request has been sent for this media item: #{m}"
	end
	mi.each do |m|
		#delCacheShelfMIurl = "http://qa64w1app01.jupiter.bbc.co.uk:8082/site2site/deleteCacheShelfInstances.jsp?userid=bbcnewstest&itemid=#{m}"
		delCacheShelfMIurl = $config[$site]["delCacheShelfMIurl"]+"#{m}"
		open(delCacheShelfMIurl).read
		puts "A CacheShelf delete request has been sent for this media item: #{m}"
	end
	mi.each do |m|
		#delOfflineMIurl = "http://qa64w1app01.jupiter.bbc.co.uk:8082/site2site/deleteImmediateFromArchive.jsp?itemid=#{m}&userid=bbcnewstest"
		delOfflineMIurl = $config[$site]["delOfflineMIurl"]+"#{m}&userid=bbcnewstest"
		open(delOfflineMIurl).read
		puts "An Offline delete request has been sent for this media item: #{m}"
		end

	puts "All #{mi_name} non reserved MI delete complete, goodbye!"
	sleep 2
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "zzperform_delete_MI end")
end

def getJobData()
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "getJobData started")
	puts 'Task now in getJobData'
	puts "The MI I am using is: #{$read_fileid}"
	url = $config[$site]["getJobDataURL"]+ "#{$read_fileid}%22"
	#url = "http://zgbwccouchdb7001.jupiter.bbc.co.uk:5984/joe-qa64w1/_design/performanceTest/_view/performanceTest?key=%22#{$read_fileid}%22"
	resp = Net::HTTP.get_response(URI.parse(url))
	data = resp.body
	begin
		 data = Net::HTTP.get_response(URI.parse(url)).body
	rescue
		 puts "Connection error."
	end
	$pt1_data = data
	#Need for debugging
	#puts "url  : #{url}"
	#puts "resp : #{resp}"
	#puts "data : #{data}"
	puts 'Task now leaving getJobData'
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "getJobData end")
end

def getJobID()
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "getJobID started")
	puts 'Task now in getJobID()'
	puts 'Now calling getJobData()'
	getJobData()
	puts 'Back in getJobID() from getJobData()'
	data              = $pt1_data
	datetime1         = $datetime
	value             = JSON.parse(data)
  #Need for debugging
	#puts data
	#puts value
	finished          = value['rows'][0]['value'][0]['finished']
	failed            = value['rows'][0]['value'][0]['failed']
	while finished    != true do
		sleep 2
		getJobData()
		data            = $pt1_data
		value           = JSON.parse(data)
		finished        = value['rows'][0]['value'][0]['finished']
		failed          = value['rows'][0]['value'][0]['failed']
	end
	puts 'finished is '+"#{finished}"
	failed            = value['rows'][0]['value'][0]['failed']
	if failed         == false
		$mediaitemid    = value['rows'][0]['key']
		datetime2       = value['rows'][0]['value'][0]['jobSubmittedTime']
		jobStatrTime1   = value['rows'][0]['value'][0]['jobQueuedTime']
		jobEndTime1     = value['rows'][0]['value'][0]['jobCompletedTime']
		finished        = value['rows'][0]['value'][0]['finished']
		x               = datetime2.split(":")[0]
		y               = datetime2.split(":")[1]
		$ndatetime2     = x+":"+y
		actualdt = Time.now.strftime("%Y-%m-%dT%H:%M")
		puts $ndatetime2
		puts actualdt
		if actualdt >= $ndatetime2
			job_id        = value['rows'][0]['id']
			url           = $config[$site]["getJobIDURL"]+"#{job_id}"
			#url           = "http://zgbwccouchdb7001.jupiter.bbc.co.uk:5984/joe-qa64w1/#{job_id}"
			resp          = Net::HTTP.get_response(URI.parse(url))
			data          = resp.body
			begin
			   data       = Net::HTTP.get_response(URI.parse(url)).body
			rescue
			   puts "Connection error."
			end
			$pt2_data   = data
			puts 'Job ' +"#{job_id}"+ ' FOUND!'
		else
			fail 'NO job FOUND!'
		end
		$job = "#{job_id}"
		return $job
	elsif failed == true
			fail "The job has failed"
	else
			puts "ooOps I Dont know what failed!, code is in getJobID"
	end
	puts 'Task now leaving getJobID'
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "getJobID end")
end

def readMIinstance(jobstatus, mi_type)
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "readMIinstance started")
	puts "Task now in readMIinstance"
	puts "**************************"
	counter = 1
	ispresent = "false"
	begin
		counter += 1
		sleep 2
		url = $config[$site]["readMIinstanceURL"]+"#{$read_fileid}"
		#url = "http://qa64w1app05.jupiter.bbc.co.uk:8082/mediaitem/mediaitemXMLwithInstance.jsp?itemids=#{$read_fileid}"
		xml_data = open(url).read
		type    = []
		hdarray = []
		#ispresent = "false"
		if(xml_data.include? "instances")
			instances = xml_data.split("<instances>")[1].split("</instances>")[0].strip
			instance = instances.split("<instance")[1..-1]
			instance.each do |eachInstance|
				type.push(eachInstance.split("<type>")[1].split("</type")[0].strip.to_i)
			end
			type = type.sort
			print '#{jobstatus} array content: '
			puts type.inspect
		end

		type = type.sort
		case jobstatus
			when "save"
				#ispresent = "true"
				if mi_type.downcase == "hd"
					hdarray = [1,3,4,5,11,20,112,114]
					#if (type.size == hdarray.size) && (type == hdarray)
					if ((type.include?("1")) && (type.include?("20")) && (type.include?("112")))
						ispresent = "true"
						print 'ispresent = true with hdarray: '
						puts hdarray.inspect
						print 'ispresent = true with type: '
						puts type.inspect
					else
						ispresent = "false"
						print 'ispresent = false with hdarray: '
						puts hdarray.inspect
						print 'ispresent = false with type: '
						puts type.inspect
					end
				elsif mi_type.downcase == "sd"
					sdarray = [1,3,4,5,11,12,20,114]
					if (type.size == hdarray.size) && (type == sdarray)
					#if ((type.include?(1)) && (type.include?(12)) && (type.include?(20)))
						ispresent = "true"
						print 'ispresent = true with hdarray: '
						puts hdarray.inspect
						print 'ispresent = true with type: '
						puts type.inspect
					else
						ispresent = "false"
						print 'ispresent = false with hdarray: '
						puts hdarray.inspect
						print 'ispresent = false with type: '
						puts type.inspect
					end
				end
				puts "ispresent is #{ispresent} for #{jobstatus}"

			when "restore"
				#ispresent = "true"
				if mi_type.downcase == "hd"
					hdarray = [1,3,4,5,11,20,112,114]
					if (type.size == hdarray.size) &&  (type == hdarray)
					#if ((type.include?(1)) && (type.include?(20)) && (type.include?(112)))
						ispresent = "true"
						print 'ispresent = true with hdarray: '
						puts hdarray.inspect
						print 'ispresent = true with type: '
						puts type.inspect
					else
						ispresent = "false"
						print 'ispresent = false with hdarray: '
						puts hdarray.inspect
						print 'ispresent = false with type: '
						puts type.inspect
					end
				elsif mi_type.downcase == "sd"
					sdarray = set[1,3,4,5,11,12,20,114]
					if (type.size == hdarray.size) && (type == sdarray)
					#if ((type.include?(1)) && (type.include?(12)) && (type.include?(20)))
						ispresent = "true"
						print 'ispresent = true with hdarray: '
						puts hdarray.inspect
						print 'ispresent = true with type: '
						puts type.inspect
					else
						ispresent = "false"
						print 'ispresent = false with hdarray: '
						puts hdarray.inspect
						print 'ispresent = false with type: '
						puts type.inspect
					end
				end
				puts "ispresent is #{ispresent} for #{jobstatus}"

			when "partialrestore_A"
				#ispresent = "true"
				if mi_type.downcase == "hd"
					hdarray = [3,4,5,11,20,112,114]
					if (type.size == hdarray.size) && (type == hdarray)
					#if ((type.include?(20)) && (type.include?(112)))
						ispresent = "true"
						print 'ispresent = true with hdarray: '
						puts hdarray.inspect
						print 'ispresent = true with type: '
						puts type.inspect
					else
						ispresent = "false"
						print 'ispresent = false with hdarray: '
						puts hdarray.inspect
						print 'ispresent = false with type: '
						puts type.inspect
					end
				elsif mi_type.downcase == "sd"
					sdarray = [3,4,5,11,12,20,114]
					if (type.size == hdarray.size) && (type == sdarray)
					#if ((type.include?(12)) && (type.include?(20)))
						ispresent = "true"
						print 'ispresent = true with hdarray: '
						puts hdarray.inspect
						print 'ispresent = true with type: '
						puts type.inspect
					else
						ispresent = "false"
						print 'ispresent = false with hdarray: '
						puts hdarray.inspect
						print 'ispresent = false with type: '
						puts type.inspect
					end
				end
				puts "ispresent is #{ispresent} for #{jobstatus}"

			when "partialrestore_B"
				#ispresent = "true"
				if mi_type.downcase == "hd"
					hdarray = [1,3,4,5,11,112]
					if (type.size == hdarray.size) && (type == hdarray)
					#if ((type.include?(1)) && (type.include?(112)))
						ispresent = "true"
						print 'ispresent = true with hdarray: '
						puts hdarray.inspect
						print 'ispresent = true with type: '
						puts type.inspect
					else
						ispresent = "false"
						print 'ispresent = false with hdarray: '
						puts hdarray.inspect
						print 'ispresent = false with type: '
						puts type.inspect
					end
				elsif mi_type.downcase == "sd"
					sdarray = [1,3,4,5,11,12]
					if (type.size == hdarray.size) && (type == sdarray)
					#if ((type.include?(1)) && (type.include?(12)))
						ispresent = "true"
						print 'ispresent = true with hdarray: '
						puts hdarray.inspect
						print 'ispresent = true with type: '
						puts type.inspect
					else
						ispresent = "false"
						print 'ispresent = false with hdarray: '
						puts hdarray.inspect
						print 'ispresent = false with type: '
						puts type.inspect
					end
				end
				puts "ispresent is #{ispresent} for #{jobstatus}"

			else
				fail "There was a problem in I want to readMIinstance method!"
				ispresent == "false"
		end

		if ispresent == "false"
			fail "I need to wait until ispresent == true"
		end

	rescue
		puts counter
		if (ispresent == "false")
			puts "ispresent = false"
			#if counter > 180
			#	fail "we just wanted to stop it here"
			#else
				sleep 2
				retry
			#end
		else
			puts "ispresent = true"
			print "hdarray: "
			puts hdarray.inspect
			print "type: "
			puts type.inspect
		end
	end
	puts "Task now leaving readMIinstance"
	puts "*******************************"
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "readMIinstance end")
end

Given /^I want to check the performanceTest jobStatus with "(.*?)" "(.*?)" "(.*?)" and "(.*?)"$/ do |originalMediaItem, origMediaItempng, newMediaItempng, clipName|
		#Publish----------------------------------------------------------------------------------------------
		#Scenario: Search Media Items
	    steps %Q{
		    Given I search for "#{originalMediaItem}" in "All Material"
		    And I click on "button_Search.png" until "archive_Search_Status_Online.png" appears at_some_point
		}
		 steps %Q{
		    And I load asset "#{origMediaItempng}" into QVL
		    And I click on "qvl_Button_Clear.png"
		    And I click on either "qvl_Button_Left_Arrow.png" or "qvl_Button_Left_Arrow_Old.png"
		    And I type "i"
		    And I wait "2" seconds
		    And I click on either "qvl_Button_Right_Arrow.png" or "qvl_Button_Right_Arrow_Old.png"
		    And I wait "2" seconds
		    And I type "o"
		    And I wait "6" seconds
				And I click on "qvl_Button_Publish.png"
				And I wait for "qvl_Radio_Button_Status_Finished.png" to appear
				And I type "News"
				And I click on "qvl_Radio_Button_Status_Finished.png"
				And I click on "qvl_Radio_Button_Category_Sequence.png"
				And I click on "qvl_Textbox_Story.png"
				And I type "zzperform"
				And I click on "qvl_Textbox_Details.png"
				And I type "#{clipName}"
		    And I use TAB
		    And I type the current time
				And I click on "Button_Publish.png"
				And I wait for "button_remove.png" to disappear
				And I handle any publish name errors
		}
end

When /^I get the "(.*?)" jobstatus for "(.*?)" "(.*?)" "(.*?)" "(.*?)" "(.*?)" and "(.*?)"$/ do |jobstatus,newMediaItem,newMediaItempng,partMediaItem,partMediaItempng,cliphdsd,mitype|

	case jobstatus
	when "save"
	#Save--------------------------------------------------------------------------------------------------
	#Scenario: Search for Sequence
		steps %Q{
			And I search for "#{newMediaItem}" in "All Material"
			And I click on "button_Search.png" until "archive_Search_Status_Online.png" appears at_some_point
			And I rightclick on "archive_Search_Status_Online.png" and click "rightclick_copy.png"
			And I click on "shortcut.png"
			And I wait "3" seconds
			And I get the cliplist itemid
			And I get the cliplist item datetime
    }
		#And I readMIinstance with "#{jobstatus}" and "#{mitype}"
		steps %Q{
			And I click on "white_space.png"
			And I rightclick on "archive_Search_Status_Online.png" and click "context_Menu_Keep_Decision.png"
			And I click on "archive_Search_Checkbox_Offline.png"
			And I get the actual datetime
			And I click on "button_OK.png"
			And I wait for "button_Cancel.png" to disappear
			And I should not see "button_Ok.png"
			And I wait "20" seconds
			And I get "#{jobstatus}" JobID with "#{newMediaItem}" and "#{mitype}"
		}
		#steps %Q{
	   	#	And I see the "#{jobstatus}" jobstatus
	    #}
	when "restore"
	#Restore------------------------------------------------------------------------------------------------
	#Scenario: Search for Sequence
	    steps %Q{
		    And I search for "#{newMediaItem}" in "All Material"
		    And I click on "button_Search.png" until "archive_Search_Status_Offline.png" appears at_some_point
		    And I rightclick on "archive_Search_Status_Offline.png" and click "rightclick_copy.png"
		    And I click on "shortcut.png"
		    And I wait "3" seconds
		    And I get the cliplist itemid
		    And I get the cliplist item datetime
		    And I search for "#{newMediaItem}" in "All Material"
			}
			#And I readMIinstance with "#{jobstatus}" and "#{mitype}"
		#Scenario: Select Restore from Shelf checkbox
	    steps %Q{
			And I click on "white_space.png"
		    And I rightclick on "archive_Search_Status_Offline.png" and click "archive_Rightclick_Restore.png"
		    And I click on "button_restore.png"
		    And I wait "2" seconds
		    And I click on "button_restore.png" if exists
		    And I get the actual datetime
				And I click on "button_Ok4.png" if exists
		    And I click on "button_Search.png" until "archive_Search_Status_Online_And_Archive.png" appears at_some_point
		    And I should see "archive_Search_Status_Online_And_Archive.png"
				And I get "#{jobstatus}" JobID with "#{newMediaItem}" and "#{mitype}"
		}

		#steps %Q{
	   	#	And I see the "#{jobstatus}" jobstatus
	    #}
	when "partialrestore_A"
	#Partial Restore A-----------------------------------------------------------------------------------------
	#Scenario: Select Restore from Shelf checkbox
		#And I readMIinstance with "#{jobstatus}" and "#{mitype}"
		steps %Q{
		    And I search for "#{newMediaItem}" in "All Material"
		    And I click on "button_Search.png" until "archive_Search_Status_Offline.png" appears at_some_point
				And I wait "10" seconds
			  And I doubleclick on "archive_Search_Status_Offline.png"
				And I check screenexists
		    And I click on "qvl_Button_Clear.png"
		    And I click on either "qvl_Button_Left_Arrow.png" or "qvl_Button_Left_Arrow_Old.png"
		    And I type "i"
		    And I wait "2" seconds
		    And I click on either "qvl_Button_Right_Arrow.png" or "qvl_Button_Right_Arrow_Old.png"
		    And I wait "2" seconds
		    And I type "o"
		    And I wait "6" seconds
		    And I click on "qvl_Button_New.png"
		    And I click on "partial_restore.png"
		    And I click on "button_restore.png"
		    And I wait for "qvl_Radio_Button_Status_Finished.png" to appear
		    And I type "News"
		    And I click on "qvl_Radio_Button_Status_Finished.png"
		    And I click on "qvl_Radio_Button_Category_Sequence.png"
		    And I click on "qvl_Textbox_Story.png"
		    And I type "zzperform"
		    And I click on "qvl_Textbox_Details.png"
		    And I type "#{cliphdsd}"
		    And I use TAB
		    And I type the current time
		    And I click on "Button_Publish.png"
		    And I wait for "button_remove.png" to disappear
		    And I click on "partial_restore_OK_button.png"
		    And I handle any publish name errors
		    And I search for "#{newMediaItem}" in "All Material"
		    And I click on "button_Search.png" until "archive_Search_Status_Offline.png" appears at_some_point
		    And I rightclick on "archive_Search_Status_Offline.png" and click "rightclick_copy.png"
		    And I click on "shortcut.png"
		    And I wait "3" seconds
		    And I get the cliplist itemid
		    And I get the cliplist item datetime
				And I get "#{jobstatus}" JobID with "#{newMediaItem}" and "#{mitype}"
        Then I want to deleteMI "delOfflineMI"

    }
    when "partialrestore_B"
    #Partial Restore B-----------------------------------------------------------------------------------------
		steps %Q{
			  And I search for "#{partMediaItem}" in "All Material"
			  And I click on "button_Search.png" until "archive_Search_Status_Online_Shelf.png" appears at_some_point
			  And I rightclick on "archive_Search_Status_Online_Shelf.png" and click "rightclick_copy.png"
			  And I click on "shortcut.png"
		 	  And I wait "3" seconds
		    And I get the cliplist itemid
		    And I get the cliplist item datetime
        And I get "#{jobstatus}" JobID with "#{partMediaItem}" and "#{mitype}"
        And I want to deleteMI "delOnlineShelfMI"
		}

	else
		fail "There was a problem in I get the '{jobstatus}' jobstatus!"
	end
end

And /^I see the "(.*?)" jobstatus$/ do |status|
		#getJobID()
		case status
		when "save"
			finished           = "false"
			until finished     == "true" do
				data           = $pt2_data
				value          = JSON.parse(data)
				finished       = value['finished']
			end
			puts finished
			#This is the performance test data I want to extract***********************************************
			data               = $pt2_data
			#puts data
			value              = JSON.parse(data)
			jobStatrTime2      = value['jobSubmittedTime']
			jobEndTime2        = value['jobCompletedTime']
			username           = value['username']
			template           = value['job']['template']
			displayname        = value['job']['displayName']
			jobSubTasks        = value['job']['subtasks'][0]
			clipname           = value['job']['metadata']['clipname']
			duration           = value['job']['metadata']['duration']
			mediaitemid        = value['job']['metadata']['mediaitemid']
			jobPriority        = value['jobPriority']
			jobHistory         = value['jobEventHistory'][0]
			failed             = value['failed']
			cancelled          = value['cancelled']
			finished           = value['finished']
			values = ["jobStatrTime2:#{jobStatrTime2}","jobEndTime2:#{jobEndTime2}","username:#{username}","template:#{template}","displayname:#{displayname}","jobSubTasks:#{jobSubTasks}","clipname:#{clipname}","duration:#{duration}","mediaitemid:#{mediaitemid}","jobPriority:#{jobPriority}","jobHistory:#{jobHistory}","failed:#{failed}","cancelled:#{cancelled}","finished:#{finished}"]
			#This is the performance test data I want to extract***********************************************
			files = "//zgbwcfs3005.jupiter.bbc.co.uk/QA/Jenkins/Jupiter/performance_test_job.txt"
			f = File.open(files,'a')
			f.write(values)
			f.close

		when "restore"
			finished           = "false"
			until finished     == "true" do
				data           = $pt2_data
				value          = JSON.parse(data)
				finished       = value['finished']
			end
			puts finished
			#This is the performance test data I want to extract***********************************************
			data               = $pt2_data
			#puts data
			value              = JSON.parse(data)
			jobStatrTime2      = value['jobSubmittedTime']
			jobEndTime2        = value['jobCompletedTime']
			username           = value['username']
			template           = value['job']['template']
			displayname        = value['job']['displayName']
			jobSubTasks        = value['job']['subtasks'][0]
			clipname           = value['job']['metadata']['clipname']
			inpoint            = value['job']['metadata']['inpoint']
			status             = value['job']['metadata']['status']
			outpoint           = value['job']['metadata']['outpoint']
			mediaitemid        = value['job']['metadata']['mediaitemid']
			jobPriority        = value['jobPriority']
			jobHistory         = value['jobEventHistory'][0]
			failed             = value['failed']
			cancelled          = value['cancelled']
			finished           = value['finished']
			values = ["jobStatrTime2:#{jobStatrTime2}","jobEndTime2:#{jobEndTime2}","username:#{username}","template:#{template}","displayname:#{displayname}","jobSubTasks:#{jobSubTasks}","clipname:#{clipname}","inpoint:#{inpoint}","status:#{status}","outpoint:#{outpoint}","mediaitemid:#{mediaitemid}","jobPriority:#{jobPriority}","jobHistory:#{jobHistory}","failed:#{failed}","cancelled:#{cancelled}","finished:#{finished}"]
			#This is the performance test data I want to extract***********************************************
			files = "//zgbwcfs3005.jupiter.bbc.co.uk/QA/Jenkins/Jupiter/performance_test_job.txt"
			f = File.open(files,'a')
			f.write(values)
			f.close

		when "partialrestore_A"
			finished           = "false"
			until finished     == "true" do
				data           = $pt2_data
				value          = JSON.parse(data)
				finished       = value['finished']
			end
			puts finished
			#This is the performance test data I want to extract***********************************************
			data               = $pt2_data
			#puts data
			value              = JSON.parse(data)
			jobStatrTime2      = value['jobSubmittedTime']
			jobEndTime2        = value['jobCompletedTime']
			username           = value['username']
			template           = value['job']['template']
			displayname        = value['job']['displayName']
			jobSubTasks        = value['job']['subtasks'][0]
			clipname           = value['job']['metadata']['clipname']
			inpoint            = value['job']['metadata']['inpoint']
			status             = value['job']['metadata']['status']
			duration           = value['job']['metadata']['duration']
			outpoint           = value['job']['metadata']['outpoint']
			mediaitemid        = value['job']['metadata']['mediaitemid']
			jobPriority        = value['jobPriority']
			jobHistory         = value['jobEventHistory'][0]
			failed             = value['failed']
			cancelled          = value['cancelled']
			finished           = value['finished']
			values = ["jobStatrTime2:#{jobStatrTime2}","jobEndTime2:#{jobEndTime2}","username:#{username}","template:#{template}","displayname:#{displayname}","jobSubTasks:#{jobSubTasks}","clipname:#{clipname}","inpoint:#{inpoint}","status:#{status}","duration:#{duration}","outpoint:#{outpoint}","mediaitemid:#{mediaitemid}","savemd5hashsuccess:#{savemd5hashsuccess}","jobPriority:#{jobPriority}","jobHistory:#{jobHistory}","failed:#{failed}","cancelled:#{cancelled}","finished:#{finished}"]
			#This is the performance test data I want to extract***********************************************
			files = "//zgbwcfs3005.jupiter.bbc.co.uk/QA/Jenkins/Jupiter/performance_test_job.txt"
			f = File.open(files,'a')
			f.write(values)
			f.close
		else
			fail "No job status found!"
		end
end

Given /^I want to deleteMI "(.*?)"$/ do |deleteMI|
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "deleteMI started")

	case deleteMI
	when "delOnlineShelfMI"
		#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "delOnlineShelfMI started")
		url = "#{$config[$site]['delOnlineShelfMIurl']}#{$mediaitemid}&includeonline=true&includeshelf=true"
		numberOfTries = 0
		begin
			xml_data = open(url).read
			if(xml_data.include? "op")
				result = xml_data.split("<op>")[1].split("</op>")[0]
				if result == "failed"
					reason = xml_data.split("<reason>")[1].split("</reason>")[0]
					fail "delOnlineShelfMI failed to delete MI"
				end
			else
				fail "cannot find op tag!"
			end
		rescue
			numberOfTries = numberOfTries + 1
			retry
		end
		puts "numberOfTries: #{numberOfTries}"
    puts $mediaitemid
		#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "delOnlineShelfMI end")

	when "delOfflineMI"
		#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "delOfflineMI started")
		url = "#{$config[$site]['delOfflineMIurl']}#{$mediaitemid}&userid=bbcnewstest"
		numberOfTries = 0
		begin
		xml_data = open(url).read
			if(xml_data.include? "results")
				result = xml_data.split("results=")[1].split("status=")[0].strip
				status = xml_data.split("status=")[1].split("/>")[0].strip
			else
				fail "cannot find results!"
			end
		rescue
			numberOfTries = numberOfTries + 1
			retry
		end
		puts "numberOfTries: #{numberOfTries}"
		puts $mediaitemid
		#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "delOfflineMI end")

	when "delCacheShelfMI"
		#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "delCacheShelfMI started")
		url = $config[$site]["delCacheShelfMIurl"]+"#{$mediaitemid}"
		numberOfTries = 0
		begin
    xml_data = open(url).read
			if(xml_data.include? "results")
				result = xml_data.split("results=")[1].split("status=")[0].strip
				status = xml_data.split("status=")[1].split("/>=")[0].strip
			else
				fail "cannot find results!"
      end
		rescue
			numberOfTries = numberOfTries + 1
			retry
		end
		puts "numberOfTries: #{numberOfTries}"
		puts $mediaitemid

	else
		fail "There was a problem in I want to deleteMI!"
  end
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "deleteMI end")
end

Given /^I get "(.*?)" JobID with "(.*?)" and (.*?)"$/ do |jobstatus, newMediaItem, mitype|
	puts "#{jobstatus} job started for #{newMediaItem}"
  puts "*********************************************"
	$mediaitemid = $read_fileid
#=begin
  #step 'I want to check the mpp queue'
#	if (jobstatus == "restore")
#			step 'I readMIinstance with "#{jobstatus}" and "#{mitype}"'
#  end
	if (jobstatus != "partialrestore_B")
    getJobID()
  end
#=end
	puts "#{jobstatus} job complete for #{newMediaItem}"
	puts "*********************************************"
end

Given /^I want to delete all non reserved "(.*?)" MI's$/ do |r|
  zzperform_delete_MI(r)
end

Given /^I want to check the mpp queue$/ do
	mpp_check()
end

Given /^I readMIinstance with "(.*?)" and "(.*?)"$/ do |jobstatus, mitype|
	readMIinstance(jobstatus, mitype)
end

Given /^I check screenexists$/ do
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "check screenexist started")
	if @screen.exists "load_clip_failed_Yes_button.png"
		step 'I click on "load_clip_failed_Yes_button.png"'
		step 'I click on "white_space.png"'
		step 'I wait "10" seconds'
		step 'I doubleclick on "archive_Search_Status_Offline.png'
	end
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "check screenexist end")
end

Given /^I create a new media item for "(.*?)" with "(.*?)", "(.*?)" and "(.*?)"$/ do |run_number,story,details,statusname|
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "create new media started")
	n = run_number.to_i
  createANewJLIBMediaItem(n)
	$mediaitemid = $jlib_mediaitemid
	changeMediaItemName($mediaitemid,story,details,statusname)
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "create new media end")
end

And /^I want to save mi to offline diva$/ do
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "save mi to offline started")
	$post_mediaitemid = $jlib_mediaitemid
	$post_clipname    = $changedclipname
	$post_duration    = $jlib_duration
	post_redirector   = $config[$site]["post_redirector"]
	post_mediaitemid  = $post_mediaitemid
	post_sitelocation = $config[$site]["post_sitelocation"]
	post_siteid       = $config[$site]["post_siteid"]
	post_clipname     = $post_clipname
	post_duration     = $post_duration
  save_url = $config[$site]["save_url"]
=begin
#Need for debugging
  puts "save_url          :  #{save_url}"
	puts "post_redirector   :  #{post_redirector}"
	puts "post_mediaitemid  :  #{post_mediaitemid}"
	puts "post_sitelocation :  #{post_sitelocation}"
	puts "post_siteid       :  #{post_siteid}"
	puts "post_clipname     :  #{post_clipname}"
	puts "post_duration     :  #{post_duration}"
=end
	numberOfTries = 0
	begin
		#save_url = "http://qa64w1.davina.jupiter.bbc.co.uk/jex/olu/"
		puts "Saving to "+save_url
		payload = {
				"redirector"   => "#{post_redirector}",
				"mediaitemid"  => "#{post_mediaitemid}",
				"location"     => "#{post_sitelocation}",
				"siteid"       => "#{post_siteid}",
				"clipname"     => "#{post_clipname}",
				"duration"     => post_duration,
				"formigration" => "false"
		}.to_json

		#puts payload
		uri = URI.parse(save_url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json'})
		request.body = payload
		resp = http.request(request)

		#puts "This is the response to our request"
		#puts resp.body
		#puts "Our save has finished (apparently)"

  rescue
		numberOfTries = numberOfTries + 1
		if(numberOfTries < 4)
			sleep 3
			retry
		else
			raise "Unable to rename the media item"
		end

  end
  #I may have to change $read_fileid in the getJobID and getJobData methods
	$read_fileid = post_mediaitemid
  puts 'Now calling getJobID'
	getJobID()
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "save mi to offline end")
end

And /^I want to restore mi from offline$/ do
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "restore mi from offline started")
	numberOfTries = 0
	begin
		#restore_url = "http://qa64w1app01.jupiter.bbc.co.uk:8082/site2site/submitRestoreRequestToOriginalItem.jsp?username=bbcnewstest&itemid=3166"
		restore_url = "#{$config[$site]['restore_url']}#{$post_mediaitemid}"
		xml_data = open(restore_url).read
		if(xml_data.include? 'results')
			result = xml_data.split('<RC call="submitRestoreRequestToOriginalItem.jsp" ')[1].split('/>')[0]
			result_mi = xml_data.split('<restoresubmission itemid="')[1].split('" requestid="')[0]
			puts result
			puts result_mi
		end
  rescue
		numberOfTries = numberOfTries + 1
		if(numberOfTries < 4)
			sleep 3
			retry
		else
			raise "Unable to restore the media item"
		end
  end
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "restore mi from offline end")
end

And /^I want to partial restore mi from offline$/ do
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "partial restore mi from offline started")
	numberOfTries = 0
	begin
		inpoint = "&inpoint=0"
    puts inpoint
		jlib_duration = $jlib_duration.to_i-1
    puts jlib_duration
		outpoint = "&outpoint=#{jlib_duration}"
		placeholderitemid = "&placeholderitemid=#{$place_mediaitemid}"
    part_restore_url = "#{$config[$site]['part_restore_url']}#{$post_mediaitemid}#{inpoint}#{outpoint}#{placeholderitemid}"
	  puts part_restore_url
    puts $post_mediaitemid
    puts $place_mediaitemid
		xml_data = open(part_restore_url).read
		if(xml_data.include? "results")
			result = xml_data.split('<RC call="submitRestorePartialOrPlaceholder.jsp" ')[1].split('/>')[0]
			puts result
			result_mi = xml_data.split('<restoresubmission itemid="')[1].split('" requestid=')[0]
			puts result_mi
		end
	rescue
		numberOfTries = numberOfTries + 1
		if(numberOfTries < 4)
			sleep 3
			retry
		else
			raise "Unable to partial restore the media item"
		end
	end
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "partial restore mi from offline end")
end

Given /^I test logger$/ do
  stepStartTime=Time.now
#	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "test started")
#  #Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "test end")
#  #Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "Another test started")
#	sleep for 3 seconds
	sleep(3)
	stepEndTime=Time.now
	el=stepEndTime-stepStartTime
	#Jlogs.jlogs(File.basename(__FILE__), __LINE__.to_s, "StepName: 'jlib_save', Elapsed:#{el}")
end


=begin
Given /^I want to get and format the jlib result for "(.*?)"$/ do |diva|
	numberOfTries       = 0
	path                = "D:\\"
	cleaned_data_header = []
	cleaned_data_value  = []
	newdata             = []
	xls_newdata         = []
	begin
		json_data   = []
		testdate    = Time.now.strftime("%Y-%m-%d")
    timenow     = Time.now.strftime("_%H_%M_%S")
		puts testdate
		puts timenow
		url = "#{$config[$site]['board']}#{testdate}/#{testdate}.json"
		#puts url
    #puts "*********************************************************"
		data = open(url).read
		json_data = JSON.parse(data)
		#File.open(path+"\\JlibPerform.json","w") do |json|
		#	json.write(json_data.to_json)
		#end
		cleaned_data_header = json_data[0].keys
		json_data.each do |each_hash|
			if (each_hash["username"] == "bbcnewstest") && (each_hash["clipName"].include? "zzperform")
				cleaned_data_value.push(each_hash.values)
			end
    end
  	#puts cleaned_data_header
		(0..cleaned_data_value.length-1).each do |j|
			newdata[j] = cleaned_data_header.zip(cleaned_data_value[j])
			xls_newdata << Hash[newdata[j]]
		end
		#puts diva
		case diva
			when 'Perivale'
				ndiva = 'Perivale_Report_Raw_Data'
			when 'NonProd_NPBH'
				ndiva = 'NonProd_NPBH_Report_Raw_Data'
			when 'NonProd_NPPQ'
				ndiva = 'NonProd_NPPQ_Report_Raw_Data'
			when 'ProdPDBH'
				ndiva = 'ProdPDBH_Report_Raw_Data'
			when 'ProdPDPQ'
				ndiva = 'ProdPDPQ_Report_Raw_Data'
			else
		end
		puts "Writing to #{ndiva}"
		Spreadsheet.client_encoding = 'UTF-8'
#		master_template_xls = "#{path}Performance_Report_Master_Template.xlsx"
#		workbook = Spreadsheet.open master_template_xls
#   workbook = Spreadsheet.open 'D:\\Performance_Report_Master_Template.xls'
		sheet = workbook.worksheet ndiva
#		sheet.each do |col|
#			col[0] = cleaned_data_value[0][0]
#			#cleaned_data_value
#		end
		sheet.row[0] = xls_newdata
 		#sheet.row(1). = cleaned_data_header
  	#sheet.row(2).push = cleaned_data_value
		#write array to new xls file using template format
		workbook.write "#{path}Performance_Report_Master_#{testdate}#{timenow}.xls"

		#write array to new csv file
		column_names = cleaned_data_header
		csvfile = CSV.generate do |csv|
			csv << column_names
			cleaned_data_value.each do |elem|
				csv << elem
			end
		end
		File.write("#{path}Performance_Report_Master_#{testdate}#{timenow}.csv", csvfile)
#=begin
	rescue
		puts "Connection error."
		numberOfTries = numberOfTries + 1
		if(numberOfTries < 4)
			sleep 3
			retry
		else
			raise "Unable to rename the media item"
		end
	end
#=end
end

#This code will bring back a result of what qaw1 is set to Jlib wise.
#http://qa64w1.davina.jupiter.bbc.co.uk/jex/olu/sitemode.php?asjson
#http://west1.davina.bbc.co.uk/jex/getscope.php?asjson
#http://qa64w1.davina.jupiter.bbc.co.uk/jex/getscope.php?asjson
=end