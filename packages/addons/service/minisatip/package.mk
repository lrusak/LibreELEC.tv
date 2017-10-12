################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="minisatip"
PKG_VERSION="184c0d3"
PKG_REV="99"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/catalinii/minisatip"
PKG_URL="https://github.com/catalinii/minisatip/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain dvb-apps libdvbcsa libxml2 openssl"
PKG_SECTION="service"
PKG_SHORTDESC="minisatip: a Sat>IP streaming server for Linux"
PKG_LONGDESC="minisatip($PKG_VERSION): is a Sat>IP streaming server for Linux supporting DVB-C, DVB-S/S2 and DVB-T/T2"
PKG_AUTORECONF="yes"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Minisatip"
PKG_ADDON_TYPE="xbmc.service"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-netceiver \
                           --disable-dvbca \
                           --with-xml2=$(get_build_dir libxml2)"

pre_configure_target() {
  # minisatip fails to build in subdirs
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME
}

pre_make_target() {
  #  export LIBS=""
  LDFLAGS="$LDFLAGS -lpthread -lcrypto"
}

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/minisatip $ADDON_BUILD/$PKG_ADDON_ID/bin
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/webif
  cp -PR $PKG_BUILD/html/* $ADDON_BUILD/$PKG_ADDON_ID/webif
}
