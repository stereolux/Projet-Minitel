class Tweet
{
  private int col ; 
  private int siz ;
  private PVector pos ;
  private String texte; 
  private int timecrea; 
  
  

  public Tweet(String texte, PVector pos)
  {
    col = int(255);
    siz = 10;
    this.texte = texte;
    this.pos = pos;
    this.timecrea = millis();
  }

  public void disparaitre()
  {
       if(col >= 0)
       {
         col=col-20;
       }
  }
  
  public int getTime()
  {
    return timecrea; 
  } 
  
  public void setTime(int time)
  {
    this.timecrea = time; 
  }

  public String getText()
  {
    return texte; 
  }
  public int getCol()
  {
    return col;
  }
  
  public PVector getPos(){
    return pos;
  }

}

