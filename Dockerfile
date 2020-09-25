FROM 0x01be/verilator as verilator
FROM 0x01be/iverilog as iverilog

FROM alpine as build

RUN apk add --no-cache --virtual cocotb-build-dependencies \
    build-base \
    python3-dev \
    py3-pip

RUN pip install --prefix=/opt/cocotb cocotb

FROM alpine

RUN apk add --no-cache --virtual cocotb-runtime-dependencies \
    python3 \
    perl \
    libstdc++

COPY --from=build /opt/cocotb/ /opt/cocotb/
COPY --from=iverilog /opt/iverilog/ /opt/iverilog/
COPY --from=verilator /opt/verilator/ /opt/verilator/

ENV PATH $PATH:/opt/cocotb/bin/:/opt/iverilog/bin/:/opt/verilator/bin/
ENV PYTHONPATH /usr/lib/python3.8/site-packages/:/opt/cocotb/lib/python3.8/site-packages/

