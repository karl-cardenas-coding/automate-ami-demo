FROM hashicorp/terraform:latest

RUN apk update  && apk upgrade && apk add --no-cache \
    python3 \
    && python3 -m ensurepip \
    && pip3 install --upgrade pip setuptools \
    && pip3 install awscli --upgrade --user \
    && apk add bash --no-cache \
    && mv /root/.local/bin/* /usr/local/bin \
    && rm -rf /var/cache/apk/*


WORKDIR /usr/local/bin
COPY packer ./
ENTRYPOINT [""]
