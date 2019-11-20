resource "google_compute_firewall" "allow-http" {
    name = "allow-http"
    network = "default"

    allow {
        protocol = "tcp"
        ports = ["80", "8080"]
    }

    target_tags = ["http-server"]
}

resource "google_compute_firewall" "allow-https" {
    name = "allow-https"
    network = "default"

    allow {
        protocol = "tcp"
        ports = ["443"]
    }

    target_tags = ["https-server"]
}

resource "google_compute_firewall" "allow-ssh" {
    name = "allow-ssh"
    network = "default"

    allow {
        protocol = "tcp"
        ports = ["22"]
    }

    target_tags = ["allow-ssh"]
}