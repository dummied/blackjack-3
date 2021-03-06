require_relative 'card'

# Represents a deck of cards
class Deck < Array
  def initialize
    populate
    shuffle!
  end

  def populate
    Card.suits.each do |suit|
      Card.faces.each do |face|
        push Card.new(face, suit)
      end
    end
  end

  def draw(num = 1)
    shift(num)
  end

  def hey
    "hey"
  end
end
