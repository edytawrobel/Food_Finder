class Restaurant

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
    #return instances of restaurant
  end

  def initialize(args={}) #in case of an empty hash
    @name    = args[:name]    || "" #default to the empty string in case of no name
    @cuisine = args[:cuisine] || ""
    @price   = args[:price]   || ""
  end

  def save
    #open file, and write to it
    return false unless Restaurant.file_usable? #instance method, so we have to ask the class
    File.open(@@filepath, 'a') do |file| #location (@@filepath)
      file.puts "#{[@name, @cuisine, @price].join("\t")}\n" #output a tabbed version of the array / export a line to the file
    end
    return true #to see if it worked
  end

end
