class Restaurant

  @@filepath = nil
  def self.filepath=(path=nil) #a setter method that allows us to call the filepath var. outside Restaurant class
    @@filepath = File.join(APP_ROOT, path) #assume that path is always relarive to APP_ROOT
  end

  def self.file_exists?
    # class should know if the restaurant file exists
  end

  def self.create_file
    #create the restaurant file
  end

  def self.saved_restaurants
    #read the restaurant file
    #return instances of restaurant
  end

end
