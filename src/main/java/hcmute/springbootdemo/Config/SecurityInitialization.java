package hcmute.springbootdemo.Config;

import hcmute.springbootdemo.Repository.UserRepository;
import hcmute.springbootdemo.Service.impl.UserDetailsServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.userdetails.UserDetailsService;

@Configuration
public class SecurityInitialization {
    private final UserRepository userRepository;

    public SecurityInitialization(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Bean
    public UserDetailsService userDetailsService() {
        return new UserDetailsServiceImpl(userRepository);
    }
    
}
