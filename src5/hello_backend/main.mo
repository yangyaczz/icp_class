import List "mo:base/List";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Time "mo:base/Time";

actor {
  public type Message = {
    text: Text;
    time : Time.Time;
    author: Text;
  };

  public type Microblog = actor {
    follow: shared(Principal) -> async();
    follows: shared query() -> async[Principal]; 
    post: shared(Text) -> async();
    posts: shared query(Time.Time) -> async[Message];
    timeline: shared(Time.Time) -> async[Message];
  };

  stable var followed : List.List<Principal> = List.nil();
  stable var au : Text = "yycz";

  public shared func set_name(name: Text) : async() {
    au := name;
  };

  public shared func get_name(): async Text{
    au
  };

  public shared func follow(id: Principal) : async(){
    followed := List.push(id, followed);
  };

  public shared query func follows() : async [Principal]{
    List.toArray(followed);
  };

  stable var messages : List.List<Message> = List.nil();
 
  public shared(msg) func post(otp: Text ,text: Text) : async(){
    
    assert(otp == "tintinland");

    let message = {
      text = text;
      time = Time.now();
      author = au
    };
    messages := List.push(message, messages)
  };
  
  //
  public shared query func posts(since: Time.Time) : async [Message]{
    var posts : List.List<Message> = List.nil();

    for (msg in Iter.fromList(messages)){
      if (msg.time >= since) {
        posts := List.push(msg, posts);
      }
    };

    List.toArray(posts)
    // List.toArray(messages)
  };

  public shared func timeline(since: Time.Time) : async [Message]{
    var all : List.List<Message> = List.nil();

    for (id in Iter.fromList(followed)){
      let canister : Microblog = actor(Principal.toText(id));
      let msgs = await canister.posts(since);
      for (msg in Iter.fromArray(msgs)){
        all := List.push(msg, all)
      }
    };

    List.toArray(all)
  };


};