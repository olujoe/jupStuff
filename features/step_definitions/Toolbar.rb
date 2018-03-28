#Video options - Check Load video option is True or False
#Given /^I want to make sure the load video option is notfalse$/ do
Given /^I want VLT set to automatic$/ do
	if @screen.exists "tools_vlt_automatic.png", 9	
		$vlt = "automatic"
		step 'I click on "tools_options_cancel-button.png"'
	elsif @screen.exists "tools_vlt_manual.png", 9
		$vlt = "manual"
		step 'I click on "tools_vlt_manual.png"'	
		step 'I click on "tools_drop-down-arrow.png"'
		step 'I should see "tools_vlt_manual_blue.png"'
		step 'I use the UP_ARROW "1" times'	
		step 'I use RETURN'
		step 'I click on "tools_options_save-button.png"'
		$vlt = "automatic"
	elsif @screen.exists "tools_vlt_advanced.png", 9
		$vlt = "advanced"
		step 'I click on "tools_vlt_advanced.png"'	
		step 'I click on "tools_drop-down-arrow.png"'
		step 'I should see "tools_vlt_advanced_blue.png"'
		step 'I use the UP_ARROW "2" times'	
		step 'I use RETURN'
		step 'I click on "tools_options_save-button.png"'
		$vlt = "automatic"				
	end	
end
Given /^I want VLT set to manual-best$/ do
	if @screen.exists "tools_vlt_manual.png"
		if @screen.exists "tools_vlt_best.png"
			step 'I should see "tools_vlt_best.png"'
			$mqr = "best"
			step 'I click on "tools_options_cancel-button.png"'
		elsif @screen.exists "tools_vlt_medium.png"
			step 'I should see "tools_vlt_manual_medium.png"'
			$mqr = "medium"
			step 'I click on "tools_vlt_medium.png"'	
			step 'I click on "tools_drop-down-arrow.png"'
			step 'I should see "tools_vlt_manual_medium_blue.png"'
			step 'I use the UP_ARROW "1" times'	
			step 'I use RETURN'
			step 'I click on "tools_options_save-button.png"'
			$mqr = "best"
		elsif @screen.exists "tools_vlt_low.png"
			step 'I click on "tools_vlt_manual_low.png"'	
			$mqr = "low"				
			step 'I click on "tools_vlt_low.png"'	
			step 'I click on "tools_drop-down-arrow.png"'
			step 'I should see "tools_vlt_manual_low_blue.png"'
			step 'I use the UP_ARROW "2" times'	
			step 'I use RETURN'
			step 'I click on "tools_options_save-button.png"'
			$mqr = "best"
		end	
	end	
end

Given /^I want VLT set to advanced-bmq$/ do
	if @screen.exists "tools_vlt_advanced.png"
		puts "in 1"
		if @screen.exists "tools_vlt_bqm.png"
			puts "in 2"
			@region = @screen.exists "tools_vlt_bqm.png"
			@region.highlight(5)
			step 'I click on "tools_options_cancel-button.png"'
		elsif @screen.exists "tools_vlt_wqm-H.png"
			step 'I click on "tools_vlt_wqm-H.png"'	
			step 'I click on "tools_drop-down-arrow.png"'
			step 'I use the UP_ARROW "1" times'	
			step 'I use RETURN'
			step 'I click on "tools_options_save-button.png"'
		elsif @screen.exists "tools_vlt_wqm-L.png"
			step 'I click on "tools_vlt_wqm-L.png"'	
			step 'I click on "tools_drop-down-arrow.png"'
			step 'I use the UP_ARROW "2" times'	
			step 'I use RETURN'
			step 'I click on "tools_options_save-button.png"'
		elsif @screen.exists "tools_vlt_fqm.png"
			step 'I click on "tools_vlt_fqm.png"'	
			step 'I click on "tools_drop-down-arrow.png"'
			step 'I use the UP_ARROW "3" times'	
			step 'I use RETURN'
			step 'I click on "tools_options_save-button.png"'
		elsif @screen.exists "tools_vlt_jfe.png"
			step 'I click on "tools_vlt_jfe.png"'	
			step 'I click on "tools_drop-down-arrow.png"'
			step 'I use the UP_ARROW "4" times'	
			step 'I use RETURN'
			step 'I click on "tools_options_save-button.png"'
		elsif @screen.exists "tools_vlt_wav.png"
			step 'I click on "tools_vlt_wav.png"'	
			step 'I click on "tools_drop-down-arrow.png"'
			step 'I use the UP_ARROW "5" times'	
			step 'I use RETURN'
			step 'I click on "tools_options_save-button.png"'
		elsif @screen.exists "tools_vlt_imx30-mxf.png"
			step 'I click on "tools_vlt_imx30-mxf.png"'	
			step 'I click on "tools_drop-down-arrow.png"'
			step 'I use the UP_ARROW "6" times'	
			step 'I use RETURN'
			step 'I click on "tools_options_save-button.png"'
		elsif @screen.exists "tools_vlt_badger.png"
			step 'I click on "tools_vlt_badger.png"'	
			step 'I click on "tools_drop-down-arrow.png"'
			step 'I use the UP_ARROW "7" times'	
			step 'I use RETURN'
			step 'I click on "tools_options_save-button.png"'
		elsif @screen.exists "tools_vlt_dvcpro100-mxf.png"
			step 'I click on "tools_vlt_dvcpro100-mxf.png"'	
			step 'I click on "tools_drop-down-arrow.png"'
			step 'I use the UP_ARROW "8" times'	
			step 'I use RETURN'
			step 'I click on "tools_options_save-button.png"'
		elsif @screen.exists "tools_vlt_gvgbroadcast.png"
			step 'I click on "tools_vlt_gvgbroadcast.png"'	
			step 'I click on "tools_drop-down-arrow.png"'
			step 'I use the UP_ARROW "9" times'	
			step 'I use RETURN'
			step 'I click on "tools_options_save-button.png"'
		end
	end		
end

Given /^$/ do
end

Given /^I want to set video options$/ do
	step 'I click on "tools.png"'
	step 'I click on "options.png"'
	step 'I should see "tools_options.png"'
	step 'I doubleclick on "tools_options_video.png"'
end
Given /^I want to make sure the video option is notfalse$/ do #|video_option|
	step 'I want to set video options'
	if @screen.exists "tools_lv_true_pl_true.png"				#Load video, port listening 
		if @screen.exists "tools_lv_true_pl_true_result.png"		#Load video = true, port listening = true
			$lvo = "true"											#lvo = Load_video
			$pl0 = "true"											#pl0 = Port listening
			step 'I click on "tools_options_cancel-button.png"'
		elsif @screen.exists "tools_lv_true_pl_false_result.png"		#Load video = true, port listening = false
			$lvo = "true"
			$pl0 = "false"
			step 'I click on "tools_video_portlistening.png"'
			step 'I click on "tools_drop-down-arrow.png"'			
			step 'I should see "tools_options_falseY-true.png"'
			step 'I click on "tools_options_true.png"'
			step 'I click on "tools_options_save-button.png"'
			step 'I click on "tools_new_recording_item_standby_record-playout_end.png"'
			$pl0 = "true"
		end
	else @screen.exists "tools_lv_false_pl_true.png", 5				
		if @screen.exists "tools_lv_false_pl_true_result.png", 5		#Load video = false, port listening = true
			$lvo = "false"
			$pl0 = "true"
			step 'I click on "tools_video_loadvideo.png"'
			step 'I click on "tools_drop-down-arrow.png"'			
			step 'I should see "tools_options_falseY-true.png"'
			step 'I click on "tools_options_true.png"'
			step 'I click on "tools_options_save-button.png"'
			step 'I click on "tools_new_recording_item_standby_record-playout_end.png"'			
			$lvo = "true"
		elsif @screen.exists "tools_lv_false_pl_false_result.png", 5	 #Load video = false, port listening = false
			$lvo = "false"
			step 'I click on "tools_video_loadvideo.png"'
			step 'I click on "tools_drop-down-arrow.png"'			
			step 'I should see "tools_options_falseY-true.png"'
			step 'I click on "tools_options_true.png"'
			step 'I click on "tools_options_save-button.png"'
			$lvo = "true"
			$pl0 = "false"
			step 'I click on "tools_video_portlistening.png"'
			step 'I click on "tools_drop-down-arrow.png"'			
			step 'I should see "tools_options_falseY-true.png"'
			step 'I click on "tools_options_true.png"'
			step 'I click on "tools_options_save-button.png"'
			step 'I click on "tools_new_recording_item_standby_record-playout_end.png"'
			$pl0 = "true"
		end	
	end	

end

#Video options - Set Load video option to True and False
#Given /^I want to set the video option to "(.*?)"$/ do |stuff|
Given /^I want to set the "(.*?)" to "(.*?)"$/ do |lv_pl, stuff|
	step 'I wait "5" seconds'
	step 'I click on "tools.png"'
	step 'I click on "options.png"'
	step 'I should see "tools_options.png"'
	step 'I doubleclick on "tools_options_video.png"'
	if lv_pl ==  "load_video"
		if (stuff == "t2f") && (@screen.exists "tools_lv_true_pl_true_result.png", 5)
				step 'I should see "tools_lv_true_pl_true_result.png"'	#Load video = true, port listening = true
				step 'I click on "tools_video_loadvideo.png"'
				step 'I click on "tools_drop-down-arrow.png"'
				step 'I should see "tools_options_false-trueY.png"' 
				step 'I click on "tools_options_false.png"' 
		elsif (stuff == "t2f") && (@screen.exists "tools_lv_true_pl_false_result.png", 5)
				step 'I should see "tools_lv_true_pl_false_result.png"'	#Load video = true, port listening = true
				step 'I click on "tools_video_loadvideo.png"'
				step 'I click on "tools_drop-down-arrow.png"'
				step 'I should see "tools_options_false-trueY.png"' 
				step 'I click on "tools_options_false.png"' 		
		elsif (stuff == "f2t") && (@screen.exists "tools_lv_false_pl_true_result.png", 5)
				step 'I should see "tools_lv_false_pl_true_result.png"'		#Load video = false, port listening = true
				step 'I click on "tools_video_loadvideo.png"'
				step 'I click on "tools_drop-down-arrow.png"'			
				step 'I should see "tools_options_falseY-true.png"'
				step 'I click on "tools_options_true.png"'
		elsif (stuff == "f2t") && (@screen.exists "tools_lv_false_pl_false_result.png", 5)
				step 'I should see "tools_lv_false_pl_false_result.png"' 	 #Load video = false, port listening = false
				step 'I click on "tools_video_loadvideo.png"'
				step 'I click on "tools_drop-down-arrow.png"'			
				step 'I should see "tools_options_falseY-true.png"'
				step 'I click on "tools_options_true.png"'				
		end	
	elsif lv_pl == "port_listening"
		if (stuff == "t2f") && (@screen.exists "tools_lv_true_pl_true_result.png", 5)
				step 'I should see "tools_lv_true_pl_true_result.png"'	#Load video = true, port listening = true
				step 'I click on "tools_video_portlistning.png"'
				step 'I click on "tools_drop-down-arrow.png"'
				step 'I should see "tools_options_false-trueY.png"' 
				step 'I click on "tools_options_false.png"' 
		elsif (stuff == "t2f") && (@screen.exists "tools_lv_false_pl_true_result.png", 5)
				step 'I should see "tools_lv_false_pl_true_result.png"'		#Load video = false, port listening = true
				step 'I click on "tools_video_portlistning.png"'
				step 'I click on "tools_drop-down-arrow.png"'
				step 'I should see "tools_options_false-trueY.png"' 
				step 'I click on "tools_options_false.png"' 
		elsif (stuff == "f2t") && (@screen.exists "tools_lv_true_pl_false_result.png", 5)
				step 'I should see "tools_lv_true_pl_false_result.png"' 	#Load video = true, port listening = false
				step 'I click on "tools_video_portlistning.png"'
				step 'I click on "tools_drop-down-arrow.png"'			
				step 'I should see "tools_options_falseY-true.png"'
				step 'I click on "tools_options_true.png"'	
		elsif (stuff == "f2t") && (@screen.exists "tools_lv_false_pl_false_result.png", 5)
				step 'I should see "tools_lv_false_pl_false_result.png"' 	#Load video = false, port listening = false
				step 'I click on "tools_video_portlistning.png"'
				step 'I click on "tools_drop-down-arrow.png"'			
				step 'I should see "tools_options_falseY-true.png"'
				step 'I click on "tools_options_true.png"'								
		end	
	end
	step 'I click on "tools_options_save-button.png"'
end

Given /^I want "(.*?)" loaded to QVL$/ do |lv|
	if lv == "load_video"
		step 'I search for the duplicated media item and load the item to QVL'		
	elsif lv == "port_listening"
		step 'I want to start-standby-stop a recording'
	end			
end

Given /^I want to start-standby-stop a recording$/ do
		step 'I click on "tools_new_recording.png"'
		step 'I should see "tools_new_recording_item.png"'
		step 'I click on "tools_new_recording_item_standby.png"'
		step 'I should see "tools_new_recording_item_warning.png"'
		step 'I click on "tools_new_recording_item_warning_yes.png"'	
		step 'I should see "tools_new_recording_item_standby_record-playout.png"'
		step 'I click on "tools_new_recording_item_standby_record-playout_greenarrow.png"'
		#step 'I click on "tools_new_recording_item_standby_record-playout_blue_stop.png"'
		#step 'I should see "tools_new_recording_item_standby_recording_details.png"'
end