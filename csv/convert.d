import std.stdio :File,write;
import std.algorithm;
import std.range;
void main(string[] file){
	auto f=File(file[1]).byLineCopy;
	f.drop(10);
	foreach(s;f.take(16)){
		s=s[18..$];//OH MY FUCKING GOD WHY ARE THESE FILES IN "BGR"???????????
		s[4..6].write;
		s[2..4].write;
		s[0..2].write;
		",".write;
}}