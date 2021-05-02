all:
	@echo "choose a specific target to configure"
	@exit 1

.PHONY: terraform
terraform:
	cd _terraform && terraform apply

.PHONY: elk.ln.oefd.net
elk.ln.oefd.net:
	sudo salt-call --file-root=_salt --pillar-root=_pillar --local state.apply

.PHONY: vole.li.oefd.net
thrush.vl.oefd.net:
	salt-ssh --config-dir=saltcfg "thrush.vl.oefd.net" state.apply
