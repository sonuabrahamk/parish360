import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ServiceIntentionsComponent } from './service-intentions.component';

describe('ServiceIntentionsComponent', () => {
  let component: ServiceIntentionsComponent;
  let fixture: ComponentFixture<ServiceIntentionsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ServiceIntentionsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ServiceIntentionsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
