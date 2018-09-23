FROM ubuntu:trusty

RUN apt-get update
RUN apt-get install -y apt-transport-https curl
RUN sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
RUN sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'

RUN apt-get update
RUN apt-get install -y dart

RUN /usr/lib/dart/bin/pub global activate webdev
RUN /usr/lib/dart/bin/pub global activate stagehand

ENTRYPOINT ["/bin/bash"]
