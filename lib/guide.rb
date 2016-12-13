require 'restaurant'
class Guide

  class Config #a bit overkill (but shows we can have class inside a class)
    @@actions = ['list', 'find', 'add', 'quit']
    def self.actions; @@actions; end # reader method, as it is not accessible outside the class, semicolon to do one line!
  end

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
      action = get_action
      #   do that action
      result = do_action(action)
    end
    conclusion
  end

  # to make sure the user's input is valid
  def get_action
    action = nil #has a value first time through the loop
    # Keep asking for user input until we get a valid action
    until Guide::Config.actions.include?(action)
      puts "Actions: " + Guide::Config.actions.join(", ") if action #will output the list of available actions after the first time and only if we have a failure
      print "> "
      user_response = gets.chomp
      action  = user_response.downcase.strip #it will still work even if the user gives us capital letters, or capslock
    end
    return action
  end

  def do_action(action)
    case action
      when "list"
        puts "listing..."
      when "find"
        puts "Finding..."
      when "add"
        add
      when "quit"
        return :quit
      else
        puts "\nI don't understand that command.\n"
      end
  end

  def add
    puts "\nAdd a restaurant\n\n".upcase #title
    restaurant = Restaurant.build_using_questions #ask the questions you need to build yourself

    #save it - appending the data to a file, so we read it back later
    if restaurant.save
      puts "\nRestaurant added\n\n"
    else
      puts "\nSave Error: Restaurant not added\n\n"
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
