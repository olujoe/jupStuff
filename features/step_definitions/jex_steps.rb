
Then(/^I drop a file into the jex folder$/) do 
	
	filename = "CanonSX210_640.MOV"
	source = "videos/#{filename}"
	destination = $config[$site]["jex_inbox"]
	FileUtils.cp(source,destination)

end


