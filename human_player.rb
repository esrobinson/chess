class HumanPlayer
  attr_accessor :name, :color

  def initialize(name)
    @name = name
  end

  def set_color(color)
    @color = color
    self
  end

  def move
    puts "Enter a move. (Format: a1 b6)"
    positions = gets.chomp.split(' ')
    parse_move(positions)
  end

  private

    def parse_move(positions)
      positions.map! do |position|
        position = position.split('')
        position[0] = position[0].downcase.ord - 97
        position[1] = position[1].to_i - 1
        position
      end
    end
end