public  class LWCExampleController {
        
    @AuraEnabled(Cacheable = true)
    public static List<Contact> getContacts() {
        List<Contact> result=new List<Contact>();
        List<Contact> tmpContact=[SELECT Id, Name, FirstName, LastName, Phone, Email,Total_amount_of_Payments__c,(SELECT Id,Payment_Date__c from Payments__r )  FROM Contact]; 
        for(Contact contact_x:tmpContact){
            for(Payment__c test : contact_x.Payments__r){  
                result.add(contact_x);
                break;                  
            }      
        }   
            
        return result;        
    }

    @AuraEnabled
    public static Payment__c createPayment(Payment__c payment) {      
        insert payment;
        return payment;
    }

    @AuraEnabled(Cacheable = true)
    public static List<Payment__c> getPaymentByContact(String concatId) {
        List<Payment__c> result=new List<Payment__c>();
        List<Contact> tmpContact=[SELECT Id, Name, FirstName, LastName, Phone, Email,Total_amount_of_Payments__c,(SELECT Id,Payment_Date__c,Name from Payments__r )  FROM Contact where Id=:concatId]; 
        for(Contact contact_x:tmpContact){
            for(Payment__c payment_x : contact_x.Payments__r){  
                result.add(payment_x);
                                
            }      
        }   
            
        return result;  
    }

    @AuraEnabled(Cacheable = true)
    public static List<Payment__c> getPayment(String concatId) {
        List<Payment__c> result=[SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate,
        LastReferencedDate, Amount__c, Contact__c, Payment_Date__c, Date__c, Project__c from PAYMENT__C  WHERE Contact__c=:concatId AND Project__c<>NULL
        ORDER BY Payment_Date__c DESC];     
        return result;        
    }
    
    @AuraEnabled(Cacheable = true)
    public static String getRecentPaymentDate(String concatId) {
        List<Payment__c> result=[SELECT Id,Payment_Date__c from PAYMENT__C  WHERE Contact__c=:concatId 
        ORDER BY Payment_Date__c DESC];
        if(result.size()>0){
            return result.get(0).Payment_Date__c+'';
        }
        else{return 'Not Data Found';}     
               
    }

    @AuraEnabled(Cacheable = true)
    public static String getShowTotalPayment(String concatId) {
        AggregateResult[] groupedResults = [SELECT SUM(Amount__c) VALUE from PAYMENT__C  WHERE Contact__c=:concatId];
        Object sumAmount = groupedResults[0].get('VALUE');     
        return sumAmount+'';    
    }

}