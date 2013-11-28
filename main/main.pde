import twitter4j.conf.*;
import twitter4j.internal.async.*;
import twitter4j.internal.org.json.*;
import twitter4j.internal.logging.*;
import twitter4j.json.*;
import twitter4j.internal.util.*;
import twitter4j.management.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import twitter4j.util.*;
import twitter4j.internal.http.*;
import twitter4j.*;
import twitter4j.internal.json.*;
import java.util.*;


Tweet montweet; 
Twitter twitter; // objet twitter
String searchString = "@stereoluxlab"; // utilisé dans la recherche de tweets
List<Status> tweets; // liste contenant 100 tweets
ArrayList tweetList = new ArrayList<Tweet>(); // liste d'objet Tweet
String tweetText; // le texte du tweet
int currentTweet = 0; //variable nous indiquant quel tweet doit être affiché 


//Mensuration du tweet a afficher
int tweetWidth ; // largeur total du tweet 
int tweetHeight ; // hauteur du tweet


int frameNumber = 60;

void setup() {
  
  //variables d'affichages
  size(450, 300);
  background(0); // couleur du fond d'ecran
  textSize(10); // taille du texte
  textLeading(11); //taille des interlignes du texte

  tweetWidth = 278; // largeur total du tweet + photo affiché
  tweetHeight = 48; // taille de l'image de profil 

  //preparation des identifiants de l'application 
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("xxxxxxxxxxxxxxxxxxxxxxx");
  cb.setOAuthConsumerSecret("xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"); 
  cb.setOAuthAccessToken("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"); 
  cb.setOAuthAccessTokenSecret("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"); 

  TwitterFactory tf = new TwitterFactory(cb.build());

  //création de l'objet twitter qui servira tout au long du sketch
  twitter = tf.getInstance();

  //fonction appellé pour la premiere fois afin de charger des tweets dans notre liste
  getNewTweets();
  //refreshTweets();
  montweet = new Tweet("test", new PVector(50,50)); 


  //la fonction refreshTweets est ensuite appellé dans un thread a par afin de ne pas ralentir le sketch lorsque de nouveaux tweets sont chargé dans le tableau
  thread("refreshTweets");
}

void draw() {
  background(0);
  
  

  
  // si le compteur "curentTweet" depasse le total de tweets dans la list nous faisons une remise a zero du sketch
  if (currentTweet >= tweetList.size()) {
    currentTweet = 0; 
    background(0);
  }

  // contient le tweet à afficher pour cette frame
//  Status status = tweets.get(currentTweet);
  Tweet tweet = (Tweet)tweetList.get(currentTweet);
  currentTweet ++;
  fill(tweet.getCol());
    // texte du tweet
  tweetText = tweet.getText();

  //Affichage du tweet
  // fill(0);
  //image(img, xPos, yPos);
  // text(tweetText ,xPos+tweetHeight, yPos, tweetTextSize, tweetHeight);
  PVector pos=tweet.getPos();
  text(tweetText.toUpperCase(), pos.x, pos.y, 80, 30);
  delay(1000);
  
  
  
  
  if ( millis() - tweet.getTime() > 1000)
  {
    tweet.disparaitre();
  }
  //------------------------------------------------

  //On determine la position du tweet
  /*xPos = tweetColumnsCount*tweetWidth;
   yPos = tweetRowsCount*tweetHeight;*/
//  float xPos = random(300);
//  float yPos = random(300);

  //image de profil 
  // imageUrl = status.getUser().getProfileImageURL();
  // img = loadImage(imageUrl,"jpg");
  // imageWidth = img.width;
  // imageHeight = img.height;



  /// determiner la position du prochain tweet
  /*if(tweetColumnsCount%tweetColumns == 0 && tweetColumnsCount !=0){
   tweetColumnsCount = 0;
   tweetRowsCount ++;
   if(tweetRowsCount%tweetRows ==0 && tweetRowsCount !=0){
   tweetRowsCount = 0;
   }
   } else{
   tweetColumnsCount++;
   }*/

}

//fonction qui vient chercher les 100 derniers tweets
void getNewTweets() {

  try {
    Query query = new Query(searchString);
    query.count(100);
    QueryResult result = twitter.search(query);
    tweets = result.getTweets();
    int i; 
    for (i=0; i<tweets.size(); i++)
    {
      tweets.get(i).getText();
      PVector posXY = new PVector(random(100),random(100));
      Status s = tweets.get(i);
      String texte = s.getText();
      tweetList.add(new Tweet(texte,new PVector(random(100),random(100))));
    }
  } 
  catch (TwitterException te) {
    println("Echec de la recherche de tweets: " + te.getMessage());
    exit();
  }
}

//charge de nouveau tweets dans la list "tweets" toutes les 
void refreshTweets()
{

  while (true) {
    getNewTweets();
    println("tweets mis a jours"); 
    delay(1000);
  }
}

