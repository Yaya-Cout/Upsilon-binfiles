# Updating prebuilt files

## Making a new beta/official release

Build most files for N0100/N0110 using

```bash
cd scripts
bash ./prebuild-n110.bash
bash ./prebuild-n100.bash
```

This command have to be run at Upsilon repo root.

Then move the files from `binpack` to the appropriate folder in this repo.

Build files not built by the scripts:

- `n100/flasher.light.bin`
- `n100/flasher.light.bin.sha256`
- `n100/flasher.verbose.bin`
- `n100/flasher.verbose.bin.sha256`
- `n110/flasher.light.bin`
- `n110/flasher.light.bin.sha256`
- `n110/flasher.verbose.bin`
- `n110/flasher.verbose.bin.sha256`

```bash
make cleanall
make flasher.light.bin MODEL=n0100 -j8
make flasher.verbose.bin MODEL=n0100 -j8
make flasher.light.bin MODEL=n0110 -j8
make flasher.verbose.bin MODEL=n0110 -j8
mkdir binpacks
mkdir binpacks/n100
mkdir binpacks/n110
cp output/release/device/n0100/flasher.light.bin binpacks/n100/
cp output/release/device/n0100/flasher.verbose.bin binpacks/n100/
cp output/release/device/n0110/flasher.light.bin binpacks/n110/
cp output/release/device/n0110/flasher.verbose.bin binpacks/n110/
for bin in binpacks/*/*.bin
do
    shasum -a 256 -b $bin > $bin.sha256
done
```

The binary files along with their checksums should be found in the `binpacks`
folder and should be merged with the other built files.

<!-- TODO: Automate -->

TODO: Build simulators

## Building a new dev release

Run at Upsilon repo root:

```bash
bash ./prebuild-n100-dev.bash
bash ./prebuild-n110-dev.bash
```

TODO: Build simulators
