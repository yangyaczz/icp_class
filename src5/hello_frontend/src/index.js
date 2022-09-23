import { hello_backend } from "../../declarations/hello_backend";

async function post() {
  let post_button = document.getElementById("post");
  let error = document.getElementById("error");
  error.innerText = "";
  post_button.disabled = true;
  let textarea = document.getElementById("message");
  let otp = document.getElementById("otp").value;
  let text = textarea.value;

  try {
    await hello_backend.post(otp, text);
    textarea.value = "";
  } catch (err) {
    console.log(err);
    error.innerText = "Post Failed";
  }
  post_button.disabled = false;
}


async function load_follows() {
  let follows_section = document.getElementById("follows");
  follows_section.replaceChildren([]);
  let follows = await hello_backend.follows();

  for (var i = 0; i < follows.length; i ++){
    let follow = document.createElement('f')
    let br = document.createElement("br");
    follow.innerText = 'canisterId:------------' +  follows[i]
    follows_section.appendChild(follow)
    follows_section.appendChild(br)
  }

}





async function load_posts() {

  let posts_section = document.getElementById("posts");
  posts_section.replaceChildren([]);
  let posts = await hello_backend.posts(0);

  for (var i = 0; i < posts.length; i++) {
    let post = document.createElement("p");
    let br = document.createElement("br");


    let ttt = new Date(Number(posts[i].time) / 1000000)
    let t = timestampToTime(ttt)

    post.innerText = "Message:" + posts[i].text + "------------  Time:"+ t + "------------- Author:" + posts[i].author 
    posts_section.appendChild(post)
    // posts_section.appendChild(br)
  }
}

function timestampToTime(timestamp) {
  var date = new Date(timestamp);
  var Y = date.getFullYear() + '-';
  var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
  var D = date.getDate() + ' ';
  var h = date.getHours() + ':';
  var m = date.getMinutes() + ':';
  var s = date.getSeconds();
  return Y + M + D + h + m + s;
}


function load() {
  let post_button = document.getElementById("post")
  post_button.onclick = post
  load_posts()
  load_follows()
  // setInterval(load_posts, 3000)
}

window.onload = load;