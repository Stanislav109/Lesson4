require_relative 'wagon'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'train_pass'
require_relative 'train_cargo'
require_relative 'wagon_pass'
require_relative 'wagon_cargo'

class RailRoad
  attr_reader :stations, :trains, :routes, :wagons 

  def initialize 
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
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

  def seed
    @stations << Station.new('Belgorod')
    @stations << Station.new('Kursk')
    @stations << Station.new('Orel')
    @stations << Station.new('Moskow')
    @routes << Route.new(@stations[0], @stations[1])
    
    @trains << Train.new(123, 'passenger')
    @trains << Train.new(223, 'cargo')
    @trains << Train.new(124, 'passenger')
    @trains << Train.new(224, 'cargo')

    @wagons << Wagon.new(555, 'cargo')
    
  end

    private

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
    stations.each_with_index {|station, index| puts "#{index + 1}. #{station.name}"} 
    puts "Введите индекс начальной станции"
    number_of_ss = gets.to_i
    puts "Введите индекс конечной станции"
    number_of_es = gets.to_i
    routes << Route.new(stations[number_of_ss - 1], stations[number_of_es - 1]) 
     show_all_routes
  end

  def show_all_routes
    routes.each_with_index do |route, index|
      puts "Маршрут #{index + 1}: начальная станция: #{route.stations.first.name} конечная стания: #{route.stations.last.name}"
    end
  end 

 def add_route_to_train
    show_trains
    puts "Выберите индекс поезда"
    train_choice = gets.chomp!.to_i 
    show_all_routes
    puts "Выберите индекс маршрута"
    route_choice = gets.chomp!.to_i  
      trains[train_choice-1].route = routes[route_choice-1]
    puts "Поезд № #{trains[train_choice-1].number} назначен на маршрут #{route_choice}" 
 end

  def add_wagon_to_train
    puts "Выберите тип вагона - 'passenger' или 'cargo'"
    type_of_wagon = gets.chomp!.to_sym
    puts "Введите номер вагона"
    number_of_wagon = gets.to_i
    # wagons << Wagon.new(number_of_wagon,type_of_wagon)
    # puts "Вагон номер #{number_of_wagon} добавлен"

    if type_of_wagon == :passenger
      wagon = PassengerWagon.new(number_of_wagon,type_of_wagon)
      wagons << wagon
      puts "Вагон номер #{number_of_wagon} добавлен"
    elsif type_of_wagon == :cargo
      wagon = CargoWagon.new(number_of_wagon,type_of_wagon)
      wagons << wagon 
      puts "Вагон номер #{number_of_wagon} добавлен"
    else
      puts "Вы ввели неправильный тип вагона" 
    end
  end

  def move_train_to_next_station
    show_trains
    puts "Выберите индекс поезда"
    train_choice = gets.to_i 
    trains[train_choice-1].move_next_station
    puts "#{trains[train_choice-1].station.name}"
  end

  def move_train_to_previous_station
    show_trains
    puts "Выберите индекс поезда"
    train_choice = gets.to_i 
    trains[train_choice-1].move_previous_station
    puts "#{trains[train_choice-1].station.name}"
    
  end

  def show_stations
    # stations.each {|station| puts station.name}
    stations.each_with_index { |station,index| puts "#{index+1}. #{station.name}" }
  end

  def show_trains
    trains.each_with_index { |train,index| puts " #{index+1}: Поезд № #{train.number} Тип #{train.type}" } #trains.each_with_index { |train, index| p "#{index}: #{train.number}  #{train.type}" }           
  end
end

raiload = RailRoad.new
raiload.seed
raiload.start