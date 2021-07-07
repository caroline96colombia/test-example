public class PaymentTriggerhandler {

 public static void updateTotalProjectAndContactAmmounts(List<Payment__c> payments)
    {
        Set<Id> contactIds = getContactIds(payments);
        Set<Id> projectIds = getProjectIds(payments);
        List<Payment__c> allPayments = [Select Contact__c, Project__c, Amount__c from Payment__c where Contact__c in :contactIds or Project__c in :projectIds];
        if (allPayments.isEmpty())
		{
			List<Contact> contactsToUpdate = new List<Contact>();            
			for(Id contactId :contactIds)
			{
				contactsToUpdate.add(new Contact(Id = contactId, Total_amount_of_Payments__c = 0));
			}
			update contactsToUpdate;
		}
		else
		{
			setTotalContactAmmount(allPayments);
			setTotalProjectAmmount(allPayments);	
		}     
        
        
    }
      
     private static Decimal  getPaymentAmmount(List<Payment__c> payments)
    {
        Decimal result = 0;
        for(Payment__c thePayment : payments)
        {
            if(thePayment.Amount__c != null){
                result += thePayment.Amount__c;
            }            
        }
        return result;
    }
    
     public static void setTotalContactAmmount(List<Payment__c> payments)
    {
        Map<Id, List<Payment__c>> allPaymentsByContactId = getAllPaymentsByContactId(payments);
        List<Contact> contactToUpdate = new List<Contact>();
        for(Id ContactId :allPaymentsByContactId.keySet())
        {
            contactToUpdate.add(new Contact(Id = ContactId, Total_amount_of_Payments__c = getPaymentAmmount(allPaymentsByContactId.get(ContactId))));
        }

        if(!contactToUpdate.isEmpty())
        {
            update contactToUpdate;
        }
        
    }
    
    public static void setTotalProjectAmmount(List<Payment__c> payments)
    {
        Map<Id, List<Payment__c>> allPaymentsByContactId = getAllPaymentsByProjectId(payments);
        List<project__c> projectsToUpdate = new List<project__c>();
        for(Id projectId :allPaymentsByContactId.keySet())
        {
            projectsToUpdate.add(new project__c(Id = projectId, Total_amount_of_Payments__c = getPaymentAmmount(allPaymentsByContactId.get(projectId))));
        }
        if(!projectsToUpdate.isEmpty())
        {
            update projectsToUpdate;
        }
    }
       
    public static Map<Id, List<Payment__c>> getAllPaymentsByContactId(List<Payment__c> payments)
    {
        Map<Id, List<Payment__c>> result = new Map<Id, List<Payment__c>>();
        for(Payment__c thePAyment :payments)
        {
            if(thePayment.Contact__c == null) continue;
                if (!result.containsKey(thePayment.Contact__c))
                {
                    result.put(thePayment.Contact__c, new List<Payment__c>());
                }
                result.get(thePayment.Contact__c).add(thePAyment);           
        }
        return result;
    }
     public static Map<Id, List<Payment__c>> getAllPaymentsByProjectId(List<Payment__c> payments)
    {
        Map<Id, List<Payment__c>> result = new Map<Id, List<Payment__c>>();
        for(Payment__c thePAyment :payments)
        {
        	if(thePayment.Project__c == null) continue;
                if (!result.containsKey(thePayment.Project__c))
                {
                    result.put(thePayment.Project__c, new List<Payment__c>());
                }
                result.get(thePayment.Project__c).add(thePayment);
        }
        return result;
    }
    
    public static Set<Id> getContactIds(List<Payment__c> payments)
    {
        Set<Id> result = new Set<Id>();
        for(Payment__c thePAyment :payments)
        {
            result.add(thePayment.Contact__c);
        }
        return result;
    }
    
     public static Set<Id> getProjectIds(List<Payment__c> payments)
    {
        Set<Id> result = new Set<Id>();
        for(Payment__c thePAyment :payments)
        {
            result.add(thePayment.Project__c);
        }
        return result;
    }
}