package storage;

import model.Transaction;

import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class TransactionStorage {

    private static final String FILE_PATH = "transactions.json";
    private static final Object lock = new Object();

    public static List<Transaction> loadAll() {
        synchronized (lock) {
            List<Transaction> transactions = new ArrayList<>();
            try {
                String content = Files.readString(Path.of(FILE_PATH)).trim();
                if (content.isEmpty() || content.equals("[]")) {
                    return transactions;
                }

                content = content.substring(1, content.length() - 1); // remove [ ]
                String[] objects = content.split("},\\s*\\{");

                for (String obj : objects) {
                    if (!obj.startsWith("{")) obj = "{" + obj;
                    if (!obj.endsWith("}")) obj = obj + "}";
                    transactions.add(Transaction.fromJson(obj));
                }
            } catch (IOException e) {
                System.out.println("خطا در خواندن تراکنش‌ها");
            }
            return transactions;
        }
    }

    public static void save(Transaction transaction) {
        synchronized (lock) {
            List<Transaction> transactions = loadAll();
            transactions.add(transaction);
            overwriteAll(transactions);
        }
    }

    public static void overwriteAll(List<Transaction> transactions) {
        synchronized (lock) {
            try (FileWriter writer = new FileWriter(FILE_PATH)) {
                writer.write("[\n");
                for (int i = 0; i < transactions.size(); i++) {
                    writer.write(transactions.get(i).toJson());
                    if (i < transactions.size() - 1) writer.write(",\n");
                }
                writer.write("\n]");
            } catch (IOException e) {
                System.out.println("خطا در ذخیره تراکنش‌ها");
            }
        }
    }
}
