public class ParkLocator{
    public static String[] country(String arg0) {
         
        ParkService.ParksImplPort pp = new ParkService.ParksImplPort();
        String [] arr = pp.byCountry(arg0);
        return arr;
    }
}