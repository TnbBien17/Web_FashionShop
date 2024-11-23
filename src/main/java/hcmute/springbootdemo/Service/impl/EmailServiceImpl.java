package hcmute.springbootdemo.Service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailServiceImpl {
    @Autowired
    private JavaMailSender emailSender;
    
    public void sendSimpleMessage(
      String to, String subjectSend, String text) {
        SimpleMailMessage message = new SimpleMailMessage(); 
        message.setFrom("tubetnb123@gmail.com");
        message.setTo(to); 
        message.setSubject(subjectSend); 
        message.setText(text);
        emailSender.send(message);
    }

    public String generateRandomCode(){
        String code = "";
        for(int i=0;i<6;i++){
            code += (int)(Math.random()*10);
        }
        return code;
    }
}
