import std;
void main(){
	foreach(s;File("csv/filelist").byLineCopy){
		s.write;
		",".write;
		File("csv/"~s~".csv")
		.byLineCopy.front.writeln;
}}