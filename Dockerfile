FROM ubuntu:focal as provider-build

RUN  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  git \
  golang \
  libvirt-dev

RUN git clone https://github.com/dmacvicar/terraform-provider-libvirt.git && \
  cd terraform-provider-libvirt && \
  make

FROM hashicorp/terraform:0.14.9

RUN mkdir -p ~/.terraform.d/plugins/registry.terraform.io/dmacvicar/libvirt/0.6.3/linux_amd64/
COPY --from=provider-build /terraform-provider-libvirt/terraform-provider-libvirt ~/.terraform.d/plugins/registry.terraform.io/dmacvicar/libvirt/0.6.3/linux_amd64/
