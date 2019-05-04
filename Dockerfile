FROM ubuntu:latest

# based on https://github.com/pfichtner/docker-mqttwarn

MAINTAINER jakezp@gmail.com

# based on https://github.com/jpmens/mqttwarn

ENV DEBIAN_FRONTEND noninteractive

# Add config files
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD run.sh /run.sh

# Update and install packages
RUN apt-get update && apt-get upgrade -yq && apt-get install supervisor tzdata python-pip git -yq
RUN pip install paho-mqtt requests jinja2

# build /opt/mqttwarn
RUN chmod +x /run.sh && mkdir -p /opt/mqttwarn && groupadd -r mqttwarn && useradd -r -g mqttwarn mqttwarn
COPY . /opt/mqttwarn
RUN chown -R mqttwarn /opt/mqttwarn
VOLUME ["/opt/mqttwarn/conf"]
ENV MQTTWARNINI="/opt/mqttwarn/conf/mqttwarn.ini"
WORKDIR /opt/mqttwarn
CMD ["/run.sh"]

