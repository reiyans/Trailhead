// Database.Batchable インターフェースを実装し、組織のすべてのリードレコードを特定の LeadSource で更新する Apex クラスを作成する
public class LeadProcessor implements Database.Batchable<sObject> {
    // インスタンスメンバ（recordsProcessed = 処理レコード数）がトランザクションを跨いで状態を保持する
    public Integer recordsProcessed = 0;

    // start メソッドで QueryLocator を使用して組織のすべての Lead レコードを収集する
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, FirstName, LastName FROM Lead'
        );
    }

    // execute メソッドでは組織のすべての Lead レコードを LeadSource 値「Dreamforce」で更新する必要がある
    public void execute(Database.BatchableContext bc, List<Lead> scope) {
        List<Lead> leadsToUpdate = new List<Lead>();
        for (Lead lead : scope) {
            lead.LeadSource = 'Dreamforce';
            leadsToUpdate.add(lead);
        }
        update leadsToUpdate;
    }

    // finish メソッドで処理レコード数、非同期 Apex ジョブ ID をデバッグログに出力する
    public void finish(Database.BatchableContext bc) {
        System.debug('処理レコード数: ' + recordsProcessed);
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
                           FROM AsyncApexJob
                           WHERE Id = :bc.getJobId()];
        System.debug('非同期 Apex ジョブ: ' + job);
    }
}