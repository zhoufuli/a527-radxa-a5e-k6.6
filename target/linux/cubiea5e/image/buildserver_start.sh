# 获取顶层目录的绝对路径
CFG_TOP_DIR=$(realpath "$1")

cat << EOF > "$CFG_TOP_DIR/tina/.buildconfig"
export LICHEE_PLATFORM=linux
export LICHEE_LINUX_DEV=buildroot
export LICHEE_IC=a527
export LICHEE_BOARD=cubie_a5e
export LICHEE_FLASH=default
export LICHEE_KERN_NAME=linux-5.15
export LICHEE_KERNEL_ARCH=arm64
export LICHEE_ARCH=arm64
export LICHEE_KERN_VER=linux-5.15
export LICHEE_KERNEL_VERSION=5.15.173
export LICHEE_KERN_DEFCONF=bsp_defconfig
export LICHEE_KERN_DEFCONF_RT=
export LICHEE_BUILDING_SYSTEM=buildroot
export LICHEE_BR_VER=202205
export LICHEE_BR_DEFCONF=sun55iw3p1_aiot_defconfig
export LICHEE_DEFCONFIG_FRAGMENT=
export LICHEE_PRODUCT=
export LICHEE_BRANDY_VER=2.0
export LICHEE_BRANDY_DEFCONF=sun55iw3p1_defconfig
export LICHEE_BRANDY_UBOOT_VER=
export LICHEE_BRANDY_BUILD_OPTION=
export LICHEE_COMPILER_TAR=aarch64/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu.tar.xz
export LICHEE_ROOTFS=target-arm64-10.3
export LICHEE_RAMFS=
export LICHEE_BUSSINESS=
export LICHEE_BR_RAMFS_CONF=
export LICHEE_CHIP=sun55iw3p1
export LICHEE_RTOS_PROJECT_NAME=
export LICHEE_DSP_PROJECT_NAME=
export LICHEE_PACK_HOOK=
export LICHEE_PACK_SECURE_TYPE=
export LICHEE_REDUNDANT_ENV_SIZE=
export LICHEE_BRANDY_SPL=
export LICHEE_COMPRESS=
export LICHEE_NO_RAMDISK_NEEDED=
export LICHEE_RAMDISK_PATH=
export LICHEE_KERN_DEFCONF_RECOVERY=
export LICHEE_USE_INDEPENDENT_BSP=true
export LICHEE_INDEPENDENT_PACK=
export LICHEE_BOOT0_BIN_NAME=
export LICHEE_EFEX_BIN_NAME=
export LICHEE_EFEX_DEFCONF=
export ANDROID_CLANG_PATH=
export ANDROID_TOOLCHAIN_PATH=
export ANDROID_CLANG_ARGS=
export LICHEE_BSP_STAGING=
export LICHEE_GEN_BOOT0_DTS_INFO=
export LICHEE_KERN_SYSTEM=
export LICHEE_KERN_DEFCONF_RELATIVE=../../../../../device/config/chips/a527/configs/default/linux-5.15/bsp_defconfig
export LICHEE_KERN_DEFCONF_ABSOLUTE=$CFG_TOP_DIR/tina/device/config/chips/a527/configs/default/linux-5.15/bsp_defconfig
export LICHEE_KERN_DEFCONF_RECOVERY_RELATIVE=
export LICHEE_KERN_DEFCONF_RECOVERY_ABSOLUTE=
export LICHEE_CROSS_COMPILER=aarch64-none-linux-gnu
export LICHEE_TOP_DIR=$CFG_TOP_DIR/tina
export LICHEE_CBBPKG_DIR=$CFG_TOP_DIR/tina/platform
export LICHEE_BRANDY_DIR=$CFG_TOP_DIR/tina/brandy/brandy-2.0
export LICHEE_BUILD_DIR=$CFG_TOP_DIR/tina/build
export LICHEE_BR_DIR=$CFG_TOP_DIR/tina/buildroot/buildroot-202205
export LICHEE_DEVICE_DIR=$CFG_TOP_DIR/tina/device
export LICHEE_KERN_DIR=$CFG_TOP_DIR/tina/kernel/linux-5.15
export LICHEE_BSP_DIR=$CFG_TOP_DIR/tina/bsp
export BSP_TOP=
export LICHEE_PLATFORM_DIR=$CFG_TOP_DIR/tina/platform
export LICHEE_SATA_DIR=$CFG_TOP_DIR/tina/test/SATA
export LICHEE_DRAGONABTS_DIR=$CFG_TOP_DIR/tina/test/dragonabts
export LICHEE_DRAGONBAORD_DIR=$CFG_TOP_DIR/tina/test/dragonboard
export LICHEE_TOOLS_DIR=$CFG_TOP_DIR/tina/tools
export LICHEE_COMMON_CONFIG_DIR=$CFG_TOP_DIR/tina/device/config/common
export LICHEE_CHIP_CONFIG_DIR=$CFG_TOP_DIR/tina/device/config/chips/a527
export LICHEE_BOARD_CONFIG_DIR=$CFG_TOP_DIR/tina/device/config/chips/a527/configs/cubie_a5e
export LICHEE_PRODUCT_CONFIG_DIR=$CFG_TOP_DIR/tina/device/target/
export LICHEE_OUT_DIR=$CFG_TOP_DIR/tina/out
export LICHEE_BRANDY_OUT_DIR=$CFG_TOP_DIR/tina/device/config/chips/a527/bin
export LICHEE_BR_OUT=$CFG_TOP_DIR/tina/out/a527/cubie_a5e/buildroot/buildroot
export LICHEE_PACK_OUT_DIR=$CFG_TOP_DIR/tina/out/a527/cubie_a5e/pack_out
export LICHEE_TOOLCHAIN_PATH=$CFG_TOP_DIR/tina/out/toolchain/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu
export LICHEE_PLAT_OUT=$CFG_TOP_DIR/tina/out/a527/cubie_a5e/buildroot
export LICHEE_BOARDCONFIG_PATH="$CFG_TOP_DIR/tina/device/config/chips/a527/configs/default/BoardConfig.mk $CFG_TOP_DIR/tina/device/config/chips/a527/configs/cubie_a5e/buildroot/BoardConfig.mk $CFG_TOP_DIR/tina/out/BoardConfig-select.mk $CFG_TOP_DIR/tina/device/config/chips/a527/configs/default/BoardConfig-conditions.mk"
export LICHEE_ARISC_PATH=$CFG_TOP_DIR/tina/brandy/arisc
export LICHEE_DRAMLIB_PATH=$CFG_TOP_DIR/tina/brandy/dramlib
export LICHEE_KERN_TYPE=
export LICHEE_POSSIBLE_BIN_PATH="bin /bin configs/cubie_a5e/bin configs/cubie_a5e//bin configs/cubie_a5e/buildroot/bin configs/cubie_a5e/buildroot//bin"
EOF

echo ".buildconfig 文件已创建在 $CFG_TOP_DIR/tina/.buildconfig" 

pidlist=($(lsof 2>/dev/null | awk -v path="$CFG_TOP_DIR/tina/tools/build/buildserver" '$9 ~ path {print $2}'))

if [ ${#pidlist[@]} -eq 0 ]; then
    echo "No buildserver processes found"
fi

echo "清除 buildserver processes..."
for pid in "${pidlist[@]}"; do
    if [ -n "$pid" ]; then
        echo "Killing process $pid"
        kill -9 "$pid" 2>/dev/null
    fi
done

# 进入 build 目录
cd "$CFG_TOP_DIR/tina/tools/build" || {
    echo "Error: Failed to enter directory $CFG_TOP_DIR/tina/tools/build"
    exit 1
}

# 检查 buildserver 是否存在并可执行
if [ -f "buildserver" ]; then
    echo "Starting buildserver..."
    # 启动 buildserver 并后台运行，输出重定向到 /dev/null
    ./buildserver --path "$CFG_TOP_DIR/tina" >/dev/null 2>&1 &
    echo "Buildserver started in background"
else
    echo "Error: buildserver executable not found in $PWD"
    exit 1
fi

