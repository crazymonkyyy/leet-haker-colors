import raylib;
import std;
enum windowx=700;
enum windowy=615;
string csv;
Color hextocolor(string s){
	import std.range;
	struct color{
		int r;
		int g;
		int b;
		import raylib;
		auto get(){
			return Color(cast(ubyte)r,cast(ubyte)g,cast(ubyte)b,255);
		}
		alias get this;
	}
	color output;
	enum zippy= zip(
		[16,1].cycle,
		["r","r","g","g","b","b"],
		iota(0,100));
	static foreach(digit,mix,i;zippy){ {
		int t;
		if(s[i]>='0' && s[i]<='9'){
			t=s[i]-'0';}
		if(s[i]>='a' && s[i]<='f'){
			t=s[i]-'a'+10;}
		if(s[i]>='A' && s[i]<='F'){
			t=s[i]-'A'+10;}
		t*=digit;
		mixin("output."~mix)+=t;
	} }
	return output.get;
}
string hextorgb(ubyte i){
	return i.to!string.padLeft('0',3).array.to!string;
}
void main(string[] s){
	csv=File("csv/"~s[1]~".csv").byLineCopy.front;
	csv.writeln;
	string[] colors=csv.split(',').array;
	colors.writeln;
	InitWindow(windowx, windowy, "Hello, Raylib-D!");
	SetWindowPosition(2000,0);
	SetTargetFPS(60);
		BeginDrawing();
			enum height=1000;
			ClearBackground(colors[0].hextocolor);
			DrawText( ("Base 16: "~ s[1]).toStringz, 10,10, 20, colors[5].hextocolor);
			DrawText( csv.toStringz,10,35,10,colors[5].hextocolor);
			DrawRectangle(50,50,35,height,colors[1].hextocolor);
			DrawRectangle(90,50,35,height,colors[2].hextocolor);
			DrawRectangle(130,50,35,height,colors[3].hextocolor);
			DrawRectangle(155,50,1000,75,colors[3].hextocolor);
			foreach(int i,c;colors){if(c.length>=6){
				auto c_=c.hextocolor;
				DrawText( ("Color "~(i.to!string.padLeft('0',2).array.to!string)).toStringz,
					170,60+i*35,20,c.hextocolor);
				DrawText( (" : #"~c).toStringz, 250,60+i*35,20,c.hextocolor);
				DrawText( ("|").toStringz, 380,60+i*35,20,c.hextocolor);
				DrawText( ("red: "~c_.r.hextorgb).toStringz, 390,60+i*35,20,c.hextocolor);
				DrawText( ("green: "~c_.g.hextorgb).toStringz, 485,60+i*35,20,c.hextocolor);
				DrawText( ("blue: "~c_.g.hextorgb).toStringz, 600,60+i*35,20,c.hextocolor);
				
				DrawRectangle(15,60+i*35,25,25,c.hextocolor);
				DrawRectangle(55,60+i*35,25,25,c.hextocolor);
				DrawRectangle(95,60+i*35,25,25,c.hextocolor);
				DrawRectangle(135,60+i*35,25,25,c.hextocolor);
			}}
		EndDrawing();
	TakeScreenshot( ("/pics/"~s[1]~".png").toStringz);
	CloseWindow();
}