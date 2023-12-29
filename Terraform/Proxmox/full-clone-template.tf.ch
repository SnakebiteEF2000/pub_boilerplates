# Proxmox Full-Clone
# ---
# Create a new VM from a clone

resource "proxmox_vm_qemu" "SERVER NAME" {
    
    # VM General Settings
    target_node = "pve01"
    vmid = ""
    name = ""
    desc = ""

    # proxmox tags
    tags = ""

    # VM Advanced General Settings
    onboot = true 

    # VM OS Settings 
    # Standard template
    clone = "ubuntu-server-jammy-test-1"

    # VM System Settings
    # qemu agent will be used
    agent = 1
    
    # VM CPU Settings
    cores = 1
    sockets = 1
    cpu = "host"    
    
    # VM Memory Settings
    memory = 1024

    # VM Network Settings
    network {
        bridge = "vmbr0"
        model  = "virtio"
        tag = 101
    }

    # VM Cloud-Init Settings
    os_type = "cloud-init"

    # (Optional) IP Address and Gateway
    # For DHCP:
    ipconfig0 = "ip=dhcp"
    
    # For Static IP
    # ipconfig0 = "ip=10.2.0.103/24,gw=10.2.0.1"
    
    # (Optional) Default User
    ciuser = "svc_linautomation"
    
    # (Optional) Add your SSH KEY
    # sshkeys = <<EOF
    # #YOUR-PUBLIC-SSH-KEY
    # EOF

    # Ignore qemu_os and sshkey changes in the cloud init drive 
    lifecycle {
        ignore_changes = [qemu_os, sshkeys]
    }
}