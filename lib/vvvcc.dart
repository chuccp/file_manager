
class AA {
  const AA(this.aa);
  final  String aa;

   void ooo(){
     print(aa);
   }
}
AA ff(){
  return  const AA("1111");
}
AA ff0(){
  return  const AA("1111c");
}
void main(){

  var aa =  ff();
print(aa.hashCode);
  var bb = ff0();
  print(bb.hashCode);
}