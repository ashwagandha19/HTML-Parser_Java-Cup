package cup.example;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import java_cup.runtime.*;

class Driver {

	public static void main(String[] args) throws Exception {
		  ComplexSymbolFactory symbolFactory = new ComplexSymbolFactory();
		  File file = new File("input.txt");
		  FileInputStream fis = null;
		  try {
		    fis = new FileInputStream(file);
		  } catch (IOException e) {
		    e.printStackTrace();
		  } 
		  Lexer lexer = new Lexer(symbolFactory,fis);
		  Symbol sym;
		  while((sym = lexer.next_token()).sym != 0) {
			  System.out.println(sym);
		  }
		  Parser parser = new Parser();
		  parser.debug_parse();
	}
}