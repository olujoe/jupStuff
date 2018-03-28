
Then /^I click the (.*?) button$/ do |text|
	case text.downcase
		when "standby"
			steps %Q{
				And I click on "tools_new_recording_item_standby.png"
			}
		when "sidebar green arrow"
			steps %Q{
				And I click on "tools_new_recording_item_standby_record-playout_greenarrow.png"
			}
		when "qvl close"
			steps %Q{
				And I click on "qvl_close.png"
			}
		when "rcm close"
			steps %Q{
				And I click on "RCM_close.png"
			}
		when "close recording"
			steps %Q{
				And I click on "tools_new_recording_item_standby_record-playout_end.png"
			}
		when "rcm complete"
			steps %Q{
				And I click on "RCM_complete.png"
			}
		when "record"
			steps %Q{
				And I click on "recording_Record_Button.png"
			}
		when "qvl record"
			steps %Q{
				And I click on "qvl_record.png"
			}
		else
			fail "The code for clicking '#{text}' button hasnt been written" 

	end
end