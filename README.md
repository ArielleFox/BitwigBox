# BitwigBox

A portable Bitwig Studio container. Inspired by [davincibox](https://github.com/zelikos/davincibox).

The BitwigBox container is first built to include all dependencies needed to run your specific version of Bitwig Studio and windows plugins with yabridge. A distrobox container is then created using the container. This allows you to run Bitwig Studio in a portable way, without having to install it on your host system.

BitwigBox can safely be removed and recreated without losing any data, such as configuration files, plugins, projects, login sessions, etc.

The BitwigBox uses it's own home directory at `~/BitwigBox/`. You can migrate your existing Bitwig Studio settings to the new home directory by copying over `~/BitwigStudio/` and `~/.BitwigStudio/` into `~/BitwigBox`. Bitwig Studio will be able to read and write to all directories and files on your system, but it will not litter your home directory with it's config files. This is why the home directory is in a separate location. You can install extensions, plugins, etc. normally into the BitwigBox directory.

BitwigBox can mostly be managed with the supplied `just` recipes, but you may also run `distrobox enter bitwigbox` to interact with the container directly.

## Requirements

Make sure these are installed on your host system.

-   [Distrobox](https://distrobox.it/)
-   [Podman](https://podman.io/)
-   [just][https://just.systems/]

## Usage

### Installation

```bash
# clone this repo (any directory works)
git clone https://github.com/xynydev/bitwigbox

# enter the directory
cd bitwigbox

# build the container
just build-local

# create a distrobox container
just create
```

### Running Bitwig Studio

Note: The first run will take a while as it sets up the distrobox environment.

You can run Bitwig Studio inside the repo directory like this:

```bash
just run
```

You can also export the Bitwig Studio app to the app menu:

```bash
just export
```

### Running Windows Plugins (VST2/3 & CLAP) with Yabridge

[Yabridge](https://github.com/robbert-vdh/yabridge) is a tool that allows you to run Windows plugins on Linux. It is the reason this project exists, as Bitwig Studio can be used easily with Flatpak, but that setup does not support yabridge.

To run a Windows plugin with yabridge, you first need to install it into the BitwigBox wine prefix. You can interact with wine using `just wine`, and you can use `winecfg` to configure wine. You may also drop the `.dll` files into `~/BitwigBox/.wine/drive_c/`, but most plugins will come with installers you can just run with `just wine`.

Once you have some plugins installed, you can add them to yabridge by running `just yabridgectl add <plugin-directory>`. To quickly add the usual Windows plugin folders, you can use the following command. Note that this will fail if you haven't installed any plugins to the specific directories yet.

```bash
just yabridgectl 'add ~/BitwigBox/.wine/drive_c/Program\ Files/Steinberg/VstPlugins' # vst2
just yabridgectl 'add ~/BitwigBox/.wine/drive_c/Program\ Files/Common\ Files/VST3' # vst3
just yabridgectl 'add ~/BitwigBox/.wine/drive_c/Program\ Files/Common\ Files/CLAP' # clap
```

Lastly, you'll need to run `just yabridgectl sync` to add the yabridge plugin wrappers to `~/BitwigBox/.vst/`, `~/BitwigBox/.vst3/`, and `~/BitwigBox/.clap/` respectively.

Now the plugins should be available in Bitwig Studio.

## TODO

-   investigate building on GitHub and publishing container images
    -   possible copyright ramifications?
