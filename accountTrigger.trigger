trigger accountTrigger on Account (before insert, before update, before delete) {

    List<Opportunity> opptysList = [select id, name, closedate, stagename from Opportunity where accountId IN :Trigger.newMap.keySet()];

    for(Account a : Trigger.new){
        for(Opportunity o: opptysList){
            if(o.accountid == a.id ){
                
                if( o.StageName =='Closed - Lost')
                    System.debug('Do more logic here for closed lost...');
                
                else if(o.StageName =='Closed - Won')
                    System.debug('Do more logic here for closed won...');        
            }
        }
    }
}