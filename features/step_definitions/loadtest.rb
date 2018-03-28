	Given /^I start apache-jmeter$/ do
		step 'I click on "windows_TaskBar_Start.png"'
		step 'I type "e:\apache-jmeter-2.13\bin\jmeter.bat"'
		step 'I use RETURN'
	end	

	Given /^I ensure apache jmeter is running$/ do 
			if !@screen.exists "apache-jmeter.png"  #apache-jmeter.png"
				if !@screen.exists "apache-jmeter_taskbar.png" #apache-jmeter_taskbar.png
					step 'I start apache-jmeter'
					step 'I wait for "apache-jmeter.png" to appear'
					step 'I click on "window_Maximize.png" if exists'
				end
				#step 'I click on "apache-jmeter_taskbar.png" if "apache-jmeter.png" not exists'
				#step 'I click on "window_Maximize.png" if exists'
				#step 'I should see "apache-jmeter.png"'
			end
		nooftries = 0
		begin
			if @screen.exists "button_Cancel.png"
				step 'I click on "button_Cancel.png"'
			end
			if @screen.exists "search_Close_Button.png"
				timeout = 0
				while @screen.exists "search_Close_Button.png" and timeout < 4
					step 'I click on "search_Close_Button.png"'
					sleep 1
					timeout = timeout + 1
				end
			end
			if @screen.exists "button_Exceptions_Close.png"
			  #@screen.click "button_Exceptions_Close.png"
			end
		rescue
			if(ENV['debug'])
				puts "JMeter already set"
			end
			if(nooftries < 2)
				nooftries = nooftries + 1
				retry
			end
		end
	end
	

	Then /^I select and run a load test plan thread:$/ do |table|

		ind = 1
		table.hashes.each do |line|

			load_test_tg = line['load_test_tg']
			run_time = line['run_time'].to_i * 60
			scale = line['scale']
			puts "in line #{ind}"
			steps %Q{
				And I click on "apache-jmeter_File_Open2.png"
				And I doubleclick on "apache-jmeter_File_example.png"
				And I click "100" pixels to the "right" of "apache_filename.png"
				And I use CTRL A
				And I use DELETE
				And I type "#{load_test_tg}"
				And I click on "apache-jmeter_Open-button.png"
				And I click on "apache-jmeter_expand-all-button.png"
				And I click on "apache-jmeter_clear-all-button.png"				
				And I click on "apache-jmeter_graphics.png"
				And I click on "apache_settings.png"
				And I click on "apache_settings-draw-final.png"
				And I click on "apache_force-Max.png"
				And I use TAB
				And I type "#{scale}"
				And I click on "apache_chart.png"
				And I click on "apache-jmeter_run-button.png"
				And I wait for "#{run_time}" seconds
				And I click on "apache-jmeter_stop-button.png"
				And I wait "1" seconds
			}
			if @screen.exists "apache_stopping-test2.png", 10
				step 'I wait for "apache_stopping-test2.png" to disappear eventually'
			end
			steps %Q{
				And I take a screenshot
				And I wait "1" seconds
				And I click on "apache_settings.png"
				And I click on "apache_settings-limit-number.png"	
				And I click on "apache_chart.png"
				And I wait "1" seconds
				And I take a screenshot	
				And I wait "1" seconds		
			}	
			ind = ind + 1
	  	end	
	end
	
	Then /^I should see a result$/ do 
		
	end

	Given /^I start putty$/ do
		step 'I click on "windows_TaskBar_Start.png"'
		step 'I type "e:\putty.exe"'
		step 'I use RETURN'	
	end	

	Then /^I ensure "(.*?)" is running on putty$/ do |red_rev|
			if !@screen.exists "putty.png" #apache-jmeter_taskbar.png
				step 'I start putty'
				step 'I wait for "putty.png" to appear'
				step 'I should see "putty_redirector-server.png"'
				step 'I click on "putty_redirector-server.png"'
				step 'I should see "putty_redirector-server-clicked.png"'
				step 'I click on "putty_load.png"'
				step 'I should see "putty_redirector-server-qa64w1app05.png"'
				step 'I click on "putty_open.png"'
				step 'I should see "putty_redirector-server-qa64w1app05_header.png"'
				step 'I doubleclick on "putty_redirector-server-qa64w1app05_header.png"'
				step 'I click "20" pixels to the "right" of "putty_redirector-server-qa64w1app05_login.png"'
				step 'I type "npf"'
				step 'I use RETURN'
				step 'I type "npf"'
				step 'I use RETURN'
				if red_rev == "redirector" 
					step 'I type "cd /etc/apache2/sites-available/qa/red/"'
					step 'I use RETURN'
					step 'I type "sudo cp redirector ../../"'
					step 'I use RETURN'
					step 'I type "npf"'
					step 'I use RETURN'
					step 'I type "cd ../.."'
					step 'I use RETURN'
					step 'I type "sudo apache2ctl configtest"'
					step 'I use RETURN'			
					step 'I should see "putty_syntax-ok.png"'
					if !@screen.exists "putty_syntax-ok.png"
						puts "Redirector NOT engaged"
					elsif 						
						step 'I type "sudo apache2ctl graceful"'
						step 'I use RETURN'	
						puts "Redirector Fully engaged"
					end	
					step 'I type "exit"'
					step 'I use RETURN'
				elsif red_rev == "reverse-proxy" 
					step 'I type "cd /etc/apache2/sites-available/qa/rev/"'
					step 'I use RETURN'
					step 'I type "sudo cp redirector ../../"'
					step 'I use RETURN'
					step 'I type "npf"'
					step 'I use RETURN'
					step 'I type "cd ../.."'
					step 'I use RETURN'					
					step 'I type "sudo apache2ctl configtest"'
					step 'I use RETURN'
					step 'I should see "putty_syntax-ok.png"'
					if !@screen.exists "putty_syntax-ok.png"
						puts "Reverse-prox NOT engaged"
					elsif 						
						step 'I type "sudo apache2ctl graceful"'
						step 'I use RETURN'	
						puts "Reverse-proxy Fully engaged"
					end	
					step 'I type "exit"'
					step 'I use RETURN'			
				end	
			end
		nooftries = 0
		begin
			if @screen.exists "button_Cancel.png"
				step 'I click on "button_Cancel.png"'
			end
		rescue
			if(ENV['debug'])
				puts "putty already set"
			end
			if(nooftries < 2)
				nooftries = nooftries + 1
				retry
			end
		end
	end


	Given /^I clear the output folder$/ do 
	end

	Given /^I copy the output to "(.*?)"$/ do |folder|
	end