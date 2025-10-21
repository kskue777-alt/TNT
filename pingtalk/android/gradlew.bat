@ECHO OFF

IF EXIST "%~dp0\gradle\wrapper\gradle-wrapper.jar" (
  "%JAVA_HOME%\bin\java" -jar "%~dp0\gradle\wrapper\gradle-wrapper.jar" %*
) ELSE (
  gradle %*
)
