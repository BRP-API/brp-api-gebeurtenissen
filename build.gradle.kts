import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
	kotlin("jvm") version "1.9.25"
	kotlin("plugin.spring") version "1.9.25"
	id("org.springframework.boot") version "3.5.6"
	id("io.spring.dependency-management") version "1.1.7"
	id("org.openapi.generator") version "7.15.0"
}

group = "nl.brp.api"
version = "0.0.1-SNAPSHOT"
description = "BRP API Gebeurtenissen"

val axonVersion = "4.9.0"

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
	implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
	implementation("org.jetbrains.kotlin:kotlin-reflect")
	testImplementation("org.springframework.boot:spring-boot-starter-test")
	testImplementation("org.jetbrains.kotlin:kotlin-test-junit5")
	testRuntimeOnly("org.junit.platform:junit-platform-launcher")

	runtimeOnly("org.postgresql:postgresql")

	//	 OpenAPI Generator runtime dependencies
	implementation("jakarta.validation:jakarta.validation-api:3.0.2")
	implementation("org.openapitools:jackson-databind-nullable:0.2.5")
	implementation("org.hibernate.validator:hibernate-validator:8.0.1.Final")
	implementation("jakarta.el:jakarta.el-api:5.0.1")
	runtimeOnly("org.glassfish.expressly:expressly:5.0.0")

	// JPA and Postgres dependencies
	implementation("jakarta.persistence:jakarta.persistence-api:3.1.0")
	implementation("org.springframework.boot:spring-boot-starter-data-jpa")

	// Axon Framework dependencies
	implementation("org.axonframework:axon-spring-boot-starter:$axonVersion")

	// Axon Server Connector for the JdbcEventStorageEngine
	implementation("org.axonframework:axon-server-connector:$axonVersion")

	// Axon Test dependency
	testImplementation("org.axonframework:axon-test:$axonVersion")

}

sourceSets {
	main {
		kotlin {
			srcDir("${layout.buildDirectory.get()}/generated/src/main/kotlin")
		}
	}
}

openApiGenerate {
	generatorName.set("kotlin-spring")
	inputSpec.set("$rootDir/src/main/resources/openapi.json")
	outputDir.set("${layout.buildDirectory.get()}/generated")

	configOptions.put("apiPackage", "nl.brp.api.gebeurtenissen.web.api")
	configOptions.put("modelPackage", "nl.brp.api.gebeurtenissen.web.api")

	configOptions.put("delegatePattern", "true")
	configOptions.put("documentationProvider", "none")
	configOptions.put("implicitHeaders", "true")
	configOptions.put("useOptional", "false")
	configOptions.put("useSpringBoot3", "true")
	configOptions.put("useTags", "true")
	configOptions.put("useSwaggerUI", "false")
}

kotlin {
	compilerOptions {
		freeCompilerArgs.addAll("-Xjsr305=strict")
	}
}

tasks.withType<Test> {
	useJUnitPlatform()
}

tasks.withType<KotlinCompile> {
	dependsOn("openApiGenerate")
}
