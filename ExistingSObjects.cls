public class ExistingSObjects {
    public static List<sObjectType> sObjectList(){
		List<sObjectType> objectList = new List<sObjectType>();
        for( Schema.SObjectType obj : Schema.getGlobalDescribe().values()){
            System.debug(obj.getDescribe().getName());
    		objectList.add(obj);
        }
        return objectList;
    }

}