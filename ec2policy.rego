package ec2policy

# Define allowed instance types
allowed_instance_types = ["t2.micro"]

# Rule to allow specific instance types
allow {
    input.resource_type == "aws_instance"
    input.instance_type in allowed_instance_types
}

# Rule to deny all other instance types
deny {
    input.resource_type == "aws_instance"
    not input.instance_type in allowed_instance_types
}
