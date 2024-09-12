class Method2

#Calculates the logarithm of a number with a specified base
def logarithm(a, b)
  if b <= 0 || b == 1
    puts "Error: base must be positive and not equal to 1 or 0"
    return
  end

  if a <= 0
    puts "Error: input must be positive"
    return
  end 

  Math.log(a, b)
  end

#Returns the factorial of a non-negative integer n
def factorial(n)
  if n < 0
    puts "Input cannot be negative"
    return
  end

  if n == 0 || n == 1
    return 1
  else
    return n * factorial(n-1)
  end
end


#Calculates what percentage a is of b
def percentage(a, b)
  percentage = nil
  if b == 0
    puts "Error division by zero not allowed"
  else
    percentage = (a.to_f / b) * 100
  end
  return percentage
end
 

#Implemented bubble sort in order to sort data for median
def sort(array)
  n = array.length
  swapped = true
  while swapped do
    swapped = false
    i = 0
    while i < n - 1 do
      if array[i] > array[i+1]
        array[i], array[i+1] = array[i+1], array[i]
        swapped = true
      end
      i += 1
    end
  end
  array
end


#Calculates the median of the data set
def median(data)
    data.sort!
    len=data.length
    if len % 2 == 0
      return (data[len/2 - 1].to_f + data[len/2]) / 2.0
    else
      return data[len/2]
    end
  end


 
#Checks if a number is prime
def isPrime?(n)
    if n <= 1
      return false
    end
    if n == 2
      return true
    end
    if n % 2 == 0
      return false
    end
    i = 3
    while i <= Math.sqrt(n)
      if n % i == 0
        return false
      end
      i += 2
    end
    return true
  end


#Generate all prime numbers less than a given number and save them to a file
def generateprime(num)
  n = 2
  file = File.open("primes.txt", "w")
  while n < num
    if isPrime?(n)
      file.puts(n)
    end
  n += 1
  end

  file.close()
  puts "Primes less than #{num} have been saved to primes.txt." 

  end

end

