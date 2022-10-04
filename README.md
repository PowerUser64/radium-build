# Radium Builder

This repository contains a docker image and some shell scripts that should make
it easy to compile the [Radium
Tracker/DAW](https://github.com/kmatheussen/radium).

### General Use

General usage is as follows:

```bash
./build-radium.sh
./run-radium.sh
```

If this doesn't work, check the [Requirements](#requirements) section of this
document.

### Requirements

This assumes you have docker installed and it is accessible to your user. If
you don't have docker, follow the official guide
[here](https://docs.docker.com/engine/install/) or search for instructions for
your Linux distribution.

Additionally, it is assumed that your qt5 plugins path is
`/usr/lib/qt/plugins`. If it is not, you will have to manually update
`./run-radium.sh`. Please submit a PR or an issue if this path doesn't exist on
your system so we can update the script to be more accommodating to other
distributions.
