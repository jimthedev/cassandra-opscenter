FROM jimthedev/cassandra

RUN apt-get update
RUN apt-get install -y curl sudo

RUN echo "deb http://debian.datastax.com/community stable main" | tee -a /etc/apt/sources.list.d/datastax.sources.list
RUN curl -L https://debian.datastax.com/debian/repo_key | apt-key add -

RUN apt-get update
RUN apt-get install -y sysstat datastax-agent

ADD . /etc/cassandra/opscenter/
RUN cp /etc/cassandra/opscenter/jmxremote.password.template /etc/cassandra/jmxremote.password
RUN chown cassandra:cassandra /etc/cassandra/jmxremote.password
RUN chmod 400 /etc/cassandra/jmxremote.password

RUN sed -i 's/LOCAL_JMX=yes.*$/LOCAL_JMX=no/' /etc/cassandra/cassandra-env.sh

RUN echo "stomp_interface: 172.17.0.33" | sudo tee -a /var/lib/datastax-agent/conf/address.yaml

RUN service datastax-agent start