#
# Copyright (C) 2010-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-mentohust
PKG_VERSION:=0.12
PKG_RELEASE:=1
PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

PO2LMO:=$(BUILD_DIR)/luci/build/po2lmo

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  DEPENDS:=
  TITLE:=luci-app-mentohust                         
  PKGARCH:=all
endef

define Package/$(PKG_NAME)/description
 mentohust web UI                           
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh 
[ -n "$${IPKG_INSTROOT}" ] || {
	( . /etc/uci-defaults/luci-mentohust ) && rm -f /etc/uci-defaults/luci-mentohust
	chmod 755 /etc/init.d/mentohust >/dev/null 2>&1
	/etc/init.d/mentohust enable >/dev/null 2>&1
	exit 0
}
endef

define Package/$(PKG_NAME)/install
	$(CP) ./root/* $(1)
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n $(1)/usr/lib/lua/luci
	#$(PO2LMO) ./po/zh-cn/mentohust.po $(1)/usr/lib/lua/luci/i18n/mentohust.zh-cn.lmo
	$(CP) ./luasrc/* $(1)/usr/lib/lua/luci
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
