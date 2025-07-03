# Config
INVENTORY=ansible/inventory.ini
PLAYBOOK=ansible/lab.yml

# Targets
.PHONY: traefik__config__update

traefik__configure:
	ansible-playbook -i $(INVENTORY) --ask-vault-pass $(PLAYBOOK) --tags traefik

monitoring__prometheus__configure:
	ansible-playbook -i $(INVENTORY) --ask-vault-pass $(PLAYBOOK) --tags prometheus