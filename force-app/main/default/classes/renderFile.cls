public with sharing class renderFile {
    public transient Blob fileBody { get; set; }
    public String contentType { get; set; }
    public String fileName { get; set; }
    public string[] items { get; set; }

    public renderFile() {
        items = new string[0];
    }

    public void save() {
        Document d = new Document(FolderId=UserInfo.getUserId(), Name=fileName, Body=fileBody, ContentType=contentType);
        insert d;
        items.add('Uploaded '+d.Name+' as ID '+d.Id);
    }
    public void reRender() {
        items.add('Item: '+(items.size()+1));
    }
    
    public void getfile() {
        system.debug('@@@fileName :' + fileName );
    }
}