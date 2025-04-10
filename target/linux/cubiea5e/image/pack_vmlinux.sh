#!/bin/sh
# 确保 vmlinux 存在
set -ex
[ $# -eq 1 ] || {
    echo "SYNTAX: $0 <LINUX_DIR>"
    exit 1
}
LINUX_DIR="$1"

if [ ! -f "$LINUX_DIR/vmlinux" ]; then
    echo "Error: vmlinux not found in $LINUX_DIR"
    exit 1
fi

# 打包成 vmlinux.tar.bz2
echo "Packing vmlinux into vmlinux.tar.bz2..."
tar -cjvf ./tina/out/a527/cubie_a5e/buildroot/vmlinux.tar.bz2 -C "$LINUX_DIR" vmlinux

# 检查是否生成成功
if [ -f "./tina/out/a527/cubie_a5e/buildroot/vmlinux.tar.bz2" ]; then
    echo "Success: vmlinux.tar.bz2 generated in current directory!"
else
    echo "Error: Failed to create vmlinux.tar.bz2"
    exit 1
fi
