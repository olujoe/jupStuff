###################################
# Environment file for Jupiter
# Written by Richard Foster
# Date 10th February 2013
###################################

#require 'D:/Projects/Jupiter/Tools/SikuliX/sikuli-script.jar'
#require 'java'
#require 'watir-webdriver'
#require 'selenium-webdriver'
#require 'win32/screenshot'
#require 'mini_magick'
#require 'win32/screenshot'
#require 'capybara'
#require 'smarter_csv'
#require 'fastercsv'
#require 'nokogiri'
#require 'date'
#require 'time'
#require 'roo'

#require 'spreadsheet'
require 'rubygems'
require 'sikuli'
require 'yaml'
require 'clipboard'
require 'open-uri'
require 'net/http'
require 'JSON'
require 'pry'
require 'fileutils'
require 'watir-webdriver'
#require 'rest-client'
#require 'fastercsv'

#require 'logger'
#require 'logglier'


#ENV['debug'] = "false"
ENV['FAIL_FAST'] = "false"

Sikuli::Config.run do |config|
  config.image_path = "images\\"
  config.logging = false
  config.highlight_on_find = false
end

Pry.config.input = STDIN
Pry.config.output = STDOUT




class SikuliNavigator
  def initialize
    #if (defined?(@screen)).nil?
    #    @screen.destroy()
    #end
    @screen = Sikuli::Screen.new                  # from the sikuli gem
    #puts "************************************************"

    #resultRegion = @screen.exists("images\\result_region.png")
    #@resultRegion = resultRegion.below()

    #resultRegion = @screen.exists("images\\result_region.png")
    #@qvlRegion = resultRegion.above()

  end
end

#def initialize_browser
#    @browser = Watir::Browser.new :firefox # should open a new chrome window
#    #@browser = Selenium::Browser.new :firefox # should open a new chrome window
#end

World { SikuliNavigator.new }
$config = YAML.load(File.read('features/support/config.yml'))

    if(ENV['site'])
        scenario_tags = ENV['site']
    else
        scenario_tags = "QA_W1"
    end
    if(scenario_tags.include? "usa")
        $site = "QA_USA"
        puts "Running on QA USA"
    elsif (scenario_tags.include? "West1")
        $site = "West1"
        puts "Running on West1"
    elsif (scenario_tags.include? "WS")
        $site = "QA_WS"
        puts "Running on QA WS"
    elsif (scenario_tags.include? "Salford")
        $site = "Salford"
        puts "Running on Salford"
    elsif (scenario_tags.include? "Millbank")
        $site = "Millbank"
        puts "Running on Millbank"
    else
        $site = "QA_W1"
        puts "Running on QA W1"
    end

#********************************THIS SECTION IS FOR TEST RAIL SETUP*******************************************

    if(ENV['testrail'])
        if(ENV['testrail'].downcase == "yes")
            $testrail = true
        else
            $testrail = false
        end
    else
      $testrail = false
    end

    $testrail = false
    #$testrail = true
    $projectID = "151"
    $suiteID = "4119"
    $caseids = ""
    $versionId = "3.11.0.1764"
    $runId = "151712"

    
    if $testrail
        puts "*** Updating TestRail In This Run, ID: #{$runId} ***"
    else
        puts "*** Not Updating TestRail In This Run ***"
    end

    # Need this for QA reporting
    $feature_start_time = Time.now


#=begin
  Before do |scenario|
      
      #puts "in before"
      #upadetNewQAAPI(scenario.tags.to_s, "")
       upadetNewQAAPI(scenario.tags.to_s, "")

      if $testrail
          @@startT = Time.now
      end
      scenario.tags.to_s.split(',').each do |data|
        #puts data
          tag = data.to_s.split('::Tag "')[1].split('" (features')[0].strip
          if tag.include? "usa_only"
              if $site != "QA_USA"
                  scenario.skip_invoke!
                  #skip_this_scenario
              end
          end

          if tag.include? "w1_only"
              if $site != "QA_W1"
                  scenario.skip_invoke!
                  #skip_this_scenario
              end
          end

      end

  end

  # This block is used to terminate a Test if a Scenario fails
  After do |scenario|
      
      upadetNewQAAPI(scenario.tags.to_s, scenario.failed?)

      if scenario.failed?
        if ENV['FAIL_FAST'] == "true"
          #-Cucumber.wants_to_quit = true if scenario.failed? 
        end
      end

      if $testrail

          @@endT = Time.now
          elapsedseconds = @@endT - @@startT
          puts "Elapsed Time in (s): #{elapsedseconds}"
          finaltag = ""

          scenario.tags.to_s.split(',').each do |data|

              tag = data.to_s.split('::Tag "')[1].split('" (features')[0].strip

              if tag.gsub(tag[0,2],"").isInteger?    

                  if (tag[0,2] == "@c" )
                      
                      newtag = tag.gsub("@c", "")  
                      begin
                          finaltag = newtag.to_i
                      rescue
                          finaltag = ""
                      end

                  elsif (tag[0,2] == "@C")

                      newtag = tag.gsub("@C", "")  
                      begin
                          finaltag = newtag.to_i
                      rescue
                          finaltag = ""
                      end

                  else
                      finaltag = "" 
                  end

                  if finaltag == ""
                      puts "Cannot Find Case ID for tag '#{tag}', so not going to upload result to Testrail!!!"
                  else
                      #caseId = finaltag.gsub("@C", "") 
                      caseId = finaltag
                      puts "Case id: #{caseId}"
                      #files = "//zgbwcfs3005.jupiter.bbc.co.uk/QA/Jenkins/Jupiter/Jupiter_testrailrunid.txt"
                      #file = File.new(files,'r')
                      #runId = file.gets
                      #file.close
                      #puts "Run id: "+runId
                      #$runId = runId
                      if scenario.failed?
                          statusId = "5"
                      else
                          statusId = "1"
                      end
                      posttestrail($runId, caseId, statusId, $versionId, elapsedseconds)
                  end

              end

          end

      end

  end




at_exit do

  ##id= "in at exit\n"
  #puts "in at exit"
  #files = "//zgbwcfs3005.jupiter.bbc.co.uk/QA/Jenkins/Jupiter/mike.txt"
  #f = File.open(files,'a')
  #f.write(id)
  #f.write($test_tags)
  #f.close
  #puts $test_tags

  $test_feature_file = "";
  #upadetNewQAAPI($test_tags,"")
  upadetNewQAAPI("","")

end




#=end

#********************************THIS SECTION IS FOR TEST RAIL SETUP*******************************************



=begin
#Before do |scenario|

  if $site == "QA_USA" 
      Before('@sendToShelf') do
          pending
      end
  end
#end


# This block is used to terminate a Test if a Scenario fails
After do |scenario|
    #puts "In After Block"

    # fail-fast
    if scenario.failed?
    #if ENV['FAIL_FAST']
      #@screen.type(Sikuli::KEY_PRINTSCREEN)
      #sleep 4
      #@screen.click(200,200)
#=begin
#      sleep 2
#      system("features/support/getErrorImages.bat")
#      sleep 3
#      files = "/features/support/image_list.txt"
#      file = File.new(files, "r")
#      text = file.gets
#      file.close
#      puts text
#=end

      #scenario.embed(screenshot, "C:/Users/BBCNewsTest/Desktop/Screen capture/Screenpresso/image/png"); 
	  end

     
      #files = `find /features/ -type f -maxdepth 1`
      #puts files
    #Win32::Screenshot::Take.of(:foreground).write("#{scenario.name}.png")
#screen = @screen
#file = screen.capture(screen.getBounds())
#shutil.move(img, '/Users/Log/img_' + str(time.time()) + '.png')
#fname = "sample.png"
#somefile = File.open(fname, "w")
#somefile.puts file
#somefile.close
#@screen.type(Key::KEY_PRINTSCREEN, Sikuli::KEY_ALT)

#shortcut = Clipboard.paste
#F.write("whatever.png", file)
#f = File.open("whatever.png",'w')
#f.write(shortcut)
 #@screen.type(Sikuli::KEY_PRINTSCREEN)

  #screen = @screen
  #file = screen.capture(screen.getBounds())



#width, height, bmp = Win32::Screenshot.foreground
#File.open("D:/Automation/firefox.bmp", "wb") {|io| io.write(bmp)}


#Win32::Screenshot::Take.of(:foreground).write("image.png")

#print("Saved screen as "+file)

  #if scenario.failed?
  #  encoded_img = capture(SCREEN)
  #  embed("data:image/png;base64,#{encoded_img}",'image/png')
  #end

end
=end








