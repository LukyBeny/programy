:game_start
cls
@echo off
setlocal enabledelayedexpansion

color 0f
:: Generovani nahodneho cisla od 1 do 100
set /a target=%random% %% 100 + 1
set attempts=0
set max_attempts=10

echo Vitejte ve hre "Hadej cislo"!
echo Program nahodne vybral cislo mezi 1 a 100.
echo Mate 10 pokusu na uhodnuti cisla.
echo.

:guess_loop
if %attempts% GEQ %max_attempts% goto game_over

set /a attempts+=1
echo Pokus #%attempts% z %max_attempts%.
set /p "guess=Zadejte svuj tip: "

:: Kontrola, zda uzivatel zadal cislo
if not "!guess!"=="" for /f "delims=0123456789" %%a in ("!guess!") do (
    echo Prosim zadejte platne cislo.
    set /a attempts-=1
    goto guess_loop
cls
)

:: Porovnani tipu s cilem
if "!guess!" == "!target!" (
color 2f
    echo Gratulujeme! Uhodli jste spravne cislo: %target%
goto continue_prompt

::neplatna odpovedznovu se zeptame
echo prosim zadejte "ano" nebo "ne"
goto contine_prompt

    goto end
) else (
    if !guess! LSS !target! (
        echo Prilis nizke!
    ) else (
        echo Prilis vysoke!
    )
    goto guess_loop
)
color 07
:game_over
:: Cerveny text (pro Windows, barva 4F oznacuje cervene pozadi a jasny text)
color 4F
echo Bohuzel jste neuhodli cislo. Spravne cislo bylo: %target%.
echo Prohral jsi!

color  00

:continue_prompt
set /p "continue=Chcete hrat znovu? (ano/ne): "
if /i "!continue!" == "ano" goto game_start
if /i "!continue!" == "ne" goto end


:: Neplatna odpoved, znovu se zeptame
echo Prosim zadejte "ano" nebo "ne".
goto continue_prompt
: cast ktera ukonci hru kdys uzivatel zada "ne"
:end
exit
