import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MiscellenousComponent } from './miscellenous.component';

describe('MiscellenousComponent', () => {
  let component: MiscellenousComponent;
  let fixture: ComponentFixture<MiscellenousComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MiscellenousComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MiscellenousComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
