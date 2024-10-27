FROM almalinux:9.4

# Install necessary packages
RUN dnf update -y && \
    dnf install -y epel-release && \
    dnf install -y ansible-core openssh-clients vim sudo && \
    dnf clean all

# Create ansibleuser and grant sudo privileges
RUN useradd -m -s /bin/bash ansibleuser && \
    echo "ansibleuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Setup ssh_key for target-node
RUN mkdir -p /home/ansibleuser/.ssh && \
    chmod 700 /home/ansibleuser/.ssh && \
    ssh-keygen -t rsa -f /home/ansibleuser/.ssh/id_rsa -q -C "" -N "" && \
    chown -R ansibleuser:ansibleuser /home/ansibleuser/.ssh

# Copy ansible.cfg and hosts to container
COPY --chown=ansibleuser:ansibleuser .ansible.cfg /home/ansibleuser/
COPY --chown=ansibleuser:ansibleuser hosts /home/ansibleuser/

# Set default user to ansibleuser
USER ansibleuser

# Set default directory
WORKDIR /home/ansibleuser

# Keep Docker Container running
CMD ["tail", "-F", "/dev/null"]
