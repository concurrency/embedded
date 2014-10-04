# Top-level Makefile.am for the KRoC tree.

ACLOCAL_AMFLAGS = -I m4

SUBDIRS = @occam_subdirs@

EXTRA_DIST = \
	.gitignore \
	BUGS \
	CHANGELOG \
	README 
  
aclocaldir = $(prefix)/share/aclocal
dist_aclocal_DATA = \
	m4/kroc.m4 \
	m4/occam-mysql.m4 \
	m4/occam-opengl.m4 \
	m4/occam-pkg.m4 \
	m4/occam-sdl.m4 \
	m4/occam-cuda.m4 \
	m4/occbuild.m4 \
	m4/tvm.m4

all-local: display-message

DISTCLEANFILES = in-tree-modules
