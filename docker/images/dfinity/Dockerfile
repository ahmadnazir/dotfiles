FROM debian:stretch-slim

RUN apt-get update
RUN apt-get install curl -y

# The following doesn't work because the terminal isn't interactive
RUN bash -ci "$(curl -fsSL https://sdk.dfinity.org/install.sh)"