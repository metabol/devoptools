#Create a cloud user
/usr/sbin/useradd -m stack 

#Add user to sudoers group with nopasswd
/bin/mkdir -p /etc/sudoers.d/

echo "stack ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/stack

/bin/su - stack
