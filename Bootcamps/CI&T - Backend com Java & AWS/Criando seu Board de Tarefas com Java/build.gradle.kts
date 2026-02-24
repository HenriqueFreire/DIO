plugins {
    id("java")
}

group = "br.com.dio"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.liquibase:liquibase-core:4.29.1")
    implementation("mysql:mysql-connector-java:8.0.33")
    implementation("org.projectlombok:lombok:1.18.34")
    implementation("org.jdbi:jdbi3-core:3.51.0")
    implementation("org.jdbi:jdbi3-sqlobject:3.51.0")

    annotationProcessor("org.projectlombok:lombok:1.18.34")

    testImplementation("com.h2database:h2:2.2.224")
    testImplementation("org.junit.jupiter:junit-jupiter-api:5.11.0-M1") // Latest version as of now
    testRuntimeOnly("org.junit.jupiter:junit-jupiter-engine:5.11.0-M1")
}

tasks.test {
    useJUnitPlatform()
}