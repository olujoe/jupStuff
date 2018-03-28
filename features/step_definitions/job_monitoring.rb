##################################################
# Video pipeline job monitoring file for Jupiter
# Written by Olugbenga Ogunbusola
# March 2015
##################################################

ENV['HTTP_PROXY'] = ENV['http_proxy'] = nil


Given /^I want to check the job status$/ do
	#url = 'http://zgbwccouchdb7001.jupiter.bbc.co.uk:5984/joe-qa64w1/_design/oluTest/_view/oluTestView?key=%22254412%22'
	url = "http://zgbwccouchdb7001.jupiter.bbc.co.uk:5984/joe-qa64w1/_design/oluTest/_view/oluTestView?key=%22#{$read_fileid}%22"
	resp = Net::HTTP.get_response(URI.parse(url)) 
	data = resp.body
	begin
	   data = Net::HTTP.get_response(URI.parse(url)).body
	rescue
	   print "Connection error."
	end
	$first_data = data
end

When /^I get the job status$/ do
	data = $first_data
	datetime1 = $datetime
	actualdt  = $actualdatetime
	#puts 'Media Item creation time is ' + datetime1
	#puts 'Media Item archive time is ' + actualdt
	#puts '********Data from CouchDB**************'
	#puts data
	#puts '********Data extracted from CouchDB****'
	value = JSON.parse(data) 
	mediaitemid = value['rows'][0]['key']
	username = value['rows'][0]['value'][0]
	datetime2 = value['rows'][0]['value'][1]
	#puts mediaitemid +' : '+ username +' : '+ datetime2
	x = datetime2.split(":")[0]
	y = datetime2.split(":")[1]
	$ndatetime2 = x+":"+y 
	#puts 'Media Item archive time trimmed is ' + $ndatetime2
	if $ndatetime2 = actualdt
		job_id = value['rows'][0]['id']
		#puts job_id
		url = "http://joe.qaw1.jupiter.bbc.co.uk/job/#{job_id}"
		#puts url
		resp = Net::HTTP.get_response(URI.parse(url)) 
		data = resp.body
		begin
		   data = Net::HTTP.get_response(URI.parse(url)).body
		rescue
		   print "Connection error."
		end		
		$second_data = data
		puts 'Job ' +"#{job_id}"+ ' FOUND!'
	else
		puts 'NO job FOUND!'		
	end
	$job = "#{job_id}"
end

And /^I see the status of the job:$/ do |table|
	table.hashes.each do |row|

		data = $second_data
		job = $job
		value = JSON.parse(data)
		class Object
			def to_sb
			    return 'false' unless self
			    return 'true' if self.class == TrueClass
			    self
			end
		end
		status_fail = value['failed'].to_sb
		status_can  = value['cancelled'].to_sb
		status_fin  = value['finished'].to_sb

		if row['failed'] == status_fail && row['cancelled'] == status_can && row['finished']  == status_fin
			$job_status = 'The job '+job+" result is "+ row['result']
		end

	end	
 
end

Then /^I can display the job status$/ do
	puts $job_status
=begin
	data = $second_data
	job = $job
	value = JSON.parse(data)
	puts '************Job Status*************' 
		if value['failed'] 	
			puts "status_failed : true, the job "+job+" has FAILED"
		else
			puts "status_failed : false, the job "+job+" did NOT FAIL"
		end
		if value['cancelled'] 
			puts "status_cancelled : true, the job "+job+" is CANCELLED"
		else
			puts "status_cancelled : false, the job "+job+" was NOT CANCELLED"
		end
		if value['finished'] 
			puts "status_finished : true, the job "+job+" is FINISHED"
		else
			puts "status_finished : false, the job "+job+" is IN PROGRESS"
		end	
	puts '***********************************' 
=end
end

And /^I get the cliplist item datetime$/ do
	shortcut = Clipboard.paste.encode('utf-8')
	id = shortcut.split("]:")[1].split(">>")[0]
	month = shortcut.split("]:")[0].split("/")[6]
	day = shortcut.split("]:")[0].split("/")[5]
	year = Time.now.strftime("%Y")
	time = shortcut.split("]:")[0].split("/")[4]
	hr = time.slice(0,2)
	min = time.slice(2,4)
	day = "0#{day}" if day.length == 1
	month = "0#{month}" if month.length == 1
	dt = year+"-"+month+"-"+day+"T"+hr+":"+min	
	puts dt
	$datetime = dt
end

And /^I get the actual datetime$/ do
	actualdt = Time.now.strftime("%Y-%m-%dT%H:%M")
	#puts 'Current date and time is ' + actualdt
	$actualdatetime = actualdt
end