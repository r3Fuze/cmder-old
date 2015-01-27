:: Init Script for cmd.exe
:: Sets some nice defaults
:: Created as part of cmder project

:: Find root dir
@if not defined CMDER_ROOT (
    for /f %%i in ("%ConEmuDir%\..\..") do @set CMDER_ROOT=%%~fi
)

:: Change the prompt style
:: Mmm tasty lamb NOPE!
:: Prompt is now handled in 'prompt.lua'
:: @prompt $E[1;32;40m$P$S{git}$S$_$E[1;30;40m{lamb}$S$E[0m

:: Pick right version of clink
@if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    set architecture=86
) else (
    set architecture=64
)

:: Run clink
@"%CMDER_ROOT%\vendor\clink\clink_x%architecture%.exe" inject --quiet --profile "%CMDER_ROOT%\config"

:: Prepare for msysgit

:: I do not even know, copypasted from their .bat
@set PLINK_PROTOCOL=ssh
@if not defined TERM set TERM=cygwin

:: Enhance Path
@set git_install_root=%CMDER_ROOT%\vendor\msysgit

:: Should we check if the file exists? @if exist %include_path%
@set include_path=%CMDER_ROOT%\bin\include

:: Using 'for /f' to assign output of a command to a variable
:: 'type' command is used to output contents of 'include file'
:: 'tr' command is used to replace newlines with semi colons
:: Included git commands are not loaded at this points so we are using %git_install_root% just in case the user doesn't have git installed
@for /f "delims=" %%i in ('type %include_path% ^| %git_install_root%\bin\tr "\\n" ";"') do @set include_content=%%i

:: Using 'call' to expand environment variables inside string. Thanks, jeb! http://stackoverflow.com/a/28115851/1169576
@call set include_content=%include_content%

:: Add the bin folder and everything inside the include file to PATH
@set PATH=%CMDER_ROOT%\bin;%include_content%;%CMDER_ROOT%;%PATH%

:: Add all the git stuff to PATH. This includes the hub utility
@set PATH=%git_install_root%\bin;%git_install_root%\cmd;%git_install_root%\share\vim\vim74;%CMDER_ROOT%\vendor\hub;%PATH%

:: Add aliases
@doskey /macrofile="%CMDER_ROOT%\config\aliases"

:: Set home path
@if not defined HOME set HOME=%USERPROFILE%

@if defined CMDER_START (
    @cd /d "%CMDER_START%"
) else (
    @if "%CD%\" == "%CMDER_ROOT%" (
        @cd /d "%HOME%"
    )
)

:: @call "%CMDER_ROOT%/bin/agent.cmd"
