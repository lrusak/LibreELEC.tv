################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="odroid-remote"
PKG_VERSION="00b09c9"
PKG_REV="1"
PKG_ARCH="arm aarch64"
PKG_LICENSE="other"
PKG_SITE="http://www.amlogic.com"
PKG_URL="https://github.com/mdrjr/c1_irremote/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="c1_irremote-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="sysutils/remote"
PKG_SHORTDESC="odroid-remote - IR remote configuration utility for odroid-based devices"
PKG_LONGDESC="odroid-remote - IR remote configuration utility for odroid-based devices"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  $CC $CFLAGS -c -o irremote.o irremote.c
  $CC $CFLAGS -c -o config.o config.c
  $CC $CFLAGS -c -o parsefile.o parsefile.c

  $CC $LDFLAGS -o odroid_remote irremote.o config.o parsefile.o
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp odroid_remote $INSTALL/usr/bin/

  mkdir -p $INSTALL/etc/odroid-remote
    cp odroid_remote.conf $INSTALL/etc/odroid-remote/
}

post_install() {
  enable_service odroid-remote.service
}
