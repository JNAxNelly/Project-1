class Popups

    def handle_median_to_file(methods_instance2, data_entry, display, popup)
      data = data_entry.value.split(',').map(&:to_f)
      result = methods_instance2.median(data)
      display.text = result.to_s
      popup.destroy
    end
  
    def median_popup(methods_instance2, display)
      popup = TkToplevel.new { title "Median Calculator" }
  
      TkLabel.new(popup) do
        text 'Enter numbers (comma-separated):'
        pack { padx 10; pady 5 }
      end
  
      data_entry = TkEntry.new(popup) do
        width 30
        pack { padx 10; pady 5 }
      end
  
      TkButton.new(popup) do
        text 'Calculate Median'
        command { handle_median_to_file(methods_instance2, data_entry, display, popup) }
        pack { padx 10; pady 10 }
      end
    end
  
    def handle_log(methods_instance2, base_entry, number_entry, display, popup)
      base = base_entry.value.to_f
      number = number_entry.value.to_f
      result = methods_instance2.logarithm(base, number)
      display.text = result.to_s
      popup.destroy
    end
  
    def log_popup(methods_instance2, display)
      popup = TkToplevel.new { title "Logarithm Calculator" }
  
      TkLabel.new(popup) do
        text 'Enter number:'
        pack { padx 10; pady 5 }
      end
  
      base_entry = TkEntry.new(popup) do
        width 10
        pack { padx 10; pady 5 }
      end
  
      TkLabel.new(popup) do
        text 'Enter base:'
        pack { padx 10; pady 5 }
      end
  
      number_entry = TkEntry.new(popup) do
        width 10
        pack { padx 10; pady 5 }
      end
  
      TkButton.new(popup) do
        text 'Calculate Log'
        command { handle_log(methods_instance2, base_entry, number_entry, display, popup) }
        pack { padx 10; pady 10 }
      end
    end
  
    def handle_percent(methods_instance2, base_entry, percent_entry, display, popup)
      base = base_entry.value.to_f
      percent = percent_entry.value.to_f
      result = methods_instance2.percentage(base, percent)
      display.text = result.to_s + '%'
      popup.destroy
    end
  
    def percent_popup(methods_instance2, display)
      popup = TkToplevel.new { title "Percentage Calculator" }
  
      TkLabel.new(popup) do
        text 'Enter numerator:'
        pack { padx 10; pady 5 }
      end
  
      base_entry = TkEntry.new(popup) do
        width 10
        pack { padx 10; pady 5 }
      end
  
      TkLabel.new(popup) do
        text 'Enter denominator:'
        pack { padx 10; pady 5 }
      end
  
      percent_entry = TkEntry.new(popup) do
        width 10
        pack { padx 10; pady 5 }
      end
  
      TkButton.new(popup) do
        text 'Calculate Percent'
        command { handle_percent(methods_instance2, base_entry, percent_entry, display, popup) }
        pack { padx 10; pady 10 }
      end
    end
  
    def handle_odd_to_file(methods_instance3, range_start, range_end, display)
      start_val = range_start.value.to_i
      end_val = range_end.value.to_i
  
      if start_val >= end_val
        display.text = "Invalid Range"
      else
        methods_instance3.generateOddToFile([start_val, end_val], "odd_numbers.txt")
        display.text = "Odd numbers saved to file."
      end
    end
  
    def odd_popup(methods_instance3, display)
      popup = TkToplevel.new { title "Odd Number Generator" }
  
      TkLabel.new(popup) do
        text 'Enter range for odd numbers:'
        font TkFont.new('times 15 bold')
        pack { padx 10; pady 5 }
      end
  
      range_start = TkEntry.new(popup) do
        width 10
        pack { padx 10; pady 5 }
      end
  
      range_end = TkEntry.new(popup) do
        width 10
        pack { padx 10; pady 5 }
      end
  
      TkButton.new(popup) do
        text 'Generate Odd Numbers'
        command { handle_odd_to_file(methods_instance3, range_start, range_end, display) }
        pack { padx 10; pady 10 }
      end
    end
  
    def handle_Even_range_to_file(methods_instance1, range_start, range_end, display)
      start_val = range_start.value.to_i
      end_val = range_end.value.to_i
  
      if start_val >= end_val
        display.text = "Invalid Range"
      else
        methods_instance1.genEven([start_val, end_val])
        display.text = "Range saved to file."
      end
    end
  
    def even_popup(methods_instance1, display)
      popup = TkToplevel.new { title "Even Number Generator" }
  
      TkLabel.new(popup) do
        text 'Enter range for Even numbers:'
        font TkFont.new('times 15 bold')
        pack { padx 10; pady 5 }
      end
  
      range_start = TkEntry.new(popup) do
        width 10
        pack { padx 10; pady 5 }
      end
  
      range_end = TkEntry.new(popup) do
        width 10
        pack { padx 10; pady 5 }
      end
  
      TkButton.new(popup) do
        text 'Generate Even Numbers'
        command { handle_Even_range_to_file(methods_instance1, range_start, range_end, display) }
        pack { padx 10; pady 10 }
      end
    end
  
    def prime_popup(methods_instance3, display)
      popup = TkToplevel.new { title "Prime Number Checker" }
  
      TkLabel.new(popup) do
        text 'Enter a number to check if it is prime:'
        font TkFont.new('times 15 bold')
        pack { padx 10; pady 5 }
      end
  
      prime_input = TkEntry.new(popup) do
        width 10
        pack { padx 10; pady 5 }
      end
  
      TkButton.new(popup) do
        text 'Check Prime'
        command {
          number = prime_input.value.to_i
          if methods_instance3.isPrime?(number)
            display.text = "#{number} is Prime"
          else
            display.text = "#{number} is not Prime"
          end
        }
        pack { padx 10; pady 10 }
      end
    end
  
    def minimum_popup(methods_instance3, display)
      popup = TkToplevel.new { title "Minimum Calculator" }
  
      TkLabel.new(popup) do
        text 'Enter a list of numbers (comma-separated):'
        font TkFont.new('times 15 bold')
        pack { padx 10; pady 5 }
      end
  
      min_input = TkEntry.new(popup) do
        width 30
        pack { padx 10; pady 5 }
      end
  
      TkButton.new(popup) do
        text 'Calculate Minimum'
        command {
          numbers = min_input.value.split(',').map(&:to_i)
          result = methods_instance3.minimum(numbers)
          display.text = "Minimum: #{result}"
        }
        pack { padx 10; pady 10 }
      end
    end
  
    def exponent_popup(methods_instance1, display)
      popup = TkToplevel.new { title "Exponent Calculator" }
  
      TkLabel.new(popup) do
        text 'Enter a base and an exponent (comma-separated):'
        font TkFont.new('times 15 bold')
        pack { padx 10; pady 5 }
      end
  
      exp_input = TkEntry.new(popup) do
        width 30
        pack { padx 10; pady 5 }
      end
  
      TkButton.new(popup) do
        text 'Calculate Exponent'
        command {
          begin
            # Split input and map to integers
            data = exp_input.value.split(',').map(&:strip)
            
            # Validate input: check if exactly two values are given and they are numeric
            if data.size != 2 || !is_numeric?(data[0]) || !is_numeric?(data[1])
              raise ArgumentError, "Invalid input"
            end
            
            base = data[0].to_f
            exponent = data[1].to_i
  
            # Perform the exponentiation
            result = methods_instance1.exponent(base, exponent)
            display.text = "Exponent: #{result}"
  
          rescue ArgumentError
            display.text = "Invalid input"
          rescue
            display.text = "Invalid input"
          end
        }
        pack { padx 10; pady 10 }
      end
    end
  
    def is_numeric?(str)
      true if Float(str) rescue false
    end
  
    def handle_mode_input(methods_instance3, mode_input, display)
      data = mode_input.value.split(',').map(&:to_i) # Convert the input to an array of integers
      if data.empty?
        display.text = "Invalid Input"
      else
        result = methods_instance3.mode(data)
        display.text = "Mode: #{result}"
      end
    end
  
    def mode_popup(methods_instance3, display)
      popup = TkToplevel.new { title "Mode Calculator" }
  
      TkLabel.new(popup) do
        text 'Enter a list of numbers (comma-separated):'
        font TkFont.new('times 15 bold')
        pack { padx 10; pady 5 }
      end
  
      mode_input = TkEntry.new(popup) do
        width 30
        pack { padx 10; pady 5 }
      end
  
      TkButton.new(popup) do
        text 'Calculate Mode'
        command { handle_mode_input(methods_instance3, mode_input, display) }
        pack { padx 10; pady 10 }
      end
    end
  
    def handle_Square_range_to_file(methods_instance1, range_start, range_end, display)
      start_val = range_start.value.to_i
      end_val = range_end.value.to_i
  
      if start_val >= end_val
        display.text = "Invalid Range"
      else
        methods_instance1.genSqrd([start_val, end_val])
        display.text = "Range saved to file."
      end
    end
  
    def sqr_popup(methods_instance1, display)
      popup = TkToplevel.new { title "Square Number Generator" }
  
      TkLabel.new(popup) do
        text 'Enter range for square numbers:'
        font TkFont.new('times 15 bold')
        pack { padx 10; pady 5 }
      end
  
      range_start = TkEntry.new(popup) do
        width 10
        pack { padx 10; pady 5 }
      end
  
      range_end = TkEntry.new(popup) do
        width 10
        pack { padx 10; pady 5 }
      end
  
      TkButton.new(popup) do
        text 'Generate square Numbers'
        command { handle_Square_range_to_file(methods_instance1, range_start, range_end, display) }
        pack { padx 10; pady 10 }
      end
    end

    #Method max for the separate GUI to take in an array
def max_popup(methods_instance4, display)
    popup = TkToplevel.new { title "Max Number Calculation"}
    #label to prompt user for entering array
    arr_label = TkLabel.new(popup) do
      text 'Enter array of numbers, separated by commas'
      font TkFont.new('times 15 bold')
      pack { padx 10; pady 5 }
    end
    #input box for array
    arr_entry = TkEntry.new(popup) do
      width 20
      pack { padx 10; pady 5 }
    end
    #button to call method and print to main calculator gui
    TkButton.new(popup) do
      text 'Calculate Max'
      command do
        input = arr_entry.value
        number_array = input.split(',').map(&:strip).map(&:to_f)
  
        max_result = methods_instance4.maximum(number_array)
        display.text = "Maximum #{max_result}"
        $current_input = max_result.to_s
      end
      pack { padx 15; pady 10 }
    end
  end
  #Method fibonacci for separate GUI to prompt limit
  def fib_popup(methods_instance4, display)
    popup = TkToplevel.new { title "Fibonacci Generator"}
    #label to ask user for limit to input
    fib_label = TkLabel.new(popup) do
      text 'Enter limit'
      font TkFont.new('times 15 bold')
      pack { padx 10; pady 5 }
    end
   #box to input limit to
    limit_entry = TkEntry.new(popup) do
      width 10
      pack { padx 10; pady 5}
    end
   #Prints a message to calculator to confirm printed to file
   TkButton.new(popup) do
     text 'Generate Fibonacci'
     command do
       input = limit_entry.value.to_i
       if input > 0
         result = methods_instance4.fibonacci(input)
         display.text = "Fib printed to file"
       else
        display.text = "Error printing fib"
       end
     end
     pack { padx 10; pady 10}
   end
  end
  
  end  # End of the class Popups
  