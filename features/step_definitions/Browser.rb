def get_browser()
#	url = $config["url"]

	#url = $config["url1"]
	begin
		begin
			#puts "Check if an exisiting brwoser is already running"
			#binding.pry
			if ($browser.windows.last.url =~ /jupiter.bbc.co.uk/)
					$browser.windows.last.use do
							$browser.refresh
				end
			end
		rescue
			#puts "No Browser fround, create a new one!"
			if $config["browser"] == "chrome"
				$browser = Watir::Browser.new :chrome
			elsif $config["browser"] == "ie"
				$browser = Watir::Browser.new :ie
			elsif $config["browser"] == "firefox"
				$browser = Watir::Browser.new :firefox
			end
	    #$browser.goto url
			$browser.driver.manage.window.maximize   
			#$result_frame = $browser.frame(:id => "resultFrame")
			#$media_frame = $browser.frame(:id => "mediaFrame")	
		end			
	rescue
		print "Connection error."
		#$browser.close
	end

		
end

def close_browser
	sleep 2
	$browser.close
	puts "closing the browser!"
end