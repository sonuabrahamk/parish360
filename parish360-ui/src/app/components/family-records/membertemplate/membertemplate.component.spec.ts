import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MembertemplateComponent } from './membertemplate.component';

describe('MembertemplateComponent', () => {
  let component: MembertemplateComponent;
  let fixture: ComponentFixture<MembertemplateComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MembertemplateComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MembertemplateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
