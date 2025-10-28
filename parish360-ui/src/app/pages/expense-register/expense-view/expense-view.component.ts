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
import { FooterComponent } from '../../../components/family-records/footer/footer.component';
import { Account } from '../../../services/interfaces/accounts.interface';
import { AccountService } from '../../../services/api/accounts.service';
import { ToastService } from '../../../services/common/toast.service';

@Component({
  selector: 'app-expense-view',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    FontAwesomeModule,
    FooterComponent,
  ],
  templateUrl: './expense-view.component.html',
  styleUrl: './expense-view.component.css',
})
export class ExpenseViewComponent {
  screen: string = SCREENS.EXPENSES;
  isEditMode: boolean = true;
  faArrowLeft = faArrowLeft;

  accounts!: Account[];
  expenseId: string | null = null;
  expense!: Expense;
  expenseForm!: FormGroup;

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private expenseService: ExpenseService,
    private fb: FormBuilder,
    private accountService: AccountService,
    private toast: ToastService
  ) {}

  ngOnInit() {
    this.expenseId = this.route.snapshot.paramMap.get('expenseId');
    this.accountService.getAccountsList().subscribe({
      next: (accounts) => {
        this.accounts = accounts;
        if (this.expenseId) {
          this.expenseService
            .getExpense(this.expenseId)
            .subscribe((expense) => {
              this.expense = expense;
              this.loadExpenseForm();
              this.expenseForm.disable();
              this.isEditMode = false;
            });
        }
        this.loadExpenseForm();
      },
      error: (error) => {
        this.toast.error('Error fetching accounts: ', error);
      },
    });
    this.loadExpenseForm();
  }

  loadExpenseForm() {
    this.expenseForm = this.fb.group({
      id: [this.expense?.id || 'create'],
      date: [
        this.expense?.date
          ? new Date(this.expense.date).toISOString().split('T')[0]
          : new Date().toISOString().split('T')[0],
      ],
      paid_to: [this.expense?.paid_to || ''],
      paid_by: [this.expense?.paid_by || ''],
      amount: [this.expense?.amount || ''],
      currency: [this.expense?.currency || 'INR'],
      payment_method: [this.expense?.payment_method || 'cash'],
      description: [this.expense?.description || ''],
      account_id: [
        this.expense?.account_id || this.accounts?.length > 0
          ? this.accounts[0].id
          : '',
      ],
    });
  }

  onModeUpdate(event: FooterEvent) {
    this.isEditMode = event.isEditMode;
    event.isSaveTriggered ? this.onSave() : null;
    event.isDeleteTriggered ? this.onDelete() : null;
    this.isEditMode ? this.expenseForm.enable() : this.expenseForm.disable();
  }

  onDelete() {
    this.expenseService.deleteExpense(this.expenseId!).subscribe({
      next: () => {
        this.toast.success('Expense deleted successfully');
        this.router.navigate(['/expenses']);
      },
      error: (error) => {
        this.toast.error('Error deleting expense: ', error);
      },
    });
  }

  onSave() {
    if (this.expenseForm.get('id')?.value === 'create') {
      this.expenseForm.removeControl('id');
      this.expenseService.createExpense(this.expenseForm.value).subscribe({
        next: (expense) => {
          this.toast.success('Expense created successfully');
          this.router.navigate(['/expenses/view', expense.id]);
        },
        error: (error) => {
          this.toast.error('Error creating expense: ', error);
        },
      });
    } else {
      this.expenseService
        .updateExpense(this.expenseId!, this.expenseForm.value)
        .subscribe({
          next: (expense) => {
            this.toast.success('Expense updated successfully');
            this.expense = expense;
            this.expenseForm.disable();
            this.isEditMode = false;
          },
          error: (error) => {
            this.toast.error('Error updating expense: ', error);
          },
        });
    }
  }

  onBackClick() {
    this.router.navigate(['/expenses']);
  }
}
