FROM gcc as builder
WORKDIR /opt
RUN apt-get update && apt-get -y install libhiredis-dev git &&\
	git clone https://github.com/tnm/vulcan.git &&\
	cd vulcan &&\
	gcc vulcan.c -lhiredis -o vulcan -pthread


FROM debian:latest
LABEL authors="cgarciaarano@gmail.com"
RUN apt-get update && apt-get -y install libhiredis0.13
COPY --from=builder /opt/vulcan/vulcan /vulcan
ENTRYPOINT ['./vulcan']

