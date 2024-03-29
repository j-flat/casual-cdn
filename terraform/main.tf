variable "SSH_USER" {}
variable "SSH_PUB_KEY" {}

resource "google_compute_instance" "casual_cdn" {
    name = var.machine_name
    machine_type = var.machine_type
    zone = var.zone
    can_ip_forward = "false"
    description = "NGINX Server running on CentOS-6 utilising Varnish for caching requests. Last updated at ${timestamp()}"

    # FIREWALL RULES
    tags = ["http-server", "https-server", "allow-ssh"]

    boot_disk {
        initialize_params {
            image = var.image
            size = var.boot_disk_size
        }
    }

    labels = {
        name = var.machine_name
        machine_type = var.machine_type
        region = var.region
        zone = var.zone
        image = replace(var.image, "/", "_")
        boot_disk_size = var.boot_disk_size
    }

    network_interface {
        network = "default"

        access_config {

        }
    }

    metadata = {
        ssh-keys = "${var.SSH_USER}:${file(var.SSH_PUB_KEY)}"
    }

    metadata_startup_script = "${file("../bash/startup.sh")}"

    service_account {
        scopes = ["userinfo-email", "compute-ro", "storage-ro"]
    }
}