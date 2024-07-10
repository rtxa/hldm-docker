# Build

```bash
docker build -t onlyrtxa/hldm-docker:steam_legacy .
```

# How to develop with this container

## 1. Mount volume and restart container whenever you need to update changes

We mount a volume with the custom game files we require for our server into `/tmp/gamedir/`. 
Then, this directory is mirrored at `/home/hlds_user/hlds/valve`.

```bash
docker run --rm -ti -p 27015:27015/udp -v C:/Users/rtxa/gamedir-agmodx:/tmp/gamedir/ onlyrtxa/hldm-docker:steam_legacy
```

## 2. Mount volume and sync as needed

We mount a volume with the custom game files we require for our server into `/tmp/gamedir/`. 
Then, this directory is mirrored at `/home/hlds_user/hlds/valve`.

```bash
docker run --rm -ti -p 27015:27015/udp -v C:/Users/rtxa/gamedir-agmodx:/tmp/gamedir/ onlyrtxa/hldm-docker:steam_legacy
```

It's synced just at startup, because I couldn't find a way to keep it sync because volume don't trigger **inotify** events
 when using WSL, so nothing to do in my side. To workaround this, execute this script to keep it sync as needed.

```bash
docker exec <container-name> ./sync_script.sh
```

## 2. Use Docker Compose watch mode

I find this the best way, only for one thing, you can't use absolute paths for COPY in container, so you have to put the game files where the dockerfile is located, otherwise it wouldn't work.

After that, just run in your terminal

```bash
docker compose up -w --build
```

You can't omit --build if you're not gonna changes the files for a while, I guess..

> Issue I found is that port are not opening or not working with default 27015, try with others like 27016


Detacthed mode doesn't work with watch mode, you have to use this:
```bash
docker-compose up -d --build

docker compose watch &
```