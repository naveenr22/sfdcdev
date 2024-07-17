import { LightningElement } from 'lwc';

export default class ApexHoursPractice extends LightningElement {
/*
    myVal = "I am practising today";

    handleChange(event){
        this.myVal= event.target.value;
    }
     */
    FirstName=' ';

    LastName=' ';
    handleChange(event){
        const field= event.target.name;
        if(field=='FirstName'){
            this.FirstName=event.target.value;
        }
        else{
            this.LastName=event.target.value;
        }
    }
    get uppercaseName(){
        return `${this.FirstName} ${this.LastName}`.toUpperCase();
    }
}