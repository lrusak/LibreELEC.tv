################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2016-     Team LibreELEC
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="glib"
PKG_VERSION="2.54.1"
PKG_SHA256="7413aedbfd3108aceea16e8b1b487d557066be3f8ce34dd3be308128c5caf5b7"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.gtk.org/"
PKG_URL="https://github.com/GNOME/glib/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib libffi Python3:host util-linux"
PKG_DEPENDS_HOST="Python3:host libffi:host pcre:host"
PKG_SECTION="devel"
PKG_SHORTDESC="glib: C support library"
PKG_LONGDESC="GLib is a library which includes support routines for C such as lists, trees, hashes, memory allocation, and many other things."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MESON_OPTS_HOST="-Dwith-docs=no \
                     -Dwith-man=no \
                     -Dwith-pcre=system \
                     -Denable-libmount=no \
                     -Denable-dtrace=false \
                     -Denable-systemtap=false"

PKG_MESON_OPTS_TARGET="-Dwith-docs=no \
                       -Dwith-man=no \
                       -Dwith-pcre=internal \
                       -Denable-libmount=no \
                       -Denable-dtrace=false \
                       -Denable-systemtap=false"

pre_configure_host() {
  export LC_ALL=en_US.UTF-8
}

pre_configure_target() {
  export LC_ALL=en_US.UTF-8

  # meson needs a host compiler and it's detected through the environment. meh.
  export CC="$HOST_CC"
  export CXX="$HOST_CXX"
}

post_makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/pkgconfig
    cp g*-2.0.pc $SYSROOT_PREFIX/usr/lib/pkgconfig

  mkdir -p $SYSROOT_PREFIX/usr/share/aclocal
    cp ../m4macros/glib-gettext.m4 $SYSROOT_PREFIX/usr/share/aclocal
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/lib/gdbus-2.0
  rm -rf $INSTALL/usr/lib/glib-2.0
  rm -rf $INSTALL/usr/share
}
