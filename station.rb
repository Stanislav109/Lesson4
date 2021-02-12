class Station
  attr_reader :name, :trains

  def initialize(name)
    #пользователь может создавать станции
    @name = name
    @trains = []
  end

  
  protected

  def get_train(train)
    #пользователь не может принять станцией поезд
    self.trains << train
  end

  def send_train(train)
    #пользователь не может послать станией поезд
    self.trains.delete(train)
  end

end






