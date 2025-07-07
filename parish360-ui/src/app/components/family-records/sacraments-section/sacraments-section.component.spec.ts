import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SacramentsSectionComponent } from './sacraments-section.component';

describe('SacramentsSectionComponent', () => {
  let component: SacramentsSectionComponent;
  let fixture: ComponentFixture<SacramentsSectionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SacramentsSectionComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SacramentsSectionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
