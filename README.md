# keycloakx

This is an image specifically created for the helm chart [codecentric/keycloakx](https://artifacthub.io/packages/helm/codecentric/keycloakx) with the SPI metrics module installed.

## Usage

### Build locally

```shell
docker build -t keycloakx:dev --build-arg VERSION=20.0.3 --build-arg SPI_VERSION=2.5.3 .
```

### pull image

```shell
docker pull ghcr.io/emil-jacero/keycloakx:latest
```
