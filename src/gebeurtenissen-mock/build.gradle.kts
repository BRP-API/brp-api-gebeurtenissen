import org.openapitools.generator.gradle.plugin.tasks.GenerateTask

plugins {
    kotlin("jvm") version "2.2.21"
    kotlin("plugin.spring") version "2.2.21"
    id("org.springframework.boot") version "4.0.6"
    id("io.spring.dependency-management") version "1.1.7"
    id("org.openapi.generator") version "7.22.0"
}

group = "nl.rvig.brpapi"
version = "0.0.1-SNAPSHOT"
description = "gebeurtenissen-mock"

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(21)
    }
}

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter-webmvc")
    implementation("org.jetbrains.kotlin:kotlin-reflect")

    implementation("io.swagger.core.v3:swagger-annotations:2.2.49")

    testImplementation("org.springframework.boot:spring-boot-starter-webmvc-test")
    testImplementation("org.jetbrains.kotlin:kotlin-test-junit5")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

kotlin {
    compilerOptions {
        freeCompilerArgs.addAll("-Xjsr305=strict", "-Xannotation-default-target=param-property")
    }
}

tasks.withType<Test> {
    useJUnitPlatform()
}

val openApiSpec = rootProject.file("../../specificaties/abonnementen-en-bevragen/resolved/openapi.yaml")
val generatedDir = layout.buildDirectory.dir("generated/openapi")

tasks.register<Delete>("cleanOpenApiGenerated") {
    delete(generatedDir)
}

tasks.named<GenerateTask>("openApiGenerate") {
    dependsOn("cleanOpenApiGenerated")

    generatorName.set("kotlin-spring")
    inputSpec.set(openApiSpec.absolutePath)
    outputDir.set(generatedDir.get().asFile.absolutePath)

    apiPackage.set("nl.rvig.brpapi.gebeurtenissenmock.generated.api")
    modelPackage.set("nl.rvig.brpapi.gebeurtenissenmock.generated.model")
    invokerPackage.set("nl.rvig.brpapi.gebeurtenissenmock.generated.invoker")

    configOptions.set(
        mapOf(
            "interfaceOnly" to "true",
            "useBeanValidation" to "false",
        )
    )

    globalProperties.set(
        mapOf(
            "models" to "",
            "apis" to "",
        )
    )
}

sourceSets {
    main {
        kotlin {
            srcDir(generatedDir.map { it.dir("src/main/kotlin") })
        }
    }
}

tasks.named("compileKotlin") {
    dependsOn("openApiGenerate")
}
