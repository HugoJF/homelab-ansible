# Config
INVENTORY=ansible/inventory.ini
PLAYBOOK=ansible/lab.yml

TERRAFORM=terraform -chdir=config

# Targets
.PHONY: traefik__config__update

default: tf_apply traefik__configure

tf_plan:
	cd terraform && $(TERRAFORM) plan

tf_apply:
	cd terraform && $(TERRAFORM) apply -auto-approve

tf_upgrade:
	cd terraform && $(TERRAFORM) init -upgrade

traefik__configure:
	ansible-playbook -i $(INVENTORY) --ask-vault-pass $(PLAYBOOK) --tags traefik

monitoring__prometheus__configure:
	ansible-playbook -i $(INVENTORY) --ask-vault-pass $(PLAYBOOK) --tags prometheus