package Riachuelo.storefront.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;

@Configuration
public class OpenAPIConfig {
    
    @Bean
    OpenAPI openApi() {
        return new OpenAPI()
            .info(new Info()
                .title("Riachuelo API Vitrine do E-commerce")
                .version("1.0")
                .description("Documentação da API Vitrine do E-commerce."));
    }
}