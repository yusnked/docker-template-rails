FROM ruby:3.1-bullseye AS base

ARG WORKDIR
ENV WORKDIR=${WORKDIR}
WORKDIR ${WORKDIR}

ARG USER_NAME=user
ARG UID=1000
ARG API_ROOT_PASSWORD
ARG API_USER_PASSWORD

RUN useradd --shell /bin/bash -l -u ${UID} -G sudo -o -c "" -m ${USER_NAME}
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo "root:${API_ROOT_PASSWORD}" | chpasswd
RUN echo "${USER_NAME}:${API_USER_PASSWORD}" | chpasswd
RUN chown -R user /api

COPY entrypoint.sh /
RUN chmod 555 /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

FROM base AS builder

# apt-getでインストールされるnodejsは古いのでnで新しいのをインストールする
RUN apt-get update && \
    apt-get install -y --no-install-recommends nodejs=12.22.12* npm=7.5.2* && \
    npm install -g n@9.0.0 && \
    n 16.16.0 && \
    apt-get purge -y nodejs npm && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN npm install -g yarn@1.22.19 && \
    echo 'gem: --no-document' >> /etc/.gemrc

USER ${USER_NAME}

CMD [ "sleep", "infinity" ]

FROM base AS product
# CMD [ "rails", "s", "-b", "0.0.0.0" ]
CMD ["sleep", "infinity"]