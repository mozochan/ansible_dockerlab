# ansible_dockerlab

This is a simple Ansible lab with docker compose on almalinux 9.4.

## Requirements

- Install Docker and Docker Compose.
- If you want to start the lab as a non-root user, create a Unix group called docker and add users to it.

## Usage

### Start Lab

```bash
git clone https://github.com/mozochan/ansible_dockerlab.git
cd ansible_dockerlab
make up
```

When you start the lab, the following containers will be created.

| Container_name/hostname | Applications                                      |
| ----------------------- | ------------------------------------------------- |
| control-node            | Ansible control node with ansible-core installed  |
| target-node1            | Ansible target node with openssh-server installed |
| target-node2            | Ansible target node with openssh-server installed |

### Login containers and test Ansible

Login into Ansible control node.

Default user on the control node is ansibleuser.

```bash
make con
ansible all -m ping
```

You can login into Ansible target node with following commands.

Default user on the target node is root.

```bash
# Login into target-node1
make tar1

# Login into target-node2
make tar2
```

### Stop containers

```bash
make stop
```

### Delete containers

Delete containers and network.

```bash
make down
```

If you also want to delete Docker image.

```bash
make clean
```

### Make commands

| Command            | Action                                                   | Dependencies  |
| ------------------ | -------------------------------------------------------- | ------------- |
| make build_control | docker compose build control-node                        | -             |
| make build_target  | docker compose build target-node1                        | build_control |
| make up            | docker compose up -d                                     | build_target  |
| make ps            | docker compose ps -a                                     | -             |
| make stop          | docker compose stop                                      | -             |
| make down          | docker compose down                                      | -             |
| make con           | docker compose exec control-node bash                    | -             |
| make tar1          | docker compose exec target-node1 bash                    | -             |
| make tar2          | docker compose exec target-node2 bash                    | -             |
| make clean         | docker compose down --rmi all --volumes --remove-orphans | -             |
