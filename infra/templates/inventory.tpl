all:
  hosts: 
    ${public_ip}
  vars:
    ansible_ssh_private_key_file: ${key_name}
    ansible_user: ${username}