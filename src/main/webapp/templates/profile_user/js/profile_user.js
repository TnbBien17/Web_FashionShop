show_eye=document.querySelector(".login_input_show")
hide_eye=document.querySelector(".login_input_hidden")
input_old_password=document.querySelector(".form_fill_new_password_content_input input")

show_eye.addEventListener("click",function(){
    input_old_password.type="text"
    show_eye.style.display="none"
    hide_eye.style.display="block"
});
hide_eye.addEventListener("click",function(){
    input_old_password.type="password"
    show_eye.style.display="block"
    hide_eye.style.display="none"
});


show_eye1=document.querySelector(".login_input_show.newPassword")
hide_eye1=document.querySelector(".login_input_hidden.newPassword")
input_new_password=document.querySelector(".form_fill_new_password_content_input.newPassword input")

show_eye1.addEventListener("click",function(){
    input_new_password.type="text"
    show_eye1.style.display="none"
    hide_eye1.style.display="block"
});
hide_eye1.addEventListener("click",function(){
    input_new_password.type="password"
    show_eye1.style.display="block"
    hide_eye1.style.display="none"
});


show_eye2=document.querySelector(".login_input_show.renewPassword")
hide_eye2=document.querySelector(".login_input_hidden.renewPassword")
input_renew_password=document.querySelector(".form_fill_new_password_content_input.renewPassword input")

show_eye2.addEventListener("click",function(){
    input_renew_password.type="text"
    show_eye2.style.display="none"
    hide_eye2.style.display="block"
});
hide_eye2.addEventListener("click",function(){
    input_renew_password.type="password"
    show_eye2.style.display="block"
    hide_eye2.style.display="none"
});