/**
 * Created by mjain on 18-Feb-20.
 */

public class BusScheduleCache {
    private Cache.OrgPartition part;
    public BusScheduleCache(){this.part = Cache.Org.getPartition('local.BusSchedule');}

    public void putSchedule(String busLine, Time[] schedule)
    {
        part.put(busLine, schedule);
    }

    public Time[] getSchedule(String busLine)
    {
        Time[] result = new Time[]{};
        return (part.get(busLine) != null) ? (Time[]) part.get(busLine) : (Time[]) new Time[]{Time.newInstance(8, 0, 0, 0), Time.newInstance(17, 0, 0, 0)};
    }
}

/*public with sharing class BusScheduleCache {
    private Cache.OrgPartition part;

    public BusScheduleCache(){
        part = new Cache.OrgPartition('local.BusSchedule ');
    }

    public void putSchedule(String busLine, Time[] schedule){
        part.put('busLine', schedule);
    }
    public Time[] getSchedule(String busLine){
        if ( this.part.get(busLine) != null ) {
            return (Time[]) this.part.get(busLine);
        }
        else {
            Time[] lstTime = new List<Time>{Time.newInstance(8,0,0,0), Time.newInstance(17,0,0,0)};
            return lstTime;
        }

    }
}*/