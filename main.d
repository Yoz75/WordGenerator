
import std.stdio;
import std.algorithm;
import std.file : read, getcwd;
import std.conv : to;
import generator.itexttokenizer;
import generator.texttokenizer;
import generator.randomtexttokenizer;
import generator.generatorsettings;
import generator.token;
import generator.textgenerator;
import generator.wgstring;

extern(Windows)
{
	bool SetConsoleOutputCP(uint wCodePageID);
}

final abstract class Arguments
{
static:
	public immutable string ReadFileName = "source=";
	public immutable string TokenSize = "ts=";
	public immutable string TokenRandomSizes = "trs=";
	public immutable string TokensGenerate = "tg=";
	public immutable string TokensNext = "tn=";
	public immutable string TokensRandomChance = "tr=";
	public immutable string FunRecreationsCount = "fr=";
}

WGString ReadInputFromConsole()
{
	static if(is(WGString == string))
	{
		return cast(WGString)readln();
	}
	else
	{
		return cast(WGString)readln();
	}
}

void main(string[] args)
{
	SetConsoleOutputCP(65001);

	ITextTokenizer tokenizer = new TextTokenizer();
	size_t tokenSize = 5;
	size_t tokensCount = 250;
	size_t nextTokens = 2;
	size_t funRecreationsCount = 0;
	ubyte randomTokenChance = 5;

	WGString input;

	if(args.length <= 1)
	{	
		 input = ReadInputFromConsole();
	}
	else
	{
		foreach(string arg; args)
		{
			if(arg.startsWith(Arguments.ReadFileName))
			{
				 input = cast(WGString)read((getcwd() ~ '/' ~ arg[Arguments.ReadFileName.length..$])); 
			}
			
			else if(arg.startsWith(Arguments.TokenSize))
			{
				tokenSize = to!(size_t)(arg[Arguments.TokenSize.length..$]);
			}
			
			else if(arg.startsWith(Arguments.TokensGenerate))
			{
				tokensCount = to!(size_t)(arg[Arguments.TokenSize.length..$]);
			}
					
			else if(arg.startsWith(Arguments.TokensNext))
			{
				nextTokens = to!(size_t)(arg[Arguments.TokenSize.length..$]);
			}

			else if(arg.startsWith(Arguments.TokensRandomChance))
			{
				randomTokenChance = to!(ubyte)(arg[Arguments.TokenSize.length..$]);
			}
			else if(arg.startsWith(Arguments.FunRecreationsCount))
			{
				funRecreationsCount = to!(size_t)(arg[Arguments.TokenSize.length..$]);
			}
			if(arg.startsWith(Arguments.TokenRandomSizes))
			{
				string minValue, maxValue;
				minValue = maxValue = "";
				bool isAppendingMinValue, isAppendingMaxValue;
				foreach(char character; arg)
				{
					if(character == '=')
					{
						isAppendingMinValue = true;
						continue;
					}
					else if(character == ';')
					{
						isAppendingMinValue = false;
						isAppendingMaxValue = true;
						continue;
					}	 					

					if(isAppendingMinValue)
					{
						minValue ~= character;
					}
					else if(isAppendingMaxValue)
					{
						maxValue ~= character;
					}
				}
				tokenizer = new RandomTextTokenizer(to!size_t(minValue), to!size_t(maxValue));
			}
		}
	}

	Token[] tokens = tokenizer.Tokenize(input, tokenSize);

	GeneratorSettings settings;

	settings.Tokens = tokens;
	settings.TokensGenerateCount = tokensCount;
	settings.NextTokensCount = nextTokens;
	settings.RandomNextTokenChance = randomTokenChance;

	TextGenerator generator = new TextGenerator();

	WGString text;
	if(funRecreationsCount > 0)
	{
		for(size_t i = 0; i < funRecreationsCount; i++)
		{
			text = generator.Generate(settings);
			tokens = tokenizer.Tokenize(text, tokenSize);
			settings.Tokens = tokens;
		}
	}
	else
	{
		text = generator.Generate(settings);
	}

	writeln("====================================================================================");
	writeln("result:\n");

	foreach(char character; text)
	{
		if(character == '�')
		{
			character = ' ';
		}
	}

	writeln(text);

	readln();
}
