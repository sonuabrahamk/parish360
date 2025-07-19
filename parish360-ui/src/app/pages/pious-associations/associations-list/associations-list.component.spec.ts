import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AssociationsViewComponent } from './associations-list.component';

describe('AssociationsViewComponent', () => {
  let component: AssociationsViewComponent;
  let fixture: ComponentFixture<AssociationsViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AssociationsViewComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AssociationsViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
