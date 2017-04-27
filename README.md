# GoCD Server
GoCD Server based on alpine, with pre installed yaml config.

#### Inspired by
https://github.com/gocd/docker-gocd-server

# Usage
Start the container with this:

```bash
docker run -d -p8153:8153 -p8154:8154 stakater/gocd-server:v17.3.0
```

This will expose container ports 8153(http) and 8154(https) onto your server.
You can now open `http://localhost:8153` and `https://localhost:8154`

# Available configuration options

## Mounting volumes

The GoCD server will store all configuration, pipeline history database,
artifacts, plugins, and logs into `/godata`. If you'd like to provide secure
credentials like SSH private keys among other things, you can mount `/home/go`

```bash
docker run -v /path/to/godata:/godata -v /path/to/home-dir:/home/go stakater/gocd-server
```

> **Note:** Ensure that `/path/to/home-dir` and `/path/to/godata` is accessible by the `go` user in container (`go` user - uid 1000).

## Installing plugins

All plugins can be installed under `/godata`.

```
mkdir -p /path/to/godata/plugins/external
curl --location --fail https://example.com/plugin.jar > /path/to/godata/plugins/external/plugin.jar
chown -R 1000 /path/to/godata/plugins
```

## Installing addons

All addons can be installed under `/godata`.

```
mkdir -p /path/to/godata/addons
curl --location --fail https://example.com/addon.jar > /path/to/godata/addons/plugin.jar
chown -R 1000 /path/to/godata/addons
```

## Tweaking JVM options (memory, heap etc)

JVM options can be tweaked using the environment variable `GO_SERVER_SYSTEM_PROPERTIES`.

```bash
docker run -e GO_SERVER_SYSTEM_PROPERTIES="-Xmx4096mb -Dfoo=bar" stakater/gocd-server
```