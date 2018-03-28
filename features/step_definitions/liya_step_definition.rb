
Given(/^I click on the taskbar start button$/) do
	
end

Given(/^I type chrome in the search field$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I click on the google chrome icon$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see google chrome open$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^first test$/) do

driver = Selenium::WebDriver.for :ie
driver.navigate.to "http://google.com"
element = driver.find_element(:name, 'q')
element.send_keys "Selenium Tutorials"
element.submit

driver.quit
end


Given(/^Jupiter is in QAW1$/) do

	steps %Q{
		And I should see "QAW1.png"
	}	
end

Given(/^Jupiter is in west1/) do
	steps %Q{
		And I click on Tools.png
		Then I should see sites.png
		When I click on West1.png
		And I wait for "menu_New.png" to appear
		#Then I should see the Jupiter is in West1
		And I should see "west1_BBC.png"
	}	
end

Given(/^jupiter is in West (\d+)$/) do 
	steps 
	arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see the "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end



Given(/^I add the required sites$/) do

	if !@screen.exists "salford_checkbox.png"
		steps %Q{  
			And I click on "button_Add.png"
			And I click on "expand_live.png"
			And I click on "Salford.png"
			And I click on "MI_Description_Component_OKButton.PNG"
			Then I should see "salford_checkbox.png"
		}
	end
end

Given(/^I should check the notification$/) do
 	
 	top = @screen.exists("search_result_region.png")
 	#binding.pry
	reg = top.below(600).right(400)
	#reg.highlight(1)
	if reg.exists "Transfer_failed.png", 20
 		#fail("Transfer failed")
 		puts "passed"
 	end
 end

Given(/^I add the add the west site$/) do

	if !@screen.exists "west1_checkbox.png"
		steps %Q{  
			And I click on "button_Add.png"
			And I click on "expand_live.png"
			And I click on "west1_tranfer.png"
			And I click on "MI_Description_Component_OKButton.PNG"
			Then I should see "west1_checkbox.png"
		}
	end
end

Given /^I create a liya rights component, from "(.*?)" %, to "(.*?)" %, copyrightholder "(.*?)", trafficlight "(.*?)"$/ do |from,to,copyright,trafficlight|
	case trafficlight.downcase
		when "red"
			traffic = 4
		when "amber"
			traffic = 3
		when "green"
			traffic = 2
	end

	#getItemID()
	input = (from.to_f/100) * (32*27)
	output = (to.to_f/100) * (32*27)
	puts input
	puts output

	link = "#{$config[$site]['create_rights_component']}&itemid=#{$readfileid}&trafficLight=#{traffic}&startOffset=#{input.to_i}&endOffset=#{output.to_i}&copyrightholder=#{copyright}"
	puts link
	xml_data = open(link).read

end

When(/^I create a  crash recording(\d+)$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I load the asset rights\/green rec(\d+) in the QVL$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see the following rights$/) do |table|
  # table is a Cucumber::Core::Ast::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end




