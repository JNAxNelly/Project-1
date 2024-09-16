class Methods4
#Category 1 method no. 4
#binary converter 
    def binary(num)
    num.to_s(2)
    end
#octal converter
    def octal(num)
    num.to_s(8)
    end
#hexadecimal converter
    def hexadecimal(num)
    num.to_s(16)
    end

#Category 2 methods no. 4
#mean calculation
    def mean(data)
        if data.length == 0
            return "Error calculating mean"
        end
    total = 0
    i = 0
        while i < data.length
        total += data[i]
        i += 1
        end
    average = total / data.length.to_f

        return average
    end
#maximum calculation
    def maximum(data)
        if data.length == 0 
            return "Error calculating maximum"
        end
    max = 0
    tempMax = 0
    i = 0
        while i < data.length
            if tempMax < data[i]
            tempMax = data[i]
            end
        i += 1
        end
    max = tempMax
        return tempMax
    end
#fibonacci calculation
    def fibonacci(limit)
        if limit <= 0
            return "Error calculating fibonacci"
        end
    fib = Array.new
    num1 = 1
    num2 = 0
    num3 = 0
        while (num1 < limit)
        num3 = num1 
        num1 = num2 + num1
        num2 = num3
        fib.push(num1)
        end
        return fib
    end
#fahrenheit to celsius calculation
    def fToC(degree)
        return (degree - 32) * (5/9.to_f)
    end
end
methodsTest = Methods4.new
puts(methodsTest.maximum([1,8,3,4,5,6]))
puts(methodsTest.mean([1,2,3,4,5,6]))
puts(methodsTest.fToC(49))
puts(methodsTest.fibonacci(9))