# nixpkgs/nix:latest
FROM nixpkgs/nix@sha256:c7ab99ed60cc587ac784742e2814303331283cca121507a1d4c0dd21ed1bdf83 as base

WORKDIR /usr/src
COPY nix nix

FROM base as build
ARG nix_derivation=ipp-nomitigation.nix
COPY ${nix_derivation} ${nix_derivation}
RUN nix-build --quiet ${nix_derivation}
