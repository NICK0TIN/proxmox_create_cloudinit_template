#!/bin/bash 

TEMP_ID=1001
TEMP_NAME="RHEL9 CLOUD INIT"
TEMP_NAME="RHEL8 CLOUD INIT"
CLOUD_ISO='/opt/rhel-8.2-x86_64-kvm.qcow2'


qm create $TEMP_ID --memory 2048 --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-single
qm set $TEMP_ID --scsi0 local-lvm:0,import-from=$CLOUD_ISO
qm set $TEMP_ID --ide2 local-lvm:cloudinit
qm set $TEMP_ID --boot order=scsi0
qm template $TEMP_ID
   
