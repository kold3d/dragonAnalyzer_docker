docker run -ti --rm \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -v /home/sriteja/docker/dragon_analyzer/:/data \
    sriteja/dragon_analyzer:1.2 \
    /bin/bash -c "source /usr/local/root/bin/thisroot.sh && root /data/ssbCounts_new.C"
    export containerID=$(docker ps -l -q)

