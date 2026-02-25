# Basic Terraform Provider Configuration
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# Example: Resource for the User Service Container
# (In production, this would be AWS ECS, Kubernetes, etc.)
resource "docker_image" "user_service" {
  name = "micro-user-service:latest"
  # This image would be built by Nix and loaded/pushed
}

resource "docker_container" "user_service" {
  image = docker_image.user_service.image_id
  name  = "user-service"
  ports {
    internal = 8080
    external = 8081
  }
  networks_advanced {
    name = "ecommerce_network"
  }
}

resource "docker_network" "ecommerce_network" {
  name = "ecommerce_network"
}
