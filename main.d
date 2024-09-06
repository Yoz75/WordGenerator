
import std.stdio;
import std.algorithm;
import std.file : read, getcwd;
import std.conv : to;
import generator.texttokenizer;
import generator.generatorsettings;
import generator.token;
import generator.textgenerator;
import generator.wgstring;

extern(Windows)
{
	bool SetConsoleOutputCP(uint wCodePageID);
}

void main(string[] args)
{
	final abstract class Arguments
	{
		static:
		public immutable string ReadFileName = "source=";
		public immutable string TokenSize = "ts=";
		public immutable string TokensGenerate = "tg=";
		public immutable string TokensNext = "tn=";
		public immutable string TokensRandomChance = "tr=";
	}
	//SetConsoleOutputCP(65001);

	TextTokenizer tokenizer = new TextTokenizer();
	size_t tokenSize = 5;
	size_t tokensCount = 250;
	size_t nextTokens = 2;
	ubyte randomTokenChance = 5;

	WGString input;

	void ReadInputFromConsole()
	{
	    static if(is(WGString == string))
		{
			input = cast(WGString)readln();
		}
		else
		{
			input = cast(WGString)readln();
		}
	}

	if(args.length <= 1)
	{	
		 ReadInputFromConsole();
	}
	else
	{
		foreach(string arg; args)
		{
			if(arg.startsWith(Arguments.ReadFileName))
			{
				 input = cast(WGString)read((getcwd() ~ '/' ~ arg[Arguments.ReadFileName.length..$])); 
			}
			
			if(arg.startsWith(Arguments.TokenSize))
			{
				tokenSize = to!(size_t)(arg[Arguments.TokenSize.length..$]);
			}
			
			if(arg.startsWith(Arguments.TokensGenerate))
			{
				tokensCount = to!(size_t)(arg[Arguments.TokenSize.length..$]);
			}
					
			if(arg.startsWith(Arguments.TokensNext))
			{
				nextTokens = to!(size_t)(arg[Arguments.TokenSize.length..$]);
			}

			if(arg.startsWith(Arguments.TokensRandomChance))
			{
				randomTokenChance = to!(ubyte)(arg[Arguments.TokenSize.length..$]);
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

	WGString text = generator.Generate(settings);

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
