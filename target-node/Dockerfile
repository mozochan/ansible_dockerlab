FROM almalinux:9.4

# Install SSH Server and sudo
RUN dnf update -y && \
    dnf install -y openssh-server sudo && \
    dnf clean all

# Create ansibleuser and grant sudo privileges
RUN useradd -m -s /bin/bash ansibleuser && \
    echo "ansibleuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create SSH Host Key
RUN mkdir -p /home/ansibleuser/.ssh && \
    chmod 700 /home/ansibleuser/.ssh && \
    chown ansibleuser:ansibleuser /home/ansibleuser/.ssh && \
    ssh-keygen -A

# Permit PubkeyAuthentication and RootLogin
RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Copy Public Key from control-node image
COPY --from=ansible_dockerlab-control-node --chown=ansibleuser:ansibleuser /home/ansibleuser/.ssh/id_rsa.pub /home/ansibleuser/.ssh/authorized_keys

# Start SSH Server
CMD ["/usr/sbin/sshd", "-D"]
