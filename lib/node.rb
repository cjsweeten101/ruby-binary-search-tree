# frozen_string_literal: true

# A node stores its value and left and right children
class Node
  include Comparable
  attr_accessor :right, :left, :data

  def initialize(data, left, right)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    @data <=> other.data
  end
end
