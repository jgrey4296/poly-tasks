//  build.gradle.kts -*- mode: Kotlin -*-
/*
 {{cookiecutter.proj_name}}

 Root Gradle build file
 October 18, 2023 - 00:59:47

 https://docs.gradle.org/current/kotlin-dsl/
 https://docs.gradle.org/current/userguide/kotlin_dsl.html

 Compiled during *configuration phase*.

 Blocks:
 - artifacts
 - ConfigurationContainer
 - dependencies
 - dependencies.constraints
 - plugins
 - buildscript
 - tasks
 -



*/

////-- plugins
plugins {
    id("java")
    id("maven-publish")
    // For insisting on a specific version across sub pacakges, uncomment:
    // id("org.jetbrains.kotlin.jvm").version("2.0.21")

    // Documentation
    // id("org.jetbrains.dokka").version("2.1.0")

    // Android
    // id("com.android.application").version("8.12.3")
    // id("com.android.library").version("8.12.3")
    // id("org.jetbrains.kotlin.android").version("2.0.21")
}

////-- end plugins

apply(from=".tasks/jg.gradle.kts")

// defaultTasks(":kt_{{cookiecutter.proj_name}}:run")

layout.buildDirectory = File(".temp")

tasks.clean {
    delete(layout.buildDirectory)
}
