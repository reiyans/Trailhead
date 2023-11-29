// ref: https://trailhead.salesforce.com/ja/trailblazer-community/feed/0D54V00007LVtfbSAD
// ref: https://developer.salesforce.com/forums/?id=9060G000000XhdMQAS
@isTest
public class UnitOfWorkTest {
    @isTest static void challengeComplete(){
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new Schema.SObjectType[] {
                Account.SObjectType,
                Contact.SObjectType,
                Note.SObjectType
			}
		);
        for(Integer i = 0;i<100;i++){
           Account acc = new Account(Name = 'Account Name '+i);
            uow.registerNew(acc);
            for(Integer j = 0; j<5;j++){
                Contact con = new Contact(LastName = 'Contact Name '+j);
                uow.registerNew(con,Contact.AccountId, acc);                
                Note no = new Note(Body='Body No'+j,Title='Title '+j);
                uow.registerNew(no,Note.ParentId, acc);                                
            }
        }
        uow.commitWork();
        System.assertEquals(100, [Select Id from Account].size());
        System.assertEquals(500, [Select Id from Contact].size());
        System.assertEquals(500, [Select Id from Note].size());
    }
}