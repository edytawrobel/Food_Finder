require 'restaurant'
class Guide

  def initialize(path=nil)
    #locate the restaurant text file at path
    Restaurant.filepath = path
    if Restaurant.file_usable?
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
    result = nil
    until result == :quit
      #   what do you want to do? (list, find, add, quit)
      print "> "
      user_response = gets.chomp
      #   do that action
      result = do_action(user_response)
    end
    conclusion
  end

  def do_action(action)
    case action
      when "list"
        puts "listing..."
      when "find"
        puts "Finding..."
      when "add"
        puts "Adding..."
      when "quit"
        return :quit
      else
        puts "\nI don't understand that command.\n"
      end
  end

  def introduction
    puts "\n\n<<< Welcome to the Food Finder >>>"
    puts "This is an interactive guide to help you find the food you crave.\n\n"
  end

  def conclusion
    puts "\n<<< Goodbye and Bon Appretit! >>>\n\n\n"
  end

end
