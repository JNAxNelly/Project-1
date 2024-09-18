require 'tk'
require_relative 'Methods1'
require_relative 'Methods3'
require_relative 'method2'
require_relative 'method4'
require_relative 'Popups'

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
methods_instance1 = Methods1.new
methods_instance2 = Method2.new
methods_instance4 = Methods4.new
popup_instance = Popups.new 

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
  tokens = expression.scan(/\d+\.?\d*|\+|\-|\*|\/|\^|\(|\)|√/) # Updated the tokenization
  
  tokens.each_with_index do |token, index|
    if token =~ /\d/ # Match numbers
      output << token
    elsif token == '('
      operator_stack.push(token)
    elsif token == ')'
      while operator_stack.last != '('
        output << operator_stack.pop
      end
      operator_stack.pop
    elsif OPERATORS[token]
      # Handle negative number cases:
      # If token is '-' and is the first character or follows an operator or '(', it's a negative sign
      if token == '-' && (index == 0 || tokens[index - 1] =~ /[\+\-\*\/\(]/)
        output << '0' # Insert a '0' to make subtraction work (e.g., 0 - 3 instead of just -3)
        operator_stack.push(token)
      else
        while !operator_stack.empty? && OPERATORS[operator_stack.last] && OPERATORS[operator_stack.last] >= OPERATORS[token]
          output << operator_stack.pop
        end
        operator_stack.push(token)
      end
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
    end
  end

  stack.pop
end

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


button_frame = TkFrame.new(root).pack
buttons = [
  ['(', ')', '√', '/'],
  ['7', '8', '9', '*'],
  ['4', '5', '6', '-'],
  ['1', '2', '3', '+'],
  ['C', '0', '=', '^'],
  ['sin', 'cos', 'tan','mean'],
  ['genOdd','genEven','Neg','median'],
  ['genSqrd','genPrime','genFib','mode'],
  ['log','max','min','binary'],
  ['!','%','cbrt','octal',],
  ['hexa','FtoC']
]

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
          popup_instance.odd_popup(methods_instance3, display)
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
          result = methods_instance1.absolute($current_input.to_f)
          display.text = result.to_s
          $current_input = result.to_s
        when 'cbrt'
          result = methods_instance1.cbrt($current_input.to_f)
          display.text = result.to_s
          $current_input = result.to_s
        when '√'
          result = methods_instance1.sqrt($current_input.to_f)
          display.text = result.to_s
          $current_input = result.to_s
        when 'genEven'
          popup_instance.even_popup(methods_instance1, display)
        when 'genSqrd'
          popup_instance.sqr_popup(methods_instance1, display)
        when '^'
          
          popup_instance.exponent_popup(methods_instance1, display)
        when 'log'
          popup_instance.log_popup(methods_instance2, display)
        when '!'
          n = $current_input.to_i
          result = methods_instance2.factorial(n)
          display.text = result.to_s
          $current_input = result.to_s
        when '%'
          popup_instance.percent_popup(methods_instance2, display)
        when 'median'
          popup_instance.median_popup(methods_instance2, display)
        when 'genPrime'
          n = $current_input.to_i
          methods_instance2.generateprime(n)
          display.text = "Primes saved"
          $current_input = ''
        when 'min'
          popup_instance.minimum_popup(methods_instance3, display)
        when 'isPrime'
          popup_instance.prime_popup(methods_instance3, display)
        when 'mode'
          popup_instance.mode_popup(methods_instance3, display)
        when 'binary'
          binary = methods_instance4.binary($current_input.to_i)
          display.text = binary
          $current_input = display.text
        when 'octal'
          octal = methods_instance4.octal($current_input.to_i)
          display.text = octal
          $current_input = display.text
        when 'hexa'
          hexa = methods_instance4.hexadecimal($current_input.to_i)
          display.text = hexa
          $current_input = display.text
        when 'mean'
          popup_instance.mean_popup(methods_instance4, display)
        when 'max'
          popup_instance.max_popup(methods_instance4, display)
        when 'genFib'
          popup_instance.fib_popup(methods_instance4, display)
        when 'FtoC'
          celsius = methods_instance4.fToC($current_input.to_i)
          display.text = "#{celsius} C"
          $current_input = display.text
        else
          update_display(button_text, display)
        end
      end
    end
  end
end

Tk.mainloop