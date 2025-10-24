# Variables
FLAKE ?= $(CURDIR)
USER := $(shell whoami)
HOST := $(shell hostname)
OS := $(shell uname -s)

# Conditional variables
REBUILD := $(if $(findstring Darwin,$(OS)),sudo darwin-rebuild,nixos-rebuild)
SYSTEM_ARGS := $(if $(findstring Darwin,$(OS)),,--sudo --no-reexec --log-format internal-json)
NOM_CMD := $(if $(findstring Darwin,$(OS)),nom,nom --json)

# Default target
.PHONY: default
default:
	@echo "Available targets:"
	@echo "  rebuild/deploy      - Deploy to a host"
	@echo "  rebuild/deploy-all  - Deploy to all hosts"
	@echo "  rebuild/boot        - Rebuild the boot"
	@echo "  rebuild/test        - Test the configuration"
	@echo "  rebuild/switch      - Switch to the new configuration"
	@echo "  package/build       - Build a package"
	@echo "  package/iso         - Build an ISO image"
	@echo "  package/tar         - Build a tarball"
	@echo "  dev/check           - Check the flake for errors"
	@echo "  dev/repl-host       - Start a Nix REPL for a host"
	@echo "  dev/update          - Update flake inputs"
	@echo "  dev/push-mirrors    - Push to mirrors"
	@echo "  utils/verify        - Verify the Nix store"
	@echo "  utils/repair        - Repair the Nix store"
	@echo "  utils/clean         - Clean and optimize the Nix store"

# --- Rebuild Group ---
.PHONY: rebuild/deploy
rebuild/deploy: HOST ?= $(error Please specify a host)
rebuild/deploy:
	$(REBUILD) switch \
	  --flake $(FLAKE) \
	  $(SYSTEM_ARGS) \
	  --target-host $(HOST) --use-substitutes |& $(NOM_CMD)

.PHONY: rebuild/deploy-all
rebuild/deploy-all:
	$(MAKE) rebuild/deploy HOST=c0d3h01
	$(MAKE) rebuild/deploy HOST=eva

.PHONY: rebuild/boot
rebuild/boot:
	$(REBUILD) boot \
	  --flake $(FLAKE) \
	  $(SYSTEM_ARGS) |& $(NOM_CMD)

.PHONY: rebuild/test
rebuild/test:
	$(REBUILD) test \
	  --flake $(FLAKE) \
	  $(SYSTEM_ARGS) |& $(NOM_CMD)

.PHONY: rebuild/switch
rebuild/switch:
	$(REBUILD) switch \
	  --flake $(FLAKE) \
	  $(SYSTEM_ARGS) |& $(NOM_CMD)

.PHONY: rebuild/provision
rebuild/provision: HOST ?= $(error Please specify a host)
rebuild/provision:
	nix run github:LnL7/nix-darwin -- switch --flake $(FLAKE)#$(HOST)
	sudo -i nix-env --uninstall lix

# --- Package Group ---
.PHONY: package/build
package/build: PKG ?= $(error Please specify a package)
package/build:
	nix build $(FLAKE)#$(PKG) \
	  --log-format internal-json \
	  -v |& $(NOM_CMD)

.PHONY: package/iso
package/iso: IMAGE ?= $(error Please specify an image)
package/iso:
	$(MAKE) package/build PKG=nixosConfigurations.$(IMAGE).config.system.build.isoImage

.PHONY: package/tar
package/tar: HOST ?= $(error Please specify a host)
package/tar:
	sudo nix run $(FLAKE)#nixosConfigurations.$(HOST).config.system.build.tarballBuilder

# --- Dev Group ---
.PHONY: dev/check
dev/check:
	nix flake check --no-allow-import-from-derivation

.PHONY: dev/repl-host
dev/repl-host: HOST ?= $(HOST)
dev/repl-host:
	nix repl .#nixosConfigurations.$(HOST)

.PHONY: dev/update
dev/update: INPUT ?= ""
dev/update:
	nix flake update $(INPUT) \
	  --refresh \
	  --commit-lock-file \
	  --commit-lockfile-summary "flake.lock: update $(if $(INPUT),$(INPUT),all inputs)" \
	  --flake $(FLAKE)

.PHONY: dev/push-mirrors
dev/push-mirrors:
	git push git@gitlab.com:c0d3h01/dotfiles.git
	git push --mirror ssh://git@codeberg.org/c0d3h01/dotfiles.git

# --- Utils Group ---
.PHONY: utils/verify
utils/verify:
	nix-store --verify $(ARGS)

.PHONY: utils/repair
utils/repair:
	$(MAKE) utils/verify ARGS="--check-contents --repair"

.PHONY: utils/clean
utils/clean:
	nix-collect-garbage --delete-older-than 3d
	nix store optimise
