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

HtmlComment = "<!--" {CommentContent} \*+ "-->"
CommentContent = ( [^*] | \*+[^*/] )*
Comment = {HtmlComment}
Digit       = [0-9]
Number      = [1-9][0-9]*
Punctuation = [!\"#\$%&\'()\*\+\,\-\.\/:;<=>\?@\[\]\\\^_`{}\~]
Character   = {Punctuation} | {Digit} | [A-Za-z]
String      = {Character}+


ident = ([:jletter:] | "" ) ([:jletterdigit:] | [:jletter:] | "" )*


%eofval{
    return symbolFactory.newSymbol("EOF",sym.EOF);
%eofval}

%state CODESEG

%%  

    /* keywords: https://www.w3.org/TR/1998/NOTE-compactHTML-19980209/ */
    <YYINITIAL> "DOCTYPE"            {return symbolFactory.newSymbol("DOCTYPE", DOCTYPE); }
    <YYINITIAL> "="            {return symbolFactory.newSymbol("EQ", EQ); }
    <YYINITIAL> "<"            {return symbolFactory.newSymbol("LT", LT); }
    <YYINITIAL> ">"            {return symbolFactory.newSymbol("GT", GT); }
    <YYINITIAL> "/"            {return symbolFactory.newSymbol("SL", SL); }
    <YYINITIAL> "A"            {return symbolFactory.newSymbol("A", A); }
    <YYINITIAL> "ABBR"         {return symbolFactory.newSymbol("ABBR", ABBR); }
    <YYINITIAL> "ACRONYM"      {return symbolFactory.newSymbol("ACRONYM", ACRONYM); }
    <YYINITIAL> "ADDRESS"      {return symbolFactory.newSymbol("ADDRESS", ADDRESS); }
    <YYINITIAL> "APPLET"      {return symbolFactory.newSymbol("APPLET", APPLET); }
    <YYINITIAL> "AREA"      {return symbolFactory.newSymbol("AREA", AREA); }
    <YYINITIAL> "B"      {return symbolFactory.newSymbol("B", B); }
    <YYINITIAL> "BASEFONT"      {return symbolFactory.newSymbol("BASEFONT", BASEFONT); }
    <YYINITIAL> "BASE"      {return symbolFactory.newSymbol("BASE", BASE); }
    <YYINITIAL> "BDO"         {return symbolFactory.newSymbol("BDO", BDO); }
    <YYINITIAL> "BGSOUND"         {return symbolFactory.newSymbol("BGSOUND", BGSOUND); }
    <YYINITIAL> "BIG"         {return symbolFactory.newSymbol("BIG", BIG); }
    <YYINITIAL> "BLINK"         {return symbolFactory.newSymbol("BLINK", BLINK); }
    <YYINITIAL> "BLOCKQUOTE"   {return symbolFactory.newSymbol("BLOCKQUOTE", BLOCKQUOTE); }
    <YYINITIAL> "BODY"         {return symbolFactory.newSymbol("BODY", BODY); }
    <YYINITIAL> "BR"           {return symbolFactory.newSymbol("BR", BR); }
    <YYINITIAL> "CAPTION"       {return symbolFactory.newSymbol("CAPTION", CAPTION); }
    <YYINITIAL> "CENTER"       {return symbolFactory.newSymbol("CENTER", CENTER); }
    <YYINITIAL> "CITE"       {return symbolFactory.newSymbol("CITE", CITE); }
    <YYINITIAL> "CODE"       {return symbolFactory.newSymbol("CODE", CODE); }
    <YYINITIAL> "COL"       {return symbolFactory.newSymbol("COL", COL); }
    <YYINITIAL> "COLGROUP"       {return symbolFactory.newSymbol("COLGROUP", COLGROUP); }
    <YYINITIAL> "DD"           {return symbolFactory.newSymbol("DD", DD); }
    <YYINITIAL> "DEL"           {return symbolFactory.newSymbol("DEL", DEL); }
    <YYINITIAL> "DFN"           {return symbolFactory.newSymbol("DFN", DFN); }
    <YYINITIAL> "DIR"          {return symbolFactory.newSymbol("DIR", DIR); }
    <YYINITIAL> "DIV"          {return symbolFactory.newSymbol("DIV", DIV); }
    <YYINITIAL> "DL"           {return symbolFactory.newSymbol("DL", DL); }
    <YYINITIAL> "DT"           {return symbolFactory.newSymbol("DT", DT); }
    <YYINITIAL> "EM"           {return symbolFactory.newSymbol("EM", EM); }
    <YYINITIAL> "EMBED"           {return symbolFactory.newSymbol("EMBED", EMBED); }
    <YYINITIAL> "FIELDSET"           {return symbolFactory.newSymbol("FIELDSET", FIELDSET); }
    <YYINITIAL> "FONT"           {return symbolFactory.newSymbol("FONT", FONT); }
    <YYINITIAL> "FORM"         {return symbolFactory.newSymbol("FORM", FORM); }
    <YYINITIAL> "FRAMESET"         {return symbolFactory.newSymbol("FRAMESET", FRAMESET); }
    <YYINITIAL> "HEAD"         {return symbolFactory.newSymbol("HEAD", HEAD); }
    <YYINITIAL> "H1"           {return symbolFactory.newSymbol("H1", H1); }
    <YYINITIAL> "H2"           {return symbolFactory.newSymbol("H2", H2); }
    <YYINITIAL> "H3"           {return symbolFactory.newSymbol("H3", H3); }
    <YYINITIAL> "H4"           {return symbolFactory.newSymbol("H4", H4); }
    <YYINITIAL> "H5"           {return symbolFactory.newSymbol("H5", H5); }
    <YYINITIAL> "H6"           {return symbolFactory.newSymbol("H6", H6); }
    <YYINITIAL> "HR"           {return symbolFactory.newSymbol("HR", HR); }
    <YYINITIAL> "HTML"         {return symbolFactory.newSymbol("HTML", HTML); }
    <YYINITIAL> "I"         {return symbolFactory.newSymbol("I", I); }
    <YYINITIAL> "IFRAME"         {return symbolFactory.newSymbol("IFRAME", IFRAME); }
    <YYINITIAL> "ILAYER"         {return symbolFactory.newSymbol("ILAYER", ILAYER); }
    <YYINITIAL> "IMG"          {return symbolFactory.newSymbol("IMG", IMG); }
    <YYINITIAL> "INPUT"        {return symbolFactory.newSymbol("INPUT", INPUT); }
    <YYINITIAL> "INS"        {return symbolFactory.newSymbol("INS", INS); }
    <YYINITIAL> "ISINDEX"        {return symbolFactory.newSymbol("ISINDEX", ISINDEX); }
    <YYINITIAL> "KBD"        {return symbolFactory.newSymbol("KBD", KBD); }
    <YYINITIAL> "KEYGEN"        {return symbolFactory.newSymbol("KEYGEN", KEYGEN); }
    <YYINITIAL> "LABEL"        {return symbolFactory.newSymbol("LABEL", LABEL); }
    <YYINITIAL> "LAYER"        {return symbolFactory.newSymbol("LAYER", LAYER); }
    <YYINITIAL> "LEGEND"        {return symbolFactory.newSymbol("LEGEND", LEGEND); }
    <YYINITIAL> "LI"           {return symbolFactory.newSymbol("LI", LI); }
    <YYINITIAL> "LINK"           {return symbolFactory.newSymbol("LINK", LINK); }
    <YYINITIAL> "LISTING"           {return symbolFactory.newSymbol("LISTING", LISTING); }
    <YYINITIAL> "MAP"           {return symbolFactory.newSymbol("MAP", MAP); }
    <YYINITIAL> "MARQUEE"           {return symbolFactory.newSymbol("MARQUEE", MARQUEE); }
    <YYINITIAL> "MENU"         {return symbolFactory.newSymbol("MENU", MENU); }
    <YYINITIAL> "META"         {return symbolFactory.newSymbol("META", META); }
 <YYINITIAL> "ILAYER"         {return symbolFactory.newSymbol("ILAYER", ILAYER); }
 <YYINITIAL> "SPACER"         {return symbolFactory.newSymbol("SPACER", SPACER); }
    <YYINITIAL> "MULTICOL"         {return symbolFactory.newSymbol("MULTICOL", MULTICOL); }
    <YYINITIAL> "NOBR"         {return symbolFactory.newSymbol("NOBR", NOBR); }
    <YYINITIAL> "NEXTID"         {return symbolFactory.newSymbol("NEXTID", NEXTID); }
    <YYINITIAL> "NOEMBED"         {return symbolFactory.newSymbol("NOEMBED", NOEMBED); }
    <YYINITIAL> "NOFRAMES"         {return symbolFactory.newSymbol("NOFRAMES", NOFRAMES); }
    <YYINITIAL> "NOSCRIPT"         {return symbolFactory.newSymbol("NOSCRIPT", NOSCRIPT); }
    <YYINITIAL> "OBJECT"         {return symbolFactory.newSymbol("OBJECT", OBJECT); }
    <YYINITIAL> "OL"           {return symbolFactory.newSymbol("OL", OL); }
    <YYINITIAL> "OPTGROUP"           {return symbolFactory.newSymbol("OPTGROUP", OPTGROUP); }
    <YYINITIAL> "OPTION"       {return symbolFactory.newSymbol("OPTION", OPTION); }
    <YYINITIAL> "P"            {return symbolFactory.newSymbol("P", P); }
    <YYINITIAL> "PARAM"            {return symbolFactory.newSymbol("PARAM", PARAM); }
    <YYINITIAL> "PRE"          {return symbolFactory.newSymbol("PRE", PRE); }
    <YYINITIAL> "Q"          {return symbolFactory.newSymbol("Q", Q); }
    <YYINITIAL> "S"          {return symbolFactory.newSymbol("S", S); }
    <YYINITIAL> "SAMP"          {return symbolFactory.newSymbol("SAMP", SAMP); }
    <YYINITIAL> "SELECT"       {return symbolFactory.newSymbol("SELECT", SELECT); }
    <YYINITIAL> "SERVER"       {return symbolFactory.newSymbol("SERVER", SERVER); }
    <YYINITIAL> "SCRIPT"       {return symbolFactory.newSymbol("SCRIPT", SCRIPT); }
    <YYINITIAL> "SPACER"       {return symbolFactory.newSymbol("SPACER", SPACER); }
    <YYINITIAL> "SMALL"       {return symbolFactory.newSymbol("SMALL", SMALL); }
    <YYINITIAL> "STYLE"        {return symbolFactory.newSymbol("STYLE", STYLE); }
    <YYINITIAL> "SPAN"         {return symbolFactory.newSymbol("SPAN", SPAN); }
    <YYINITIAL> "STRIKE"         {return symbolFactory.newSymbol("STRIKE", STRIKE); }
    <YYINITIAL> "STRONG"         {return symbolFactory.newSymbol("STRONG", STRONG); }
    <YYINITIAL> "SUB"         {return symbolFactory.newSymbol("SUB", SUB); }
    <YYINITIAL> "SUP"         {return symbolFactory.newSymbol("SUP", SUP); }
    <YYINITIAL> "TABLE"         {return symbolFactory.newSymbol("TABLE", TABLE); }
    <YYINITIAL> "TBODY"         {return symbolFactory.newSymbol("TBODY", TBODY); }
    <YYINITIAL> "TD"         {return symbolFactory.newSymbol("TD", TD); }
    <YYINITIAL> "TEXTAREA"     {return symbolFactory.newSymbol("TEXTAREA", TEXTAREA); }
    <YYINITIAL> "TFOOT"     {return symbolFactory.newSymbol("TFOOT", TFOOT); }
    <YYINITIAL> "TH"     {return symbolFactory.newSymbol("TH", TH); }
    <YYINITIAL> "THEAD"     {return symbolFactory.newSymbol("THEAD", THEAD); }
    <YYINITIAL> "TITLE"        {return symbolFactory.newSymbol("TITLE", TITLE); }
    <YYINITIAL> "TR"        {return symbolFactory.newSymbol("TR", TR); }
    <YYINITIAL> "TT"        {return symbolFactory.newSymbol("TT", TT); }
    <YYINITIAL> "U"        {return symbolFactory.newSymbol("U", U); }
    <YYINITIAL> "UL"           {return symbolFactory.newSymbol("UL", UL); }
    <YYINITIAL> "WBR"           {return symbolFactory.newSymbol("WBR", WBR); }
    <YYINITIAL> "VAR"           {return symbolFactory.newSymbol("VAR", VAR); }
    <YYINITIAL> "XMP"           {return symbolFactory.newSymbol("XMP", XMP); }
    <YYINITIAL> "version"           {return symbolFactory.newSymbol("version", version); }
    <YYINITIAL> "href"           {return symbolFactory.newSymbol("href", href); }


  /* comments */
  {Comment}                      { /* ignore */ }

  /* whitespace */
  {Whitespace} {                              }
 
  
  // error fallback
.|\n          { emit_warning("Unrecognized character '" +yytext()+"' -- ignored"); }