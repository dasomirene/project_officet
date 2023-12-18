package officet;

import java.util.List;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebMvc
public class WebConfig  implements WebMvcConfigurer {
	// ResponseEntity<객체>를 리턴할 때, json데이터로 변경처리
	@Override
	public void configureMessageConverters(List<HttpMessageConverter<?>> 
		converters) {
		converters.add(new MappingJackson2HttpMessageConverter());
	}

}
