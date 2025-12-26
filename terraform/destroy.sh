TF_CMD="docker compose -f docker-compose.yml run --rm terraform"

terraform_destroy() {
    local TERRAFORM_ENV="$1"
    export TERRAFORM_ENV
    $TF_CMD init -upgrade
    $TF_CMD destroy -auto-approve
}

terraform_destroy "proxmox1"