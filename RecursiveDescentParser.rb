class RecursiveDescentParser
  #private
  $index = 0
  @@errorFlag = 0

  def token
    $inputString[$index]
  end

  def advancePtr
    if $index < (($inputString.length) -1)
        $index += 1
      puts "Pointer advanced"
    end
  end

  def match(t)
    puts "reached match #{token} with index #{$index}"
    t == token ? advancePtr : error
    if token == '$'
      if @@errorFlag == 0
        puts "Legal.\n"
      else puts "Errors found.\n Error at position: #{$index}. Error Code #{@@errorFlag}"
      end
      exit
    end
  end

  def error
    puts "error at position: #{$index}"
    @@errorFlag = 1
    advancePtr
    exit
  end

  def block
    puts "Reached block"
    match 'B'
    while token == 'A' || 'I' || 'W' || 'R' || 'B' do
      puts "reached block while loop"
      statemt
    end
    match 'E'
    if token == 'D'
      match 'D'
    end
  end

  def statemt
    puts "Reached statemt"
    if token == 'A'
      asignmt
    elsif token == 'I'
      ifstmt
    elsif token == 'W'
      wcomprsn
    elsif token == 'R'
      inpout
    elsif token == 'B'
      block
    else error
    end
  end

  def asignmt
    puts "reached asignmt"
    match 'A'
    ident
    match '~'
    exprsn
  end

  def ifstmt
    puts "reached ifstmt"
    match 'I'
    comprsn
    match 'T'
    block
    if token == 'L'
      match 'L'
      block
    end
  end

  def wcomprsn
    #Formerly named while, obviously a keyword so it has been renamed for clarity
    puts "reached wcomprsn"
    match 'W'
    comprsn
    block
  end

  def inpout
    puts "reached inpout"
    iosym
    ident
    while token == ',' do
      match ','
      ident
    end
  end

  def comprsn
    puts "reached comprsn"
    match '('
    oprnd
    opratr
    oprnd
    match ')'
  end

  def exprsn
    "puts reached exprsn"
    factor
    while token == '+' || '-' do
      sumop
      factor
    end
  end

  def factor
    puts "reached factor"
    oprnd
    while token == '*' || '/' do
      prodop
      oprnd
    end
  end

  def oprnd
    puts "reached oprnd"
    if token == '0' || '1'
      integer
    elsif token == 'X' || 'Y' ||'Z'
      ident
    elsif token == '('
      match '('
      exprsn
      match ')'
    else
        error
    end
  end

  def ident
    puts "reached ident"
    letter
    while token == 'X' || 'Y' ||'Z' || '0' || '1' do
      charter
    end
  end

  def charter
    puts "reached charter"
    #Formerly named char, obviously a keyword so it has been renamed for clarity
        token == 'X' || 'Y' ||'Z' ? letter : digit
  end

  def intger
    puts "reached intger"
    #Formerly named integer, obviously a keyword so it has been renamed for clarity
      digit until token != '0' || '1'
  end

  def iosym
    puts "reached iosym"
    token == 'R' || 'O' ? match(token) : error
  end

  def opratr
    puts "reached opratr"
   token == '<' || '=' || '>' || '!' ? match(token) : error
  end

  def sumop
    puts "reached sumop"
    token == '+' || '-' ? match(token) : error
  end

  def prodop
    puts "reached prodop"
    token == '*' || '/' ? match(token) : error
  end

  def letter
    "puts reached letter"
    token == 'X' || 'Y' || 'Z' ? match(token) : error
  end

  def digit
    puts "reached digit"
    token == '0' || '1' ? match(token) : error
  end
public
  def start
    puts "reached start"
    block
    match '$'
  end
end

puts "\nEnter an expression: "
$inputString = gets.chomp
token = $inputString[$index]
rdp = RecursiveDescentParser.new
rdp.start
puts "#{token}"
