class CargoWagon < Wagon
  attr_reader :type_wagon, :wagon_number

  def initialize(wagon_number)
    @wagon_number = wagon_number
    @type_wagon = :cargo
  end

end