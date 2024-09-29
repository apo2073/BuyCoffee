val kotlin_version: String by project
val logback_version: String by project

plugins {
    kotlin("jvm") version "2.0.20"
    id("io.ktor.plugin") version "2.3.12"
}

group = "kr.apo2073"
version = "0.0.1"

application {
    mainClass.set("kr.apo2073.ApplicationKt")

    val isDevelopment: Boolean = project.ext.has("development")
    applicationDefaultJvmArgs = listOf("-Dio.ktor.development=$isDevelopment")
}

repositories {
    mavenCentral()
    maven("https://repo.papermc.io/repository/maven-public/") {
        name = "papermc-repo"
    }
    maven("https://oss.sonatype.org/content/groups/public/") {
        name = "sonatype"
    }
    maven("https://jitpack.io") {
        name= "jitpack"
    }
}

dependencies {
    compileOnly("io.papermc.paper:paper-api:1.20.1-R0.1-SNAPSHOT")
    implementation("io.ktor:ktor-server-core-jvm")
    implementation("io.ktor:ktor-server-freemarker-jvm")
    implementation("io.ktor:ktor-server-netty-jvm")
    implementation("ch.qos.logback:logback-classic:$logback_version")
    implementation("com.googlecode.json-simple:json-simple:1.1.1")
    implementation("com.github.apo2073:ApoLib:1.0.3")
}

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(17)
    }
}

val targetJavaVersion = 17
kotlin {
    compilerOptions {
        freeCompilerArgs.addAll("-Xjsr305=strict")
    }
    jvmToolchain(targetJavaVersion)
}

tasks.withType<JavaCompile> {
    options.encoding = "UTF-8"
}

tasks.processResources {
    val props = mapOf("version" to version)
    inputs.properties(props)
    filteringCharset = "UTF-8"
    filesMatching("plugin.yml") {
        expand(props)
    }
}

tasks.withType<Jar> {
    manifest {
        attributes["Main-Class"] = "kr.apo2073.Applications"
    }
}

tasks.shadowJar {
    archiveFileName.set("DonateMe.jar")
    archiveClassifier.set("all")
    //mergeServiceFiles()
    //dependencies {
    //    include(dependency("com.github.apo2073:ApoLib:1.0.3"))
    //}
    //from(sourceSets.main.get().output) {
    //    include("**/*")
    //}
}