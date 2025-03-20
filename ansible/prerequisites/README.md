# Prerequisite to creating ansible collections to connect to cloud platform like AWS

## To Setup EC-2 instances

### Install boto3

```
pip install boto3
```

### Install aws collection

```
ansible-galaxy collection install amazon.aws
```

### Setup vault

1. Create a password for vault

```
openssl rand -base64 2048 > vault.pass
```

2. Add your aws credentials using the below vault command

```
ansible-vault create group_vars/all/pass.yml --vault-password-file vault.pass
```

3. To run the command to create ec2 instances

```
ansible-playbook ec2_create.yml --vault-password-file vault.pass
```
