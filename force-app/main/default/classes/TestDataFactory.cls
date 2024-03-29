/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 21-07-2022
 * @last modified by  : Fábio Marques
**/
public class TestDataFactory {

    public static Account createAccount(){
        Account account = new Account();

        account.Name = 'Loba';
        account.BillingCity = 'city';
        account.BillingStreet = 'city';
        account.BillingPostalCode = '9871';
        account.BillingCountry = 'Portugal';
        account.SLA__c = 'Gold';
        account.SLAExpirationDate__c = System.today().addDays(30);
        account.SLASerialNumber__c = '12345aa';

        insert account;

        return account;
    }

    public static List<Supply__c> createSupplies(Integer nSupplies){
        List<Supply__c> supplies = new List<Supply__c>();

        for (Integer i = 0; i < nSupplies; i++) {
            Supply__c s = new Supply__c();
            s.Name = 'Teste DataFactory'+i;
            s.Quantity__c = i+10;
            s.Unit_Cost__c = i+1;
            supplies.add(s);
        }
        return supplies; 
    }

    public static List<Resource__c> createResources(Integer nResource){
        List<Resource__c> resources = new List<Resource__c>();

        for (Integer i = 0; i < nResource; i++) {
            Resource__c r = new Resource__c();
            r.Name = 'Teste Resource DataFactory'+i;
            r.Quantity__c = i+10;
            r.Minimum_Workload__c = 10;
            resources.add(r);
        }
        return resources; 
    }

    public static List<Warship__c> createWarship(Integer nWarships){
        List<Warship__c> warships = new List<Warship__c>();
        Account acc = createAccount();
        for (Integer i = 0; i < nWarships; i++) {
            Warship__c w = new Warship__c();
            w.Name = 'Teste DataFactory'+i;
            w.Weapons_Status__c = 'Not Yet Operational';
            w.Account__c = acc.Id;
            warships.add(w);
        }
        return warships;
    }

    public static void createWarSup (Integer newWarSup){
        List<Warship_Supply__c> warshipSuplly = new List<Warship_Supply__c>();
        List<Supply__c> supplies = createSupplies(newWarSup);
        List<Warship__c> warships = createWarship(2);
        insert supplies;
        insert warships;
        for (Warship__c w : warships) {
            for (Integer i = 0; i < newWarSup; i++) {
                Warship_Supply__c warSup = new Warship_Supply__c();
                warSup.Ship_supply__c = w.Id;
                warSup.Supply__c = supplies[i].Id;
                warSup.Quantity__c = i+1;
                warshipSuplly.add(warSup);
            }
        }      
        insert warshipSuplly; 
    }

    public static void createWarRes (Integer newWarRes){
        List<Warship_Resource__c> warshipResource = new List<Warship_Resource__c>();
        List<Resource__c> resources = createResources(newWarRes);
        List<Warship__c> warships = [Select id from Warship__c];
        insert resources;
        for (Warship__c w : warships) {
            for (Integer i = 0; i < newWarRes; i++) {
                Warship_Resource__c warRes = new Warship_Resource__c();
                warRes.Warship__c = w.Id;
                warRes.Resoure__c = resources[i].Id;
                warRes.Quantity__c = i+1;
                warshipResource.add(warRes);
            }
        }      
        insert warshipResource; 
    }

    public static void createWarshipsWithMilestones(){
        List<Warship__c> warships = createWarship(3);
        insert warships;
        
        User u = [Select id from User where id= :UserInfo.getUserId()];

        system.runAs(u){
            PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Disable_Validation_Rule'];
            insert new PermissionSetAssignment(AssigneeId = UserInfo.getUserId(), PermissionSetId = ps.Id);    
    
            List<Milestone__c> milestones = new List<Milestone__c>();
     
            for (Integer i = 0; i < 5; i++) {
                Milestone__c ms = new Milestone__c();
                ms.Name = 'Teste 1'+i;
                ms.Warship__c = warships[0].Id;
                ms.Status__c = 'On Track';
                ms.Due_Date__c = System.today().addDays(i-1);
                milestones.add(ms);
            }
            for (Integer i = 0; i < 5; i++) {
                Milestone__c ms = new Milestone__c();
                ms.Name = 'Teste 2'+i;
                ms.Warship__c = warships[1].Id;
                if(i == 0){
                    ms.Status__c = 'Behind Schedule';
                }else{
                    ms.Status__c = 'On Track';
                }
                ms.Due_Date__c = System.today().addDays(i+1);
                milestones.add(ms);
            }
            for (Integer i = 0; i < 5; i++) {
                Milestone__c ms = new Milestone__c();
                ms.Name = 'Teste 2'+i;
                ms.Warship__c = warships[2].Id;
                ms.Status__c = 'Behind Schedule';
                ms.Due_Date__c = System.today().addDays(i+1);
                milestones.add(ms);
            }
            insert milestones;
        }
    
    }

    public static void createMilestones(String w_Id, Integer nMilestones){
        List<Milestone__c> milestones = new List<Milestone__c>();

        for (Integer i = 0; i < nMilestones; i++) {
            Milestone__c ms = new Milestone__c();
            ms.Name = 'Teste 1'+i;
            ms.Warship__c = w_Id;
            ms.Status__c = 'On Track';
            ms.Due_Date__c = System.today().addDays(i);
            milestones.add(ms);
        }
        insert milestones;
    }
}