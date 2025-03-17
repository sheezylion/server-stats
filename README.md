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
   - For RHEL-based systems (RedHat, CentOS, Rocky Linux, etc):
     ```
     systemctl restart sshd
     ```

   - For Debian-based systems (Ubuntu, Debian, etc.):
     ```
      systemctl restart ssh
     ```

## Setting Up Passwordless SSH Authentication (Recommended)

1. On the control node, generate an SSH key pair:

```
ssh-keygen
```

2. Copy the public key to the worker node:
```
ssh-copy-id root@<worker-node-ip>
```

Enter the root password when prompted. Once done, the control node can connect without requiring a password.

3. To confirm connectivity, run:

```
ssh root@<worker-node-ip>
```
If successful, it should log in without asking for a password.
     
   
## Testing Ansible Connection
Once SSH is set up, test the connection using Ansible:

```
ansible all -i inventory.ini -m ping
```

A successful connection will return:

```
<worker-ip> | SUCCESS => {...}
```

## Ansible Ad-Hoc Commands vs Playbooks
- Ad-Hoc Commands → Used for simple, one-time tasks. Example:

```
ansible all -i inventory.ini -m apt -a "name=apache2 state=present" --become
```

- Playbooks → Used for automating multiple tasks in a structured manner. Example:

```
ansible-playbook -i inventory.ini playbook.yml
```

## Gathering System Information
To check system details of worker nodes, use:

```
ansible all -i inventory.ini -m setup
```

This fetches detailed facts about each server, including OS version, CPU, memory, and more.

## Next Steps: Ansible Roles & Vaults
Ansible Roles → Organizing playbooks for better reusability and structure.
Ansible Vault → Encrypting sensitive data (e.g., passwords, API keys) in playbooks.



   
