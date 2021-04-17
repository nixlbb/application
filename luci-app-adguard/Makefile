# Copyright (C) 2018-2019 Lienol
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-adguard
PKG_VERSION:=1.8
PKG_RELEASE:=11

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-adguard
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI app for adguard
	PKG_MAINTAINER:=<https://github.com/rufengsuixing/luci-app-adguard>
	PKGARCH:=all
	DEPENDS:=+!wget&&!curl:wget
endef

define Package/luci-app-adguard/description
	LuCI support for adguard
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/luci-app-adguard/conffiles
/usr/share/AdGuard/links.txt
/etc/config/AdGuard
endef

define Package/luci-app-adguard/install
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci
	cp -pR ./luasrc/* $(1)/usr/lib/lua/luci
	$(INSTALL_DIR) $(1)/
	cp -pR ./root/* $(1)/
	$(INSTALL_DIR) $(1)/usr/bin/AdGuard
	$(INSTALL_BIN) ./root/usr/bin/AdGuard/AdGuard $(1)/usr/bin/AdGuard
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./root/etc/init.d/AdGuard $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	po2lmo ./po/zh-cn/AdGuard.po $(1)/usr/lib/lua/luci/i18n/AdGuard.zh-cn.lmo
endef

define Package/luci-app-adguard/postinst
#!/bin/sh
	/etc/init.d/AdGuard enable >/dev/null 2>&1
	enable=$(uci get AdGuard.AdGuard.enabled 2>/dev/null)
	if [ "$enable" == "1" ]; then
		/etc/init.d/AdGuard reload
	fi
	rm -f /tmp/luci-indexcache
	rm -f /tmp/luci-modulecache/*
exit 0
endef

define Package/luci-app-adguard/prerm
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
     /etc/init.d/AdGuard disable
     /etc/init.d/AdGuard stop
uci -q batch <<-EOF >/dev/null 2>&1
	delete ucitrack.@AdGuard[-1]
	commit ucitrack
EOF
fi
exit 0
endef

$(eval $(call BuildPackage,luci-app-adguard))
