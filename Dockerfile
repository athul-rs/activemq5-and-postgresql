FROM openjdk:8-jre-alpine

# define activemq version and workdir
ENV ACTIVEMQ_VERSION 5.18.0
ENV ACTIVEMQ_WORKDIR /app

# create the work dir
RUN mkdir -p $ACTIVEMQ_WORKDIR

# copy activemq
COPY activemq/apache-activemq-5.18.0-bin.tar.gz .

# download active mq and extract
RUN tar -xzf apache-activemq-5.18.0-bin.tar.gz -C $ACTIVEMQ_WORKDIR

# create link
RUN ln -s $ACTIVEMQ_WORKDIR/apache-activemq-$ACTIVEMQ_VERSION $ACTIVEMQ_WORKDIR/activemq

# copy the activemq configuration
COPY conf/activemq.xml $ACTIVEMQ_WORKDIR/activemq/conf

# copy the db properties
COPY conf/db.properties $ACTIVEMQ_WORKDIR/activemq/conf/db.properties

# copy the jars
COPY lib $ACTIVEMQ_WORKDIR/activemq/lib

# change work dir
WORKDIR $ACTIVEMQ_WORKDIR/activemq

# EXPOSE PORTS
# ACTIVEMQ UI
EXPOSE 8161
# ACTIVEMQ TCP
EXPOSE 61616

# start
CMD ["/bin/sh", "-c", "bin/activemq console"]