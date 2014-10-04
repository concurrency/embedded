# Top-level Makefile.am for the Embedded TVM tree.

ACLOCAL_AMFLAGS = -I m4

SUBDIRS = @occam_subdirs@

EXTRA_DIST = \
	.gitignore \
	BUGS \
	CHANGELOG \
	README 
  
aclocaldir = $(prefix)/share/aclocal
dist_aclocal_DATA = \
	m4/occbuild.m4 \
	m4/tvm.m4

all-local: display-message

DISTCLEANFILES = in-tree-modules
