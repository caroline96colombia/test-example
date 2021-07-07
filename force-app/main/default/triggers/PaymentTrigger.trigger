trigger PaymentTrigger on Payment__c (before insert,before update, after insert, after update, after delete) {

if(Trigger.isBefore){
     if(Trigger.isInsert)
        {
            //triggerHanlder.setPaymentDate(Trigger.new);
            for(Payment__c paymentRecord : Trigger.New) {                      
            if(paymentRecord.Payment_Date__c == null ){
                paymentRecord.Payment_Date__c = datetime.now();
            }       
        }

        }
    }
    else
    {//isAfter
        if(Trigger.isInsert)
        {
           //PaymentTriggerhandler.setPaymentDate(Trigger.new);
           PaymentTriggerhandler.updateTotalProjectAndContactAmmounts(Trigger.new);
        }
        else if(Trigger.isUpdate)
        {            
            PaymentTriggerhandler.updateTotalProjectAndContactAmmounts(Trigger.new);
        }
         else if(Trigger.isDelete)
        {           
            system.debug('isDelete');
            system.debug(Trigger.old+'Trigger.old´´´´´´');
            PaymentTriggerhandler.updateTotalProjectAndContactAmmounts(Trigger.old);
        }
    }
}