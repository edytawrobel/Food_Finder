
require 'support/number_helper'
class Restaurant
  include NumberHelper #the functionality inside the class

  @@filepath = nil
  def self.filepath=(path=nil) #a setter method that allows us to call the filepath var. outside Restaurant class
    @@filepath = File.join(APP_ROOT, path) #assume that path is always relarive to APP_ROOT
  end

  attr_accessor :name, :cuisine, :price

  def self.file_exists?
    # class should know if the restaurant file exists
    if @@filepath && File.exists?(@@filepath)
      return true
    else
      return false
    end
  end

  def self.file_usable?  #there are all the steps along the way where it might fails, but if it passes the conditions, we are safe
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    return true
  end

  def self.create_file
    #create the restaurant file
    File.open(@@filepath, 'w') unless file_exists?
    return file_usable? #return as boolean
  end

  def self.saved_restaurants
    #read the restaurant file
    restaurants = []
    if file_usable?
      file = File.new(@@filepath, 'r')
      file.each_line do |line|
        restaurants << Restaurant.new.import_line(line.chomp)
      end
      file.close
    end
    return restaurants
    #return instances of restaurant
  end

  def self.build_using_questions
    args = {}
    print "Restaurant name: "
    args[:name] = gets.chomp.strip

    print "Cuisine type: "
    args[:cuisine] = gets.chomp.strip

    print "Average price: "
    args[:price] = gets.chomp.strip

    return self.new(args)
  end

  def initialize(args={}) #in case of an empty hash
    @name    = args[:name]    || "" #default to the empty string in case of no name
    @cuisine = args[:cuisine] || ""
    @price   = args[:price]   || ""
  end

  def import_line(line)
    line_array = line.split("\t")
    #triple assignment, array equals another array and will assign it to the respective indexes
    @name, @cuisine, @price = line_array
    return self #for saved_restaurants to use it
  end

  def save
    #open file, and write to it
    return false unless Restaurant.file_usable? #instance method, so we have to ask the class
    File.open(@@filepath, 'a') do |file| #location (@@filepath)
      file.puts "#{[@name, @cuisine, @price].join("\t")}\n" #output a tabbed version of the array / export a line to the file
    end
    return true #to see if it worked
  end

  def formatted_price
    number_to_currency(@price)
  end

end
