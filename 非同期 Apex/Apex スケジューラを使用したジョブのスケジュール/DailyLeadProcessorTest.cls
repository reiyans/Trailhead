// テストクラスで、200 件の Lead レコードを挿入し、DailyLeadProcessor クラスをスケジュールして実行し、
// すべての Lead レコードが正しく更新されたことを検証する
@isTest
private class DailyLeadProcessorTest {
    // 毎日 AM 1:00:00 に実行する CRON 式
    // CRON　式の書式: Seconds Minutes Hours Day_of_month Month Day_of_week Optional_year
    public static String CRON_EXP = '0 0 1 * * ?';

    @isTest
    static void testScheduleJob() {
        // 200 件の Lead レコードを挿入（LeadSource 項目は null）
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(
                LastName = 'Test Lead ' + i,
                Company = 'Test Company'
            ));
        }
        insert leads;

        // テスト（LeadSource が空白の Lead 最大 200 件の LeadSource を DailyLeadProcessor クラスで Dreamforce に更新）
        Test.startTest();
        String jobId = System.schedule(
            'DailyLeadProcessorTest',
            CRON_EXP,
            new DailyLeadProcessor()
        );
        Test.stopTest();

        //　検証（LeadSource が Dreamforce の Lead が 200 件存在しているか）
        Integer numOfDreamforceLeads = [SELECT COUNT() FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, numOfDreamforceLeads);
    }
}