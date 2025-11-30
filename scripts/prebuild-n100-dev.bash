#!/bin/bash

# Script that compiles upsilon for all the given languages using default theme

languages=(
    "en"
    "fr"
    "nl"
    "pt"
    "it"
    "de"
    "es"
    "hu"
)
echo Compiling for n100
echo ---

mkdir binpacks
mkdir binpacks/n100

make cleanall &> /dev/null
for lang in "${languages[@]}"
do
    echo Compiling for n100 $lang $i
    make -j8 MODEL=n0100 EPSILON_I18N=$lang binpack &> binpacks/n100/$lang.log
    # Ensure clean build as i18n updates aren't always detected on first build
    make -j8 MODEL=n0100 EPSILON_I18N=$lang binpack &> binpacks/n100/$lang.log
    mv output/release/device/n0100/binpack/epsilon.onboarding.internal.bin binpacks/n100/epsilon.onboarding.$lang.internal.bin -v
    mv output/release/device/n0100/binpack/epsilon.onboarding.internal.bin.sha256 binpacks/n100/epsilon.onboarding.$lang.internal.bin.sha256 -v
    rm output/release/device/n0100/apps/i18n.o output/release/device/n0100/apps/i18n.cpp
done

echo Compiling flasher light
make -j8 flasher.light.bin MODEL=n0100 &> binpacks/n100/flasher.light.log
echo Compiling flasher verbose
make -j8 flasher.verbose.bin MODEL=n0100 &> binpacks/n100/flasher.verbose.log
cp output/release/device/n0100/flasher.light.bin binpacks/n100/
cp output/release/device/n0100/flasher.verbose.bin binpacks/n100/
for bin in binpacks/*/*.bin
do
    shasum -a 256 -b $bin > $bin.sha256
done

#Avoid crashing the CI
exit 0
