# Ansible Overview & Basic Usage
### What is Ansible?
Ansible is a configuration management tool used to manage both software and hardware across multiple servers. It allows you to automate tasks like software installation, updates, and system configurations.

One key advantage of Ansible is that it is agentless, meaning only the control node requires Ansible installation, while the worker nodes (managed servers) do not need any additional software. Ansible runs on Python and uses SSH to communicate with worker nodes.


## Setting Up SSH Connection (Control Node to Worker Node)
To manage worker nodes, Ansible connects via SSH. You can authenticate using either password-based login or passwordless authentication (recommended).
### Steps for Password-Based SSH Authentication:
1. On the worker node, set a root password using:
   ```
   passwd
   ```

2. Modify SSH configurations:
   - Open /etc/ssh/sshd_config.d/60-custom.conf (for newer systems) or /etc/ssh/sshd_config (for older systems).
   - Set the following values:
   ```
   PermitRootLogin yes
   PasswordAuthentication yes
   ```
  - Save and exit.

3. Restart the SSH service:
   
