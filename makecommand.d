import std;
void main(){
	foreach(s;File("csv/filelist").byLineCopy){
		"![".write;
		s.write;
		"](/pics/".write;
		s.write;
		".png)".writeln;
}}