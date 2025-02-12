# frozen_string_literal: true

require_relative 'node'
# Implementation of a balancing BST, using not duplicate values
class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr)
  end

  def build_tree(arr)
  end
end
