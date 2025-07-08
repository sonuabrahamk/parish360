import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BlessingsSectionComponent } from './blessings-section.component';

describe('BlessingsSectionComponent', () => {
  let component: BlessingsSectionComponent;
  let fixture: ComponentFixture<BlessingsSectionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [BlessingsSectionComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BlessingsSectionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
