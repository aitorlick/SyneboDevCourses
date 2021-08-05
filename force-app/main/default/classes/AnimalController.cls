public with sharing class AnimalController {

    @AuraEnabled
    public static List<Animal__c> getAnimalsById(String externalID){
        
        Boolean incomingDataIsId = true;
        try{
            Id test = Id.valueOf(externalID);           
        } catch(Exception e) {
            incomingDataIsId = false;
        }
        
        String searchField = incomingDataIsId ? 'Id' : 'External_Id__c';
        String query = 'SELECT Id'
            + 		', Name'
            + 		', Eats__c'
            + 	 	', Says__c'
            + 		', External_Id__c'
            +' FROM Animal__c'
            +' WHERE ' + searchField +' = :externalID';    
        
        List<Animal__c> animalList = Database.query(query);
        
        return animalList;
        
    }
    
}