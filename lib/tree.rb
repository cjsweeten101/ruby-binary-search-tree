# frozen_string_literal: true

require_relative 'node'
# Implementation of a balancing BST, using not duplicate values
class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr)
  end

  def build_tree(arr)
    new_arr = arr.sort.uniq
    sorted_array_to_bst(new_arr, 0, new_arr.length - 1)
  end

  def sorted_array_to_bst(arr, start_i, end_i)
    return nil if start_i > end_i

    mid_point = (start_i + end_i) / 2
    root = Node.new(arr[mid_point])
    root.left = sorted_array_to_bst(arr, start_i, mid_point - 1)
    root.right = sorted_array_to_bst(arr, mid_point + 1, end_i)

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.pretty_print
