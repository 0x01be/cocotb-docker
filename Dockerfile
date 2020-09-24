FROM alpine as build

RUN apk add --no-cache --virtual cocotb-build-dependencies \
    build-base \
    python3-dev \
    py3-pip

RUN pip install --prefix=/opt/cocotb cocotb

FROM alpine

RUN apk add --no-cache --virtual cocotb-runtime-dependencies \
    python3 \
    libstdc++

COPY --from=build /opt/cocotb/ /opt/cocotb/

ENV PATH $PATH:/opt/cocotb/bin/
ENV PYTHONPATH /usr/lib/python3.8/site-packages/:/opt/cocotb/lib/python3.8/site-packages/

