CARGO = cargo
INSTALL = install
RM = rm

INSTALL_PROGRAM = $(INSTALL)
INSTALL_DATA = $(INSTALL) -m 644

prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
sysconfdir = $(prefix)/etc

all:
	$(CARGO) build --release

debug:
	$(CARGO) build

clean:
	$(CARGO) clean

install: all
	$(INSTALL) -d $(DESTDIR)$(bindir) $(DESTDIR)$(sysconfdir)
	$(INSTALL) target/release/labhub $(DESTDIR)$(bindir)/labhub
	if ! test -f $(DESTDIR)$(sysconfdir)/LabHub.toml; then \
		$(INSTALL) LabHub.toml $(DESTDIR)$(sysconfdir)/LabHub.toml; fi

uninstall:
	$(RM) -f $(DESTDIR)$(bindir)/labhub

.PHONY: all debug clean install uninstall
