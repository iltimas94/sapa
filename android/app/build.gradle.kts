import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.sapa.sapa"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.sapa.sapa"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        // Google Play requires a minimum SDK of 24 or higher for app bundles
        // (automatic protection of Play requires API 24+).
        // flutter.minSdkVersion is 21 on Flutter 3.32, so it is set explicitly here.
        minSdk = 24
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String
        }
    }
    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now,
            // so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}

// ---------------------------------------------------------------------------
// Workaround for Google Drive for Desktop (GoogleDriveFS.exe)
//
// Repos that live under the user's Documents folder get a `desktop.ini` file
// injected by Google Drive, and Windows then marks every folder containing it
// as ReadOnly. Gradle's `:app:packageRelease` step removes the previous output
// folders before packaging and fails with:
//   java.nio.file.AccessDeniedException: ...\build\app\outputs\apk\release\baselineProfiles\0
//
// Clearing the ReadOnly flag on the build outputs right before the packaging
// task runs keeps `flutter build apk` working without any manual cleanup.
// ---------------------------------------------------------------------------
val clearReadOnlyBuildOutputs = tasks.register("clearReadOnlyBuildOutputs") {
    description = "Removes the Windows ReadOnly attribute from build outputs (Google Drive workaround)."
    doLast {
        val outputsDir = layout.buildDirectory.dir("outputs").get().asFile
        if (outputsDir.isDirectory) {
            outputsDir.walkTopDown().forEach { file ->
                // On Windows, setWritable(true) clears the ReadOnly attribute that
                // Google Drive / Explorer puts on folders containing desktop.ini.
                // This is best effort: failures are ignored.
                try {
                    file.setWritable(true)
                } catch (e: Exception) {
                    // Best effort only, ignore.
                }
            }
        }
    }
}

// Applies to every AGP packaging task (apk + app bundle, debug + release).
tasks.matching {
    it.name in setOf(
        "packageRelease",
        "packageDebug",
        "bundleRelease",
        "bundleDebug",
    )
}.configureEach {
    dependsOn(clearReadOnlyBuildOutputs)
}
