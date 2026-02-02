/*
 kt_{{cookiecutter.proj_name}}

 Gradle build file for Basic Kotlin Applications

 https://docs.gradle.org/current/kotlin-dsl/
 https://docs.gradle.org/current/userguide/kotlin_dsl.html

 Compiled during *configuration phase*.

*/

////-- imports
// by default:
// - org.gradle.api...
// - org.gradle.kotlin.dsl
// - org.gradle.kotlin.dsl.plugins.dsl
// - org.gradle.kotlin.dsl.precompile
// - java.util.concurrent.{Callable, TimeUnit}
// - java.math.{BigDecimal, BigInteger}
// - java.io.File
// - javax.inject.Inject
import java.io.ByteArrayOutputStream
import org.jetbrains.dokka.gradle.tasks.DokkaGenerateTask
////-- end imports

val buildDir  = layout.buildDirectory
val projDir   = layout.projectDirectory
val polyTemp  = project.file(System.getenv("POLYGLOT_TEMP"))

////-- plugins
repositories {
    maven("https://repo.gradle.org/gradle/libs-releases")
    maven("https://jitpack.io")
    mavenCentral()
    google()
    gradlePluginPortal()
}

plugins {
    id("java")
    // id("java-library")
    id("maven-publish")
    id("org.jetbrains.kotlin.jvm").version("2.2.21")
    id("org.jetbrains.dokka").version("2.1.0")
    `jvm-test-suite`
}


////-- end plugins

////-- toolchains
java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(24))
    }

    // withJavadocJar()
    // withSourcesJar()
    // sourceCompatibility
    // targetCompatibility
}
////-- end toolchains

////-- source sets
sourceSets {
    main {
        java {
            srcDir(projDir.dir("kotlin"))
            srcDir(projDir.dir("java"))
        }
        // resources {
        //     srcDir(projDir.dir("../_data"))
        //     srcDir(projDir.dir("_configs"))
        // }
    }
    test {
        java {
            sourceSets.main.get().java.srcDirs
            srcDir(projDir.dir("__tests"))
        }
        compileClasspath += sourceSets.main.get().output
        runtimeClasspath += sourceSets.main.get().output
    }
}

////-- end source sets

////-- configurations
configurations {
    //// Defaults:
    // compileOnly
    // implementation
    // runtimeOnly
    // testImplementation
    // testRuntimeOnly

    //// plus java's:
    // api
    // compileOnlyApi

}

////-- end configurations

////-- dependencies

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:2.2.21")
    testImplementation("org.jetbrains.kotlin:kotlin-test:2.2.21")
}

////-- end dependencies

////-- publishing
publishing {
    publications {
        create<MavenPublication>("maven") {
            from( components["java"] )
        }
    }
}

////-- end publishing

version         = "1.0"
layout.buildDirectory  = rootProject.layout.buildDirectory.dir("kotlin")

// val proj_name   = "{{cookiecutter.proj_name}}"
val proj_name = project.name
val log_props   = "_configs/logging.properties"
val log_dir     = buildDir.dir("logs/${proj_name}")
val launcher    = "MainKt"


defaultTasks("run")

// Run tasks    --------------------------------------------------

tasks.register<JavaExec>("run") {
    dependsOn("classes")
    mainClass    = launcher
    classpath    = sourceSets.main.get().runtimeClasspath
    // jvmArgs = "-Xss15m"
    args(
          "blah", "bloo", "aweg"
        // "--log-conf", projDir.file(log_props)
    )
    doFirst {
        mkdir(log_dir)
    }
}

// Build tasks  --------------------------------------------------

tasks.jar {
    dependsOn(configurations.runtimeClasspath)
    duplicatesStrategy  = DuplicatesStrategy.EXCLUDE
    archiveBaseName     = proj_name

    manifest {
        attributes(
         "Main-Class" to launcher,
         "Class-Path" to configurations
             .runtimeClasspath
             .get()
             .joinToString(separator=" ") //{ file -> "libs/${file.name}" }
        )
    }

    from (sourceSets.main.get().output)
    from (buildDir.dir("classes")) {
        include("**/*")
    }
}

// Test tasks   --------------------------------------------------

tasks.register("CheckFiles") {

    doFirst {
        val test_files = fileTree(projDir.dir("__tests"))
        println("Test Files: ")
        test_files.forEach {
            println("- $it")
        }

    }

}


tasks.test {
    // outputs.upToDateWhen { false }
    useJUnitPlatform()
    testLogging {
        events(
    "passed",
    "skipped",
    "failed"
        )
    }
}

// Doc --------------------------------------------------

tasks.withType<DokkaGenerateTask>().configureEach {
    outputDirectory = polyTemp.resolve("docs/kotlin/${proj_name}")
}

// jason.util.asl2dot
// jason.util.asl2html

// util funcs   --------------------------------------------------

fun transformLine(line:String, styler:Map<Int,(String) -> String>) : Unit {
    println(line)
    //     .replace("TESTING","${styler["yellow"]("TESTING")}")
    //     .replace("PASSED","${styler["green"]("PASSED")}")
    //     .replace("FAILED","${styler["red"]("FAILED")}")
    //     .replace("TODO","${styler["magenta"]("TODO")}")
    //     .replace("LAUNCHING","${styler["blue"]("LAUNCHING")}")
    // )
}
