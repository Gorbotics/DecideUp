import { Component, OnInit } from '@angular/core';
import {User} from '../User';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.css']
})
export class AdminComponent implements OnInit {
  user: User = {
    id: 1,
    name: 'brian'
  };
  constructor() { }

  ngOnInit() {
  }

}
