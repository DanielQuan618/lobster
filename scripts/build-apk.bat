@echo off
rem Build gate for lobster: unit tests + release APKs (both flavors).
rem Equivalent of updateApk.sh (Git Bash). Keep this file ASCII-only:
rem cmd uses codepage 936 which garbles UTF-8 comments.
rem Requires: JDK 17 on PATH or JAVA_HOME set; Android SDK/NDK via local.properties or env.

setlocal
cd /d "%~dp0.."

if not defined JAVA_HOME (
  echo [warn] JAVA_HOME not set - Gradle will use "java" from PATH, which must be JDK 17.
)
if not defined ANDROID_HOME if not defined ANDROID_SDK_ROOT (
  echo [warn] ANDROID_HOME / ANDROID_SDK_ROOT not set - Gradle needs an Android SDK 34 + NDK 25.1.
)

echo [1/3] unit tests ...
call gradlew.bat :app:testArmv8-dotprodDebugUnitTest || goto :fail
echo [2/3] assemble release APKs ...
call gradlew.bat assembleArmv8Release assembleArmv8-dotprodRelease || goto :fail
echo [3/3] copy APKs to repo-root apk\ delivery dir ...
if not exist apk mkdir apk
del /q apk\Lobster_*.apk >nul 2>&1
copy /y app\build\outputs\apk\armv8\release\*.apk apk\ >nul || goto :fail
copy /y app\build\outputs\apk\armv8-dotprod\release\*.apk apk\ >nul || goto :fail
dir /b apk\Lobster_*.apk
echo BUILD OK
exit /b 0

:fail
echo BUILD FAILED
exit /b 1
