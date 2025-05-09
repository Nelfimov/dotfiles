install:
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
	nix run nix-darwin/master#darwin-rebuild -- switch

apply:
	darwin-rebuild switch --flake .#mac

update:
	nix flake update
	darwin-rebuild switch --flake .#mac

clear:
	nix-collect-garbage -d

show:
	nix-store --gc --print-dead
