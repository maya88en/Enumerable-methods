# frozen_string_literal: true

module Enumerable
  def my_each
    return true unless block_given?

    (0...length).each do |i|
      yield(self[i])
    end
  end

  def my_each_with_index
    return true unless block_given?

    k = 0
    (0...length).each do |i|
      yield(self[i], k)
      k += 1
    end
  end

  def my_select(&block)
    return true unless block_given?

    result = []
    each do |element|
      result << element if block.call(element) == true
    end
    result
  end

  def my_all?(pattern = nil)
    if block_given?
      my_each { |v| return false unless yield(v) }
    elsif !pattern.nil?
      my_each { |v| return false unless pattern == v.to_i }
    else
      my_each { |v| return false unless v }
    end
    true
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |v| return true if yield(v) }
    elsif !pattern.nil?
      my_each { |v| return true if pattern == v.to_i }
    else
      my_each { |v| return true if v }
      return false
    end
    false
  end

  def my_none?(pattern = nil)
    if block_given?
      my_each { |v| return false if yield(v) }
    elsif !pattern.nil?
      my_each { |v| return false if pattern == v.to_i }
    else
      my_each { |v| return false if v }
    end
    true
  end

  def my_count(num = nil)
    return true unless block_given?

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
    return true unless block_given?

    result = []
    my_each do |i|
      result << block.call(i)
    end
    result
  end

  def my_inject(element = 0)
    return true unless block_given?

    result = element
    my_each do |i|
      result = yield(result, i)
    end
    result
  end

  def multiply_els
    return true unless block_given?

    my_inject(1) { |x, y| x * y }
  end
end

arr = [1, 2, 3, 4]
puts arr.my_all?(3)

puts arr.my_any?(5)

puts arr.my_none?(5)

puts arr.my_inject{ |final_val, x| final_val + x }
#puts arr.my_inject { |final_val, x| final_val + x }

puts arr.my_inject(:+)
