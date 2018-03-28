# encoding: UTF-8
#$KCODE = 'u'

Then(/^I create a new recording with special characters$/) do
	#char = $config['utf8_short']
	
	steps %Q{
		And  I open the new recording dialogue
		And I set all the default crash recording 1 options
		When I click on "create_Recording_Textbox_Description.png"
		And I use CTRL A
		And I use DELETE
		And I paste the medium UTF8 characters
		And I click on "button_Record.png"
		And I click on "button_Yes.png" if exists
	}
end


Then(/^I create a new recording$/) do
	steps %Q{
		And  I open the new recording dialogue
		And I set all the default crash recording 1 options
		And I click on "button_Record.png"
		And I click on "button_Yes.png" if exists
		And I wait for "20" seconds
		When I stop the recording
	}
end

Then(/^I paste the long UTF8 characters$/) do
	#char = "شبکه جوز خدماتان مي دهد که 我能吞下玻璃而不伤身体。 אני יכ מזיק לי. 'âäáàêëéèîïẅẃẁŷÿýỳ' Aš gaęs nežeidžia T’ ii"
	Clipboard.copy $config['utf8']
	sleep 1
	@screen.type("v", Sikuli::KEY_CTRL)
end

Then(/^I paste the medium UTF8 characters$/) do
	Clipboard.copy $config['utf8_medium']
	sleep 1
	@screen.type("v", Sikuli::KEY_CTRL)
end

Then(/^I paste the short UTF8 characters$/) do
	Clipboard.copy $config['utf8_short']
	sleep 1
	@screen.type("v", Sikuli::KEY_CTRL)
end


Then(/^I create a dopesheet component "(.*?)"$/) do |dope|
	steps %Q{
		Given I create a timed video segment "" at in "2" sec and out "6" sec
		And I click on "quick_component_option.png"
		And I click on "add_dopesheet.png"
		And I wait for "ScreenTitle_Component.png" to appear

	    And I type "#{dope}"
		And I click on "qvl_Button_Ok.png"
		And I wait for "tools_options_cancel-button.png" to disappear soon
		And I clear any errors encountered
		And I click on "qvl_Component_Button_Edit.png"
		And I clear any errors encountered
		And I wait for any not responding message to disappear
		And I clear any errors encountered
	    When I waitAndclick on "qvl_Rights_Component_Story_Dropdown.png"
	    And I type "auto"
		And I use TAB
	    And I type "dope"
		And I click on "MI_Description_Save.PNG"
	}
end


Then(/^I open the dopesheet dialogue$/) do 
	steps %Q{
		And I click on either "qvl_Component_dopesheet_highlighted.png" or "qvl_Component_Dopesheet.png"
	}
end


Then(/^I edit the component dopesheet details to utf8$/) do 
	steps %Q{
		And I open the dopesheet dialogue
		And I use CTRL A
		And I use DELETE
		And I paste the medium UTF8 characters
		And I click on "qvl_Component_KeepTab_OkButton.png"
	}
end


Then(/^I create a new recording with special characters in restrictions$/) do
	
	steps %Q{
		And  I open the new recording dialogue
		And I set all the default crash recording 1 options
		And I click "20" pixels to the "bottom" of "details.png"
		And I use CTRL A
		And I use DELETE
		And I type "utf8"
		When I click on "new_Recording_Usage_Restriction.png"
		And I use CTRL A
		And I use DELETE
		And I paste the medium UTF8 characters
		And I click on "button_Record.png"
		And I click on "button_Yes.png" if exists
	}
end


Then(/^I create a new recording with special characters in restrictions and description$/) do
	
	steps %Q{
		And  I open the new recording dialogue
		And I set all the default crash recording 1 options
		And I click "20" pixels to the "bottom" of "details.png"
		And I use CTRL A
		And I use DELETE
		And I type "utf8"
		When I click on "new_Recording_Usage_Restriction.png"
		And I use CTRL A
		And I use DELETE
		And I paste the medium UTF8 characters

		When I click on "create_Recording_Textbox_Description.png"
		And I use CTRL A
		And I use DELETE
		And I paste the medium UTF8 characters
		And I click on "button_Record.png"
		And I click on "button_Yes.png" if exists
	}
end


Then(/^I create an arrival booking with UTF8 characters in desc and usage$/) do
	steps %Q{
		And I open the arrival booking window
		And I fill all arrival booking fields
		And I click "30" pixels to the "bottom" of "description_box_heading.png"
		And I use CTRL A
		And I use DELETE
		And I paste the medium UTF8 characters
		And I click "40" pixels to the "bottom" of "usage_restrictions.png"
		And I use CTRL A
		And I use DELETE
		And I paste the short UTF8 characters
		And I click "20" pixels to the "bottom" of "arrival_booking_details_box_heading.png"
		And I use CTRL A
		And I use DELETE
		And I type "utf8"
		And I click on "button_Ok.png"
	}
end


Then(/^I create a departure booking with utf8 description$/) do
	steps %Q{
		And I open the departure booking dialogue
		And I fill out the departure booking form "depat_utf8"
		And I click "20" pixels to the "bottom" of "departure_booking_description.png"
		And I paste the medium UTF8 characters
		And I click on "button_Ok.png"
		And I wait for "ScreenTitle_DeparturelBooking.PNG" to disappear
	}
end


Then(/^I should see the utf8 characters in the cliplist when i scroll right$/) do
	image = "cliplist_utf8.png"
	if !@screen.exists image
		40.times do 
			@screen.type(Sikuli::RIGHT_ARROW)
		end

		if !@screen.exists image
			fail("Did not find the cliplist item '#{image}'")
		end
	end

	150.times do 
		@screen.type(Sikuli::LEFT_ARROW)
	end	
end