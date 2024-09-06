module generator.generatorsettings;

import generator.token;

struct GeneratorSettings
{
	public Token[] Tokens;
	public size_t TokensGenerateCount;
	public size_t NextTokensCount;
	public ubyte RandomNextTokenChance;
}
