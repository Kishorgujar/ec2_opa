package ec2policy

# Define allowed instance types
allowed_instance_types = ["t2.micro"]

# Rule to allow specific instance types
allow {
    input.resource_type == "aws_instance"
    allowed_instance_types[_] == input.instance_type
}

# Rule to deny all other instance types
deny {
    input.resource_type == "aws_instance"
    not allowed_instance_types[_] == input.instance_type
}
