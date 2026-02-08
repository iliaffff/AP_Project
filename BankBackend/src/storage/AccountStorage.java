package storage;

import model.Account;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class AccountStorage {

    static final Object lock = new Object();
    private static final String FILE_PATH = "BankBackend/accounts.json";

    public static void save(Account account) {
        synchronized (lock) {
            List<Account> accounts = loadAll();
            accounts.add(account);
            overwriteAll(accounts);
        }
    }

    public static List<Account> loadAll() {
        synchronized (lock) {
            List<Account> accounts = new ArrayList<>();
            try {
                String content = Files.readString(Path.of(FILE_PATH)).trim();
                if (content.equals("[]") || content.isEmpty()) {
                    return accounts;
                }

                content = content.substring(1, content.length() - 1); // remove [ ]
                String[] objects = content.split("},\\s*\\{");

                for (String obj : objects) {
                    if (!obj.startsWith("{")) obj = "{" + obj;
                    if (!obj.endsWith("}")) obj = obj + "}";
                    accounts.add(Account.fromJson(obj));
                }
            } catch (IOException e) {
                System.out.println("خطا در خواندن حساب‌ها.");
            }
            return accounts;
        }
    }


    public static Account findByAccountNumber(String accountNumber) {
        synchronized (lock) {
            for (Account acc : loadAll()) {
                if (acc.getAccountNumber().equals(accountNumber)) {
                    return acc;
                }
            }
            return null;
        }
    }

    public static void overwriteAll(List<Account> accounts) {
        synchronized (lock) {
            try (FileWriter writer = new FileWriter(FILE_PATH)) {
                writer.write("[\n");
                for (int i = 0; i < accounts.size(); i++) {
                    writer.write(accounts.get(i).toJson());
                    if (i < accounts.size() - 1) writer.write(",\n");
                }
                writer.write("\n]");
            } catch (IOException e) {
                System.out.println("خطا در ذخیره حساب‌ها.");
            }
        }
    }
}