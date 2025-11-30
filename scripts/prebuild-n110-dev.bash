#!/bin/bash

# Script that compiles upsilon for n0110 using default theme

echo Compiling for n110
echo ---

mkdir binpacks
mkdir binpacks/n110

echo Compiling for n110
make cleanall &> /dev/null
echo Compilation start: $(date) > binpacks/n110/legacy.log
make -j8 binpack MODEL=n0110 &>> binpacks/n110/legacy.log
echo Compilation end: $(date) >> binpacks/n110/legacy.log

echo Compilation start: $(date) > binpacks/n110/bl.log
make -j8  &>> binpacks/n110/bl.log
echo Compilation end: $(date) >> binpacks/n110/bl.log

echo Compilation start: $(date) > binpacks/n110/flasher.light.log
make -j8 flasher.light.bin MODEL=n0110 &> binpacks/n110/flasher.light.log
echo Compilation end: $(date) > binpacks/n110/flasher.light.log

echo Compilation start: $(date) > binpacks/n110/flasher.verbose.log
make -j8 flasher.verbose.bin MODEL=n0110 &> binpacks/n110/flasher.verbose.log
echo Compilation end: $(date) > binpacks/n110/flasher.verbose.log


mv output/release/device/bootloader/epsilon.onboarding.A.bin binpacks/n110/epsilon.onboarding.A.bin
mv output/release/device/bootloader/epsilon.onboarding.B.bin binpacks/n110/epsilon.onboarding.B.bin

mv output/release/device/n0110/binpack-n0110-$(git rev-parse HEAD | head -c 7).tgz binpacks/n110/binpack.tgz

mv output/release/device/n0110/binpack/epsilon.onboarding.external.bin binpacks/n110/epsilon.onboarding.external.bin
mv output/release/device/n0110/binpack/epsilon.onboarding.internal.bin binpacks/n110/epsilon.onboarding.internal.bin


mv output/release/device/n0110/binpack/flasher.light.bin binpacks/n110/flasher.light.bin
mv output/release/device/n0110/flasher.verbose.bin binpacks/n110/flasher.verbose.bin

echo Building bootloader...
make -j8 MODEL=n0110 bootloader &> binpacks/n110/bootloader.log
mv output/release/device/n0110/bootloader.bin binpacks/n110/bootloader.bin

echo Generating checksums...
for bin in binpacks/n110/*.bin
do
    shasum -a 256 -b $bin > $bin.sha256
done

echo Done!
