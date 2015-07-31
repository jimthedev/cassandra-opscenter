FROM jimthedev/cassandra
RUN apt-get update
RUN apt-get install -y sysstat
ADD jxmremote.password /etc/cassandra/
RUN chown cassandra:cassandra /etc/cassandra/jmxremote.password
RUN chmod 400 /etc/cassandra/jmxremote.password
RUN sed -i 's/LOCAL_JMX=yes.*$/LOCAL_JMX=no/' /etc/cassandra/cassandra-env.sh