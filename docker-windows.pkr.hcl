packer {
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "windows" {
    image = "mcr.microsoft.com/windows/servercore:ltsc2022"
    container_dir = "c:/app"
    windows_container = true
    commit = true
}

build {
  name = "packer-windows"
  sources = [
    "source.docker.windows"
  ]
  provisioner "powershell" {
    scripts = [
      "scripts/browser_install.ps1",
      "scripts/Install_UiRobot_updated.ps1"
    ]
  }
}

