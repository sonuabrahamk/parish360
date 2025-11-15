import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BookingsSummaryComponent } from './bookings-summary.component';

describe('BookingsSummaryComponent', () => {
  let component: BookingsSummaryComponent;
  let fixture: ComponentFixture<BookingsSummaryComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [BookingsSummaryComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BookingsSummaryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
