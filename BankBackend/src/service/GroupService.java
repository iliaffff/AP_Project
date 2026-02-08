package service;

import model.Group;
import storage.GroupStorage;
import storage.AccountStorage;
import model.Account;
import utils.Messages;
import model.Transaction;
import storage.TransactionStorage;
import java.time.LocalDate;

import java.util.ArrayList;
import java.util.List;

public class GroupService {

    public static void createGroup(
            String groupId,
            String groupName,
            List<String> memberAccountNumbers) {

        if (GroupStorage.findByGroupId(groupId) != null) {
            System.out.println("خطا: گروهی با این شناسه وجود دارد.");
            return;
        }

        for (String accNumber : memberAccountNumbers) {
            Account acc = AccountStorage.findByAccountNumber(accNumber);
            if (acc == null) {
                System.out.println("خطا: حساب " + accNumber + " وجود ندارد");
                return;
            }
        }

        Group group = new Group(
                groupId,
                groupName,
                memberAccountNumbers,
                0
        );

        GroupStorage.save(group);
        System.out.println("گروه با موفقیت ایجاد شد.");
    }

    public static void showGroupDetails(String groupId) {

        Group group = GroupStorage.findByGroupId(groupId);

        if (group == null) {
            System.out.println("خطا: گروه مورد نظر یافت نشد.");
            return;
        }

        System.out.println("شناسه گروه: " + group.getGroupId());
        System.out.println("نام گروه: " + group.getGroupName());
        System.out.println("اعضا: " + group.getMemberAccountNumbers());
        System.out.println("موجودی گروه: " + group.getBalance());
    }

    public static void depositToGroup(String groupId, double amount) {

        if (amount <= 0) {
            System.out.println("خطا: مبلغ واریز نامعتبر است.");
            return;
        }

        List<Group> groups = GroupStorage.loadAll();
        boolean found = false;

        for (Group group : groups) {
            if (group.getGroupId().equals(groupId)) {
                group.setBalance(group.getBalance() + amount);
                found = true;
                break;
            }
        }

        if (!found) {
            System.out.println("خطا: گروه مورد نظر یافت نشد.");
            return;
        }

        GroupStorage.overwriteAll(groups);

        Transaction transaction = new Transaction(
                "SYSTEM",
                "GROUP-" + groupId,
                amount,
                "GROUP_DEPOSIT",
                LocalDate.now().toString()
        );

        TransactionStorage.save(transaction);

        System.out.println("واریز به گروه با موفقیت انجام شد.");
    }

    public static void withdrawFromGroup(String groupId, double amount) {

        if (amount <= 0) {
            System.out.println("خطا: مبلغ برداشت نامعتبر است.");
            return;
        }

        List<Group> groups = GroupStorage.loadAll();
        boolean found = false;

        for (Group group : groups) {
            if (group.getGroupId().equals(groupId)) {

                if (group.getBalance() < amount) {
                    System.out.println("خطا: موجودی گروه کافی نیست.");
                    return;
                }

                group.setBalance(group.getBalance() - amount);
                found = true;
                break;
            }
        }

        if (!found) {
            System.out.println("خطا: گروه مورد نظر یافت نشد.");
            return;
        }

        GroupStorage.overwriteAll(groups);

        Transaction transaction = new Transaction(
                "GROUP-" + groupId,
                "SYSTEM",
                amount,
                "GROUP_WITHDRAW",
                LocalDate.now().toString()
        );

        TransactionStorage.save(transaction);

        System.out.println("برداشت از گروه با موفقیت انجام شد.");
    }
}
