module generator.texttokenizer;

import generator.token;
import generator.wgstring;
import std.stdio;
import std.array;
import std.algorithm;
import std.conv;
import std.range;
import std.string;
import std.container;

class TextTokenizer
{ 
	public Token[] Tokenize(WGString input, size_t tokenValueSize)
	{
        Token[WGString] tokensDict = new Token[WGString];

        Token[] allTokens;

        for (size_t i = 0; i <= input.length - tokenValueSize; i++) 
        {
            WGString tokenValue = input[i .. (i + tokenValueSize)];
        
            Token token = new Token(" ");

            if (tokensDict.get(tokenValue, null) !is null) 
            {
                token = tokensDict[tokenValue];
            }
            else 
            {
                token = new Token(tokenValue);
                tokensDict[tokenValue] = token;
            }

            allTokens ~= token;

            if (i >= tokenValueSize) 
            {
                WGString prevTokenValue = input[i - tokenValueSize .. i];
                auto prevToken = tokensDict[prevTokenValue];
                prevToken.AddNextToken(token);
            }
        }

        if (allTokens.length > 0)
        {
            allTokens[$-1].NextTokens = null;
        }

        return allTokens;
	}
}