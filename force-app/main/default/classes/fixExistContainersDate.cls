public class fixExistContainersDate implements Database.Batchable<SObject>{
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        
		String query = 'SELECT Id'
            		 + ', (SELECT CreatedDate'
            		 + '   FROM Invoices__r'
            		 + '   WHERE Name LIKE \'Batch%\')'
        			 + ' FROM Container__c'
            		 + ' WHERE Name LIKE \'Batch%\'';
        
		return Database.getQueryLocator(query);
        
	}

	public void execute(Database.BatchableContext bs, List<Container__c> scope){
        
        Map<Id,Container__c> cntrToUpdate = new Map<Id,Container__c>();
        for (Container__c cntr_i : scope) {
            
            Datetime currentMaxDate;
            for(ContainerInvoice__c cntrInv_j : cntr_i.Invoices__r) {
				if (currentMaxDate == Null || cntrInv_j.CreatedDate > currentMaxDate) {
					currentMaxDate = cntrInv_j.CreatedDate;                        
				}
			}
			cntr_i.Test_Date__c = currentMaxDate;
			cntrToUpdate.put(cntr_i.Id, cntr_i);
        }
        if (!cntrToUpdate.isEmpty()) {
			List<Container__c> cntrToUpdateList = [SELECT Id
                                                   FROM Container__c 
                                                   WHERE Id IN : cntrToUpdate.keySet()
                                                   FOR UPDATE];
			update cntrToUpdate.values();
		}
	}
    
	public void finish(Database.BatchableContext BC){
	}

}