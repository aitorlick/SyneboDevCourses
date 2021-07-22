public class createContainerAndContainerInvoice implements Queueable{	
    private Boolean isContainerCreate;
    private Integer countObj;
	private List<Container__c> cntrs;
      
    public createContainerAndContainerInvoice(Integer countObj) {    
        this.isContainerCreate = true;
        this.countObj = countObj;
    }
    
    // for chaining queu test
    public createContainerAndContainerInvoice(Boolean isContainerCreate, Integer countObj, List<Container__c> cntrs) {
        this.isContainerCreate = isContainerCreate;
        this.countObj = countObj;
        this.cntrs = cntrs;    
    }
    
    public void execute(QueueableContext context) {
		
		if (isContainerCreate == true) {
			List<Container__c> cntrs = new List<Container__c>();
        	for(Integer i=0;i<countObj;i++) {
				Container__c cntr = new Container__c(Name = 'Super test'+i);
                cntrs.add(cntr);
			}        
			insert cntrs;
			isContainerCreate = false;
            if(!Test.isRunningTest()){
                ID jobID = System.enqueueJob(this);
				System.debug(jobID);    
            }              
		} else {
        	List<ContainerInvoice__c> cntrsInvs = new List<ContainerInvoice__c>();
            for(Container__c cntr : cntrs) {
                for(Integer i=0;i<countObj;i++) {
                    ContainerInvoice__c cntrInv = new ContainerInvoice__c();
                    cntrInv.Name = 'Super test'+i;
                    cntrInv.Container__c = cntr.Id;
                    cntrsInvs.add(cntrInv);
                }
            }
            insert cntrsInvs;    
        }
    }
}