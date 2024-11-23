module generator.token;

import generator.wgstring;

class Token
{
	public WGString Value;
	public Token[] NextTokens;
	public Token[] SubsequentTokens;

	public this(WGString value)
	{
		Value = value;
	}

	public void AddNextToken(Token token)
	{
		foreach (ref next; NextTokens) 
		{
            if (next.Value == token.Value) 
			{
                return; // Токен уже существует в nextTokens
            }
        }
		NextTokens ~= token;
	}

	public void AddSubsequentToken(Token token)
	{
		foreach (ref next; SubsequentTokens) 
		{
            if (next.Value == token.Value) 
			{
                return; // Токен уже существует в SubsequentTokens
            }
        }
		SubsequentTokens ~= token;
	}

}