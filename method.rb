module Enumerable
    def my_each
        for i in 0...self.length
        yield(self[i])
        end
    end
         
    def my_each_with_index
        k =0;
        for i in 0...self.length
        yield(self[i],k)
        k+=1
    end
    end
         
    def my_select(&block)
        result =[]
        self.each do |element|
          result << element if block.call(element) == true
    end
        result
    end

    def my_all?
        self.my_each { |element| return false if yield(element) == false}
        true
    end


    def my_any?
        self.my_each { |element| return true if yield(element)}
        false
    end
        

    def my_none?
        none = false
        my_each do |element|
        if yield(element)
                none = false
                break
        end
    end
        none
    end

    def my_count
        count = 0
        self.my_each do |element| count += 1
      
        end
         count
    end

    def my_map(&block)
    result =[]
    self.my_each do |i|
    result << block.call(i)
    end
    result
    end


    def my_inject element=0
    result = element
    self.my_each do |i|
      result = yield(result, i)
    end
    result
    end

    def multiply_els
    self.my_inject(1){|x, y| x * y}
    end

end
puts [2,4,5].multiply_els  
