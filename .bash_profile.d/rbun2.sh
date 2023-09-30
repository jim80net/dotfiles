# Utility scripts for rbun2 jumpbox
function start_rbun2() {
   aws --profile ramtank_com ec2 start-instances --instance-ids i-09a99c3dbd0c792cb

   # Specify your security group ID
   SG_ID="sg-04495ae9ad4ef5497"
   
   # Fetch the current IP address
   MY_IP=$(curl -s checkip.amazonaws.com)
   
   # Fetch existing rules
   EXISTING_RULES=$(aws --profile ramtank_com ec2 describe-security-groups --group-ids $SG_ID --query 'SecurityGroups[].IpPermissions[]')
   
   # Revoke existing SSH rules
   echo $EXISTING_RULES | jq -c '.[] | select(.FromPort == 22 and .ToPort == 22 and .IpProtocol == "tcp")' | while read rule; do
       CIDR=$(echo $rule | jq -r '.IpRanges[].CidrIp')
       if [ ! -z "$CIDR" ]; then
           aws --profile ramtank_com ec2 revoke-security-group-ingress --group-id $SG_ID --protocol tcp --port 22 --cidr $CIDR
       fi
   done
   aws --profile ramtank_com ec2 authorize-security-group-ingress --group-id sg-04495ae9ad4ef5497 --protocol tcp --port 22 --cidr $MY_IP/32
   
}

export -f start_rbun2

function ssh_rbun2() {
   start_rbun2
   ssh rbun2
}

export -f ssh_rbun2
