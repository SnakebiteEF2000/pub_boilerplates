# Proxmox Full-Clone
# ---
# Create a new VM from a clone

resource "proxmox_vm_qemu" "SRV008" {
    
    # VM General Settings
    target_node = "pve01"
    vmid = "104"
    name = "SRV008"
    desc = "VMnet Docker host"

    tags = "docker-host"

    # VM Advanced General Settings
    onboot = true 

    # VM OS Settings
    clone = "ubuntu-server-jammy-test-1"

    # VM System Settings
    agent = 1
    
    # VM CPU Settings
    cores = 2
    sockets = 1
    cpu = "host"    
    
    # VM Memory Settings
    memory = 2048

    # VM Network Settings
    network {
        bridge = "vmbr0"
        model  = "virtio"
        tag = 101
    }

    # VM Cloud-Init Settings
    os_type = "cloud-init"

    # (Optional) IP Address and Gateway
    ipconfig0 = "ip=10.2.0.103/24,gw=10.2.0.1"
    
    # (Optional) Default User
    ciuser = "svc_linautomation"
    
    # (Optional) Add your SSH KEY
    sshkeys = var.ssh_key

    # Ignore qemu_os changes DEBUG
    lifecycle {
        ignore_changes = [qemu_os, sshkeys]
    }
}