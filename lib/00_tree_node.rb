require "byebug"

class PolyTreeNode

  attr_reader :parent, :value, :children
  attr_writer :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    # want to remove old child from parents if old parent is nil
    if self.parent == nil 
      @parent = node
      node.children << self #this above adding N3 as children of N1 
    else self.parent != nil # this below N2 adopting N3 as children from N1
      old_parent = self.parent
      # return nil if node.nil?
      # index = old_parent.children.index(self)
      # old_parent.children.slice!(index) #
      old_parent.children.delete(self)
      @parent = node
      node.children << self if !node.nil?
    end
  end

  def add_child(child)
    if !self.children.include?(child)
      child.parent = self
    end
  end

  def remove_child(child)
    self.children.delete(child)
    child.parent = nil
  end

  def dfs(target)
    return self if self.value == target
    self.children.each do |child|
      searchres = child.dfs(target)
      return searchres unless searchres == nil
    end
    nil
  end

  def bfs(target)
    queue = [self]
    # queue << self  #map { |value| self.value }
    # puts "#{queue} on line 48"
    # puts "---------------------------"
    # puts "#{target} on line 49"
    until queue.empty?
      el = queue.shift
      return el if el.value == target
      el.children.each do |child|
        queue << child
      end
    end
    nil
  end
end

# class Searchable
#   def dfs(target)

#   end

#   def bfs(target)
#     queue = []
#     queue << PolyTreeNode(value)

#   end
# end
