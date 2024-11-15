module generator.itexttokenizer;

import generator.wgstring;
import generator.token;

interface ITextTokenizer
{
	public Token[] Tokenize(WGString input, size_t tokenValueSize);		  
}