class RecursiveDescentParser
  #TODO Replace all match(method_name) with the tokens they contain
  private
  inputString = ""
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
    match("B")
    while token.match("statemt") do
      statemt
    end
    match("E")
    if token.match("D")
      match("D")
    end
  end

  def statemt
  end

  def asignmt
    match("A")
    ident
    match("~")
    exprsn
  end

  def ifstmt
    match("I")
    comprsn
    match("T")
    block
    if token.match("L")
      match("L")
      block
    end
  end

  def wcomprsn
    #Formerly named while, obviously a keyword so it has been renamed for clarity
    match("W")
    comprsn
    block
  end

  def inpout
    iosym
    ident
    while token.match(",") do
      match(",")
      ident
    end
  end

  def comprsn
    match("(")
    oprnd
    opratr
    oprnd
    match(")")
  end

  def exprsn
    factor
    while match(sumop) do
      sumop
      factor
    end
  end

  def factor
    oprnd
    while match(prodop) do
      prodop
      oprnd
    end
  end

  def oprnd
  end

  def ident
    letter
    while match(charter) do
      charter
    end
  end

  def charter
    #Formerly named char, obviously a keyword so it has been renamed for clarity
        match(letter) ? letter : digit
  end

  def intger
    #Formerly named integer, obviously a keyword so it has been renamed for clarity
      digit until token != match(digit)
  end

  def iosym
    token == "R" || "O" ? match(token) : error
  end

  def opratr
    if token == '<' || token == '=' || token == '>' || token == '!'
      match(token)
    else error
    end
  end

  def sumop
    token == "+" || "-" ? match(token) : error
  end

  def prodop
    token == "*" || "/" ? match(token) : error
  end

  def letter
    token == "X" || "Y" || "Z" ? match(token) : error
  end

  def digit
    token == "0" || "1" ? match(token) : error
  end
end
