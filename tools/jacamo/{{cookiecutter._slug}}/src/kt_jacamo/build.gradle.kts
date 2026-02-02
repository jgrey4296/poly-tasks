/*
 {{cookiecutter.proj_name}}

 Gradle build file for JaCaMo Applications

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
val polyTemp  = Project.file(System.getenv("POLYGLOT_TEMP"))

////-- plugins
repositories {
    maven("https://raw.githubusercontent.com/jacamo-lang/mvn-repo/master")
    maven("https://repo.gradle.org/gradle/libs-releases")
    maven("https://jitpack.io")
    mavenCentral()
    google()
    gradlePluginPortal()
}

plugins {
    id("java")
    id("maven-publish")
    id("org.jetbrains.kotlin.jvm").version("2.2.21")
    id("org.jetbrains.dokka").version("2.1.0")
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
        resources {
            srcDir(projDir.dir("../_data"))
            srcDir(projDir.dir("_configs"))
            srcDir(projDir.dir("agents"))
            srcDir(projDir.dir("environments"))
            srcDir(projDir.dir("organisations"))
        }
    }

    test {
        compileClasspath += sourceSets.main.get().output
        runtimeClasspath += sourceSets.main.get().output
    }

    create("jcmIntegration") {
        resources {
            srcDir(projDir.dir("__tests"))
            srcDir(projDir.dir("_configs"))
            srcDir(projDir.dir("agents"))
            srcDir(projDir.dir("environments"))
            srcDir(projDir.dir("organisations"))
        }

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

    create("jcmTests").extendsFrom(configurations["testImplementation"])
}

////-- end configurations

////-- dependencies

dependencies {
    implementation("org.jacamo:jacamo:1.3")
    implementation("io.github.jason-lang:jason-interpreter:3.3.1")
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
group           = "org.jacamo"
layout.buildDirectory  = rootProject.layout.buildDirectory.dir("jacamo")

// val proj_name   = "{{cookiecutter.proj_name}}"
val proj_name   = project.name
val jcm_file    = "{{cookiecutter.proj_name}}.jcm"
val log_props   = "_configs/logging.properties"
val log_dir     = buildDir.dir("logs")
val launcher    = "jacamo.infra.JaCaMoLauncher"

defaultTasks("run")

// Run tasks    --------------------------------------------------

tasks.register<JavaExec>("run") {
    dependsOn("classes")
    group        = "JaCaMo"
    description  = "runs the JaCaMo application"
    mainClass    = launcher
    classpath    = sourceSets.main.get().runtimeClasspath
    // jvmArgs = "-Xss15m"
    args(
        projDir.file(jcm_file),
        "--log-conf", projDir.file(log_props)
    )
    doFirst {
        mkdir(log_dir)
    }
}

// Build tasks  --------------------------------------------------

tasks.register<JavaExec>("buildJCMDeps") {
    dependsOn("classes")
    mainClass = launcher
    classpath = sourceSets.main.get().runtimeClasspath

    args(projDir.file(jcm_file), "--deps")

}

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

tasks.register<Jar>("uberJar") {
    dependsOn(configurations.runtimeClasspath)
    group        = "JaCaMo"
    description  = "creates a single runnable jar file with all dependencies"
    archiveClassifier = "uber"
    duplicatesStrategy = DuplicatesStrategy.EXCLUDE
    // the name must start with jacamo so that jacamo...jar is found in the classpath
    archiveBaseName = "jacamo-${proj_name}"

    val jcm_target: String = jcm_file

    doFirst {
        copy {
            from(jcm_target)
            rename(jcm_target,"default.jcm" )
            into(buildDir.dir("jcm"))
        }
    }

    manifest {
        attributes(
            mapOf( "Main-Class" to launcher )
        )
    }
    from(sourceSets.main.get().output)
    from(sourceSets.main.get().resources) { include("**/*") }
    from({
        configurations.runtimeClasspath.get()
            .filter { it.name.endsWith("jar") }
            .map { zipTree(it) }
    })
    from (buildDir.dir("jcm"))
    from({
        configurations.runtimeClasspath
            .get().filter { it.name.endsWith("jar") }.map { zipTree(it) }
    })
}

// Test tasks   --------------------------------------------------

// Generate a Test Task for each jcm test file
// TODO: maybe use the sourceset
val jcmFiles = fileTree(projDir.dir("__tests"))
    .filter  { it.extension == "jcm"  }

jcmFiles.forEach {
        tasks.register<JavaExec>("jcmTest_${it.nameWithoutExtension}") {
            outputs.upToDateWhen { false } // disable cache
            description     = "run test file ${it.name}"
            group           = "verification"
            classpath       = sourceSets.main.get().runtimeClasspath
            mainClass       = launcher
            // standardOutput  = ByteArrayOutputStream()
            errorOutput     = ByteArrayOutputStream()

            val styler      = "black red green yellow blue magenta cyan white"
                .split(" ")
                .withIndex()
                .associate { (key, value) -> Pair(key, { it : String -> "\\033[${value}m${it}\\033[0m" }) }

            doFirst {
                println("--- Starting Test for: ${it}")
            }

            args(
                it.toString(),
                "--log-conf", projDir.file(log_props).toString()
            )

            doLast {
                println("--- Finished Test")
            }
        }
    }

tasks.register("jcmTests") {
    outputs.upToDateWhen { false }
    jcmFiles.forEach {
        dependsOn("jcmTest_${it.nameWithoutExtension}")
    }
}

tasks.test {
    // finalizedBy("jcmTests")
}

// Doc --------------------------------------------------

tasks.withType<DokkaGenerateTask>().configureEach {
    outputDirectory = polyTemp.dir("docs/kotlin/${proj_name}")
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
