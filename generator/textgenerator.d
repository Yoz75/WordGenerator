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
    public WGString Generate(GeneratorSettings settings)
    {
        WGString result;				 
        Token thisToken;
        size_t nextTokenIndex;
        for (size_t i = 0; i < settings.TokensGenerateCount; i++)
        {
            if(IsBadToken(thisToken) ||  uniform(0, 100) < settings.RandomNextTokenChance)
            {
                PickRandom(thisToken, settings.Tokens);
            }
                                                                                        
            result ~= thisToken.Value;
            nextTokenIndex = uniform(0, settings.NextTokensCount);
            if(nextTokenIndex >= thisToken.NextTokens.length)
            {
                nextTokenIndex = thisToken.NextTokens.length - 1;
            }

            thisToken = thisToken.NextTokens[nextTokenIndex];
        }
        return result;
    }
}