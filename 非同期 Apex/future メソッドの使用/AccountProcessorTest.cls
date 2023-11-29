// ref: https://savepo.com/the_answer_of_using_the_future_method
@IsTest
public class AccountProcessorTest {
    public static testmethod void TestAccountProcessorTest() {
        Account a = new Account();
        a.Name = 'Test Account';
        Insert a;
        
        Contact c = New Contact();
        c.LastName ='Test Contact';
        c.AccountId = a.Id;
        Insert c;
        
        List<Id> setAccId = new List<Id>();
        setAccId.add(a.id);
        
        System.Test.startTest();
        AccountProcessor.countContacts(setAccId);
        System.Test.stopTest();
        
        Account Acc = [SELECT Number_of_Contacts__c FROM Account WHERE id = :a.id LIMIT 1];
        System.assertEquals ( Integer.valueOf(Acc.Number_of_Contacts__c) ,1);
    }
}