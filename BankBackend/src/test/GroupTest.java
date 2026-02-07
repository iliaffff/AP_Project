package test;

import service.GroupService;
import service.AccountService;

import java.util.Arrays;

public class GroupTest {

    public static void main(String[] args) {

        System.out.println("===== شروع تست گروه‌های مشترک =====");

        // ساخت حساب‌ها
        AccountService.createAccount("3001", "علی", 200000);
        AccountService.createAccount("3002", "سارا", 150000);

        // ایجاد گروه
        GroupService.createGroup(
                "G1",
                "گروه خانواده",
                Arrays.asList("3001", "3002")
        );

        // نمایش جزئیات گروه
        GroupService.showGroupDetails("G1");

        // واریز به گروه
        GroupService.depositToGroup("G1", 100000);

        // برداشت موفق
        GroupService.withdrawFromGroup("G1", 50000);

        //برداشت ناموفق به دلیل موجودی کم
        GroupService.withdrawFromGroup("G1", 500000);

        // نمایش نهایی
        GroupService.showGroupDetails("G1");

        System.out.println("===== پایان تست گروه‌های مشترک =====");
    }
}
