_default:
    @just --list

# Run podman build
build-local:
    podman build . -t localhost/bitwigbox

# Create distrobox
create local="local":
    #!/usr/bin/env bash

    if [ $(distrobox list | grep -oP '(?<=| )bitwigbox(?= | )') ]; then
        echo "Error: container already exists"
        read -p "Do you want to force remove it (this will stop all currently open processess) (y/n)?"$'\n' -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Removing container"
            distrobox rm bitwigbox --force
        else
            echo "Aborting"
            exit 1
        fi
    fi

    echo "Creating container"

    if [ "{{local}}" = "local" ]; then
        distrobox create -n bitwigbox -i localhost/bitwigbox --yes --home ~/BitwigBox
    else
        echo "Error: non-local builds are not supported yet"
        exit 1
        # distrobox create -n bitwigbox -i ghcr.io/xynydev/bitwigbox --yes --home ~/BitwigBox
    fi

# Export Bitwig Studio (or something else) to the app menu
export app="bitwig":
    distrobox enter bitwigbox -- distrobox-export --app {{app}}

# Run Bitwig Studio
run:
    distrobox enter bitwigbox -- /opt/bitwig-studio/BitwigStudio

# Run yabridgectl
yabridgectl *ARGS:
    distrobox enter bitwigbox -- yabridgectl {{ARGS}}

# Run wine
wine *ARGS:
    distrobox enter bitwigbox -- wine {{ARGS}}

# Run winecfg
winecfg *ARGS:
        distrobox enter bitwigbox -- winecfg {{ARGS}}