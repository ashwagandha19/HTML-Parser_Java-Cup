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
%caseless
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
    /*directiva prin care sa fie ignorat cae*/
    <YYINITIAL> {
      {Whitespace}    {                              }
      "!-"           {return symbolFactory.newSymbol("!-", !-); }
      "!DOCTYPE"     {return symbolFactory.newSymbol("!DOCTYPE", !DOCTYPE); }
      "&xxx"         {return symbolFactory.newSymbol("&xxx", &xxx); }
      "A"            {return symbolFactory.newSymbol("A", A); }
      "ABBR"         {return symbolFactory.newSymbol("ABBR", ABBR); }
      "ACRONYM"      {return symbolFactory.newSymbol("ACRONYM", ACRONYM); }
      "ADDRESS"      {return symbolFactory.newSymbol("ADDRESS", ADDRESS); }
      "APPLET"       {return symbolFactory.newSymbol("APPLET", APPLET); }
      "AREA"         {return symbolFactory.newSymbol("AREA", AREA); }
      "B"            {return symbolFactory.newSymbol("B", B); }
      "BASE"         {return symbolFactory.newSymbol("BASE", BASE); }
      "BASEFONT"     {return symbolFactory.newSymbol("BASEFONT", BASEFONT); }
      "BDO"          {return symbolFactory.newSymbol("BDO", BDO); }
      "BIG"          {return symbolFactory.newSymbol("BIG", BIG); }
      "BLOCKQUOTE"   {return symbolFactory.newSymbol("BLOCKQUOTE", BLOCKQUOTE); }
      "BODY"         {return symbolFactory.newSymbol("BODY", BODY); }
      "BR"           {return symbolFactory.newSymbol("BR", BR); }
      "BUTTON"       {return symbolFactory.newSymbol("BUTTON", BUTTON); }
      "CAPTION"      {return symbolFactory.newSymbol("CAPTION", CAPTION); }
      "CENTER"       {return symbolFactory.newSymbol("CENTER", CENTER); }
      "CITE"         {return symbolFactory.newSymbol("CITE", CITE); }
      "CODE"         {return symbolFactory.newSymbol("CODE", CODE); }
      "COL"          {return symbolFactory.newSymbol("COL", COL); }
      "COLGROUP"     {return symbolFactory.newSymbol("COLGROUP", COLGROUP); }
      "DD"           {return symbolFactory.newSymbol("DD", DD); }
      "DEL"          {return symbolFactory.newSymbol("DEL", DEL); }
      "DFN"          {return symbolFactory.newSymbol("DFN", DFN); }
      "DIR"          {return symbolFactory.newSymbol("DIR", DIR); }
      "DIV"          {return symbolFactory.newSymbol("DIV", DIV); }
      "DL"           {return symbolFactory.newSymbol("DL", DL); }
      "DT"           {return symbolFactory.newSymbol("DT", DT); }
      "EM"           {return symbolFactory.newSymbol("EM", EM); }
      "FIELDSET"     {return symbolFactory.newSymbol("FIELDSET", FIELDSET); }
      "FONT"         {return symbolFactory.newSymbol("FONT", FONT); }
      "FORM"         {return symbolFactory.newSymbol("FORM", FORM); }
      "FRAME"        {return symbolFactory.newSymbol("FRAME", FRAME); }
      "FRAMESET"     {return symbolFactory.newSymbol("FRAMESET", FRAMESET); }
      "HEAD"         {return symbolFactory.newSymbol("HEAD", HEAD); }
      "H1"           {return symbolFactory.newSymbol("H1", H1); }
      "H2"           {return symbolFactory.newSymbol("H2", H2); }
      "H3"           {return symbolFactory.newSymbol("H3", H3); }
      "H4"           {return symbolFactory.newSymbol("H4", H4); }
      "H5"           {return symbolFactory.newSymbol("H5", H5); }
      "H6"           {return symbolFactory.newSymbol("H6", H6); }
      "HR"           {return symbolFactory.newSymbol("HR", HR); }
      "HTML"         {return symbolFactory.newSymbol("HTML", HTML); }
      "I"            {return symbolFactory.newSymbol("I", I); }
      "IFRAME"       {return symbolFactory.newSymbol("IFRAME", IFRAME); }
      "IMG"          {return symbolFactory.newSymbol("IMG", IMG); }
      "INPUT"        {return symbolFactory.newSymbol("INPUT", INPUT); }
      "INS"          {return symbolFactory.newSymbol("INS", INS); }
      "ISINDEX"      {return symbolFactory.newSymbol("ISINDEX", ISINDEX); }
      "KBD"          {return symbolFactory.newSymbol("KBD", KBD); }
      "LABEL"        {return symbolFactory.newSymbol("LABEL", LABEL); }
      "LEGEND"       {return symbolFactory.newSymbol("LEGEND", LEGEND); }
      "LI"           {return symbolFactory.newSymbol("LI", LI); }
      "LINK"         {return symbolFactory.newSymbol("LINK", LINK); }
      "LISTING"      {return symbolFactory.newSymbol("LISTING", LISTING); }
      "MAP"          {return symbolFactory.newSymbol("MAP", MAP); }
      "MENU"         {return symbolFactory.newSymbol("MENU", MENU); }
      "META"         {return symbolFactory.newSymbol("META", META); }
      "NEXTID"       {return symbolFactory.newSymbol("NEXTID", NEXTID); }
      "NOFRAMES"     {return symbolFactory.newSymbol("NOFRAMES", NOFRAMES); }
      "NOSCRIPT"     {return symbolFactory.newSymbol("NOSCRIPT", NOSCRIPT); }
      "OBJECT"       {return symbolFactory.newSymbol("OBJECT", OBJECT); }
      "OL"           {return symbolFactory.newSymbol("OL", OL); }
      "OPTGROUP"     {return symbolFactory.newSymbol("OPTGROUP", OPTGROUP); }
      "OPTION"       {return symbolFactory.newSymbol("OPTION", OPTION); }
      "P"            {return symbolFactory.newSymbol("P", P); }
      "PARAM"        {return symbolFactory.newSymbol("PARAM", PARAM); }
      "PLAINTEXT"    {return symbolFactory.newSymbol("PLAINTEXT", PLAINTEXT); }
      "PRE"          {return symbolFactory.newSymbol("PRE", PRE); }
      "Q"            {return symbolFactory.newSymbol("Q", Q); }
      "S"            {return symbolFactory.newSymbol("S", S); }
      "SAMP"         {return symbolFactory.newSymbol("SAMP", SAMP); }
      "SELECT"       {return symbolFactory.newSymbol("SELECT", SELECT); }
      "SCRIPT"       {return symbolFactory.newSymbol("SCRIPT", SCRIPT); }
      "SMALL"        {return symbolFactory.newSymbol("SMALL", SMALL); }
      "SPAN"         {return symbolFactory.newSymbol("SPAN", SPAN); }
      "STRIKE"       {return symbolFactory.newSymbol("STRIKE", STRIKE); }
      "STRONG"       {return symbolFactory.newSymbol("STRONG", STRONG); }
      "STYLE"        {return symbolFactory.newSymbol("STYLE", STYLE); }
      "SUB"          {return symbolFactory.newSymbol("SUB", SUB); }
      "SUP"          {return symbolFactory.newSymbol("SUP", SUP); }
      "SPAN"         {return symbolFactory.newSymbol("SPAN", SPAN); }
      "TABLE"        {return symbolFactory.newSymbol("TABLE", TABLE); }
      "TBODY"        {return symbolFactory.newSymbol("TBODY", TBODY); }
      "TD"           {return symbolFactory.newSymbol("TD", TD); }
      "TEXTAREA"     {return symbolFactory.newSymbol("TEXTAREA", TEXTAREA); }
      "TFOOT"        {return symbolFactory.newSymbol("TFOOT", TFOOT); }
      "TH"           {return symbolFactory.newSymbol("TH", TH); }
      "THEAD"        {return symbolFactory.newSymbol("THEAD", THEAD); }
      "TITLE"        {return symbolFactory.newSymbol("TITLE", TITLE); }
      "TR"           {return symbolFactory.newSymbol("TR", TR); }
      "TT"           {return symbolFactory.newSymbol("TT", TT); }
      "U"            {return symbolFactory.newSymbol("U", U); }
      "UL"           {return symbolFactory.newSymbol("UL", UL); }
      "VAR"          {return symbolFactory.newSymbol("VAR", VAR); }
      "XMP"          {return symbolFactory.newSymbol("XMP", XMP); }
    }


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
    <<EOF>>                          { return symbol(EOF); }