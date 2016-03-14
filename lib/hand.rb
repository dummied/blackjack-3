# Represents a hand of cards
# Contains much of the game logic
class Hand
  attr_accessor :cards, :stayed, :split

  def initialize(card = nil)
    self.cards = card ? [card] : []
    self.stayed = false
    self.split = false
  end

  def value
    cards.inject(:+)
  end

  def deal(cards)
    self.cards += cards
  end

  def blackjack?
    cards.length == 2 && value == 21
  end

  def busted?
    switch_aces_as_necessary if value > 21
    value > 21
  end

  def switch_aces_as_necessary
    available_aces.value = 1 until value <= 21 || !available_aces
  end

  def available_aces
    cards.detect { |card| card.face == 'Ace' && card.value == 11 }
  end

  def six_and_safe?
    !busted? && cards.length >= 6
  end

  def >(other)
    if value == other.value
      cards.length >= other.cards.length
    else
      value > other.value
    end
  end

  def >=(other)
    self > other
  end

  def stayed?
    stayed
  end

  def twenty_one?
    value == 21
  end

  def over?
    winning? || busted? || stayed? || twenty_one? || split
  end

  def winning?
    blackjack? || six_and_safe?
  end

  def splittable?
    cards.length == 2
  end

  def soft?
    cards.any? { |card| card.face == 'Ace' }
  end

  def to_s
    cards.map(&:to_s).join("\n")
  end

  def coerce(other)
    [other, value]
  end

  def <=>(other)
    value <=> other.value
  end
end
