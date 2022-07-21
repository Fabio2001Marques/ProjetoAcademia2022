/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 21-07-2022
 * @last modified by  : Fábio Marques
**/
public with sharing class lwc_ManegementWarships {
    @AuraEnabled(cacheable=true)
    public static List<Warship__c> getWarships() {
       return [SELECT Id, Name FROM Warship__c]; 
    } 

    @AuraEnabled
    public static List<Warship_Supply__c> getSupllies(String wId) {
     
          List<Warship_Supply__c> supplies = [ SELECT Id, Name, Supply_Name__c, Quantity__c FROM Warship_Supply__c WHERE Ship_supply__c = :wId Order by Supply_Name__c];
          if(supplies.isEmpty()){
               return null;
          }
          return supplies;
     
     }

     @AuraEnabled
     public static List<Milestone__c> getMilestones(String wId) {
          
          List<Milestone__c> milestones = [SELECT id, Name, Due_Date__c,Status__c  FROM Milestone__c WHERE Warship__c = :wId Order by Due_Date__c];
          if(milestones.isEmpty()){
               return null;
          }
          return milestones;
         
     }

     @AuraEnabled
     public static List<Warship_Resource__c> getResources(String wId) {
          
          List<Warship_Resource__c> resources = [SELECT Id, Resource_Name__c, Quantity__c FROM Warship_Resource__c WHERE Warship__c = :wId];
          if(resources.isEmpty()){
               return null;
          }
          return resources;
         
     }

     @AuraEnabled
     public static Warship_Supply__c getAddSupply(String ws_Id) {
          
          Warship_Supply__c ws = [SELECT Id,Supply_Name__c, Quantity__c, Available_Quantity__c FROM Warship_Supply__c WHERE Id = :ws_Id];

          return ws;
           
     }

     @AuraEnabled
     public static List<Warship_Supply__c> updateWarSup(String ws_Id, Integer quantity) {
        
          Warship_Supply__c ws = [SELECT Ship_supply__c, Supply_Name__c, Quantity__c, Available_Quantity__c FROM Warship_Supply__c WHERE Id = :ws_Id];
          if(ws != null){
               ws.Quantity__c = ws.Quantity__c + quantity;
               update ws;     
          }
          return getSupllies(ws.Ship_supply__c);
 
     }
}
