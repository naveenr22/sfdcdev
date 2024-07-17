import { LightningElement, track } from 'lwc';
import getWeatherByCity from '@salesforce/apex/WeatherService.getWeatherByCity';

export default class MyWeatherComponent extends LightningElement {
    @track weatherData;
    city;

    handleCityChange(event) {
        this.city = event.target.value;
    }

    fetchWeather() {
        getWeatherByCity({ cityName: this.city })
        .then(result => {
            this.weatherData = JSON.parse(result).weather[0].description;
        })
        .catch(error => {
            console.error('Error fetching weather', error);
        });
    }
}
