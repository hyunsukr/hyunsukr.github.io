export class Order {
    constructor(
       public name: string,
       public email: string,
       public phone: number,
       public drink: string,
       public tempPreference: string,
       public sendText: boolean,
    ){}
 }     