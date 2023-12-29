resource "proxmox_vm_qemu" "k8s" {
  count = 0

  # VM General Settings
  target_node = "pve01"
  vmid = "80${count.index + 1}"
  name = "k8s-${count.index + 1}"
  desc = "Kubernetes Node ${count.index + 1}"

  # Add the VM to the existing pool
  pool = "k8s_vms"

  # proxmox tags
  tags = "k8s"

  # VM Advanced General Settings
  onboot = true 

  # VM OS Settings 
  clone = "ubuntu-server-jammy-test-1"

  # VM System Settings
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
    # Vlan tag for Kubernetes vms NOT YET DETERMINED
    tag = 101
  }

  # VM Cloud-Init Settings
  os_type = "cloud-init"

  # (Optional) IP Address and Gateway
  ipconfig0 = "ip=dhcp"
    
  # (Optional) Default User
  ciuser = "svc_linautomation"
    
  # (Optional) Add your SSH KEY
  sshkeys = var.ssh_key

  # Ignore qemu_os and sshkey changes in the cloud init drive 
  lifecycle {
    ignore_changes = [qemu_os, sshkeys]
  }
}
