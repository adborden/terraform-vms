# terraform-vms

Provision libvirt/QEMU/KVM virtual machines via terraform.

## Prerequisites

- Terraform 0.14+
- [libvirt provider](https://github.com/dmacvicar/terraform-provider-libvirt)

Currently the libvirt provider is not published to the Terraform Registry.
Download a binary or compile from source and copy to the plugins dir.

    $ cp terraform-provider-libvirt ~/.terraform.d/plugins/registry.terraform.io/dmacvicar/libvirt/0.6.3/linux_amd64/terraform-provider-libvirt


## Usage

Initialize terraform.

    $ terraform init

Check the plan.

    $ terraform plan -out=plan.tfplan

Apply the plan.

    $ terraform apply plan.tfplan

_TODO: move the terraform from local state to a cloud provider._
