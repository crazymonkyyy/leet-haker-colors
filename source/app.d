import raylib;
import std;
enum windowx=800;
enum windowy=600;
string csv;

void main(string[] s){
	csv=File("csv/"~s[1]~".csv").byLineCopy.front;
	InitWindow(windowx, windowy, "Hello, Raylib-D!");
	SetWindowPosition(2000,0);
	SetTargetFPS(60);
		BeginDrawing();
			ClearBackground(Colors.BLACK);
			DrawText("Hello, World!", 10,10, 20, Colors.WHITE);
			
		EndDrawing();
	TakeScreenshot( ("/pics/"~s[1]~".png").toStringz);
	CloseWindow();
}