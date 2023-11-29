// テストクラスで、200 件の Lead レコードを挿入し、LeadProcessor Batch クラスを実行し、すべての Lead レコードが正しく更新されたことを検証する
// 単体テストは LeadProcessor クラスに含まれるすべてのコード行をカバーし、結果のコードカバー率が 100% になる必要がある
@isTest
private class LeadProcessorTest {
    // 200 件の Lead レコードを挿入する
    @testSetUp
    static void setup() {
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leads.add(
                new Lead(
                	LastName = 'Lead' + i,
                	Company = 'TestCompany',
                	Status = 'Open - Not Contacted'
                )
            );
        }
        insert leads;
    }

    // LeadProcessor クラスを実行する
    @isTest static void test() {
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
        // テスト停止後、レコードが正しく更新されたか確認する
        System.assertEquals(200, [SELECT COUNT() FROM Lead WHERE LeadSource = 'Dreamforce']);
    }
}