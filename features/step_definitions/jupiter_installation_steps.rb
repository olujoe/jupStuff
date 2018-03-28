#jupiter_installation

Given /^I go to windows control panel$/ do
	step 'I click on "windows_TaskBar_Start.png"'
	step 'I click on "control_panel.png"'	
end	

When /^I uninstall an existing jupiter installation$/ do
	step 'I click on "uninstall_a_program.png"'
	if (@image.exists "bbc_jupiter_install.png")		
		step 'I click on "uninstall_a_program.png"'
		step 'I click "uninstall.png"'	
		step 'I wait "3" seconds'
#		if () #If the User account controll challenges for authentication
#			Step %Q{
#
#		}	
#		end
	end		
end

Then /^I can install the required jupiter installation$/ do

#	Step Dir.entries '\\\\zgbwcfs3005.jupiter.bbc.co.uk\Build$\Release_3_10'#'go to the path where the code is located'
#	require 'fileutils'
#	def copy_with_path(src, dst)
#	  FileUtils.mkdir_p(File.dirname(dst))
#	  FileUtils.cp(src, dst)
#	end

#	Step #'install the application' End
end