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
    
    def genEven(a,b)
    end

    ##Returns the absolute value of a number a
    def absolute(a)
        numAbs = a
        if numAbs < 0
            numAbs = -a
        end
        return numAbs


    
    end 

    def genSqr(a,b)
    end






end 









