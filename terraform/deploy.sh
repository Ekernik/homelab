TF_CMD="docker compose -f docker-compose.yml run --rm terraform"

terraform_apply() {
    local TERRAFORM_ENV="$1"
    export TERRAFORM_ENV
    $TF_CMD init -upgrade
    $TF_CMD apply -auto-approve
}

terraform_apply "proxmox1"