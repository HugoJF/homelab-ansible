# Config
INVENTORY=inventory.ini
PLAYBOOK=lab.yml

# Targets
.PHONY: traefik__config__update

traefik__config__update:
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK)
