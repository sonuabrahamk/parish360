import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AssociatesMappingComponent } from './associates-mapping.component';

describe('AssociatesMappingComponent', () => {
  let component: AssociatesMappingComponent;
  let fixture: ComponentFixture<AssociatesMappingComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AssociatesMappingComponent],
    }).compileComponents();

    fixture = TestBed.createComponent(AssociatesMappingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
