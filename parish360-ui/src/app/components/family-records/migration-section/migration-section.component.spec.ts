import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MigrationSectionComponent } from './migration-section.component';

describe('MigrationSectionComponent', () => {
  let component: MigrationSectionComponent;
  let fixture: ComponentFixture<MigrationSectionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MigrationSectionComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MigrationSectionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
