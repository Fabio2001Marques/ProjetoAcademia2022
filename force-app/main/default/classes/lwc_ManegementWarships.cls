/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 18-07-2022
 * @last modified by  : Fábio Marques
**/
public with sharing class lwc_ManegementWarships {
    @AuraEnabled(cacheable=true)
    public static List<Warship__c> getWarships() {
       return [
            SELECT Id, Name
            FROM Warship__c
       ];
       
    }

    @AuraEnabled
    public static List<Warship_Supply__c> getSupllies(String wId) {
     try {
          List<Warship_Supply__c> supplies = [ SELECT Id, Name, Supply_Name__c, Quantity__c FROM Warship_Supply__c WHERE Ship_supply__c = :wId Order by Supply_Name__c];
          if(supplies.isEmpty()){
               return null;
               }
               return supplies;
     } catch (Exception e) {
          throw new AuraHandledException(e.getMessage());
     } 
     }

     @AuraEnabled
     public static List<Milestone__c> getMilestones(String wId) {
          try {
               List<Milestone__c> milestones = [SELECT id, Name, Due_Date__c,Status__c  FROM Milestone__c WHERE Warship__c = :wId Order by Due_Date__c];
               if(milestones.isEmpty()){
                    return null;
                    }
                    return milestones;
          } catch (Exception e) {
               throw new AuraHandledException(e.getMessage());
          } 
     }

     @AuraEnabled
     public static Warship_Supply__c getAddSupply(String ws_Id) {
          try {
               Warship_Supply__c ws = [SELECT Id,Supply_Name__c, Quantity__c, Available_Quantity__c FROM Warship_Supply__c WHERE Id = :ws_Id];
               if(ws == null){
                    return null;
               }
               return ws;
          } catch (Exception e) {
               throw new AuraHandledException(e.getMessage());
          } 
     }

     @AuraEnabled
     public static List<Warship_Supply__c> updateWarSup(String ws_Id, Integer quantity) {
          try {
               Warship_Supply__c ws = [SELECT Ship_supply__c, Supply_Name__c, Quantity__c, Available_Quantity__c FROM Warship_Supply__c WHERE Id = :ws_Id];
               if(ws != null){
                    ws.Quantity__c = ws.Quantity__c + quantity;
                    update ws;     
               }
               return getSupllies(ws.Ship_supply__c);
               
          } catch (Exception e) {
               throw new AuraHandledException(e.getMessage());
          } 
     }
}
