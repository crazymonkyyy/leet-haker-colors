import std;
void main(){
	foreach(s;File("csv/filelist").byLineCopy){
		"exiftool -comment=".write;
		'"'.write;
		File("csv/"~s~".csv").byLineCopy.front.write;
		'"'.write;
		" pics/".write;
		s.write;
		".png".writeln;
}}