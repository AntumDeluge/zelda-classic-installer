prefix = /usr/local
PACKAGE = zelda-classic
VERSION = 2-50-1
FILE = zc-$(VERSION)-linux.tar.gz
BINDIR = games

MKDIR = mkdir -vp
CP = cp -vR
LN = ln -vfs
RM = rm -vf

all:

download:
	@echo "\nSetting up Zelda Classic"; \
	if [ ! -f "/tmp/$(FILE)" ]; then \
		echo "Downloading file: $(FILE)"; \
		cd "/tmp"; \
		curl -O "http://www.zeldaclassic.com/files/$(FILE)"; \
	else \
		echo "Found previously cached file: $(FILE)"; \
	fi; \

extract: download
	@echo "\nExctacting archive contents ..."; \
	cd "/tmp"; \
	tar -vxzf "$(FILE)"; \
	chmod 0755 "Zelda Classic"; \

install: extract
	@target="$(DESTDIR)$(prefix)"; \
	data_dir="$${target}/share/$(PACKAGE)"; \
	if [ -d "$${data_dir}" ]; then \
		echo "\nRemoving previous installation files ..."; \
		find "$${data_dir}" -type f -print -delete; \
		find "$${data_dir}" -type d -empty -print -delete; \
	fi; \
	cd "/tmp"; \
	echo "\nInstalling Zelda Classic ..."; \
	if [ ! -d "$${target}/share" ]; then \
		$(MKDIR) "$${target}/share"; \
	fi; \
	$(CP) "Zelda Classic" "$${data_dir}"; \
	if [ ! -d "$${target}/$(BINDIR)" ]; then \
		$(MKDIR) "$${target}/$(BINDIR)"; \
	fi; \
	$(LN) "$(prefix)/share/$(PACKAGE)/zlaunch-l" "$${target}/$(BINDIR)/zelda-classic-launcher"; \

uninstall:
	@echo "\nUninstalling Zelda Classic ..."; \
	target="$(DESTDIR)$(prefix)"; \
	$(RM) "$${target}/$(BINDIR)/zelda-classic-launcher"; \
	find "$${target}/share/$(PACKAGE)" -type f -print -delete; \
	find "$${target}/share/$(PACKAGE)" -type d -empty -print -delete; \

