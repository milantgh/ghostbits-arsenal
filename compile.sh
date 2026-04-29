#!/bin/bash
echo "========================================"
echo "   GhostBits Arsenal 编译打包"
echo "========================================"

BASE_DIR=$(pwd)
SRC_DIR="$BASE_DIR/src/main/java"
LIB_DIR="$BASE_DIR/lib"
CLASSES_DIR="$BASE_DIR/classes"

# 检查lib目录
if [ ! -d "$LIB_DIR" ] || [ -z "$(ls -A $LIB_DIR/*.jar 2>/dev/null)" ]; then
    echo "[错误] lib目录为空，请先下载依赖jar包！"
    exit 1
fi

# 检查MANIFEST.MF
if [ ! -f "$BASE_DIR/META-INF/MANIFEST.MF" ]; then
    echo "[错误] META-INF/MANIFEST.MF 不存在！"
    exit 1
fi

# 创建classes目录
mkdir -p "$CLASSES_DIR"

# 查找所有Java文件
echo "[1/3] 编译Java源文件..."
find "$SRC_DIR" -name "*.java" > sources.txt
javac -encoding UTF-8 -cp "$LIB_DIR/*" -d "$CLASSES_DIR" @sources.txt 2>&1 | grep -v "deprecated" || true

if [ ! -d "$CLASSES_DIR/com" ]; then
    echo "[错误] 编译失败，没有生成class文件！"
    rm sources.txt
    exit 1
fi
rm sources.txt

# 打包Jar
echo "[2/3] 打包Jar文件..."
cd "$CLASSES_DIR"
jar cvfe "$BASE_DIR/ghostbits-arsenal.jar" com.ghostbits.ArsenalApp .

if [ $? -ne 0 ]; then
    echo "[错误] 打包失败！"
    cd "$BASE_DIR"
    exit 1
fi

cd "$BASE_DIR"

# 清理临时文件
echo "[3/3] 清理临时文件..."
rm -rf "$CLASSES_DIR"

echo "========================================"
echo "   ✅ 编译成功！"
echo "   生成文件: ghostbits-arsenal.jar"
ls -lh ghostbits-arsenal.jar
echo "   运行命令: ./run.sh"
echo "========================================"
