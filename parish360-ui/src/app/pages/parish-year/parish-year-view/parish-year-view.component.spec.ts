import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ParishYearViewComponent } from './parish-year-view.component';

describe('ParishYearViewComponent', () => {
  let component: ParishYearViewComponent;
  let fixture: ComponentFixture<ParishYearViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ParishYearViewComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ParishYearViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
