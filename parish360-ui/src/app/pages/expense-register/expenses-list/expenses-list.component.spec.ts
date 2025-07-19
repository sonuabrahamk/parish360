import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ExpensesViewComponent } from './expenses-list.component';

describe('ExpensesViewComponent', () => {
  let component: ExpensesViewComponent;
  let fixture: ComponentFixture<ExpensesViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ExpensesViewComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ExpensesViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
