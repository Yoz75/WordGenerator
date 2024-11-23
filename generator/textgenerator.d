module generator.textgenerator;

import generator.wgstring;
import generator.token;
import generator.generatorsettings;
import std.random;
import core.thread.osthread;
import core.time : dur;

class TextGenerator
{
    bool IsBadToken(Token token)
    {
        if(!token || !token.NextTokens)
        {
            return true;
        }
        return false;
    }
    void PickRandom(ref Token token, Token[] sourceArray)
    {
        do
        {
            token = sourceArray[uniform(0, sourceArray.length)];
        } while(IsBadToken(token));
    }

    Token GetNextToken(Token token, size_t nextTokensCount)
	{
        size_t nextTokenIndex;
		nextTokenIndex = uniform(0, nextTokensCount);
		if(nextTokenIndex >= token.NextTokens.length)
		{
			nextTokenIndex = token.NextTokens.length - 1;
		}
        return token.NextTokens[nextTokenIndex];
	}
    public WGString Generate(GeneratorSettings settings)
    {
        WGString result;				 
        Token thisToken;
        for (size_t i = 0; i < settings.TokensGenerateCount; i++)
        {
            if(IsBadToken(thisToken) ||  uniform(0, 100) < settings.RandomNextTokenChance)
            {
                PickRandom(thisToken, settings.Tokens);
            }
                                                                                        
            result ~= thisToken.Value;

		thisToken = GetNextToken(thisToken, settings.NextTokensCount);
        }
        return result;
    }
}