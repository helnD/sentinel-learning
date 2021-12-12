param "day" {
  value = "monday"
}

param "hour" {
  value = 14
}

test {
  rules = {
    main          = true
    is_open_hours = false
  }
}