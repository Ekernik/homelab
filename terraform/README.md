# Terraform

[Terraform](https://developer.hashicorp.com/terraform) is an Infrastructure as Code tool that lets me build, change, and version LXCs inside Proxmox safely and efficiently.

## Steps to recreate environment

### Creating Terraform user in Proxmox and configuring it's permissions

1. Create Terraform User 
    - Proxmox -> Datacenter -> Permissions -> Users -> Add
    - Username: terraform
    - Realm: Linux PAM
    - Add

2. Create Terraform Role 
    - Proxmox -> Datacenter -> Permissions -> Roles -> Create
    - Name: TerraformProvision
    - Privileges: 
        - Datastore.AllocateSpace
        - Datastore.Audit
        - Pool.Allocate
        - SDN.Use
        - Sys.Audit
        - Sys.Console
        - Sys.Modify
        - Sys.PowerMgmt
        - VM.Allocate
        - VM.Audit
        - VM.Clone
        - VM.Config.CDROM
        - VM.Config.CPU
        - VM.Config.Cloudinit
        - VM.Config.Disk
        - VM.Config.HWType
        - VM.Config.Memory
        - VM.Config.Network
        - VM.Config.Options
        - VM.Migrate
        - VM.Monitor
        - VM.Power.Mgmt
    - Create

3.  Create Terraform Group
    - Proxmox -> Datacenter -> Permissions -> Groups -> Create
    - Name: terraform
    - Create

4.  Apply Terraform Role on Terraform Group
    - Proxmox -> Datacenter -> Permissions -> Add -> Group Permission
    - Path: /
    - Group: terraform
    - Role: TerraformProvision
    - Propagate: true

5.  Add Terraform User to the Terraform Group
    - Proxmox -> Datacenter -> Permissions -> Users
    - terraform -> Edit 
    - Group: terraform
    - Ok

### Creating API Token

1.  Issue API Token for Terraform User
    - Proxmox -> Datacenter -> Permissions -> API Tokens -> Add
    - User: terraform@pam
    - Token ID: terraform
    - Privelege Separation: false
    - Add

> Secret will be displayed only once, make sure to save it somewhere
> Save Token ID as well.

### Install terraform on control node

```bash
wget <terraform-binary-url>
unzip <downloaded-binary-url>
mv terraform /usr/share/bin/
chown root:root /usr/share/bin/terraform
rm <downloaded-zip-archive>
```

### Use Terraform

[Proxmox Provider Documentation](https://github.com/Telmate/terraform-provider-proxmox/blob/master/docs/index.md)

```bash
cd terraform/envs/lab
terraform init
terraform plan
terraform apply
```
