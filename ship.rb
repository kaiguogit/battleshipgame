class Ship

 @@shipcount = 0

 attr_accessor :size, :id

  def initialize(size)

    @size = size

    @@shipcount += 1

    @id = @@shipcount

  end

end