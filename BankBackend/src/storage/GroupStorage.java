package storage;

import model.Group;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class GroupStorage {

    private static final String FILE_PATH = "BankBackend/groups.json";

    public static void save(Group group) {
        try (FileWriter writer = new FileWriter(FILE_PATH, true)) {
            writer.write(group.toJson());
            writer.write("\n");
        } catch (IOException e) {
            System.out.println("خطا در ذخیره اطلاعات گروه");
        }
    }

    public static List<Group> loadAll() {
        List<Group> groups = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                groups.add(Group.fromJson(line));
            }
        } catch (IOException e) {
        }

        return groups;
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
        try (FileWriter writer = new FileWriter(FILE_PATH, false)) {
            for (Group group : groups) {
                writer.write(group.toJson());
                writer.write("\n");
            }
        } catch (IOException e) {
            System.out.println("خطا در بروزرسانی اطلاعات گروه‌ها");
        }
    }
}