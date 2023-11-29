// ref: https://savepo.com/the_answer_of_using_the_future_method
public class AccountProcessor {
    @future
    public static void countContacts(List<Id> redordIds) {
        // メソッドに渡された Id の Account リスト
        List<Account> accounts = [SELECT Id, Name, Number_Of_Contacts__c FROM Account WHERE Id IN :redordIds];

        // 一括更新用の Account リスト
        List<Account> updateAccounts = new List<Account>();

        // Account に関連する Contact 数をカウントして [Number_Of_Contacts__c] 項目を更新するため、一括 Update 用の Account リストに追加
        for (Account a : accounts) {
            a.Number_Of_Contacts__c = [SELECT COUNT() FROM Contact WHERE AccountId = :a.Id];
            updateAccounts.add(a);
        }

        // 一括更新
        update updateAccounts;
    }
}