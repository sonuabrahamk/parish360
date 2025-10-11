import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ParishYearListComponent } from './parish-year-list.component';

describe('ParishYearListComponent', () => {
  let component: ParishYearListComponent;
  let fixture: ComponentFixture<ParishYearListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ParishYearListComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ParishYearListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
