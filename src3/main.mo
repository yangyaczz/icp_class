import Text "mo:base/Text";
import Nat "mo:base/Nat";


actor Counter {

  stable var currentValue : Nat = 0; 


  public func increment() : async () {
    currentValue += 1;
  };


  public query func get() : async Nat {
    currentValue
  };


  public func set(n: Nat) : async () {
    currentValue := n;
  };


  public type HeaderField = (Text, Text);
  public type HttpRequest = {
      body : [Nat8];
      headers : [HeaderField];
      method : Text;
      url : Text;
  };
  public type HttpResponse = {
      body : Blob;
      headers : [HeaderField];
      status_code : Nat16;
  };


  public query func http_request(request: HttpRequest): async HttpResponse{
    {
      body = Text.encodeUtf8("<html><body><h1>TinTin IC Count is : "#Nat.toText(currentValue)#"</h1></body></html>");
      headers = [];
      status_code = 200;
    }
  }
}