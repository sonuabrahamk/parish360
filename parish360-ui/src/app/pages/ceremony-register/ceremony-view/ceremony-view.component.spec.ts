import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CeremonyViewComponent } from './ceremony-view.component';

describe('CeremonyViewComponent', () => {
  let component: CeremonyViewComponent;
  let fixture: ComponentFixture<CeremonyViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CeremonyViewComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CeremonyViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
