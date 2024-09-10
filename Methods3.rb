# This file contains the methods for the third set of functions in the calculator.

# Category 1
def sin(n)
  Math.sin(n)
end

def cos(n)
  Math.cos(n)
end

def tan(n)
  Math.tan(n)
end

# Category 2
def isPrime(n)

end

def minimum(data)
  if data.length == 0
    puts "Error: Empty data."
    return nil
  end

  min = data[0]
  i = 1
  while i < data.length
    if data[i] < min
      min = data[i]
    end
    i += 1
  end
  min
end

def generateOddToFile(range, filename)

end 

def mode(data)
if data.length == 0
    puts "Error: Empty data."
    return nil
  end

i = 0
while i < data.length
    if data[i]
end
