FROM ubuntu:focal as provider-build

RUN  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  git \
  golang \
  libvirt-dev \
  unzip \
  wget

RUN git clone https://github.com/dmacvicar/terraform-provider-libvirt.git && \
  cd terraform-provider-libvirt && \
  make

RUN wget https://releases.hashicorp.com/terraform/0.14.9/terraform_0.14.9_linux_amd64.zip && unzip terraform_0.14.9_linux_amd64.zip

#FROM ubuntu:focal

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  ca-certificates && \
  apt-get clean

RUN mkdir -p ~/.terraform.d/plugins/registry.terraform.io/dmacvicar/libvirt/0.6.3/linux_amd64/
#COPY --from=provider-build /terraform-provider-libvirt/terraform-provider-libvirt /root/.terraform.d/plugins/registry.terraform.io/dmacvicar/libvirt/0.6.3/linux_amd64/
#COPY --from=provider-build /terraform /usr/local/bin/
RUN cp /terraform-provider-libvirt/terraform-provider-libvirt /root/.terraform.d/plugins/registry.terraform.io/dmacvicar/libvirt/0.6.3/linux_amd64/
RUN cp /terraform /usr/local/bin/
