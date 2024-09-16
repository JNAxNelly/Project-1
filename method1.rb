#This file contains the first set of functions for the calculator
class Methods1
    #Category 1
    def sqrt(n)
        Math.sqrt(n)
    end

    def cbrt(n)
        Math.cbrt(n)
    end

    #Category 2

    ## Exponent (a,b) raises a to the power of b
        ## Rules : a^-b = 1/a^b , a^0 = 1 , a^1 = a
        ## counter , multiply a by a for b times 
    def exponent(a,b)

        sum = 1.0
    
        ##converting negative exponent to positive for counter
        if b >= 0
            count = b
        else 
            count = -b
        end
    
        while count > 0
            sum *= a
            count = count - 1
        end
    
        ##Accounting for negative exponent
        if b< 0 
            a = 1/sum
        else 
            a = sum 
    
        end
    
        
    end
    
    def genEven(range)
        ##Have the beginning of the and end

        rangeStrt = range[0]
        rangeEnd = range[1]

        # Check if the range is invalid (end is smaller than start)
            if rangeEnd < rangeStrt
                raise ArgumentError, "Invalid range: The end of the range (#{rangeEnd}) is smaller than the start (#{rangeStrt})."
                return              
            end

       
        ##set of even numbers 


        evenNum = []
        

        ##counter eqaul to the range from the start to the end
        max = rangeEnd - rangeStrt +1
    

        ##while loop iterating by 1? through the range
        while max > 0
            ## if the current number mod 2 == 0 then add it to array
            if rangeStrt % 2 == 0
                evenNum << rangeStrt
                
            end
            
            rangeStrt += 1
            max -= 1
            
        end     
        File.open("even_numbers.txt", "w") do |file|
            file.puts(evenNum)
        end
    end
    

     
    

    ##Returns the absolute value of a number a
    def absolute(a)
        numAbs = a
        if numAbs < 0
            numAbs = -a
        end
   







     return numAbs


    
    end 

    def genSqrd(range)
        ##Have the beginning of the and end

        rangeStrt = range[0]
        rangeEnd = range[1]

        sum = 1.0

        # Check if the range is invalid (end is smaller than start)
            if rangeEnd < rangeStrt
                raise ArgumentError, "Invalid range: The end of the range (#{rangeEnd}) is smaller than the start (#{rangeStrt})."
                return              
            end
        ##set of square numbers 


        squareNum = []

        ##counter eqaul to the range from the start to the end
        max = rangeEnd - rangeStrt +1

         ##while loop iterating by 1 through the range
         while max > 0
           ##multiply the current number by itself
           sum = rangeStrt * rangeStrt

            squareNum << sum
            
            rangeStrt += 1
            max -= 1
            
        end     

        ##write the square numbers to a file
        File.open("square_numbers.txt", "w") do |file|
            file.puts(squareNum)
        end




    end


    

    






end 

