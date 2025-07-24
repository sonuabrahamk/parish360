import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { SCREENS } from '../../../services/common/common.constants';
import { ActivatedRoute, ActivationEnd, Router } from '@angular/router';
import { ExpenseService } from '../../../services/api/expenses.service';
import { Expense } from '../../../services/interfaces/expenses.interface';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { FooterEvent } from '../../../services/interfaces/permissions.interface';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faArrowLeft } from '@fortawesome/free-solid-svg-icons';
import { FooterComponent } from "../../../components/family-records/footer/footer.component";

@Component({
  selector: 'app-expense-view',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, FontAwesomeModule, FooterComponent],
  templateUrl: './expense-view.component.html',
  styleUrl: './expense-view.component.css'
})
export class ExpenseViewComponent {
  screen: string = SCREENS.EXPENSES;
  isEditMode: boolean = false;
  faArrowLeft = faArrowLeft;

  expenseId: string | null = null;
  expense!: Expense;
  expenseForm!: FormGroup;

  constructor(private router: Router, private route: ActivatedRoute, private expenseService:ExpenseService, private fb: FormBuilder){}

  ngOnInit(){
    this.expenseId = this.route.snapshot.paramMap.get('expenseId');
    if(this.expenseId){
      this.expenseService.getExpense(this.expenseId).subscribe((expense) => {
        this.expense = expense;
        this.loadExpenseForm();
        this.expenseForm.disable();
      });
    }
    this.loadExpenseForm();
    this.expenseForm.get('id')?.disable();
  }

  loadExpenseForm(){
    this.expenseForm = this.fb.group({
      id: [this.expense?.id || ''],
      date: [this.expense?.date || new Date()],
      category: [this.expense?.category || ''],
      amount: [this.expense?.amount || ''],
      currency: [this.expense?.currency || ''],
      paid_to: [this.expense?.paid_to || ''],
      payment_method: [this.expense?.payment_method || ''],
      remarks: [this.expense?.remarks || ''],
    })
  }

  onModeUpdate(event: FooterEvent){
    this.isEditMode = event.isEditMode;
    this.isEditMode ? this.expenseForm.enable() : this.expenseForm.disable();
    this.expenseForm.get('id')?.disable();
  }

  onSave(){
    console.log('Trigger Save Action!!')
  }

  onCancel() {
    console.log('Trigger Cancel Action!!');
  }

  onBackClick(){
    this.router.navigate(['/expenses']);
  }

}
