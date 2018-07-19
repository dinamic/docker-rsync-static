FROM alpine:3.6 as builder

MAINTAINER Nikola Petkanski <nikola@petkanski.com>

RUN apk update && \
	apk add --virtual .build-dependencies binutils build-base curl perl popt-dev zlib-dev

ARG RSYNC_VERSION=3.1.3
RUN curl -L https://download.samba.org/pub/rsync/rsync-$RSYNC_VERSION.tar.gz | tar zx -C /tmp && \
	cd /tmp/rsync-$RSYNC_VERSION && \
	LDFLAGS="-static" ./configure && \
	LDFLAGS="-static" make && \
	cp rsync /

FROM scratch

COPY --from=builder /rsync /rsync

ENTRYPOINT ["/rsync"]
