module generator.randomtexttokenizer;

import generator.itexttokenizer;
import generator.token;
import generator.wgstring;
import std.random;

class RandomTextTokenizer : ITextTokenizer
{
	private const size_t MinLength, MaxLength;

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
        //TODO: fix RangeError
		Token[WGString] tokensDict = new Token[WGString];
        Token[] allTokens;

        size_t i = 0;
        while (i < input.length)
        {
            // Генерируем случайную длину токена в диапазоне [minValue, maxValue]
            tokenValueSize = uniform(MinLength, MaxLength+ 1);

            // Проверяем, чтобы токен помещался в оставшуюся часть строки
            if (i + tokenValueSize > input.length)
                break;

            WGString tokenValue = input[i .. (i + tokenValueSize)];

            Token token;
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

            // Переходим к следующему токену
            i += tokenValueSize;
        }

        if (allTokens.length > 0)
        {
            allTokens[$ - 1].NextTokens = null;
        }

        return allTokens;
	}
}