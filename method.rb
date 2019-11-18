# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    (0...length).each do |i|
      yield(self[i])
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    k = 0
    (0...length).each do |i|
      yield(self[i], k)
      k += 1
    end
  end

  def my_select(&block)
    return to_enum unless block_given?

    result = []
    each do |element|
      result << element if block.call(element) == true
    end
    result
  end

  def my_all?(pattern = nil)
    i = 0
    ar = self

    while i < ar.size
      if block_given? == true
        return false unless yield(ar[i])
      elsif pattern.class == Class
        return false unless ar[i].class.ancestors.include? pattern
      elsif pattern.class == Regexp
        return false unless ar[i] =~ pattern
      elsif pattern.nil? == true
        return false unless ar[i]
      else
        return false unless pattern[i] == ar[i]
      end
      i += 1
    end
    true
  end

  def my_any?(pattern = nil)
    i = 0
    ar = self
    while i < ar.size
      if block_given? == true
        return true if yield(ar[i])
      elsif pattern.class == Class
        return true if ar[i].class.ancestors.include? pattern
      elsif pattern.class == Regexp
        return true if ar[i] =~ pattern
      elsif pattern.nil? == true
        return true if ar[i]
      elsif pattern[i] == ar[i]
        return true
      end

      i += 1
    end
    false
  end

  def my_none?(pattern = nil)
    i = 0
    ar = self
    while i < ar.size
      if block_given? == true
        return false if yield (ar[i])
      elsif pattern.class == Class
        return false if ar[i].class.ancestors.include? pattern
      elsif pattern.class == Regexp
        return false if ar[i] =~ pattern
      elsif pattern.nil? == true
        return false if ar[i]
      elsif pattern[i] == ar[i]
        return false
      end

      i += 1
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
    return to_enum unless block_given?

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

#puts [1,2,3,4].my_each

#puts [1,2,3,4].my_each_with_index

#puts [1,2,3,4].my_select

#puts [1,2,3,4].my_map

# puts [1, 3.14, 42].my_all?(Integer)
# puts [1, 2, 3, 4].my_all?(Integer)

# puts ['ant', 'bear', 'cat'].my_all?(/t/)

# puts ['ant', 'tuna', 'cat'].my_all?(/t/)

# puts [1, 3.14, 42].my_any?(Integer)

# puts ['text', true, nil, 4.32].my_any?(Integer)

# puts ['ant', 'bear', 'boy'].my_any?(/t/)

# puts ['car', 'bear', 'boy'].my_any?(/t/)

#p [1,2,3,4].my_any?(4)

#p [1,2,3,5].my_any?(4)

# puts [1, 3.14, 42].my_none?(Integer) 

#puts [1, 3.14, 42].my_none?(String)

# p ['ant', 'bear', 'boy'].my_none?(/t/)

#p ['car', 'bear', 'boy'].my_none?(/t/)

#p [5, 6, 7, 8, 9, 10].inject { |sum, n| sum + n }

#p [5, 6, 7, 8, 9, 10].inject(:+)

# puts arr.my_all?(3)

# puts arr.my_any?(5)

# puts arr.my_none?(5)

# puts arr.my_inject { |final_val, x| final_val + x }

# puts arr.my_inject(:+)

#puts arr.my_count

#puts arr.my_inject{ |final_val, x| final_val + x }
#puts arr.my_inject { |final_val, x| final_val + x }
#puts arr.count

# puts arr.count == arr.my_count
