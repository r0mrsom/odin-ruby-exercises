require_relative 'node'

class Tree
  
  attr_accessor :root

  def initialize(array)
    @array = array.uniq.sort
    @root = build_tree(@array)
  end

  def build_tree(array)
    self.root = balance(array)
  end

  def insert(node, root = self.root)
    return Node.new(node) if root.nil?
    return root if node == root.data

    if node < root.data
      root.left = insert(node, root.left)
    else
      root.right = insert(node, root.right)
    end

    return root
  end

  def delete(node, root = self.root)
    if node > root.data
      root.right = delete(node, root.right)
    elsif node < root.data
      root.left = delete(node, root.left)
    elsif node == root.data
      if root.left.nil? && root.right.nil?
        return nil
      elsif root.left.nil? != root.right.nil?
        root.left.nil? ? root = root.right : root = root.left
      else
        current = inorder_successor(root)
        root.data = current.data
        root.right = delete(current.data, root.right)
      end
    end
    return root
  end

  def levelorder(root = self.root, array = [], queue = [])
    return if root.nil?
    array << root.data
    queue << root.left if !root.left.nil?
    queue << root.right if !root.right.nil?
    root = queue.shift
    levelorder(root, array, queue)
    array
  end

  def preorder(root = self.root, array = [])
    return if root.nil?
    array << root.data
    preorder(root.left, array)
    preorder(root.right, array)
    return array
  end

  def inorder(root = self.root, array = [])
    return if root.nil?
    inorder(root.left, array)
    array << root.data
    inorder(root.right, array)
    return array
  end

  def postorder(root = self.root, array = [])
    return if root.nil?
    postorder(root.left, array)
    postorder(root.right, array)
    array << root.data
    return array
  end

  def height(node, root = self.root)
    root = height_root_locator(node, root)
    result =  node_to_leaf_counter(node, root)
    return result[0] == true ? result[1] - 1 : nil
  end

  def depth(node, root = self.root, result = nil, counter = 0)
    return result if root.nil?
    if node > root.data
      result = depth(node, root.right, result, counter = counter + 1)
    elsif node < root.data
      result = depth(node, root.left, result, counter = counter + 1)
    else
      return result = counter
    end
    result
  end

  def balanced?(root = self.root)
    return true if root.nil?

    left_height = root.left.nil? ? 0 : height(root.left.data, root)
    right_height = root.right.nil? ? 0 : height(root.right.data, root)

    current_result = (left_height - right_height).abs <= 1

    return current_result && balanced?(root.left) && balanced?(root.right)
  end

  def rebalance
    self.root = build_tree(inorder(root))
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end


  def balance(array, start = 0, end_index = array.length - 1)
    return if start > end_index
    mid = (start + end_index) / 2
    root = Node.new(array[mid])

    root.left = balance(array, start, mid - 1)
    root.right = balance(array, mid + 1, end_index)

    return root
  end

  def inorder_successor(current)
    current = current.right
    while !current.nil? && !current.left.nil?
      current = current.left
    end
    return current
  end

  def node_to_leaf_counter(node, root = self.root, result = [false, 0])
    return result if root.nil?
    result = [true, result[1]] if node == root.data

    left_longest = node_to_leaf_counter(node, root.left, [result[0], result[1] + 1])
    right_longest = node_to_leaf_counter(node, root.right, [result[0], result[1] + 1])

    return [left_longest[0] == true || right_longest[0] == true ,[left_longest[1], right_longest[1]].max]
  end

  def height_root_locator(node, root)
    return if root.nil?
    if node < root.data
      height_root_locator(node, root.left)
    elsif node > root.data
      height_root_locator(node, root.right)
    else
      return root
    end
  end

end