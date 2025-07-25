import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AssociationViewComponent } from './association-view.component';

describe('AssociationViewComponent', () => {
  let component: AssociationViewComponent;
  let fixture: ComponentFixture<AssociationViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AssociationViewComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AssociationViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
