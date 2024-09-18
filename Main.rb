require 'tk'
require_relative 'Methods3'
require_relative 'Method2'



# Create the main window (root)
root = TkRoot.new { title "Calculator" }

# Create a label to display the input/output
display = TkLabel.new(root) do
  text '0'
  font TkFont.new('times 20 bold')
  relief 'ridge'
  anchor 'e'
  width 20
  pack { padx 10; pady 10 }
end

$current_input = ''

OPERATORS = {
  '+' => 1,
  '-' => 1,
  '*' => 2,
  '/' => 2,
  '^' => 3,
  '√' => 4
}

methods_instance3 = Methods3.new
methods_instance2 = Method2.new

def update_display(new_value, display)
  $current_input += new_value
  display.text = $current_input
end

def clear_display(display)
  $current_input = ''
  display.text = '0'
end

def to_postfix(expression)
  output = []
  operator_stack = []
  tokens = expression.scan(/-?\d+\.?\d*|\+|\-|\*|\/|\^|\(|\)|√/)

  tokens.each_with_index do |token, index|
    if token =~ /-?\d/
      output << token
    elsif token == '('
      operator_stack.push(token)
    elsif token == ')'
      while operator_stack.last != '('
        output << operator_stack.pop
      end
      operator_stack.pop
    elsif OPERATORS[token]
      while !operator_stack.empty? && OPERATORS[operator_stack.last] && OPERATORS[operator_stack.last] >= OPERATORS[token]
        output << operator_stack.pop
      end
      operator_stack.push(token)
    end
  end

  while !operator_stack.empty?
    output << operator_stack.pop
  end

  output
end

def evaluate_postfix(postfix, methods_instance3)
  stack = []

  postfix.each do |token|
    if token =~ /-?\d/
      stack.push(token.to_f)
    elsif token == '+'
      b = stack.pop
      a = stack.pop
      stack.push(a + b)
    elsif token == '-'
      b = stack.pop
      a = stack.pop
      stack.push(a - b)
    elsif token == '*'
      b = stack.pop
      a = stack.pop
      stack.push(a * b)
    elsif token == '/'
      b = stack.pop
      a = stack.pop
      if b == 0
        return Float::INFINITY
      else
        stack.push(a / b)
      end
    elsif token == '^'
      b = stack.pop
      a = stack.pop
      stack.push(a**b)
    elsif token == '√'
      a = stack.pop
      stack.push(methods_instance3.sqrt(a))
    end
  end

  stack.pop
end



button_frame = TkFrame.new(root).pack
buttons = [
  ['(', ')', 'sqrt', '/'],
  ['7', '8', '9', '*'],
  ['4', '5', '6', '-'],
  ['1', '2', '3', '+'],
  ['C', '0', '=', '^'],
  ['sin', 'cos', 'tan','mean'],
  ['genOdd','genEven','Neg','median'],
  ['genSqrd','genPrime','genFib','mode'],
  ['log','max','min','binary'],
  ['!','%','cbrt','octal',],
  ['hexa']
]

def evaluate_expression(display, methods_instance3)
  begin
    postfix = to_postfix($current_input)
    result = evaluate_postfix(postfix, methods_instance3)

    if result == Float::INFINITY || result.nan?
      display.text = 'Error: Division by Zero'
      $current_input = ''
    else
      display.text = result.to_s
      $current_input = result.to_s
    end
  rescue
    display.text = 'Error'
    $current_input = ''
  end
end

#Nebyu Method 2 popups ------------------------------------------------
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
    text 'Enter base value:'
    pack { padx 10; pady 5 }
  end

  base_entry = TkEntry.new(popup) do
    width 10
    pack { padx 10; pady 5 }
  end

  TkLabel.new(popup) do
    text 'Enter percentage:'
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
#End of Methods 2 ------------------------------------------------


#Method 3
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

  range_label = TkLabel.new(popup) do
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

buttons.each_with_index do |row, row_index|
  row.each_with_index do |button_text, col_index|
    button = TkButton.new(button_frame) do
      text button_text
      width 5
      height 2
      font TkFont.new('times 15 bold')
      grid('row' => row_index, 'column' => col_index, 'padx' => 5, 'pady' => 5)

      command do
        case button_text
        when 'C'
          clear_display(display)
        when '='
          evaluate_expression(display, methods_instance3)
        when 'Neg'
          if !$current_input.empty?
            if $current_input[-1] =~ /[\+\-\*\/]/
              update_display('-', display)
            elsif $current_input[-1] != '('
              $current_input = "-#{$current_input}" unless $current_input.start_with?('-')
              display.text = $current_input
            end
          else
            update_display('-', display)
          end
        when 'genOdd'
          odd_popup(methods_instance3, display)
        when 'sin'
          result = methods_instance3.sin($current_input.to_f)
          display.text = result.to_s
          $current_input = result.to_s
        when 'cos'
          result = methods_instance3.cos($current_input.to_f)
          display.text = result.to_s
          $current_input = result.to_s
        when 'tan'
          result = methods_instance3.tan($current_input.to_f)
          display.text = result.to_s
          $current_input = result.to_s
        when 'abs'
          #TODO
        when 'cbrt'
          #TODO
        when 'genEven'
          #TODO
        when 'genSqrd'
          #TODO
        when 'log'
          #TODO
          # values = $current_input.split(',')
          #if values.length == 2
          #   a = values[0].to_f
          #   b = values[1].to_f
          #   result = methods_instance2.logarithm(a, b)
          #   display.text = result.to_s
          #   $current_input = result.to_s
            log_popup(methods_instance2, display)
          #else
            #display.text = 'Error: Invalid input'
            #$current_input = ''
          #end
        when '!'
          #TODO
          n = $current_input.to_i
          result = methods_instance2.factorial(n)
          display.text = result.to_s
          $current_input = result.to_s
        when '%'
          #TODO
          values = $current_input.split(',')
          #if values.length == 2
            # a = values[0].to_f
            # b = values[1].to_f
            # result = methods_instance2.percentage(a, b)
            # display.text = result.to_s + '%'
            # $current_input = result.to_s
            percent_popup(methods_instance2, display)
          #else
            #display.text = 'Error: Invalid input'
            #$current_input = ''
          #end
        when 'median'
          #TODO
          #data = $current_input.split(',').map(&:to_f)
          #result = methods_instance2.median(data)
          #display.text = result.to_s
          #$current_input = result.to_s
          median_popup(methods_instance2, display)
        when 'genPrime'
          #TODO
          n = $current_input.to_i
          methods_instance2.generateprime(n)
          display.text = "Primes saved"
          $current_input = ''
        when 'min'
          #TODO
        when 'isPrime'
          #TODO
        when 'mode'
          #TODO
        when 'binary'
          #TODO
        when 'octal'
          #TODO
        when 'hexa'
          #TODO
        when 'mean'
          #TODO
        when 'max'
          #TODO
        when 'genFib'
          #TODO
        else
          update_display(button_text, display)
        end
      end
    end
  end
end

Tk.mainloop