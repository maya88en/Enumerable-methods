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

  def my_all?
    my_each { |element| return false if yield(element) == false }
    true
  end

  def my_any?
    my_each { |element| return true if yield(element) }
    false
  end

  def my_none?
    result = true
    each { |element| result = false if yield(element) }
    result
  end

  def my_count(x = nil)
    count = 0
    if block_given?
      my_each { |el| count += 1 if yield el }
    elsif x
      my_each { |el| count += 1 if el == x }
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
