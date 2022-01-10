package inc.fabric.api.automation.utility;

import inc.fabric.api.automation.pages.BasePage;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

public class RestHttp extends BasePage {

    public static Response postCall(String endPoint, String body, RequestSpecification requestSpecification){
        requestSpecification.body(body);
        scenario.write("Request Payload : "+ body);
        Response response = requestSpecification.post(endPoint);
        scenario.write("Response : "+ response.asString());
        while(response.getStatusCode() == 502){
            response = requestSpecification.post(endPoint);
        }
        response.prettyPrint();
        return response;
    }

    public static Response putCall(String endPoint, String body, RequestSpecification requestSpecification){
        requestSpecification.body(body);
        scenario.write("Request Payload : "+ body);
        Response response = requestSpecification.put(endPoint);
        scenario.write("Response : "+ response.asString());
        while(response.getStatusCode() == 502){
            response = requestSpecification.put(endPoint);
        }
        return response;
    }

    public static Response getCall(String endPoint, RequestSpecification requestSpecification){
        Response response = requestSpecification.get(endPoint);
        scenario.write("Response : "+ response.asString());
        while(response.getStatusCode() == 502){
            response = requestSpecification.get(endPoint);
        }
        return response;
    }

    public static void deleteCall(String endPoint,RequestSpecification requestSpecification){
        Response response = requestSpecification.delete(endPoint);
        while(response.getStatusCode() == 502){
            response = requestSpecification.delete(endPoint);
        }
    }
}
