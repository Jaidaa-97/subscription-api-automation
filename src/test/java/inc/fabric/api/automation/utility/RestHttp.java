package inc.fabric.api.automation.utility;

import inc.fabric.api.automation.pages.BasePage;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;


public class RestHttp extends BasePage {

    public static Response postCall(String endPoint, String body, RequestSpecification requestSpecification){
        requestSpecification.body(body);
        scenario.write("*****************************************************************************************************");
        scenario.write("EndPint : "+ endPoint);
        scenario.write("Request Payload : "+ body);
        Response response = requestSpecification.post(endPoint);
        scenario.write("Response Time : "+ response.getTime());
        scenario.write("Response : "+ response.asString());
        scenario.write("*****************************************************************************************************");
        response.prettyPrint();
        return response;
    }

    public static Response putCall(String endPoint, String body, RequestSpecification requestSpecification){
        requestSpecification.body(body);
        scenario.write("*****************************************************************************************************");
        scenario.write("EndPint : "+ endPoint);
        scenario.write("Request Payload : "+ body);
        Response response = requestSpecification.put(endPoint);
        scenario.write("Response Time : "+ response.getTime());
        scenario.write("Response : "+ response.asString());
        scenario.write("*****************************************************************************************************");
        return response;
    }

    public static Response patchCall(String endPoint, String body, RequestSpecification requestSpecification){
        requestSpecification.body(body);
        scenario.write("*****************************************************************************************************");
        scenario.write("EndPint : "+ endPoint);
        scenario.write("Request Payload : "+ body);
        Response response = requestSpecification.patch(endPoint);
        scenario.write("Response Time : "+ response.getTime());
        scenario.write("Response : "+ response.asString());
        scenario.write("*****************************************************************************************************");
        return response;
    }

    public static Response getCall(String endPoint, RequestSpecification requestSpecification){
        scenario.write("*****************************************************************************************************");
        scenario.write("EndPint : "+ endPoint);
        Response response = requestSpecification.get(endPoint);
        scenario.write("Response Time : "+ response.getTime());
        scenario.write("Response : "+ response.asString());
        scenario.write("*****************************************************************************************************");
        response.prettyPrint();
        return response;
    }

    public static Response deleteCall(String endPoint,RequestSpecification requestSpecification){
        scenario.write("*****************************************************************************************************");
        scenario.write("EndPint : "+ endPoint);
        Response response = requestSpecification.delete(endPoint);
        scenario.write("Response Time : "+ response.getTime());
        scenario.write("Response : "+ response.asString());
        scenario.write("*****************************************************************************************************");
        return response;
    }
}
