# Use Torsten Walter's Dockerfile
FROM nginx:mainline

# for debugging network issues
RUN apt-get install iputils-ping
RUN apt-get install iputils-tracepath

# support running as arbitrary user which belogs to the root group
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx

# users are not allowed to listen on priviliged ports
RUN sed -i.bak 's/listen\(.*\)80;/listen 8081;/' /etc/nginx/conf.d/default.conf

EXPOSE 8081

# comment user directive as master process is run as user in OpenShift anyhow
RUN sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf

RUN addgroup nginx root
USER nginx

COPY index.html /usr/share/nginx/html
COPY static/ /usr/share/nginx/html/static/
