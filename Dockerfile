FROM hashicorp/terraform:latest

RUN apk update && apk upgrade && addgroup -g 1000 \
&& adduser -D -u 1000 terraform -G terraform

WORKDIR /usr/local/bin
COPY packer ./

USER 1000
