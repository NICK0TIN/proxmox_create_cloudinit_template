#!/bin/bash 

TEMP_ID=1002
TEMP_NAME="rhel9-cloud-init"
#TEMP_NAME="rhel8-cloud-init"
KVM_IMAGE_DIR="/opt/kvm_images"
#CLOUD_ISO='rhel-8.2-x86_64-kvm.qcow2'
CLOUD_ISO='rhel-9.2-x86_64-kvm.qcow2'

qm create $TEMP_ID --memory 2048 --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-single -name $TEMP_NAME

#qm create 1002 --memory 2048 --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-single -name deleteme
qm set $TEMP_ID --scsi0 local-lvm:0,import-from=$KVM_IMAGE_DIR/$CLOUD_ISO
sleep 0.5
qm set $TEMP_ID --ide2 local-lvm:cloudinit
sleep 0.5
qm set $TEMP_ID --boot order=scsi0
sleep 0.5
qm template $TEMP_ID
   
