# Download the cloud image
wget  https://ftp-stud.hs-esslingen.de/pub/Mirrors/alt.fedoraproject.org/atomic/stable/Fedora-Atomic-25-20170512.2/CloudImages/x86_64/images/Fedora-Atomic-25-20170512.2.x86_64.qcow2
 
# If using HyperV, convert it to VHD format
qemu-img convert -f qcow2 -O vhdx Fedora-Atomic-25-20170512.2.x86_64.qcow2 fedora-atomic.vhdx
 
# Provision the cloud image, I'm using KVM so using the qcow2 image
openstack image create --public --property os_distro='fedora-atomic' --disk-format qcow2 \
--container-format bare --file /root/Fedora-Atomic-25-20170512.2.x86_64.qcow2 \
fedora-atomic.qcow2
 
# Create a flavor
nova flavor-create cloud.flavor auto 2048 7 1 --is-public True
 
# Create a key pair
openstack keypair create --public-key ~/.ssh/id_rsa.pub kolla-ubuntu
 
# Create Neutron networks
# Public network
neutron net-create public_net --shared --router:external --provider:physical_network \
physnet2 --provider:network_type flat
 
neutron subnet-create public_net 10.7.15.0/24 --name public_subnet \
--allocation-pool start=10.7.15.150,end=10.7.15.180 --disable-dhcp --gateway 10.7.15.1
 
# Private network
neutron net-create private_net_vlan --provider:segmentation_id 500 \
--provider:physical_network physnet1 --provider:network_type vlan
 
neutron subnet-create private_net_vlan 10.10.20.0/24 --name private_subnet \
--allocation-pool start=10.10.20.50,end=10.10.20.100 \
--dns-nameserver 8.8.8.8 --gateway 10.10.20.1
 
# Create a router
neutron router-create router1
neutron router-interface-add router1 private_subnet
neutron router-gateway-set router1 public_net
