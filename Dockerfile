# Define the image we are modifying
ARG VERSION

# Use our base image
FROM ubuntu:22.04 as baseimage
ARG SPI_VERSION
WORKDIR /src
RUN apt-get update && apt-get upgrade -y &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl git
# RUN curl -L -J -O https://github.com/aerogear/keycloak-metrics-spi/releases/download/$SPI_VERSION/keycloak-metrics-spi-$SPI_VERSION.jar
RUN git clone https://github.com/aerogear/keycloak-metrics-spi.git

# Intermediate build stage
FROM quay.io/keycloak/keycloak:$VERSION AS builder
ARG VERSION

# Build the keycloak-metrics-spi jar
COPY --from=baseimage /src /src
USER root
ENV JAVA_HOME=/usr/lib/jvm/jre-11-openjdk
WORKDIR /src/keycloak-metrics-spi
RUN ./gradlew jar

# Final image
FROM quay.io/keycloak/keycloak:$VERSION

ARG TITLE
ARG VCS_URL
ARG BUILD_DATE
ARG VERSION

LABEL org.opencontainers.image.authors="emil@jacero.se"
LABEL org.opencontainers.image.title="${TITLE}"
LABEL org.opencontainers.image.source="${VCS_URL}"
LABEL org.opencontainers.image.created="${BUILD_DATE}"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.based-on="quay.io/keycloak/keycloak:$VERSION"

# Copy the built keycloak-metrics-spi jar from builder
COPY --from=builder /src/keycloak-metrics-spi/build/libs/keycloak-metrics-spi*.jar /opt/keycloak/providers/keycloak-metrics-spi.jar
