class RecursiveDescentParser
  private
  inputString = " "
  index = 0
  errorflag = 0

  def token
    inputString.charAt(index)
  end

  def advancePtr
    if index < (inputString.length -1)
      index += 1
    end
  end

  def match(t)
    t == token ? advancePtr : error
  end

  def error
    puts "error at position: #{index}"
    errorflag = 1
    advancePtr
  end

  def block
    match 'B'
    while token == 'A' || 'I' || 'W' || 'R' || 'B' do
      statemt
    end
    match 'E'
    if token == 'D'
      match 'D'
    end
  end

  def statemt
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
    match 'A'
    ident
    match '~'
    exprsn
  end

  def ifstmt
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
    match 'W'
    comprsn
    block
  end

  def inpout
    iosym
    ident
    while token == ',' do
      match ','
      ident
    end
  end

  def comprsn
    match '('
    oprnd
    opratr
    oprnd
    match ')'
  end

  def exprsn
    factor
    while token == '+' || '-' do
      sumop
      factor
    end
  end

  def factor
    oprnd
    while token == '*' || '/' do
      prodop
      oprnd
    end
  end

  def oprnd
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
    letter
    while token == 'X' || 'Y' ||'Z' || '0' || '1' do
      charter
    end
  end

  def charter
    #Formerly named char, obviously a keyword so it has been renamed for clarity
        token == 'X' || 'Y' ||'Z' ? letter : digit
  end

  def intger
    #Formerly named integer, obviously a keyword so it has been renamed for clarity
      digit until token != '0' || '1'
  end

  def iosym
    token == 'R' || 'O' ? match(token) : error
  end

  def opratr
   token == '<' || '=' || '>' || '!' ? match(token) : error
  end

  def sumop
    token == '+' || '-' ? match(token) : error
  end

  def prodop
    token == '*' || '/' ? match(token) : error
  end

  def letter
    token == 'X' || 'Y' || 'Z' ? match(token) : error
  end

  def digit
    token == '0' || '1' ? match(token) : error
  end
end
