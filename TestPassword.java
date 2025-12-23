package com.computerpart.test;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class TestPassword {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        
        // 测试密码
        String plainPassword = "123456";
        
        // 数据库中的哈希
        String dbHash = "$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy";
        String oldHash = "$2a$10$slYQmyNdGzin7olVN3p5Be7DlH.PKZbv5H8KnzzVgXXbVxzy5QMBK";
        
        // 测试新哈希
        System.out.println("Testing new hash:");
        System.out.println("Password: " + plainPassword);
        System.out.println("Hash: " + dbHash);
        System.out.println("Matches: " + encoder.matches(plainPassword, dbHash));
        
        System.out.println("\nTesting old hash:");
        System.out.println("Password: " + plainPassword);
        System.out.println("Hash: " + oldHash);
        System.out.println("Matches: " + encoder.matches(plainPassword, oldHash));
        
        // 生成新的正确哈希
        System.out.println("\nGenerating new hash:");
        String newHash = encoder.encode(plainPassword);
        System.out.println("New hash: " + newHash);
        System.out.println("New hash matches: " + encoder.matches(plainPassword, newHash));
    }
}
