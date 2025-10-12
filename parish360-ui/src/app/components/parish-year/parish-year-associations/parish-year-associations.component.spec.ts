import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ParishYearAssociationsComponent } from './parish-year-associations.component';

describe('ParishYearAssociationsComponent', () => {
  let component: ParishYearAssociationsComponent;
  let fixture: ComponentFixture<ParishYearAssociationsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ParishYearAssociationsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ParishYearAssociationsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
