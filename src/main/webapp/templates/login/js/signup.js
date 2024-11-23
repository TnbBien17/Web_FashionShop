
show_eye_register=document.querySelector(".signup_input_show")
hide_eye_register=document.querySelector(".signup_input_hidden")
input_password_register=document.querySelector(".mb-3-password.reg input")

show_eye_register.addEventListener("click",function(){
    input_password_register.type="text"
    show_eye_register.style.display="none"
    hide_eye_register.style.display="block"
});

hide_eye_register.addEventListener("click",function(){
    input_password_register.type="password"
    show_eye_register.style.display="block"
    hide_eye_register.style.display="none"
});

show_eye_re_register=document.querySelector(".signup_input_show-re-reg")
hide_eye_re_register=document.querySelector(".signup_input_hidden-re-reg")
input_password_re_register=document.querySelector(".mb-3-password.re-reg input")

show_eye_re_register.addEventListener("click",function(){
    input_password_re_register.type="text"
    show_eye_re_register.style.display="none"
    hide_eye_re_register.style.display="block"
});

hide_eye_re_register.addEventListener("click",function(){
    input_password_re_register.type="password"
    show_eye_re_register.style.display="block"
    hide_eye_re_register.style.display="none"
});