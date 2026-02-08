package storage;

import model.Group;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

import static storage.AccountStorage.lock;

public class GroupStorage {

    private static final String FILE_PATH = "BankBackend/groups.json";

    public static void save(Group group) {
        synchronized (lock) {
            List<Group> groups = loadAll();
            groups.add(group);
            overwriteAll(groups);
        }
    }

    public static List<Group> loadAll() {
        synchronized (lock) {
            List<Group> groups = new ArrayList<>();
            try {
                String content = Files.readString(Path.of(FILE_PATH)).trim();
                if (content.equals("[]") || content.isEmpty()) {
                    return groups;
                }

                content = content.substring(1, content.length() - 1); // remove [ ]
                String[] objects = content.split("},\\s*\\{");

                for (String obj : objects) {
                    if (!obj.startsWith("{")) obj = "{" + obj;
                    if (!obj.endsWith("}")) obj = obj + "}";
                    groups.add(Group.fromJson(obj));
                }
            } catch (IOException e) {
                System.out.println("خطا در خواندن گروه‌ها.");
            }
            return groups;
        }
    }


    public static Group findByGroupId(String groupId) {
        for (Group group : loadAll()) {
            if (group.getGroupId().equals(groupId)) {
                return group;
            }
        }
        return null;
    }

    public static void overwriteAll(List<Group> groups) {
        synchronized (lock) {
            try (FileWriter writer = new FileWriter(FILE_PATH)) {
                writer.write("[\n");
                for (int i = 0; i < groups.size(); i++) {
                    writer.write(groups.get(i).toJson());
                    if (i < groups.size() - 1) writer.write(",\n");
                }
                writer.write("\n]");
            } catch (IOException e) {
                System.out.println("خطا در ذخیره گروه‌ها.");
            }
        }
    }

}