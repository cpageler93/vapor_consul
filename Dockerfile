# ubuntu 16.04 + vapor toolbox
FROM vapor/vapor

MAINTAINER Christoph Pageler

# install packages
RUN apt-get update && apt-get install -y \
    unzip

# install ruby
RUN \curl -L https://get.rvm.io | bash -s stable
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install ruby-2.4"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
RUN /bin/bash -l -c "gem install commander --no-ri --no-rdoc"

# setup environment
ENV APP_NAME vaporServer
ENV APP_PATH /$APP_NAME
ENV CONSUL_VERSION 0.9.2

# install consul
RUN curl -o consul_$CONSUL_VERSION.zip "https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip?_ga=2.147797055.947697772.1502644284-1472246637.1493547842"
RUN unzip consul_$CONSUL_VERSION.zip
RUN mv consul /usr/local/bin

# setup workdir
WORKDIR $APP_PATH
ADD entrypoint.sh $APP_PATH
ADD start_application.rb $APP_PATH

# expose ports for application and consul
EXPOSE 8080
EXPOSE 8500

# run application
ENTRYPOINT ["./entrypoint.sh"]

CMD ["start"]