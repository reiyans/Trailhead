public with sharing class ContactController {
    @AuraEnabled(cacheable=true)  // Apex メソッドをバインドするには、メソッドを cacheable にする必要あり
    public static List<Contact> getContacts() {
        // return [
        //     SELECT FirstName, LastName, Email
        //     FROM Contact
        //     WITH SECURITY_ENFORCED  // 項目およびオブジェクトレベルセキュリティ権限を確認
        //     ORDER BY Name
        // ];

        // 強制的にエラーを発生させる
        throw new AuraHandledException('Forced error');
    }
}