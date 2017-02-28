NAME = zelda-classic
SCRIPT = $(NAME)-launcher
MENU = $(SCRIPT).desktop
PIXMAP = $(NAME).png

# DEPRECATED: These variables are unused
PACKAGE = $(NAME)-installer
VERSION = 2-50-1
FILE = zc-$(VERSION)-linux.tar.gz

prefix = /usr/local
TARGET = $(DESTDIR)$(prefix)
BINDIR = $(TARGET)/games
DATAROOT = $(TARGET)/share
MENUDIR = $(DATAROOT)/applications
PIXMAPDIR = $(DATAROOT)/pixmaps

MKDIR = mkdir -vp
INSTALL = install -vm 0755
INSTALL_DATA = install -vm 0644
UNINSTALL = rm -vf
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

install:
	@echo "\nCreating required directory tree ..."; \
	if [ ! -d "$(BINDIR)" ]; then \
		$(MKDIR) "$(BINDIR)"; \
	fi; \
	if [ ! -d "$(MENUDIR)" ]; then \
		$(MKDIR) "$(MENUDIR)"; \
	fi; \
	if [ ! -d "$(PIXMAPDIR)" ]; then \
		$(MKDIR) "$(PIXMAPDIR)"; \
	fi; \
	echo "\nInstalling launcher script ..."; \
	$(INSTALL) "data/$(SCRIPT)" "$(BINDIR)"; \
	echo "\nInstalling menu pixmap ..."; \
	$(INSTALL_DATA) "data/$(PIXMAP)" "$(PIXMAPDIR)"; \
	echo "\nInstalling menu launcher ..."; \
	$(INSTALL_DATA) "data/$(MENU)" "$(MENUDIR)"; \

uninstall:
	@echo "\nUninstalling menu launcher ..."; \
	$(UNINSTALL) "$(MENUDIR)/$(MENU)"; \
	echo "\nUninstalling menu pixmap ..."; \
	$(UNINSTALL) "$(PIXMAPDIR)/$(PIXMAP)"; \
	echo "\nUninstalling launcher script ..."; \
	$(UNINSTALL) "$(BINDIR)/$(SCRIPT)"; \
