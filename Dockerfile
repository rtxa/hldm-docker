FROM hldsdocker/valve:steam_legacy

# Already available from base image
ARG APPUSER="hlds_user"
ENV APPUSER=${APPUSER}
ENV APPDIRNAME="hlds"

ARG GAMEDIR=""

USER root

RUN apt-get update && \
apt-get install -y rsync

RUN mkdir /etc/lsyncd/

USER ${APPUSER}

# Copy custom game files if specified
# Unfortunately, files needs to be in the same directory as Dockerfile
COPY --chown=${APPUSER}:${APPUSER} $GAMEDIR ./valve/

# WORKDIR set in home/${APPUSER}/${APPDIRNAME}/, no need to add whole path on copy
COPY --chown=${APPUSER}:${APPUSER} ./entrypoint.sh ./entrypoint.sh
COPY --chown=${APPUSER}:${APPUSER} ./sync_script.sh ./sync_script.sh

CMD [ "bash", "-c", "./entrypoint.sh -timeout 3 -game valve +ip 0.0.0.0 -port 27015 +map crossfire"]

# This will allow to use different scripts in case we need to debug the container
#ENTRYPOINT ["./entrypoint.sh", "-timeout 3 -game valve +ip 0.0.0.0 -port 27015 +map crossfire"]