import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

public class MongoDb {


    public static void main(String[] args) {

        MongoClientURI URL = new MongoClientURI("mongodb+srv://huF1lSb1OksYzdnN:ntWD55BiCHSBdj16@cls-02-staging-all.cx18a.mongodb.net/stg02pim2_inventory?authSource=admin&replicaSet=atlas-t6r4b1-shard-0&readPreference=primary&appname=MongoDB%20Compass&retryWrites=true&ssl=true");
        MongoClient mongoClient = new MongoClient(URL);

        String appName = mongoClient.getMongoClientOptions().getApplicationName();
        MongoDatabase md = mongoClient.getDatabase("admin");
        MongoCollection<Document> channels = md.getCollection("channels");
        Document d = channels.find(new Document("name","US Web")).first();
        System.out.println("app name " + d.get("channelId"));

    }
}
