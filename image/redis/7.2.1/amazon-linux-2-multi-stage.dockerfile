# The Source OCI Image by adding AS install_redis it runs
# as stage and we can refer it in different stage
FROM sloopstash/base:v1.1.1 AS install_redis

# Switch to tmp directory equal to CD /tmp
WORKDIR /tmp

# Download and extract Redis.
RUN wget http://download.redis.io/releases/redis-7.2.1.tar.gz \
  && tar xvzf redis-7.2.1.tar.gz

# Switch to Redis Source directory
WORKDIR redis-7.2.1

# Compile and install Redis
RUN make distclean \
  && make \
  && make install

# It copies the redis-server and redis-cli folder extracted from
# Install_redis stage and push to sloopstash/base:v1.1.1 image

FROM sloopstash/base:v1.1.1 AS copy_redis_binaries

COPY --from=install_redis /usr/local/bin/redis-server /usr/local/bin/redis-server
COPY --from=install_redis /usr/local/bin/redis-cli /usr/local/bin/redis-cli
