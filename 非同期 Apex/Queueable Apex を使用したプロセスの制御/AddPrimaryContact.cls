// 特定の州の各取引先に同じ取引先責任者を挿入する Queueable Apex クラスを作成する
public class AddPrimaryContact implements Queueable {
    // インスタンス変数
    private Contact contact;
    private String state;

    // 第 1 引数として Contact sObject、第 2 引数として州の略称の文字列を受け入れるクラスのコンストラクタを作成する
    public AddPrimaryContact(Contact record, String stateAbbreviation) {
        this.contact = record;
        this.state = stateAbbreviation;
    }

    // execute メソッドでは、コンストラクタに渡された州の略称で指定された BillingState を持つ最大 200 件の取引先をクエリし、
    // 各取引先に関連付けられた Contact sObject レコードを挿入する
    // sObject clone() メソッドを参照する
    public void execute(QueueableContext context) {
        // コンストラクタに渡された州の略称で指定された BillingState を持つ最大 200 件の取引先をクエリ
        List<Account> accounts = [SELECT Id, BillingState FROM Account WHERE BillingState = :state LIMIT 200];
        // 一括更新用の Contact リスト
        List<Contact> contacts = new List<Contact>();
        // this.contact のコピーにループ中の Account を関連付けて、Contact リストに追加
        for (Account account : accounts) {
            Contact contactCopy = contact.clone();
            contactCopy.AccountId = account.Id;
            contacts.add(contactCopy);
        }
        // 一括挿入
        insert contacts;
    }
}