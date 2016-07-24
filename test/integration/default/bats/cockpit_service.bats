#!/usr/bin/env bats

@test "Cockpit service is running" {
  run systemctl is-active cockpit.service --quiet
  [ "$status" -eq 0 ]
}
