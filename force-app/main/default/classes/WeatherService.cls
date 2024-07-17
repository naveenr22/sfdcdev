public class WeatherService {
    @AuraEnabled
    public static String getWeatherByCity(String cityName) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://api.openweathermap.org/data/2.5/weather?q='+cityName+'&appid=d4d062b9dfc510d54a8ad4781b9e3364');
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        return res.getBody();
    }
}
