# Utility scripts for rbun2 jumpbox
function start_rbun2() (
    ORIGINAL_AWS_PROFILE=$AWS_PROFILE
    AWS_PROFILE=ramtank_com
    aws ec2 start-instances --instance-ids i-09a99c3dbd0c792cb

    # Specify your security group ID
    SG_ID="sg-04495ae9ad4ef5497"
    
    # Fetch the current IP address
    MY_IP=$(curl -s checkip.amazonaws.com)

    # Fetch existing rules
    EXISTING_RULES=$(aws ec2 describe-security-groups --group-ids $SG_ID --query 'SecurityGroups[].IpPermissions[]')

    # Function to revoke rules
    revoke_rules() {
        local protocol=$1
        local from_port=$2
        local to_port=$3

        echo $EXISTING_RULES | jq -c ".[] | select(.FromPort >= $from_port and .ToPort <= $to_port and .IpProtocol == \"$protocol\")" | while read rule; do
            CIDR=$(echo $rule | jq -r '.IpRanges[].CidrIp')
            if [ ! -z "$CIDR" ]; then
                aws ec2 revoke-security-group-ingress --group-id $SG_ID --protocol $protocol --port $from_port-$to_port --cidr $CIDR
            fi
        done
    }

    # Revoke existing SSH and Mosh rules
    revoke_rules tcp 22 22
    revoke_rules udp 60000 61000

    # Authorize the inbound SSH and Mosh access from the current IP
    aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 22 --cidr $MY_IP/32
    aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol udp --port 60000-61000 --cidr $MY_IP/32

    # Restore original AWS profile. Probably redundant, given this is a subshell, but jic.
    AWS_PROFILE=$ORIGINAL_AWS_PROFILE
)

export -f start_rbun2

function ssh_rbun2() {
    start_rbun2
    ssh rbun2
}

export -f ssh_rbun2
