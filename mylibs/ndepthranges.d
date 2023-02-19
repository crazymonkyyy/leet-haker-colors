import std.algorithm; 
/**
	unittest bait, make an array have n extra wraping []
*/
private template wrapn(alias array,int i){
	enum wrapn=wrapn!([array],i-1);}
private template wrapn(alias array,int i:1){
	enum wrapn=array;}
unittest{
	static assert(wrapn!([1,2,3],2)==[[1,2,3]]);}

/**
	find the depth of the range
*/

template depth(T,int acc=0){
	import std.traits;
	static if(__traits(hasMember,T,"front")||isArray!T){
		static if(isArray!T){
			enum depth=depth!(typeof(T.init[0]),acc+1);
		} else {
			enum depth=depth!(typeof(T.front),acc+1);}
	} else {
		enum depth=acc;
}}
unittest{
	static assert(depth!(typeof(wrapn!([1,2,3],3)))==3);
	static assert(depth!(typeof([[[1,2,3]]]))==3);
	static assert(depth!(typeof([[[1,2,3]]].map!(a=>a.map!(a=>a.map!(a=>a+1)))))==3);
}

/**
	map at n depth
*/

auto mapdepth(alias F,int i,R)(R r){
	return r.mapdepth_!(F,depth!R-i);}
auto mapdepth_(alias F,int i,R)(R r){
	return r.map!(a=>a.mapdepth_!(F,i-1));}
alias mapdepth_(alias F,int i:1)=map!F;
unittest{
	import std.array;
	//assert(wrapn!([1,2,3],3).mapdepth!(a=>a+1,3)==[[[2,3,4]]]);
	assert(wrapn!([1,2,3],3).mapdepth!(a=>a+1,0)[0][0].array==[2,3,4]);
	assert(wrapn!([1,2,3],3).mapdepth!(a=>a.reduce!"a+b",1)[0][0]==6);
}

/**
	inline a check that your working at a sepefic depth at whatever point
*/
auto assertdepth(int i,R)(R r){return r.assertdepth!(i,"",R);}
auto assertdepth(int i,string s,R)(R r){
	static assert(depth!R==i,s);
	return r;
}

unittest{
	assert(wrapn!([1,2,3],3).assertdepth!3[0][0]==[1,2,3]);
}

/** 
	flatten to n depth
*/
auto flattendepth(int i,R)(R r){return r.flattendepth_!(depth!R-i);}
auto flattendepth_(int i,R)(R r){
	static if(i!=0){
		return joiner(r.map!(a => a.flattendepth_!(i - 1)));
	} else {
		return r;
}}

unittest{
	import std.array;
	assert(wrapn!([[1,2,3],[4,5,6],[7,8,9]],8).flattendepth!2.array==[[1,2,3],[4,5,6],[7,8,9]]);
}