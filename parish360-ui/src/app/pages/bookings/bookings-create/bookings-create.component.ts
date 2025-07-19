import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faArrowLeft } from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'app-bookings-create',
  imports: [CommonModule, FontAwesomeModule, ReactiveFormsModule],
  templateUrl: './bookings-create.component.html',
  styleUrl: './bookings-create.component.css'
})
export class BookingsCreateComponent {
  faArrowLeft = faArrowLeft;
  bookingsForm!: FormGroup;

  constructor(private router: Router, private fb: FormBuilder){}

  ngOnInit(){
    this.fb.group([
      this.bookingsForm = this.fb.group({
        booking_type: '',
        date: '',
        event:'',
        booked_by: '',
        contact: '',
        note: '',
        status: ''
      })
    ])
  }

  onBackClick(){
    this.router.navigate(['bookings']);
  }

  onCancel(){
    this.bookingsForm.reset();
  }

  onSave(){
    console.log(this.bookingsForm.value);
  }

}
