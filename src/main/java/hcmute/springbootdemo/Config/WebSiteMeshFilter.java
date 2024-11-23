package hcmute.springbootdemo.Config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebSiteMeshFilter implements WebMvcConfigurer {
    @Bean
    public FilterRegistrationBean siteMeshFilter() {
        FilterRegistrationBean filter = new FilterRegistrationBean();
        CustomSiteMeshFilter siteMeshFilter = new CustomSiteMeshFilter();
        filter.setFilter(siteMeshFilter);
        filter.addUrlPatterns("/*");
        return filter;
    }
}
