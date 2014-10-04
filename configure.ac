# Top-level configure.ac for the KRoC tree.

AC_INIT([tvm], [2.0.0], [tvm-bugs@concurrency.cc])
AC_PREREQ(2.59)
AC_CANONICAL_SYSTEM

AM_INIT_AUTOMAKE([-Wall foreign])

OCCAM_TOOLCHAIN
KROC_BUILD_ROOT="`pwd`"
KROC_SRC_ROOT="`(cd $srcdir && pwd)`"
OCCAM_OCCBUILD

if test "x$OCCBUILD_API_VERSION" != x3; then
  AC_MSG_ERROR([this configure script has been built with an out-of-date version of `occbuild.m4'; try clearing your `ACLOCAL' environment variable.])
fi

#OCCAM_CONFIG_SUBDIRS(tools/ilibr)
#OCCAM_CONFIG_SUBDIRS(tools/mkoccdeps)
#OCCAM_CONFIG_SUBDIRS(tools/occ21)
#OCCAM_CONFIG_SUBDIRS(tools/occamdoc)

#OCCAM_CONFIG_SUBDIRS(tools/plinker)
#OCCAM_CONFIG_SUBDIRS(tools/tenctool)
#OCCAM_CONFIG_SUBDIRS(tools/skroc)
#OCCAM_CONFIG_SUBDIRS(tools/slinker)
#OCCAM_CONFIG_SUBDIRS(tools/tinyswig)

OCCAM_CONFIG_TARGET_SUBDIRS(runtime/libtvm)

AC_ARG_WITH([wrapper],
            AC_HELP_STRING([--with-wrapper=...],
                           [Transterpreter wrapper to use (posix, arduino)]),
            [wrapper=$withval], [wrapper=posix])
if test "x$wrapper" = "xposix"; then
  OCCAM_CONFIG_TARGET_SUBDIRS(wrappers/posix)
fi

# The modules must be built in dependency order.
#OCCAM_CONFIG_TARGET_SUBDIRS(modules/inmoslibs/libsrc)
#OCCAM_CONFIG_TARGET_SUBDIRS(modules/bsclib/libsrc)
#OCCAM_CONFIG_TARGET_SUBDIRS(modules/cif/libsrc)

#OCCAM_CONFIG_TARGET_SUBDIRS(modules/random/libsrc)
#OCCAM_CONFIG_TARGET_SUBDIRS(modules/time/libsrc)
#OCCAM_CONFIG_TARGET_SUBDIRS(modules/raster/libsrc)

#OCCAM_CONFIG_SUBDIRS(doc)

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
OCCAM_OUTPUT_SUBDIRS
