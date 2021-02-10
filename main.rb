
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
    loop do
    puts "Выберите пункт меню"
    puts "Введите '1' чтобы создать станцию"
    puts "Введите '2' чтобы создать поезд"
    puts "Введите '3' чтобы создать маршрут"
    puts "Введите '4' чтобы назначить маршрут поезду"
    puts "Введите '5' чтобы добавить вагон к поезду"
    puts "Введите '6' чтобы переместить поезд вперед по маршруту"
    puts "Введите '7' чтобы переместить поезд назад по маршруту"
    puts "Введите '8' чтобы посмотреть список станций"
    puts "Введите '9' чтобы посмотреть список поездов"
    puts "Введите '10' чтобы посмотреть список маршрутов"
    puts "Введите '0' чтобы выйти"
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
      when 9
      show_trains
      when 10
      show_all_routes
      when 0 
      break    
      end
    end
  end

  def create_station
    puts "Введите название станции"
    name = gets.chomp!
    station = Station.new(name)
    stations << station
    stations.each_with_index {|station, index| puts "#{index+1}. #{station.name}"}
  end

  def create_train
    puts "Выберите тип поезда - 'passenger' или 'cargo'"
    type_of_train = gets.chomp!.to_sym
    puts "Введите номер поезда"
    number_of_train = gets.chomp!
      if type_of_train == :passenger
      train = Train.new(number_of_train, type_of_train)
      trains << train
      elsif type_of_train == :cargo
      train = Train.new(number_of_train,type_of_train)
      trains << train 
      else
      puts "Вы ввели неправильный тип поезда" 
      end
  end

  def create_route
    stations.each_with_index {|station, index| puts "#{index+1}. #{station.name}"}
    puts "Введите индекс начальной станции"
    number_of_ss = gets.chomp!
    puts "Введите индекс конечной станции"
    number_of_es = gets.chomp!
    route = Route.new(stations[number_of_ss.to_i], stations[number_of_es.to_i])
    routes << route
    # routes.each_with_index { |route| puts "начальная #{route.stations[number_of_ss.to_i]} конечная #{route.stations[number_of_es.to_i]}" }
    # routes.stations.each_with_index { |station,index| puts "#{index+1}. #{station.name}" }
    routes.each_with_index { |station, index| puts "Маршрут #{index+1}: начальная станция: #{stations[number_of_ss.to_i-1].name} конечная стания: #{stations[number_of_es.to_i-1].name}"}
    
    

    

    
  end

  def show_all_routes
    routes.each_with_index do |station, index|
      puts "#{index}: начальная станция : #{station.start_station.name}.  конечная станция: #{station.end_station.name}"
    end
  end

  def add_route_to_train
    show_trains
    puts "Выберите индекс поезда"
    train_choice = gets.chomp!.to_i

    create_route
    puts "Выберите индекс маршрута"
    route_choice = gets.chomp!.to_i

    
    trains[train_choice-1].route = routes[route_choice-1]
    puts "Поезд № #{trains[train_choice-1].number} назначен на маршрут"

    
    
    
  end

  def add_wagon_to_train
    puts "Выберите тип вагона - 'passenger' или 'cargo'"
    type_of_wagon = gets.chomp!.to_sym
    puts "Введите номер вагона"
    number_of_wagon = gets.chomp!
      if type_of_wagon == :passenger
      wagon = PassengerWagon.new(number_of_wagon)
      wagons << wagon
      elsif type_of_wagon == :cargo
      wagon = CargoWagon.new(number_of_wagon)
      wagons << wagon 
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
    # stations.each {|station| puts station.name}
    stations.each_with_index { |station,index| puts "#{index+1}. #{station.name}" }
  end

  def show_trains
    trains.each_with_index { |train,index| puts " #{index+1}: Поезд № #{train.number} Тип #{train.type}" } #trains.each_with_index { |train, index| p "#{index}: #{train.number}  #{train.type}" }           
  end

end

RailRoad.new.start




  
 


