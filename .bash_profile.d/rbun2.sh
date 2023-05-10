# Utility scripts for rbun2 jumpbox
function start_rbun2() {
   aws --profile ramtank_com ec2 start-instances --instance-ids i-036886a6107d94345
}

export -f start_rbun2

function ssh_rbun2() {
   start_rbun2
   ssh rbun2
}

export -f ssh_rbun2
