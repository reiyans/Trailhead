// Schedulable インターフェースを実装してリードレコードを特定の LeadSource で更新する Apex クラスを作成する
public class DailyLeadProcessor implements Schedulable {
    // execute メソッドでは LeadSource 項目が空白である Lead レコードの最初の 200 件を検出し、LeadSource 値「Dreamforce」で更新する必要がある
    public void execute(SchedulableContext ctx) {
        List<Lead> leads = [SELECT Id FROM Lead WHERE LeadSource = null LIMIT 200];
        List<Lead> updater = new List<Lead>();
        for (Lead lead : leads) {
            lead.LeadSource = 'Dreamforce';
            updater.add(lead);
        }
        update updater;
    }
}