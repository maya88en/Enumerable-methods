# frozen_string_literal: true

module Enumerable
  def my_each
    (0...length).each do |i|
      yield(self[i])
    end
  end

  def my_each_with_index
    k = 0
    (0...length).each do |i|
      yield(self[i], k)
      k += 1
    end
  end

  def my_select(&block)
    result = []
    each do |element|
      result << element if block.call(element) == true
    end
    result
  end

  def my1_all?
    return true unless block_given?
    my_each { |element| return false if yield(element) == false }
    true
  end

  def my_all?(pattern = nil)
    if block_given?
      my_each { |v| return false unless yield(v) }
    elsif !pattern.nil?
      my_each { |v| return false unless pattern ==   (v.to_i) }
    else
      my_each { |v| return false unless v }
    end
    true
  end

  def my1_any?
    return true unless block_given?
    my_each { |element| return true if yield(element) }
    false
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |v| return true if yield(v) }
    elsif !pattern.nil?
      my_each { |v| return true if pattern == (v.to_i) }
    else
      my_each { |v| return true if v }
      return false
    end
    false
  end

  def my1_none?
    return true unless block_given?
    result = true
    each { |element| result = false if yield(element) }
    result
  end

  def my_none?(pattern = nil)
    if block_given?
        my_each { |v| return false if yield(v) }
    elsif !pattern.nil?
      my_each { |v| return false if pattern == (v.to_i) }
    else
      my_each { |v| return false if v }
    end
    true
  end

  def my_count(num = nil)
    count = 0
    if block_given?
      my_each { |el| count += 1 if yield el }
    elsif num
      my_each { |el| count += 1 if el == num }
    else
      count = length
    end
    count
  end

  def my_map(&block)
    result = []
    my_each do |i|
      result << block.call(i)
    end
    result
  end

  def my_inject(element = 0)
    result = element
    my_each do |i|
      result = yield(result, i)
    end
    result
  end

  def multiply_els
    my_inject(1) { |x, y| x * y }
  end
end

arr=[1,2,3,4]
puts arr.my_all?(3)

puts arr.my_any?(5)

puts arr.my_none?(5)
