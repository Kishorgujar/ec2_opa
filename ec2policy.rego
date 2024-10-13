package ec2policy

# Define allowed instance types
allowed_instance_types = ["t2.micro"]

# Rule to allow specific instance types
allow {
    input.resource_type == "aws_instance"
    instance_type = input.instance_type
    instance_type_allowed(instance_type)
}

# Rule to deny all other instance types
deny {
    input.resource_type == "aws_instance"
    instance_type = input.instance_type
    not instance_type_allowed(instance_type)
}

# Helper function to check if instance type is allowed
instance_type_allowed(instance_type) {
    some i
    allowed_instance_types[i] == instance_type
}
