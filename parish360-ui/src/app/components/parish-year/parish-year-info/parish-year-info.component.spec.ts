import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ParishYearInfoComponent } from './parish-year-info.component';

describe('ParishYearInfoComponent', () => {
  let component: ParishYearInfoComponent;
  let fixture: ComponentFixture<ParishYearInfoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ParishYearInfoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ParishYearInfoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
