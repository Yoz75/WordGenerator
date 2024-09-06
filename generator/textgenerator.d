module generator.textgenerator;

import generator.wgstring;
import generator.token;
import generator.generatorsettings;
import std.random;
import core.thread.osthread;
import core.time : dur;

class TextGenerator
{
	public WGString Generate(GeneratorSettings settings)
	{
		WGString result;				 
		Token thisToken;
		size_t nextTokenIndex;
		for (size_t i = 0; i < settings.TokensGenerateCount; i++)
		{
			while(!thisToken || !thisToken.NextTokens || uniform(0, 100) <= settings.RandomNextTokenChance)
			{			
				thisToken = settings.Tokens[uniform(0, settings.Tokens.length)];
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