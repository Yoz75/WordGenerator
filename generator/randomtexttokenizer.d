module generator.randomtexttokenizer;

import generator.itexttokenizer;
import generator.token;
import generator.wgstring;
import std.random;

class RandomTextTokenizer : ITextTokenizer
{
	private size_t MinLength, MaxLength;

	public this(size_t minLength, size_t maxLength)
	{
		if(minLength > maxLength)
		{
			throw new Exception("min length is greater than max length!");
		}
		MinLength = minLength;
		MaxLength = maxLength;
	}

	public Token[] Tokenize(WGString input, size_t tokenValueSize)
	{
		Token[WGString] tokens = new Token[WGString];
		Token[] resultTokens;

		size_t thisTokenSize;
		size_t firstTokenSize;

		firstTokenSize = thisTokenSize = uniform(MinLength, MaxLength);

		for (size_t i  = 0; i  < input.length; i += thisTokenSize)
		{
			WGString tokenValue = input[i.. (i + thisTokenSize)];

			Token token;

			if (tokens.get(tokenValue, null) !is null) 
            {
                token = tokens[tokenValue];
            }
            else 
            {
                token = new Token(tokenValue);
                tokens[tokenValue] = token;
            }		

			resultTokens ~= token;

            if (i >= firstTokenSize) 
            {
                WGString prevTokenValue = input[(i - thisTokenSize)..i];
                auto prevToken = tokens[prevTokenValue];
                prevToken.AddNextToken(token);
            }
		}	
		
		thisTokenSize = uniform(MinLength, MaxLength);
		return resultTokens;
	}
}