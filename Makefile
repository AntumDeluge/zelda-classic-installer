NAME = zelda-classic
SCRIPT = $(NAME)-launcher
MENU = $(SCRIPT).desktop
PIXMAP = $(NAME).png
VERSION = 2-50-2
PACKAGE = $(NAME)-installer

# DEPRECATED: These variables are unused
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


all:

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
	\
	echo "\nInstalling launcher script ..."; \
	$(INSTALL) "data/$(SCRIPT)" "$(BINDIR)"; \
	echo "\nInstalling menu pixmap ..."; \
	$(INSTALL_DATA) "data/$(PIXMAP)" "$(PIXMAPDIR)"; \
	echo "\nInstalling menu launcher ..."; \
	$(INSTALL_DATA) "data/$(MENU)" "$(MENUDIR)"; \
	\
	echo "\nChecking installation ..."; \
	if [ -e "$(BINDIR)/$(SCRIPT)" ]; then \
		echo "Executable script found: $(BINDIR)/$(SCRIPT)"; \
		echo "Running setup ..."; \
		"$(BINDIR)/$(SCRIPT)" setup; \
	else \
		echo "ERROR: Could not find executable script: $(BINDIR)/$(SCRIPT)"; \
	fi; \

uninstall:
	@echo "\nUninstalling menu launcher ..."; \
	$(UNINSTALL) "$(MENUDIR)/$(MENU)"; \
	echo "\nUninstalling menu pixmap ..."; \
	$(UNINSTALL) "$(PIXMAPDIR)/$(PIXMAP)"; \
	echo "\nUninstalling launcher script ..."; \
	$(UNINSTALL) "$(BINDIR)/$(SCRIPT)"; \

dist:
	@tar -vcJ --exclude="debian" --exclude="*.tar.*" -f "$(PACKAGE).tar.xz" *; \
