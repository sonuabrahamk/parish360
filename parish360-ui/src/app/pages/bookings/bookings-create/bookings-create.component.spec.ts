import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BookingsCreateComponent } from './bookings-create.component';

describe('BookingsCreateComponent', () => {
  let component: BookingsCreateComponent;
  let fixture: ComponentFixture<BookingsCreateComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [BookingsCreateComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BookingsCreateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
