FROM jimthedev/cassandra
RUN apt-get install -y sysstat
RUN sed -i 's/LOCAL_JMX=yes.*$/LOCAL_JMX=no/' /etc/cassandra/cassandra-env.sh