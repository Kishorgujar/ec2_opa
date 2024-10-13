package ec2policy

# Define allowed instance types
allowed_instance_types = ["t2.micro"]

# Rule to allow specific instance types
allow {
    input.resource_type == "aws_instance"
    some instance_type
    instance_type = input.instance_type
    instance_type == allowed_instance_types[_]
}

# Rule to deny all other instance types
deny {
    input.resource_type == "aws_instance"
    some instance_type
    instance_type = input.instance_type
    not instance_type == allowed_instance_types[_]
}
