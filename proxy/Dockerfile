FROM nginx:alpine
RUN apk update && apk add openssl

RUN wget https://github.com/progrium/entrykit/releases/download/v0.4.0/entrykit_0.4.0_linux_x86_64.tgz \
&& tar -xvzf entrykit_0.4.0_linux_x86_64.tgz \
&& rm entrykit_0.4.0_linux_x86_64.tgz \
&& mv entrykit /usr/local/bin/ \
&& entrykit --symlink

COPY ./generate_cert.sh /
COPY ./nginx.conf.tmpl /etc/nginx/

WORKDIR /ssl
ENTRYPOINT [ \
"prehook", "sh /generate_cert.sh", "--", \
"render", "/etc/nginx/nginx.conf", "--" \
]

CMD ["nginx", "-g", "daemon off;"]

