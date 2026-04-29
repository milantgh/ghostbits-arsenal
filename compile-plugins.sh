#!/bin/bash
echo "========================================"
echo "   编译 GhostBits 插件"
echo "========================================"

# 检查主jar包是否存在
if [ ! -f "ghostbits-arsenal.jar" ]; then
    echo "错误: 找不到 ghostbits-arsenal.jar，请先编译主程序"
    exit 1
fi

cd plugins

# 统计
SUCCESS=0
FAILED=0

for file in *.java; do
    if [ -f "$file" ]; then
        echo -n "编译: $file ... "
        javac -cp "../ghostbits-arsenal.jar" "$file" 2> /tmp/compile_error.log
        if [ $? -eq 0 ]; then
            echo "✅ 成功"
            SUCCESS=$((SUCCESS + 1))
        else
            echo "❌ 失败"
            cat /tmp/compile_error.log
            FAILED=$((FAILED + 1))
        fi
    fi
done

cd ..
echo "========================================"
echo "   编译完成: 成功 $SUCCESS, 失败 $FAILED"
echo "========================================"