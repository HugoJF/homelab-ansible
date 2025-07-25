locals {
  public_services = [
    for each in var.services : each if each.public
  ]

  private_services = [
    for each in var.services : each if each.local_dns
  ]
}
