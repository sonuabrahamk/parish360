import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ParishInfoComponent } from './parish-info.component';

describe('ParishInfoComponent', () => {
  let component: ParishInfoComponent;
  let fixture: ComponentFixture<ParishInfoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ParishInfoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ParishInfoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
