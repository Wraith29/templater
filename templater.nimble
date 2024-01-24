# Package

version       = "1.0.1"
author        = "Isaac Naylor"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 2.1.1"

requires "regex"


# Tasks

task docs, "Docs":
  exec "nim doc --project -o:./docs ./src/templater.nim"

task test, "Run all Tests":
  exec "testament cat ." 
  exec "testament html"