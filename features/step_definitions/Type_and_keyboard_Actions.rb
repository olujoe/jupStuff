
When /^I drag "(.*?)" to "(.*?)"$/ do |bitmap, destina|

  image = bitmap.split(",")
  dest = destina.split(",")
  number = image.length
  number2 = dest.length
  tries = 0
  tries2 = 0
  retries = 0
	begin
      destination = dest[tries2]
      #@screen.wait "#{destination}", 1
      if !@screen.exists destination
        puts "********* Can not find the destination image '#{destination}' ************"
      else
        puts "********* Found the destination image '#{destination}' ************"
      end
      #puts "#{destination} exists"
      @screen.wait "#{image[tries]}", 1
      #puts "#{image[tries]} exists"
      if !@screen.exists "#{image[tries]}"
        puts "********* Can not find the destination image '#{image[tries]}' ************"
      else
        puts "********* Found the destination image '#{image[tries]}' ************"
      end

      region1 = @screen.exists destination
      region2 = @screen.exists image[tries]


      begin
          if @screen.exists "#{image[tries]}"
              puts "#{image[tries]} exists"
              @screen.dragDrop(region2,region1)
          else
              puts("Cant find '#{image[tries]}'")
              fail("Cant find '#{image[tries]}'")
          end
      rescue
          if tries < number 
              tries = tries + 1
              retry
          else
              puts ("Did not find the images: '#{bitmap}' in the region")
              fail("Did not find the images: '#{bitmap}' in the region")
          end
      end

  rescue
      if retries < (number * 4 * number2) 
          retries = retries + 1
          tries = tries + 1
=begin
          if((retries % number) == 0)
            tries = 0
            if((retries % number2) == 0)
              tries2 = tries2 + 1
            end
          end

          if((retries % (number + number2)) == 0)
            tries2 = 0
          end
=end
          retry
      else
    	   fail("The either of the following bitmaps cannot be found: " + bitmap + " or " + destina)
      end
  end

end


When /^I type time$/ do
	if(ENV['debug'])
    	puts $currentTimeOffsetString
    end
	@screen.type "#{$currentTimeOffsetString}"
end


When /^I type "(.*?)"$/ do |text|

  if text.include? "RANDOMNUMBER"
    text = text.gsub("RANDOMNUMBER","#{rand(50)}")
  end
  sleep(1)
	@screen.type "#{text}"

end


When /^I type "(.*?)" and TAB$/ do |text|
  @screen.type "#{text}"+ "\t"
  sleep(1)
end


When /^I use BACKSPACE$/ do
  @screen.type(Sikuli::KEY_BACKSPACE)
end

When /^I use BACKSPACE "(.*?)" times$/ do |number|
  number.to_i.times do |x|
    @screen.type(Sikuli::KEY_BACKSPACE)
  end
end


When /^I use TAB$/ do
  sleep(2)
  @screen.type("\t")
end


When /^I use DOWNARROW$/ do
#  @screen.type(Sikuli::KEY_DOWN)
  @screen.type(Sikuli::PAGE_DOWN)
#   @screen.type(u"\ue003")
#   @screen.type("\ue003")
end


When /^I use CTRL A$/ do
  sleep(1)
  @screen.type("a", Sikuli::KEY_CTRL)
  sleep(1)
 #@screen.type("x", Sikuli::KEY_CTRL)
end

When /^I use CTRL V$/ do
  sleep(1)
  @screen.type("v", Sikuli::KEY_CTRL)
  sleep(1)
 #@screen.type("x", Sikuli::KEY_CTRL)
end

When /^I use CTRL Q$/ do
  sleep(1)
  @screen.type("Q", Sikuli::KEY_CTRL)
  sleep(1)
 #@screen.type("x", Sikuli::KEY_CTRL)
end

When /^I use RETURN$/ do
#	And I wait "1" seconds
#    And I use CTRL A
  sleep(1)
  @screen.type("\n")
end


When /^I use DELETE$/ do
  sleep(1)
  @screen.type(Sikuli::KEY_DELETE)
end

When /^I use DELETE "(.*?)" times$/ do |number|
  sleep(1)
  number.to_i.times do 
    @screen.type(Sikuli::KEY_DELETE)
  end
end


When /^I Copy and Paste$/ do
  sleep(1)
  @screen.type("a", Sikuli::KEY_CTRL)
  sleep(1)
  @screen.type("c", Sikuli::KEY_CTRL)
  sleep(1)
  @screen.type("v", Sikuli::KEY_CTRL)
  @screen.type("v", Sikuli::KEY_CTRL)
end


When /^I Clear and Paste$/ do
  sleep(1)
  @screen.type("a", Sikuli::KEY_CTRL)
  sleep(1)
#  @screen.type("x", Sikuli::KEY_CTRL)
  @screen.type(Sikuli::KEY_BACKSPACE)
  sleep(1)
  @screen.type("v", Sikuli::KEY_CTRL)
  @screen.type(Sikuli::KEY_BACKSPACE)
end


When /^I paste "(.*?)"$/ do |text|
  @screen.paste("#{text}")
end


When /^I use Right$/ do
  	@screen.type(Sikuli::RIGHT_ARROW)
end


When /^I use LEFT$/ do
  	@screen.type(Sikuli::LEFT_ARROW)
end


When /^I scroll to the right$/ do
  150.times do 
    @screen.type(Sikuli::RIGHT_ARROW)
  end
end

When /^I scroll "(.*?)" times to the right$/ do |text|
  text.to_i.times do 
    @screen.type(Sikuli::RIGHT_ARROW)
  end
end

When /^I scroll "(.*?)" times to the left$/ do |text|
  text.to_i.times do 
    @screen.type(Sikuli::LEFT_ARROW)
  end
end


When /^I type PAGE_UP$/ do
  150.times do 
    @screen.type(Sikuli::PAGE_UP)
  end
end


When /^I scroll to the left$/ do
  150.times do 
  	@screen.type(Sikuli::LEFT_ARROW)
  end
end

When /^I scroll down a list$/ do
   @screen.type(Sikuli::PAGE_DOWN)
end  


When /^I use the DOWN_ARROW "(.*?)" times$/ do |num|
  num.to_i.times do 
    @screen.type(Sikuli::DOWN_ARROW)
  end
end

When /^I use the UP_ARROW "(.*?)" times$/ do |num|
  num.to_i.times do 
    @screen.type(Sikuli::UP_ARROW)
  end
end

When /^I press the space key$/ do
  @screen.type(" ")
end


Given /^I type sequence and a random 2 digit number$/ do
  text = rand(99)
  puts text
  @screen.type "sequence#{text}"
end

Given /^I type a random 2 digit number under 24$/ do
  text = rand(23)
  puts text
  @screen.type "sequence#{text}"
end

When /^I type F2$/ do
  @screen.type(Sikuli::KEY_F2)
end

When /^I type F3$/ do
  @screen.type(Sikuli::KEY_F3)
end

When /^I type F4$/ do
  @screen.type(Sikuli::KEY_F4)
end

When /^I type F5$/ do
  @screen.type(Sikuli::KEY_F5)
end

When /^I type F6$/ do
  @screen.type(Sikuli::KEY_F6)
end

When /^I type F7$/ do
  @screen.type(Sikuli::KEY_F7)
end

When /^I type F8$/ do
  @screen.type(Sikuli::KEY_F8)
end

When /^I type F9$/ do
  @screen.type(Sikuli::KEY_F9)
end

When /^I type F10$/ do
  @screen.type(Sikuli::KEY_F10)
end

When /^I type F11$/ do
  @screen.type(Sikuli::KEY_F11)
end

When /^I type F12$/ do
  @screen.type(Sikuli::KEY_F12)
end

When /^I type Shift F3$/ do
  @screen.type(Sikuli::KEY_F3, Sikuli::KEY_SHIFT)
end

When /^I type Shift F4$/ do
  @screen.type(Sikuli::KEY_F4, Sikuli::KEY_SHIFT)
end

When /^I type Shift F5$/ do
  @screen.type(Sikuli::KEY_F5, Sikuli::KEY_SHIFT)
end

When /^I type Shift F6$/ do
  @screen.type(Sikuli::KEY_F6, Sikuli::KEY_SHIFT)
end

When /^I type Shift F7$/ do
  @screen.type(Sikuli::KEY_F7, Sikuli::KEY_SHIFT)
end

When /^I type Shift F8$/ do
  @screen.type(Sikuli::KEY_F8, Sikuli::KEY_SHIFT)
end

When /^I type Shift F9$/ do
  @screen.type(Sikuli::KEY_F9, Sikuli::KEY_SHIFT)
end

When /^I type Shift F10$/ do
  @screen.type(Sikuli::KEY_F10, Sikuli::KEY_SHIFT)
end

When /^I type Shift F11$/ do
  @screen.type(Sikuli::KEY_F11, Sikuli::KEY_SHIFT)
end

When /^I type Shift F12$/ do
  @screen.type(Sikuli::KEY_F12, Sikuli::KEY_SHIFT)
end

When /^I type Shift J$/ do
  @screen.type("J", Sikuli::KEY_SHIFT)
end

When /^I type Shift L$/ do
  @screen.type("l", Sikuli::KEY_SHIFT)
end


When /^I type CTRL J$/ do
  @screen.type("J", Sikuli::KEY_CTRL)
end

When /^I type CTRL L$/ do
  @screen.type("l", Sikuli::KEY_CTRL)
end

When /^I use ESC$/ do
  @screen.type(Sikuli::KEY_ESC)
end

When /^I use Home$/ do
  @screen.type(Sikuli::KEY_HOME)
end

#When /^I wait for "(.*?)" to appear$/ do |bitmap|
#  begin
#    @screen.wait "#{bitmap}", 20
 # rescue
#    fail("The following bitmap cannot be found: " + bitmap)
#  end
#end

When /^I create a region "(.*?)"$/ do |bitmap|
  r=@screen.find "#{bitmap}".below(500)
end

When /^I type j 20 times$/ do
  15.times do 
    @screen.type("j")
  end
end



When /^I type Alt C$/ do
  @screen.type("c", Sikuli::KEY_ALT)
end


When /^I type WIN R$/ do
  @screen.type("r", Sikuli::KEY_WIN)
end
# Make sikuli more robust
# from org.sikuli.script.natives import Vision
#Vision.setParameter("MinTargetSize", 6) # A small value such as 6 makes the matching algorithm be faster.
#Vision.setParameter("MinTargetSize", 18) # A large value such as 18 makes the matching algorithm be more robust.

#find("OK") return all regions with ok label
#Region.text return text in a region

# Beware using this cos the application is closed automatically after the job has finished
#@script.openApp("C:\\Program Files (x86)\\BBC\\Jupiter\\bin\\Jupiter.exe")

#popup("Hello World!\nHave fun with Sikuli!")

#while @screen.exists "#{bitmap}"
#	@screen.click "#{bitmap}"
#	sleep 1
#end
#loop do @screen.click "#{bitmap}"
#	sleep 1
#	break if not (@screen.exists "#{bitmap}")
#end

#STDOUT.write "Given I click on " + bitmap + "\n"

