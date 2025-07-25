import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AssociationMembersComponent } from './association-members.component';

describe('AssociationMembersComponent', () => {
  let component: AssociationMembersComponent;
  let fixture: ComponentFixture<AssociationMembersComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AssociationMembersComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AssociationMembersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
