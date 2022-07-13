/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 13-07-2022
 * @last modified by  : Fábio Marques
**/
public class WarSupUtility {
    
    public static void insertSupplies(List<Warship_Supply__c> newWarSupplies){
        
        List<Id> suppliesIdList = new List<Id>();
        Id warshipId = newWarSupplies[0].Ship_supply__c;
        
        
        for(Warship_Supply__c newWarSup : newWarSupplies){           
            suppliesIdList.add(newWarSup.Supply__c);
        }

        List<Supply__c> suppliesList = [SELECT Id, Name FROM Supply__c Where Id in (Select Supply__c from Warship_Supply__c where Ship_supply__c = :warshipId)];
        
        
        for (Supply__c s : suppliesList) {
            for (Id ids : suppliesIdList) {
                if(ids == s.Id){
                    newWarSupplies[0].addError('This suplly already exists in this Warship.' );
                }
            }
        }

        List<Supply__c> supply = [SELECT Id, Name, Quantity__c FROM Supply__c Where Id in :suppliesIdList];
        
        //Update Stock in Supply__c Object

        for(Supply__c supplies : supply){           
            for(Warship_Supply__c newWarSup : newWarSupplies){ 
                if(supplies.Id == newWarSup.Supply__c){
                    if(supplies.Quantity__c >= newWarSup.Quantity__c && newWarSup.Quantity__c>0){
                        supplies.Quantity__c = supplies.Quantity__c - newWarSup.Quantity__c;
                    }else if(newWarSup.Quantity__c<=0){
                        newWarSup.addError('Quantity must be greater than zero' );
                    }else{
                        newWarSup.addError('There are not enough supplies.');
                    }   
                }       
            }
        }        
   
        update supply; 

        }

        public static void updateSupplies(List<Warship_Supply__c> oldWarSupplies, List<Warship_Supply__c> newWarSupplies){
            
            List<Id> suppliesIdList = new List<Id>();
            Id warshipId = newWarSupplies[0].Ship_supply__c;
            
            for(Warship_Supply__c newWarSup : newWarSupplies){           
                suppliesIdList.add(newWarSup.Supply__c);
            }

            List<Supply__c> supply = [SELECT Id, Name, Quantity__c FROM Supply__c Where Id in :suppliesIdList];

            for (Supply__c s : supply) {
                for (Warship_Supply__c ws : oldWarSupplies) {
                    if(s.Id == ws.Supply__c){
                        s.Quantity__c = s.Quantity__c + ws.Quantity__c;
                    }
                }    
            }

          for(Supply__c supplies : supply){           
                for(Warship_Supply__c newWarSup : newWarSupplies){ 
                    if(supplies.Id == newWarSup.Supply__c){
                        if(supplies.Quantity__c >= newWarSup.Quantity__c && newWarSup.Quantity__c>0){
                            supplies.Quantity__c = supplies.Quantity__c - newWarSup.Quantity__c;
                        }else if(newWarSup.Quantity__c<=0){
                            newWarSup.addError('Quantity must be greater than zero' );
                        }else{
                            newWarSup.addError('There are not enough supplies.');
                        }   
                    }       
                }
            }
            update supply;
        }
        
        public static void deleteSupplies(List<Warship_Supply__c> oldWarSupplies){
        
            List<Id> suppliesIdList = new List<Id>();
            Id warshipId = oldWarSupplies[0].Ship_supply__c;
            
            for(Warship_Supply__c oldWarSup : oldWarSupplies){           
                suppliesIdList.add(oldWarSup.Supply__c);
            }

            List<Supply__c> supply = [SELECT Id, Name, Quantity__c FROM Supply__c Where Id in :suppliesIdList];
            
            //Update Stock in Supply__c Object

            for(Supply__c supplies : supply){           
                for(Warship_Supply__c oldWarSup : oldWarSupplies){ 
                    if(supplies.Id == oldWarSup.Supply__c){
                        supplies.Quantity__c = supplies.Quantity__c + oldWarSup.Quantity__c;
                    }       
                }
            }
            update supply;
        
        }
}