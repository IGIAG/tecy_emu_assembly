import std.stdio;
import std.file;
import std.string;
import std.conv;

ubyte[string] mnemonics = [
	"and": 0,
	"or": 1,
	"add": 2,
	"sub": 3,
	"lw": 4,
	"sw": 5,
	"mov": 6,
	"nop": 7,
	"jeq": 8,
	"jne": 9,
	"jgt": 10,
	"jlt": 11,
	"load": 12,
	"store": 13,
	"li": 14,
	"jmp": 15
];

ubyte[] output = [];

ubyte[string] labels = [":start" : 0];

void main(string[] args)
{
	string path = "./program.code";
	if(args.length > 1){
		path = args[1];
	}
	string program_code = readText(path);
	program_code = toLower(program_code);
	string[] lines = splitLines(program_code);
	
	foreach (string line; lines)
	{
		if (line[0] == '#')
		{
			continue;
		}
		if(line[0] == ':'){
			labels[line] = cast(ubyte)output.length;
			line = "nop";
		}

		string[] segments = split(line, ' ');
		ubyte opcode = mnemonics[segments[0]];

		ubyte Rd = 0;
		ubyte Rs = 0;
		ubyte immed = 0;
		bool double_byte = false;
		if (opcode != 7 && opcode != 15)
		{
			Rd = cast(ubyte)(to!ubyte(segments[1][1]) - 48);
		}
		if (opcode < 7)
		{
			Rs = cast(ubyte)(to!ubyte(segments[2][1]) - 48);
		}
		if (opcode > 7)
		{
			if(opcode == 15){
				if(segments[1][0] == ':'){
					immed = labels[segments[1]];
				}
				else {
					immed = cast(ubyte)(to!int(segments[1]));
				}
			}
			else {
				if(segments[2][0] == ':'){
					immed = labels[segments[2]];
				}
				else {
					immed = cast(ubyte)(to!int(segments[2]));
				}
			}
			double_byte = true;
		}
		output ~= cast(ubyte)(((opcode << 4) & 0b11110000 ) | ((Rd << 2) & 0b00001100) | (Rs & 0b00000011) );
		writefln("%x", output[output.length - 1]);
		if(double_byte){
			output ~= immed;
			writefln("%x", output[output.length - 1]);
		}
	}
	std.file.write("./program.bin",output);
}
