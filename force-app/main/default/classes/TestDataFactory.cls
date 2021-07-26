@isTest
public class TestDataFactory {
    
    public static Container__c prepareContainer(String cntrName) {
    	Container__c cntr = new Container__c();
        cntr.Name=cntrName;
        return cntr;
	}
    
    public static ContainerInvoice__c prepareContainerInvoice(String cntrInvName, Id cntrId) {
    	ContainerInvoice__c cntrInv = new ContainerInvoice__c();
        cntrInv.Name=cntrInvName;
        cntrInv.Container__c = cntrId;
        return cntrInv;
	}
    
    public static Animal__c prepareAnimal(String animalName, String animalExternalId) {
    	Animal__c animal = new Animal__c();
        animal.Name=animalName;
        animal.External_Id__c = animalExternalId;
        return animal;
	}
    
    public static void createContainers(Integer count) {
        List<Container__c> cntrs = new List<Container__c>();
        for(Integer i=0;i<count;i++) {
        	cntrs.add(prepareContainer('Test cntr '+i));	    
        }
        insert cntrs;
	}
    
    public static void createContainerInvoice(Integer count, Id cntrId) {
        List<ContainerInvoice__c> cntrInvs = new List<ContainerInvoice__c>();
        for(Integer i=0;i<count;i++) {
        	cntrInvs.add(prepareContainerInvoice('Test cntrInv '+i, cntrId));	    
        }
        insert cntrInvs;
	}
    
    public static void createAnimals(Integer count) {
        List<Animal__c> animals = new List<Animal__c>();
        for(Integer i=0;i<count;i++) {
        	animals.add(prepareAnimal('Test animal '+i, String.valueOf(i)));	    
        }
        insert animals;
	}

}