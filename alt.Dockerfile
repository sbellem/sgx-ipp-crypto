FROM ubuntu:20.04

ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID -o nix && \
  useradd -m -u $UID -g $GID -o -s /bin/bash nix && \
  usermod -aG sudo nix && \
  DEBIAN_FRONTEND="noninteractive" apt-get update && \
  apt-get install -y git curl wget sudo xz-utils && \
  echo "nix ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/nix

ENV USER nix
USER nix

WORKDIR /home/nix

COPY --chown=nix:nix ./nix.conf /home/nix/.config/nix/nix.conf

RUN curl -L https://nixos.org/nix/install | sh

RUN . /home/nix/.nix-profile/etc/profile.d/nix.sh && \
  nix-channel --add https://nixos.org/channels/nixos-21.05 nixpkgs && \
  nix-channel --update && \
  nix-env -iA cachix -f https://cachix.org/api/v1/install
#  cachix use iohk

#RUN echo "cd ~/nix-workshop && source ./scripts/setup.sh" >> /home/nix/.profile

WORKDIR /home/src
COPY --chown=nix:nix nix nix
ARG nix_derivation=ipp-nomitigation.nix
COPY ${nix_derivation} ${nix_derivation}
RUN . /home/nix/.nix-profile/etc/profile.d/nix.sh && \
  nix-build ${nix_derivation}
