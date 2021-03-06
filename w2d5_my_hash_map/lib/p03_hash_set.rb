require_relative 'p02_hashing'
require 'byebug'
class HashSet

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
    unless self[num].include?(num)
      # if key == []
      #   self[num] = []
      # else
        self[num].push(num)
        @count += 1
        resize! if @count >= num_buckets
      # end
    end
  end

  def include?(key)
    # byebug
    num = key.hash
    # return true if num == 34315
    self[num].any?{|nums| nums == num }
  end

  def remove(key)
    num = key.hash
    self[num].delete(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num%num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_arr = Array.new(num_buckets * 2) { Array.new }
    old_arr = @store.dup
    @store = new_arr
    old_arr.each do |bucket|
      bucket.each do |el|
        @store[el%num_buckets].push(el)
      end
    end
  end
end

set = HashSet.new
set.insert(50)
set.insert("howdy")
set.insert([])
set.insert({:a => 3, :b => 4})

p set.include?([]) #(true)
p set.include?([[]])#(false)
