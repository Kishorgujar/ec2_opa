package ec2policy

# Define allowed instance types
allowed_instance_types = ["t2.micro"]

# Rule to allow specific instance types
allow {
    input.resource_type == "aws_instance"
    instance_type_allowed(input.instance_type)
    print("Allowing instance type:", input.instance_type)
}

# Rule to deny all other instance types
deny {
    input.resource_type == "aws_instance"
    not instance_type_allowed(input.instance_type)
    print("Denying instance type:", input.instance_type)
}

# Helper function to check if the instance type is allowed
instance_type_allowed(instance_type) {
    allowed_instance_types[_] == instance_type
}
