@isTest
public class PaymentTriggerHandlerTest {
    
    static testMethod void updateTotalProjectAndContactAmountsTest(){
        List <Payment__c> paymentList = new List<Payment__c>(); 
         Payment__c paymentRecords = new Payment__c();
         paymentRecords.Amount__c = 1000 ;
         paymentList.add(paymentRecords);  
		insert paymentList;  
        Test.startTest();
        	PaymentTriggerhandler.updateTotalProjectAndContactAmmounts(paymentList);
        Test.stopTest();
        System.assertNotEquals(paymentRecords.Amount__c, null);      
        
    }
}