# use headless gem when HEADLESS variable is set
if ENV['HEADLESS'] == 'true'
 require 'headless'
  	
    headless = Headless.new
    headless.start
  
    at_exit do
      headless.destroy
   end
end