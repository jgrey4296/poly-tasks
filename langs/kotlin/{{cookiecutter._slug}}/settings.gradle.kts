// //  settings.gradle.kts -*- mode: Kotlin -*-
// https://docs.gradle.org/current/userguide/settings_file_basics.html

rootProject.name = "{{cookiecutter.proj_name}}"

// path separator ':'
include(":kt_basic")
include(":kt_jacamo")

project(":kt_basic").projectDir   = File("src/kt")
project(":kt_jacamo").projectDir  = File("src/kt_jacamo")

buildCache {
    local {
        directory = File(rootDir, ".temp/gradle-cache/local")
    }
}
