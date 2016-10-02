class RecursiveDescentParser
  private
  inputString = ""
  index = 0
  errorflag = 0
  @token = token

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
    while @token.match("statemt") do
      statemt
    end
    match("E")
    if @token.match("D")
      match("D")
    end
  end

  def statemt
  end

  def asignmt
  end

  def ifstmt
  end

  def wcomprsn
    #Formerly named while, obviously a keyword so it has been renamed for clarity
  end

  def inpout
  end

  def comprsn
  end

  def exprsn
  end

  def factor
  end

  def oprnd
  end

  def ident
  end

  def charter
    #Formerly named char, obviously a keyword so it has been renamed for clarity
  end

  def intger
    #Formerly named integer, obviously a keyword so it has been renamed for clarity
  end

  def iosym
  end

  def opratr
  end

  def sumop
  end

  def prodop
  end

  def letter
  end

  def digit
  end
end
