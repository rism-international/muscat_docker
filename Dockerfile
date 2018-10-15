FROM ubuntu:16.04

MAINTAINER Stephan Hirsch <stephan.hirsch@rism.info>

RUN apt update && apt-get -y install nodejs sudo vim curl libmagickwand-dev openjdk-8-jre-headless git make gcc mysql-server libmysqlclient-dev ruby ruby-dev ruby-bundler && \
 rm -rf /var/lib/apt/lists/* && useradd -ms /bin/bash admin && echo 'admin:admin' | chpasswd
USER admin
WORKDIR /home/admin
RUN git clone https://github.com/rism-ch/muscat.git
WORKDIR /home/admin/muscat
USER root
RUN gem install bundler && echo 'gem "tzinfo"' >> Gemfile && echo 'gem "tzinfo-data"' >> Gemfile && echo 'gem "bigdecimal"' >> Gemfile && bundle install
RUN chown -R admin:admin solr 
USER admin
COPY init.sql .
WORKDIR /home/admin/muscat/config
COPY database.yml .
COPY sunspot.yml .
COPY solr.yml .
RUN cp sample_application.rb application.rb && cp muscat-custom-sample.scss /home/admin/muscat/vendor/assets/stylesheets/muscat-custom.scss
WORKDIR /home/admin/muscat
RUN mkdir log
USER admin
