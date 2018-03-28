
Then(/^the favourites panel is visible$/) do
	steps %Q{
		And I should see "favourites.png"
	}
end

Then(/^I open the task panel$/) do
	steps %Q{
		And I click on "tasks_button.png" until "task_dropdown.png" appears
	}
end