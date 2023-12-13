import { LightningElement, wire } from 'lwc';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';  
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
// 作成した Apex クラス 'ContactController' の Apex メソッド 'getContacts' をインポート
import getContacts from '@salesforce/apex/ContactController.getContacts';
import { reduceErrors } from 'c/ldsUtils';
const COLUMNS = [
    { label: 'First Name', fieldName: FIRSTNAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Last Name', fieldName: LASTNAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Email', fieldName: EMAIL_FIELD.fieldApiName, type: 'Email' }
];
export default class ContactList extends LightningElement {
    columns = COLUMNS;
    @wire(getContacts)  // @wire を getContacts メソッドに使用し、データを取得
    contacts;  // getContacts メソッドの結果を contacts プロパティに保存
    // 'contacts' プロパティにエラーがあればエラーを返し、なければ空の配列を返す
    get errors() {
        return (this.contacts.error) ? reduceErrors(this.contacts.error) : [];
    }
}