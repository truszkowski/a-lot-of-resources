variable pets {
  type    = number
  default = 10
}

resource random_pet pets {
  count     = var.pets
  prefix    = "pet-${count.index}"
  separator = " "
  length    = 3
}

variable passwords {
  type    = number
  default = 10
}

resource random_password passwords {
  count   = var.passwords
  length  = 12
  special = false
  upper   = false
  lower   = true
  number  = true
}

