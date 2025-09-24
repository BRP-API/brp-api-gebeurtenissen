plugins {
	java
	id("org.springframework.boot") version "3.5.6"
	id("io.spring.dependency-management") version "1.1.7"
	id("org.openapi.generator") version "7.15.0"
}

group = "nl.brp.api"
version = "0.0.1-SNAPSHOT"
description = "BRP API Gebeurtenissen"

java {
	toolchain {
		languageVersion = JavaLanguageVersion.of(21)
	}
}

repositories {
	mavenCentral()
}

dependencies {
	implementation("org.springframework.boot:spring-boot-starter-web")
	developmentOnly("org.springframework.boot:spring-boot-devtools")
	testImplementation("org.springframework.boot:spring-boot-starter-test")
	testRuntimeOnly("org.junit.platform:junit-platform-launcher")

//	 OpenAPI Generator runtime dependencies
	implementation("jakarta.validation:jakarta.validation-api:3.0.2")
	implementation("org.openapitools:jackson-databind-nullable:0.2.5")
	implementation("org.hibernate.validator:hibernate-validator:8.0.1.Final")
	implementation("jakarta.el:jakarta.el-api:5.0.1")
	runtimeOnly("org.glassfish.expressly:expressly:5.0.0")
}

sourceSets {
	main {
		java {
			srcDir("${layout.buildDirectory.get()}/generated/src/main/java")
		}
	}
}

openApiGenerate {
	generatorName.set("spring")
	inputSpec.set("$rootDir/src/main/resources/openapi.json")
	outputDir.set("${layout.buildDirectory.get()}/generated")

	configOptions.put("apiPackage", "nl.brp.api.gebeurtenissen.web.api")
	configOptions.put("configPackage", "nl.brp.api.gebeurtenissen.web.api.configuration")
	configOptions.put("invokerPackage", "nl.brp.api.gebeurtenissen.web.api")
	configOptions.put("modelPackage", "nl.brp.api.gebeurtenissen.web.api")
	configOptions.put("packageName", "nl.brp.api.gebeurtenissen.web.api")

	configOptions.put("delegatePattern", "true")
	configOptions.put("documentationProvider", "none")
	configOptions.put("implicitHeaders", "true")
	configOptions.put("useOptional", "false")
	configOptions.put("useBeanValidation", "false")
	configOptions.put("modelPropertyNaming", "original")
	configOptions.put("useSpringBoot3", "true")
	configOptions.put("useTags", "true")
	configOptions.put("useSwaggerUI", "false")
}

tasks.withType<Test> {
	useJUnitPlatform()
}

tasks.withType<JavaCompile> {
	dependsOn("openApiGenerate")
}
