import java.io.*;
import java.util.Scanner;
//--------------------------------------------
// Recognizer for simple expression grammar
// Written by Alexa Bennett  10/06/16
//
// to run on Athena (linux) -
//    save as:  Recognizer.java
//    compile:  javac Recognizer.java
//    execute:  java Recognizer
// EBNF Grammar is -
//   block   ::= B {statemt} E [D]
//   statemt ::= asignmt | ifstmt | while | inpout | block
//   asignmt ::= A ident ~ exprsn
//   ifstmt  ::= I comprsn T block [L block]
//   while   ::= W comprsn block
//   inpout  ::= iosym ident {, ident}
//   comprsn ::= ( oprnd opratr oprnd )
//   exprsn  ::= factor {sumop factor}
//   factor  ::= oprnd {prodop oprnd}
//   oprnd   ::= integer | ident | ( exprsn )
//   ident   ::= letter {char}
//   char    ::= letter | digit
//   integer ::= digit {digit}
//   iosym   ::= R | O
//   opratr  ::= < | = | > | !
//   sumop   ::= + | -
//   prodop  ::= * | /
//   letter  ::= X | Y | Z
//   digit   ::= 0 | 1
//--------------------------------------------

public class Recognizer {
  static String inputString;
  static int index = 0;
  static int errorflag = 0;

  private char token() {
    return (inputString.charAt(index));
  }

  private void advancePtr() {
    if (index < (inputString.length() - 1))
    index++;
  }

  private void match(char T) {
    if (T == token())
    advancePtr();
    else
    error();
  }

  private void error() {
    System.out.println("error at position: " + index);
    errorflag = 1;
    advancePtr();
  }
// ----------------------
  private void block(){
    match('B');
    do{ statemt(); }while ((token() == 'A')
    || (token() == 'I')
    || (token() == 'W')
    || (token() == 'R')
    || (token() == 'O')
    || (token() == 'B'));
    match('E');
    if (token() == 'D')
    match('D');
  }

  private void statemt(){
    if (token() == 'A')
    asignmt();
    else if (token() == 'I')
    ifstmt();
    else if (token() == 'W')
    wcomprsn();
    else if (token() =='R')
    inpout();
    else if (token() =='B')
    block();
    else error();
  }

  private void asignmt(){
    match('A');
    ident();
    match('~');
    exprsn();
  }

  private void ifstmt(){
    match('I');
    comprsn();
    match('T');
    block();
    if (token() == 'L'){
      match('L');
      block();
    }
  }

  private void wcomprsn(){
    //Formerly named while, obviously a keyword so it has been renamed for clarity
    match('W');
    comprsn();
    block();
  }

  private void inpout(){
    iosym();
    ident();
    while (token() == ','){
      match(',');
      ident();
    }
  }

  private void comprsn(){
    match('(');
    oprnd();
    opratr();
    oprnd();
    match(')');
  }

  private void exprsn(){
    factor();
    while ((token() == '+')
    || (token() == '-')){
      sumop();
      factor();
    }
  }

  private void factor(){
    oprnd();
    while ((token() == '*') || (token() =='/')){
      prodop();
      oprnd();
    }
  }

  private void oprnd() {
    if ((token() == '0') || (token() == '1'))
    intger();
    else if ((token() == 'X') || (token() == 'Y') || (token() == 'Z'))
    ident();
    else if (token() == '(') {
      match('(');
      exprsn();
      match(')');
    } else
    error();
  }

  private void ident(){
    letter();
    while ((token() == '0')
    || (token() == '1')
    || (token() == 'X')
    || (token() == 'Y')
    || (token() == 'Z')
    || (token() == '(')) charter();
  }

  private void charter(){
    //Formerly named char, obviously a keyword so it has been renamed for clarity
    if ((token() == 'X')
    || (token() == 'Y')
    || (token() == 'Z')) letter(); else digit();
  }

  private void intger(){
    //Formerly named integer, obviously a keyword so it has been renamed for clarity
    do{ digit(); }while ((token() == '0') || (token() == '1'));
  }

  private void iosym(){
    if ((token() == 'R') || (token() == 'O')) match(token()); else error();
  }

  private void opratr(){
    if ((token() == '<')
    || (token() == '=')
    || (token() == '>')
    || (token() == '!')) match(token()); else error();
  }

  private void sumop(){
    if ((token() == '+')
    || (token() == '-')) match(token()); else error();
  }

  private void prodop(){
    if ((token() == '*')
    || (token() == '/')) match(token()); else error();
  }

  private void letter(){
    if ((token() == 'X')
    || (token() == 'Y')
    || (token() == 'Z')) match(token()); else error();
  }

  private void digit(){
    if ((token() == '0')
    || (token() == '1')) match(token()); else error();
  }
  // ----------------------
  private void start() {
    block();
    match('$');

    if (errorflag == 0)
    System.out.println("legal." + "\n");
    else
    System.out.println("errors found." + "\n");
  }

// ----------------------
  public static void main(String[] args) throws IOException {
    Recognizer rec = new Recognizer();

    Scanner input = new Scanner(System.in);

    System.out.print("\n" + "enter an expression: ");
    inputString = input.nextLine();

    rec.start();
  }
}
