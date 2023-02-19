import std;
void main(){
	foreach(s;File("csv/filelist").byLineCopy){
		("./app "~s).writeln;
}}