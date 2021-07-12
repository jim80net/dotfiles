function aws_get_asg_ip_addresses() {
   aws ec2 describe-instances --filter Name=tag:aws:autoscaling:groupName,Values=${1:?} Name=instance-state-code,Values=16 --query 'Reservations[*].Instances[*].PrivateIpAddress[]' --output text
}
export -f aws_get_asg_ip_addresses
