
require_relative 'wagon' 
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'train_pass'
require_relative 'train_cargo'
require_relative 'wagon_pass'
require_relative 'wagon_cargo'

class RailRoad
  attr_reader :stations, :trains, :routes

  def initialize 
    @stations = []
    @trains = []
    @routes = []
  end



  def start
    puts "Выберите пункт меню"
    puts "Введите '1' чтобы создать станцию"
    puts "Введите '2' чтобы создать поезд"
    puts "Введите '3' чтобы создать маршрут"
    puts "Введите '4' чтобы назначить маршрут поезду"
    puts "Введите '5' чтобы добавить вагон к поезду"
    puts "Введите '6' чтобы переместить поезд вперед по маршруту"
    puts "Введите '7' чтобы переместить поезд назад по маршруту"
    puts "Введите '8' чтобы посмотреть список станций"
    choice = gets.chomp.to_i
    case choice
      when 1
      create_station
      when 2 
      create_train
      when 3
      create_route
      when 4
      add_route_to_train
      when 5
      add_wagon_to_train
      when 6
      move_train_to_next_station
      when 7
      move_train_to_previous_station
      when 8
      show_stations  
    end
  end

  def create_station
    puts "Введите название станции"
    name = gets.chomp!
    station = Station.new(name)
    stations << station
    puts "#{stations}"
  end

  def create_train
    puts "Выберите тип поезда - 'passenger' или 'cargo'"
    type_of_train = gets.chomp!.to_sym
    puts "Введите номер поезда"
    number_of_train = gets.chomp!
      if type_of_train == :passenger
      train = Train.new(number_of_train, type_of_train)
      trains << train
      puts "#{trains}"
      elsif type_of_train == :cargo
      train = Train.new(number_of_train,type_of_train)
      trains << train
      puts "#{trains}" 
      else
      puts "Вы ввели неправильный тип поезда" 
      end
  end

  def create_route
    puts "Введите начальную станцию"
    start_station = gets.chomp!
    puts "Введите конечную станцию"
    end_station = gets.chomp!
    route = Route.new(start_station, end_station)
    routes << route
    puts "#{route}"
  end

  def add_route_to_train

  end

  def add_wagon_to_train
    puts "Выберите тип вагона - 'passenger' или 'cargo'"
    type_of_wagon = gets.chomp!.to_sym
    puts "Введите номер вагона"
    number_of_wagon = gets.chomp!
      if type_of_wagon == :passenger
      wagon = PassengerWagon.new(number_of_wagon)
      wagons << wagon
      puts "#{wagons}"
      elsif type_of_wagon == :cargo
      wagon = CargoWagon.new(number_of_wagon)
      wagons << wagon
      puts "#{wagons}" 
      else
      puts "Вы ввели неправильный тип вагона" 
      end
  end

  def move_train_to_next_station
    train.move_next_station
  end

  def move_train_to_previous_station
    train.move_previous_station
  end

  def show_stations
    stations.each {|station| puts station.name}
  end

end

RailRoad.new.start




  
 


