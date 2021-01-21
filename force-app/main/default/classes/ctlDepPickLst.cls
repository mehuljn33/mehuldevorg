public class ctlDepPickLst {
    public String country{get;set;}
    public String state{get;set;}

    public List<SelectOption> getcountries()
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('None','--- Select ---'));        
        options.add(new SelectOption('US','United States'));
        options.add(new SelectOption('IN','India'));
        return options;
    } 
    
    public List<SelectOption> getstates()
    {
        List<SelectOption> options = new List<SelectOption>();
        if(country == 'US')
        {       
            options.add(new SelectOption('CO','Colorado'));
            options.add(new SelectOption('NE','Nevada'));
            options.add(new SelectOption('TE','Texas'));
        }
        else if(country == 'IN')
        {       
            options.add(new SelectOption('BI','Bihar'));
            options.add(new SelectOption('KE','Kerala'));
            options.add(new SelectOption('MA','Manipur'));
        }
        else
        {
            options.add(new SelectOption('None','--- Select ---'));
        }      
        //return options;
        return null;
    }       
}