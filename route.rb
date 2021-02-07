class Route
  attr_accessor :stations
  attr_reader :start_station, :end_station

  def initialize(start_station, end_station)
    @stations = []
    @stations << start_station
    @stations << end_station
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end
