class Ship

 AVAILABLE_SHIPS = {patrolboat: 2, destroyer: 3, submarine: 3, battleship: 4, aircraft_carrier: 5}
 @@shipcount = 0

 attr_accessor :size, :id

  def initialize(type)

    @size = AVAILABLE_SHIPS[type]

    @type = type
    
    @@shipcount += 1

    @id = @@shipcount

  end

end