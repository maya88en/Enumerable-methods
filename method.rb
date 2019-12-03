# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    arr = to_a
    i = 0
    while i < arr.length
      yield(arr[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    arr = to_a.dup
    k = 0
    i = 0
    while i < arr.length
      yield(arr[i], k)
      i += 1
      k += 1
    end
    self
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
    if block_given?
      my_each { |i| return false unless yield(i) }
    elsif pattern.nil? == true
      my_each { |i| return false unless i }
    else
      my_each { |i| return false unless pattern === i }
    end
    true
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |i| return true if yield(i) }
    elsif pattern.nil?
      my_each { |i| return true if i }
    else
      my_each { |i| return true if pattern === i }
    end
    false
  end

  def my_none?(pattern = nil, &block)
    !my_any?(pattern, &block)
  end

  def my_count(num = nil)
    count = 0
    if block_given?
      my_each { |el| count += 1 if yield el }
    elsif num
      my_each { |el| count += 1 if el == num }
    else
      my_each { count += 1 }
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

  def my_inject(maya = nil, sym = nil)
    return my_inject(nil, maya) if maya.is_a? Symbol
    
    return my_inject(maya) { |m, e| :*.to_proc.call(m, e) } unless sym.nil?
    return my_inject(maya) { |m, e| :+.to_proc.call(m, e) } unless sym.nil?
    my_each { |e| maya = maya.nil? ? first : yield(maya, e) }
    maya
    end

  end
  
def multiply_els(array)
   array.my_inject(1) { |x, y| x * y }
end

#arr = [1, 2, 3, 4]

# puts [1,2,3,4].my_each

# puts [1,2,3,4].my_each_with_index

# puts [1,2,3,4].my_select

# puts [1,2,3,4].my_map

# puts [1, 3.14, 42].my_all?(Integer)
# puts [1, 2, 3, 4].my_all?(Integer)

# puts ['ant', 'bear', 'cat'].my_all?(/t/)

# puts ['ant', 'tuna', 'cat'].my_all?(/t/)

# puts [1, 3.14, 42].my_any?(Integer)

# puts ['text', true, nil, 4.32].my_any?(Integer)

# puts ['ant', 'bear', 'boy'].my_any?(/t/)

# puts ['car', 'bear', 'boy'].my_any?(/t/)

# p [1,2,3,4].my_any?(4)

# p [1,2,3,5].my_any?(4)

# puts [1, 3.14, 42].my_none?(Integer)

# puts [1, 3.14, 42].my_none?(String)

# p ['ant', 'bear', 'boy'].my_none?(/t/)

# p ['car', 'bear', 'boy'].my_none?(/t/)

#  p [5, 6, 7, 8, 9, 10].inject { |sum, n| sum + n }

#  p [5, 6, 7, 8, 9, 10].inject(:+)

# puts arr.my_all?(3)

# puts arr.my_any?(5)

# puts arr.my_none?(5)

# puts arr.my_inject { |final_val, x| final_val + x }

# puts arr.my_inject(:+)

# puts arr.my_count

# puts arr.my_inject{ |final_val, x| final_val + x }
# puts arr.my_inject { |final_val, x| final_val + x }
# puts arr.count

# puts arr.count == arr.my_count

# p (%w[ant bear cat].my_all? { |word| word.length >= 3 })
# #=> true
# p %w[ant bear cat].my_all? { |word| word.length >= 4 }
# #=> false
# p %w[ant bear cat].my_all?(/t/)
# #=> false
# p [1, 2i, 3.14].my_all?(Numeric)
# #=> true
# p [nil, true, 99].my_all?
# #=> false
# p [].my_all?
# #=> true

# p %w[ant bear cat].my_any? { |word| word.length >= 3 }
# #=> true
# p %w[ant bear cat].my_any? { |word| word.length >= 4 }
# #=> true
# p %w[ant bear cat].my_any?(/d/)
# #=> false
# p [nil, true, 99].my_any?(Integer)
# #=> true
# p [nil, true, 99].my_any?
# #=> true
# p [].my_any?
# #=> false

# p %w[ant bear cat].my_none? { |word| word.length == 5 }
# #=> true
# p %w[ant bear cat].my_none? { |word| word.length >= 4 }
# #=> false
# p %w[ant bear cat].my_none?(/d/)
# #=> true
# p [1, 3.14, 42].my_none?(Float)
# #=> false
# p [].my_none?
# #=> true
# p [nil].my_none?
# #=> true
# p [nil, false].my_none?
# #=> true
# p [nil, false, true].my_none?
# #=> false

#p multiply_els([2, 4, 5]) #=> 40

# ary = [1, 2, 4, 2]
# p ary.my_count               
# #=> 4
# p ary.my_count(2)            
# #=> 2
# p ary.my_count{ |x| x%2==0 } 
# #=> 3
# p (0..9).my_count
# #=> 10

# p [1, 2, 3, 4, 4, 5].my_inject(:+)
# p [1, 2, 3, 4, 4, 5].inject(:+)

# # Sum some numbers
# p (5..10).my_inject(:+)
# #=> 45
# # Same using a block and inject
# p (5..10).my_inject { |sum, n| sum + n }
# #=> 45
# # Multiply some numbers
# p (5..10).my_inject(1, :*) 
# #=> 151200
# # Same using a block
# p (5..10).my_inject(1) { |product, n| product * n } 
# #=> 151200
# # find the longest word
# longest = %w[cat sheep bear].my_inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
# p longest 
# #=> "sheep"

 range = Range.new(5, 50)
p range.inject(2, :+)
p range.my_inject(2, :+)

p [2, 3, 4].my_inject(:+)
