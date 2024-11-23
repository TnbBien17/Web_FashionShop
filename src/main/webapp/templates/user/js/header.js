var logo_user=document.querySelector(".user_logo img");
var user_menu=document.querySelector(".profile_user");

logo_user.addEventListener("click",function(){
    console.log("clicked");
    if(user_menu.style.display=="none"){
        user_menu.style.display="block";
    }
    else{
        user_menu.style.display="none";
    }

});