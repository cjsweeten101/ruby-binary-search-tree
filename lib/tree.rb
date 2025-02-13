# frozen_string_literal: true

require_relative 'node'
# Implementation of a balancing BST, using no duplicate values
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

  def insert(value, node = @root)
    return Node.new(value) if node.nil?
    return node if node.data == value

    if value > node.data
      node.right = insert(value, node.right)
    elsif value < node.data
      node.left = insert(value, node.left)
    end

    node
  end

  def delete(value, node = @root)
    return node if node.nil?

    if value > node.data
      node.right = delete(value, node.right)
    elsif value < node.data
      node.left = delete(value, node.left)
    else

      return node.right if node.left.nil?
      return node.left if node.right.nil?

      succ = get_successor(node)
      node.data = succ.data
      node.right = delete(succ.data, node.right)
    end
    node
  end

  def get_successor(node)
    node = node.right
    node = node.left until node.nil? || node.left.nil?
    node
  end

  def find(value, node = @root, &block)
    return node if node.nil?

    if value > node.data
      yield if block_given?
      node = find(value, node.right, &block)
    elsif value < node.data
      yield if block_given?
      node = find(value, node.left, &block)
    end
    node
  end

  # TODO: think about how to do this recursively
  def level_order_recur
  end

  def level_order_iter
    queue = [@root]
    result = []
    until queue.empty?
      curr = queue.shift
      block_given? ? yield(curr) : result << curr.data
      queue << curr.left unless curr.left.nil?
      queue << curr.right unless curr.right.nil?
    end
    block_given? ? nil : result
  end

  def inorder(node = @root, result = [], &block)
    return if node.nil?

    inorder(node.left, result, &block)
    block_given? ? block.call(node) : result << node.data
    inorder(node.right, result, &block)
    block_given? ? nil : result
  end

  def preorder(node = @root, result = [], &block)
    return if node.nil?

    block_given? ? block.call(node) : result << node.data
    preorder(node.left, result, &block)
    preorder(node.right, result, &block)
    block_given? ? nil : result
  end

  def postorder(node = @root, result = [], &block)
    return if node.nil?

    postorder(node.left, result, &block)
    postorder(node.right, result, &block)
    block_given? ? block.call(node) : result << node.data

    block_given? ? nil : result
  end

  def height(node)
    leaves = get_leaves_from_node(node)
    heights = []
    leaves.each do |leaf|
      i = 0
      find(leaf, node) { i += 1 }
      heights << i
    end
    heights.max
  end

  def get_leaves_from_node(node)
    result = []
    inorder(node) { |n| result << n.data if n.left.nil? && n.right.nil? }
    result
  end

  def depth(node)
    i = 0
    find(node.data) { i += 1 }
    i
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
