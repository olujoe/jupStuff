Given(/^I test how many "(.*?)" there are in region "(.*?)"$/) do |bitmap, imageregion|

	step 'I click on "white_space.png"'
	region = @screen.exists("#{imageregion}").below()

	image = bitmap.split(",")
	number = image.length
	counts = 0
	number = 0

	image.each do |img|
		begin
			#number = number + region.findAll("#{image[counts]}").count
			original_score = 0
			region.findAll("#{image[counts]}").each do |potential_image|
				#puts potential_image.getScore()
				if (potential_image.getScore() >= original_score) || ((original_score - potential_image.getScore()) < 0.11)
					
					if (potential_image.getScore() >= original_score)
						original_score = potential_image.getScore()
					end
					number = number + 1
				end
			end

		rescue
		end
		counts = counts + 1
	end
	
	puts "Number found: '#{number}'"
	begin
		if $countresult
			$countresult2 = number
		else
			$countresult = number
		end
	rescue
		$countresult = number
	end
	#if(defined?(@@countresult)).nil?
	#	$Zcountresult = number
	#else
	#	@@countresult2 = number
	#end
end

Given(/^I select the middle of the screen$/) do 

	binding.pry
	region = Region(100,100,100,100)
	region.highlight(8)
end




Given(/^I run the shoes test$/) do 
=begin
	Dir.glob("../features/**/*.feature").each do |filename|
		if File.file? filename
			if filename =~ /Not_Run/
				
			else
				para filename.split("/").last + "\n"
				para filename + "\n" + "\n"

			end
		end
	end
=end
puts "starting"

	ignore_folders= ["config","Not_Run","support","step_definitions","shoes"]
	#Dir.glob("/features/*").each do |topfolder|
	Dir.glob("features/*").each do |topfolder|

		

		#folder = topfolder.split("/features/").last
		folder = topfolder.split("features/").last

		if( !ignore_folders.include? folder)

			puts "-------------------------------------------------------------------"
			#new_folder = folder.gsub("-"," ").gsub("_"," ").titleize
			new_folder = folder.split(/ |\_|\-/).map(&:capitalize).join(" ")
			puts new_folder
			puts "-------------------------------------------------------------------"

			# get the feature files inside the folder
			Dir.glob( topfolder + "/**/*.feature").each do |files|

				original_filename = files
				puts original_filename.split("/").last 
				puts original_filename

			end

		end

	end
end

Given(/^I do nothing$/) do 
	puts "Done"
	#binding.pry
	#id= "done\n"
	#files = "//zgbwcfs3005.jupiter.bbc.co.uk/QA/Jenkins/Jupiter/mike.txt"

	#file = File.new(files, "r")
	#text = file.gets
	#id = text + id
	#f = File.open(files,'a')
	#f.write(id)
	#f.close
end

Given(/^I do nothing fail$/) do 
	puts "Done fail"
	fail("failing test")
end

