I made this image to allow me to develop and test plugins easily for Linux servers from Windows.

# Build Image

```bash
docker build -t onlyrtxa/hldm-docker:steam_legacy .
```

# How to Develop

There are a some options to improve your workflow using this container, the best one is using Docker Compose with `--watch` flag with initial sync experimental feature.

## 1. Mount Volume and Restart Container

1. Mount a volume with the custom game files required for the server into `/tmp/gamedir/`.
2. This directory is sync on startup at `/home/hlds_user/hlds/valve`.
3. Restart the container whenever you need to update changes.

```bash
docker run --rm -ti -p 27015:27015/udp -v C:/Users/rtxa/gamedir-agmodx:/tmp/gamedir/ onlyrtxa/hldm-docker:steam_legacy
```

> Cons of using this way if that if you have a lot of files to copy, it will slow down your workflow.

## 2. Mount Volume and Sync as Needed

1. Mount a volume with the custom game files required for the server into `/tmp/gamedir/`.
2. This directory is sync on startup at `/home/hlds_user/hlds/valve`.
3. To keep the volume synced, execute the following script:

```bash
docker exec <container-name> ./sync_script.sh
```

> The volume is synced only at startup because inotify events are not triggered when using WSL as it bypass Linux kernel filesystem. Other way would be to use polling, but that's overkilling.

## 3. Use Docker Compose Watch Mode (Preferred)

1. Place the game files in the same directory as the Dockerfile, (absolute paths for COPY in the container are not supported. You can place them in `gamedir`, git will ignore that directory.
2. Run the following command to start the container in watch mode and rebuild on changes:

```bash
docker-compose up -w --build
```

> Detached mode (`-d`) does not work with watch mode, so you can use the following command instead:
>```bash
>docker-compose watch &
>```

> There may be some issues with the default port 27015, so you may need to try other ports like 27016.
