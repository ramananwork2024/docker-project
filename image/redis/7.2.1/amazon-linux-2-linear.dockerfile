# The Source OCI Image
FROM sloopstash/base:v1.1.1

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