import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ParishYearComponent } from './parish-year.component';

describe('ParishYearComponent', () => {
  let component: ParishYearComponent;
  let fixture: ComponentFixture<ParishYearComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ParishYearComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ParishYearComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
