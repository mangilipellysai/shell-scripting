#!/bin/bash

# Variables (update these)
AMI_ID="ami-0220d79f3f480ecf5"     # Replace with your AMI ID
INSTANCE_TYPE="t3.micro"
KEY_NAME="my-key"
SECURITY_GROUP_ID="sg-0ce84b8a37dc8b1a7"
SUBNET_ID="subnet-0ba5c87ec6c6d92e0"

# Instance names
INSTANCES=("frontend" "mysql" "mongodb" "cart" "shipping")

for i in "${INSTANCES[@]}"
do
    if [ "$i" == "frontend" ]; then
        echo "Creating frontend instance with PUBLIC IP..."

        aws ec2 run-instances \
            --image-id $AMI_ID \
            --count 1 \
            --instance-type $INSTANCE_TYPE \
            --security-group-ids $SECURITY_GROUP_ID \
            --subnet-id $SUBNET_ID \
            --associate-public-ip-address \
            --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]"

    else
        echo "Creating $i instance with PRIVATE IP..."

        aws ec2 run-instances \
            --image-id $AMI_ID \
            --count 1 \
            --instance-type $INSTANCE_TYPE \
            --security-group-ids $SECURITY_GROUP_ID \
            --subnet-id $SUBNET_ID \
            --no-associate-public-ip-address \
            --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]"
    fi

done

echo "All instances created successfully!"