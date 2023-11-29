// テストクラスで、BillingState NY の取引先レコード 50 件と BillingState CA の取引先レコード 50 件を挿入する
@isTest
public class AddPrimaryContactTest {
    @testSetup
    static void setup() {
        // BillingState が NY　の Account 50 件のリストを作成
        List<Account> accountsOfNY = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            Account account = new Account(
                Name = 'Test Account' + i,
                BillingState = 'NY'
            );
            accountsOfNY.add(account);
        }
        insert accountsOfNY;

        // BillingState が CA　の Account 50 件のリストを作成
        List<Account> accountsOfCA = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            Account account = new Account(
                Name = 'Test Account' + i,
                BillingState = 'CA'
            );
            accountsOfCA.add(account);
        }
        insert accountsOfCA;
    }

    // AddPrimaryContact クラスのインスタンスを作成し、ジョブをキューに登録し、
    // BillingState が CA の 50 件の取引先それぞれについて取引先責任者レコードが挿入されたことを確認する
    static testmethod void testQueueable() {
        // Queueable インスタンスを作成
        Contact contact = new Contact(
            LastName = 'Test Contact'
        );
        String stateAbbreviation = 'CA';
        AddPrimaryContact apc = new AddPrimaryContact(contact, stateAbbreviation);

        // 非同期プロセスを実行するための startTest/stopTest ブロック
        Test.startTest();
        System.enqueueJob(apc);
        Test.stopTest();

        // 検証
        System.assertEquals(50, [SELECT COUNT() FROM Contact WHERE Account.BillingState = :stateAbbreviation]);
    }
}