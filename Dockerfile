# Define the image we are modifying
ARG VERSION

# Final image
FROM quay.io/keycloak/keycloak:$VERSION

ARG TITLE
ARG VCS_URL
ARG BUILD_DATE
ARG VERSION
ARG SPI_VERSION

LABEL org.opencontainers.image.authors="emil@jacero.se"
LABEL org.opencontainers.image.title="${TITLE}"
LABEL org.opencontainers.image.source="${VCS_URL}"
LABEL org.opencontainers.image.created="${BUILD_DATE}"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.based-on="quay.io/keycloak/keycloak:$VERSION"

# Switch to running application as the keycloak user
USER keycloak

# Copy the built keycloak-metrics-spi jar from builder
#COPY --from=baseimage /src/keycloak-metrics-spi/build/libs/keycloak-metrics-spi*.jar /opt/keycloak/providers/keycloak-metrics-spi.jar
ADD https://github.com/aerogear/keycloak-metrics-spi/releases/download/$SPI_VERSION/keycloak-metrics-spi-$SPI_VERSION.jar /opt/keycloak/providers/keycloak-metrics-spi.jar
