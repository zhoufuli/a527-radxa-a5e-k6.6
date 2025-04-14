# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2013 OpenWrt.org

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk
include $(INCLUDE_DIR)/kernel.mk

DEVICE_VARS += UBOOT_DEVICE_NAME
# due to the lack of some functions in official u-boot now and some private data cannot't be decrypted so we just generate the files for lichee
define Build/syterkit-img
	(cp $(PWD)/image/tina/device/config/chips/a527/configs/cubie_a5e/arisc.config $(PWD)/image/tina/brandy/arisc/.config &&  \
	       make -C $(PWD)/image/tina/brandy/arisc && cp $(PWD)/image/tina/brandy/arisc/ar100s/scp.bin $(PWD)/image/tina/device/config/chips/a527/bin )
	./buildserver_start.sh $(PWD)/image
	(cd ./tina/brandy/brandy-2.0/ && ./build.sh -p sun55iw3p1 -b a527)
	echo "arisc" > $(PWD)/image/tina/out/a527/cubie_a5e/buildroot/arisc
	./pack_vmlinux.sh $(LINUX_DIR)
	cp $(DTS_DIR)/allwinner/sun55i-radxa-cubie-a5e.dtb ./tina/out/a527/cubie_a5e/buildroot/sunxi.dtb

	./gen_sunxi_bootimg.sh ./tina/out/a527/cubie_a5e/buildroot/boot.img \
		$(IMAGE_KERNEL) \
		$(LINUX_DIR)/System.map \
		$(DTS_DIR)/allwinner/sun55i-radxa-cubie-a5e.dtb

	cp  $(IMAGE_ROOTFS) ./tina/out/a527/cubie_a5e/buildroot/rootfs.ext4
	
	./tina/build/pack  -i a527 -c sun55iw3p1 -p buildroot -b cubie_a5e -k linux-5.15 -n default
	cp ./tina/out/a527_linux_cubie_a5e_uart0.img $(BIN_DIR)/immortalwrt_a527_linux_cubie_a5e_k6.6.img

	echo "WIP" > $@

endef

### Devices ###
define Device/Default
  PROFILES := Default
  KERNEL_NAME := Image
  KERNEL := kernel-bin
  IMAGES := sdcard.img.gz
endef

include $(SUBTARGET).mk

$(eval $(call BuildImage))
