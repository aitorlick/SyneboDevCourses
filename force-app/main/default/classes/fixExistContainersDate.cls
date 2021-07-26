public class fixExistContainersDate implements Database.Batchable<SObject>{
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        
		String query = 'SELECT Id'
        			 + ' FROM Container__c'
            		 + ' WHERE Name LIKE \'Batch%\'';
        
		return Database.getQueryLocator(query);
        
	}

	public void execute(Database.BatchableContext bs, List<Container__c> scope){
        
        List<ContainerInvoice__c> cntrInvs = [SELECT Id
                                       		   , CreatedDate
                                          	   , Container__c
                                  		  FROM ContainerInvoice__c
                                  		  WHERE Container__c IN : scope
                                          ORDER BY Container__c];
        
        Map<Id,List<ContainerInvoice__c>> cntrIdToListCntrInvs = new Map<Id,List<ContainerInvoice__c>>();
        Id currentCntrId;
        List<ContainerInvoice__c> currentListCntrInv = new List<ContainerInvoice__c>();
        for(ContainerInvoice__c cntrInv_i : cntrInvs){
            if(currentCntrId == null
              || currentCntrId != cntrInv_i.Container__c){
                if(!currentListCntrInv.isEmpty()){
                	cntrIdToListCntrInvs.put(currentCntrId, currentListCntrInv);      
                }               
				currentCntrId = cntrInv_i.Container__c;
                currentListCntrInv.clear();
            }
            currentListCntrInv.add(cntrInv_i);
        }
        
        Map<Id,Container__c> cntrToUpdate = new Map<Id,Container__c>();
        for (Container__c cntr_i : scope) {
            
            List<ContainerInvoice__c> childListCntrInv = cntrIdToListCntrInvs.get(cntr_i.Id);
            if(childListCntrInv == null) {
                continue;
            }
            
            Datetime currentMaxDate;
            Datetime currentContainer;
            for(ContainerInvoice__c cntrInv_j : childListCntrInv) {
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