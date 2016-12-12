require 'restaurant'
class Guide

  def initialize(path=nil)
    #locate the restaurant text file at path
    Restaurant.filepath = path
    if Restaurant.file_exists?
      puts "Found restaurant file."
    elsif
      #or create a new file
      Restaurant.create_file #controlling it from the guide class, but the actual code is in restaurant.rb file
      puts "Created restaurant file."
    # exit if create fails
    else
      puts "Exiting. \n\n"
      exit!  #stops cold
    end
  end

  def launch!
    introduction
    #action loop
    #   what do you want to do? (list, find, add, quit)
    #   do that acti on
    #repeat until user quits
    conclusion
  end

  def introduction
    puts "\n\n<<< Welcome to the Food Finder >>>"
    puts "This is an interactive guide to help you find the food you crave.\n\n"
  end

  def conclusion
    puts "\n<<< Goodbye and Bon Appretit! >>>\n\n\n"
  end

end
