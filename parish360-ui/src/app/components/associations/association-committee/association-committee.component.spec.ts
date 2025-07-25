import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AssociationCommitteeComponent } from './association-committee.component';

describe('AssociationCommitteeComponent', () => {
  let component: AssociationCommitteeComponent;
  let fixture: ComponentFixture<AssociationCommitteeComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AssociationCommitteeComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AssociationCommitteeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
