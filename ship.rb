class Ship

 AVAILABLE_SHIPS = {patrolboat: 2, destroyer: 3, submarine: 3, battleship: 4, aircraft_carrier: 5}
 @@shipcount = 0

 attr_reader :size, :type

 attr_accessor :id, :damage

  def initialize(type)

    @size = AVAILABLE_SHIPS[type]

    @type = type

    @@shipcount += 1

    @id = @@shipcount

    @damage = 0
  end

  def isSunk?
    raise ArgumentError, 'damage is higher than ship size' if damage > size
    damage == size
  end
end