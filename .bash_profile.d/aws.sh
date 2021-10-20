function aws_get_asg_ip_addresses() {
   aws ec2 describe-instances --filter Name=tag:aws:autoscaling:groupName,Values=${1:?} Name=instance-state-code,Values=16 --query 'Reservations[*].Instances[*].PrivateIpAddress[]' --output text
}
export aws_get_asg_ip_addresses

function aws_get_asg_from_instance_id() {
   aws --region us-east-1  ec2 describe-instances --instance-ids ${1:?} --query 'Reservations[].Instances[].Tags[?Key==`aws:autoscaling:groupName`].Value | [0][0]' --output text
}

export aws_get_asg_from_instance_id


function aws_refresh_asg_from_instance_id() {
   aws_get_asg_from_instance_id ${1:?} |xargs  aws autoscaling start-instance-refresh --auto-scaling-group-name
}

export aws_refresh_asg_from_instance_id

function aws_ecs_instance_id_from_container_instance() {
   aws ecs describe-container-instances --cluster appmesh-staging --container-instances  ${1:?} --query "containerInstances[].ec2InstanceId" --output text
}

export aws_ecs_instance_id_from_container_instance


function aws_ec2_ip_address_from_instance_id() {
    aws ec2 describe-instances --instance-ids ${1:?} --query "Reservations[].Instances[].PrivateIpAddress" --output text
}

export aws_ec2_ip_address_from_instance_id

function aws_ssh_ecs_host_running_container_instance() {
   ssh ec2-user@$(aws_ec2_ip_address_from_instance_id $(aws_ecs_instance_id_from_container_instance ${1:?}))
}

export function aws_ssh_ecs_host_running_container_instance
