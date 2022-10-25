package cup.example;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;
import java_cup.runtime.Symbol;
import java.lang.*;
import java.io.InputStreamReader;

%%

%class Lexer
%implements sym
%public
%unicode
%line
%column
%cup
%char
%{
	

    public Lexer(ComplexSymbolFactory sf, java.io.InputStream is){
		this(is);
        symbolFactory = sf;
    }
	public Lexer(ComplexSymbolFactory sf, java.io.Reader reader){
		this(reader);
        symbolFactory = sf;
    }
    
    private StringBuffer sb;
    private ComplexSymbolFactory symbolFactory;
    private int csline,cscolumn;

    public Symbol symbol(String name, int code){
		return symbolFactory.newSymbol(name, code,
						new Location(yyline+1,yycolumn+1, yychar), // -yylength()
						new Location(yyline+1,yycolumn+yylength(), yychar+yylength())
				);
    }
    public Symbol symbol(String name, int code, String lexem){
	return symbolFactory.newSymbol(name, code, 
						new Location(yyline+1, yycolumn +1, yychar), 
						new Location(yyline+1,yycolumn+yylength(), yychar+yylength()), lexem);
    }
    
    protected void emit_warning(String message){
    	System.out.println("scanner warning: " + message + " at : 2 "+ 
    			(yyline+1) + " " + (yycolumn+1) + " " + yychar);
    }
    
    protected void emit_error(String message){
    	System.out.println("scanner error: " + message + " at : 2" + 
    			(yyline+1) + " " + (yycolumn+1) + " " + yychar);
    }
%}

Newline    = \r | \n | \r\n
Whitespace = [ \t\f] | {Newline}
Number     = [0-9]+



/* comments: WE DON'T HAVE END OF LINE COMMENTS IN HTML,  */
Comment = {HtmlComment}
HtmlComment = "<!--" {CommentContent} \*+ "-->"
CommentContent = ( [^*] | \*+[^*/] )*




ident = ([:jletter:] | "_" ) ([:jletterdigit:] | [:jletter:] | "_" )*


%eofval{
    return symbolFactory.newSymbol("EOF",sym.EOF);
%eofval}

%state CODESEG

%%  

    /* keywords: https://www.w3.org/TR/1998/NOTE-compactHTML-19980209/*/
    <YYINITIAL> "!-"           {return symbolFactory.newSymbol("!-", !-); }
    <YYINITIAL> "!DOCTYPE"     {return symbolFactory.newSymbol("!DOCTYPE", !DOCTYPE); }
    <YYINITIAL> "&xxx"         {return symbolFactory.newSymbol("&xxx", &xxx); }
    <YYINITIAL> "A"            {return symbolFactory.newSymbol("A", A); }
    <YYINITIAL> "BASE"         {return symbolFactory.newSymbol("BASE", BASE); }
    <YYINITIAL> "BLOCKQUOTE"   {return symbolFactory.newSymbol("BLOCKQUOTE", BLOCKQUOTE); }
    <YYINITIAL> "BODY"         {return symbolFactory.newSymbol("BODY", BODY); }
    <YYINITIAL> "BR"           {return symbolFactory.newSymbol("BR", BR); }
    <YYINITIAL> "BUTTON"       {return symbolFactory.newSymbol("BUTTON", BUTTON); }
    <YYINITIAL> "CENTER"       {return symbolFactory.newSymbol("CENTER", CENTER); }
    <YYINITIAL> "DD"           {return symbolFactory.newSymbol("DD", DD); }
    <YYINITIAL> "DIR"          {return symbolFactory.newSymbol("DIR", DIR); }
    <YYINITIAL> "DIV"          {return symbolFactory.newSymbol("DIV", DIV); }
    <YYINITIAL> "DL"           {return symbolFactory.newSymbol("DL", DL); }
    <YYINITIAL> "DT"           {return symbolFactory.newSymbol("DT", DT); }
    <YYINITIAL> "FORM"         {return symbolFactory.newSymbol("FORM", FORM); }
    <YYINITIAL> "HEAD"         {return symbolFactory.newSymbol("HEAD", HEAD); }
    <YYINITIAL> "H1"           {return symbolFactory.newSymbol("H1", H1); }
    <YYINITIAL> "H2"           {return symbolFactory.newSymbol("H2", H2); }
    <YYINITIAL> "H3"           {return symbolFactory.newSymbol("H3", H3); }
    <YYINITIAL> "H4"           {return symbolFactory.newSymbol("H4", H4); }
    <YYINITIAL> "H5"           {return symbolFactory.newSymbol("H5", H5); }
    <YYINITIAL> "H6"           {return symbolFactory.newSymbol("H6", H6); }
    <YYINITIAL> "HR"           {return symbolFactory.newSymbol("HR", HR); }
    <YYINITIAL> "HTML"         {return symbolFactory.newSymbol("HTML", HTML); }
    <YYINITIAL> "IMG"          {return symbolFactory.newSymbol("IMG", IMG); }
    <YYINITIAL> "INPUT"        {return symbolFactory.newSymbol("INPUT", INPUT); }
    <YYINITIAL> "LI"           {return symbolFactory.newSymbol("LI", LI); }
    <YYINITIAL> "MENU"         {return symbolFactory.newSymbol("MENU", MENU); }
    <YYINITIAL> "META"         {return symbolFactory.newSymbol("META", META); }
    <YYINITIAL> "OL"           {return symbolFactory.newSymbol("OL", OL); }
    <YYINITIAL> "OPTION"       {return symbolFactory.newSymbol("OPTION", OPTION); }
    <YYINITIAL> "P"            {return symbolFactory.newSymbol("P", P); }
    <YYINITIAL> "PLAINTEXT"    {return symbolFactory.newSymbol("PLAINTEXT", PLAINTEXT); }
    <YYINITIAL> "PRE"          {return symbolFactory.newSymbol("PRE", PRE); }
    <YYINITIAL> "SELECT"       {return symbolFactory.newSymbol("SELECT", SELECT); }
    <YYINITIAL> "SCRIPT"       {return symbolFactory.newSymbol("SCRIPT", SCRIPT); }
    <YYINITIAL> "STYLE"        {return symbolFactory.newSymbol("STYLE", STYLE); }
    <YYINITIAL> "SPAN"         {return symbolFactory.newSymbol("SPAN", SPAN); }
    <YYINITIAL> "TEXTAREA"     {return symbolFactory.newSymbol("TEXTAREA", TEXTAREA); }
    <YYINITIAL> "TITLE"        {return symbolFactory.newSymbol("TITLE", TITLE); }
    <YYINITIAL> "UL"           {return symbolFactory.newSymbol("UL", UL); }


    <YYINITIAL> {
      /* identifiers */
      {Identifier}                   { return symbol(sym.IDENTIFIER); }

      /* literals */
      {DecIntegerLiteral}            { return symbol(sym.INTEGER_LITERAL); }
      \"                             { string.setLength(0); yybegin(STRING); }

      /* comments */
      {Comment}                      { /* ignore */ }

      /* whitespace */
      {WhiteSpace}                   { /* ignore */ }
    }

    <STRING> {
      \"                             { yybegin(YYINITIAL);
                                       return symbol(sym.STRING_LITERAL,
                                       string.toString()); }
      [^\n\r\"\\]+                   { string.append( yytext() ); }
      \\t                            { string.append('\t'); }
      \\n                            { string.append('\n'); }

      \\r                            { string.append('\r'); }
      \\\"                           { string.append('\"'); }
      \\                             { string.append('\\'); }
    }

    /* error fallback */
    [^]                              { throw new Error("Illegal character <"+
                                                        yytext()+">"); }
