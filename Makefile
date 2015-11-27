all: install

install: install_dependencies add_symlinks

install_dependencies:
	chmod +x install/install_dependencies.rb
	./install/install_dependencies.rb dependencies.yml

add_symlinks:
	chmod +x install/add_symlinks.sh
	./install/add_symlinks.sh