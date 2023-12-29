# Proxmox Full-Clone
# ---
# Create a new VM from a clone

resource "proxmox_vm_qemu" "isp-router" {
    
    # VM General Settings
    target_node = "pve01"
    vmid = "600"
    name = "isp-router"
    desc = "router"

    # proxmox tags
    tags = "isp"

    # VM Advanced General Settings
    onboot = true 

    # VM OS Settings 
    # Standard template
    clone = "ubuntu-server-jammy-test-1"

    # VM System Settings
    # qemu agent will be used
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
        tag = 999
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
    sshkeys = <<EOF
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC1KWuObVnf0JDcZK3Rpd8czpCbSw7tNrVbzjdbiI7t1+Ui9xjbRE+porS60c+/Xf+32UyQd/KDlLybPwbGnM9hb9y7FPrOMhCV3USG2b15H1JUDDJ6ppkXQOnflmpGwd/wJGFwJVUAOq7LKdawW1/7cyfcbPsoFOh7nIv+lh5Nba8XYh90b983ukl+NegGOXhdhPPJvBDEWhlVoD30DMi+afayGpuEJFn4OEgZyWh8I9jEc2yTkXdkli409WHr+uxynCY6h8cVAKgzSFGCsXgVsEWFvKoZxK/npt/HynMA6+VpVpXJTvdjtycDiQ4OmHMEDw5sTy3Rc8EleMjajA5tDIvFydjrb0ec2qLGZ1I1dbhRdcYnyZWfrZ7fWsxvhdZ6sGj2IuK10z7AOOXA1yBM/eVw6HH6L2HpxMITPYi35me4jmFvKvj9m1GYO7jp8DC/4QluzXrAy7rVzztxCWZ2GaMgi7rD7yuK54gPRiAGNHYX9a0jAmJay7MP7aK9lQM= root@tele-jump-host
    EOF

    # Ignore qemu_os and sshkey changes in the cloud init drive 
    lifecycle {
        ignore_changes = [qemu_os, sshkeys]
    }
}