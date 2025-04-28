[![Docker Repository on Quay](https://quay.io/repository/bgruening/cellprofiler/status "Docker Repository on Quay")](https://quay.io/repository/bgruening/cellprofiler)

# docker-cellprofiler

Docker image with [cellprofiler](https://github.com/CellProfiler) version 4.2.8 

## How to build the container

To build this container you can use the following command:

```bash
git clone https://github.com/usegalaxy-eu/docker-cellprofiler.git
cd docker-cellprofiler
docker build -t CONTAINER_NAME .
```

## How to pull the container from Quay.io

The container is stored on Quay.io and you can get it via:

```bash
docker pull quay.io/bgruening/cellprofiler:TAG_NAME
```

## How to use the container

```bash
xhost +local:docker  # allow Docker to access X11

docker run -it \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v your/input/files:/input/ \
  CONTAINER_NAME:tag
```
