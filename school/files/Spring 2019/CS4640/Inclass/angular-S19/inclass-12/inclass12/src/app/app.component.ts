import { Component } from '@angular/core';
import { Order } from './order';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'inclass12_testing!';
  drinks = ['Coffee', 'Tea', 'Milk','Hot Chocolate'];
  orderModel = new Order('duh', 'duh@uva.edu', 9991234567, '', '', true);

}



 