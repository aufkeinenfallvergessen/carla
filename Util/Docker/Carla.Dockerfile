ARG GIT_BRANCH

USER carla

RUN cd /home/carla && \
  if [ -z ${GIT_BRANCH+x} ]; then git clone --depth 1 https://github.com/carla-simulator/carla.git; \
  else git clone --depth 1 --branch $GIT_BRANCH https://github.com/carla-simulator/carla.git; fi && \
  cd /home/carla/carla && \
  ./Update.sh && \
  make CarlaUE4Editor && \
  make PythonAPI
WORKDIR /home/carla/carla
COPY MyBuildUtilsDocker.sh .  
RUN cat MyBuildUtilsDocker.sh > Util/BuildTools/BuildUtilsDocker.sh
RUN make build.utils
RUN make package
RUN rm -r /home/carla/carla/Dist

WORKDIR /home/carla/carla
