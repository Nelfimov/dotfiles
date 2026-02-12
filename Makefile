first-time:
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
	nix run nix-darwin/master#darwin-rebuild -- switch --flake .#mac

apply:
	sudo darwin-rebuild switch --flake .#mac

update:
	nix flake update
	sudo darwin-rebuild switch --flake .#mac

update-nix:
	sudo determinate-nixd upgrade

clear:
	nix-collect-garbage -d

show:
	nix-store --gc --print-dead
