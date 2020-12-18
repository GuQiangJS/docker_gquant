FROM alpine

COPY index.html /www/index.html

COPY lighttpd.conf /lighttpd.conf

RUN apk add lighttpd

EXPOSE 80

CMD ["lighttpd","-f","lighttpd.conf"]