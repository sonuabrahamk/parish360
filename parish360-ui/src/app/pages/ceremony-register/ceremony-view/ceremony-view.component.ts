import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { SCREENS } from '../../../services/common/common.constants';
import { CeremoniesService } from '../../../services/api/ceremonies.service';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { Ceremony } from '../../../services/interfaces/ceremonys.interface';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faArrowLeft } from '@fortawesome/free-solid-svg-icons';
import { FooterComponent } from '../../../components/family-records/footer/footer.component';

@Component({
  selector: 'app-ceremony-view',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    FontAwesomeModule,
    FooterComponent,
  ],
  templateUrl: './ceremony-view.component.html',
  styleUrl: './ceremony-view.component.css',
})
export class CeremonyViewComponent {
  screen: string = SCREENS.CEREMONIES;
  isEditMode: boolean = false;
  ceremonyId!: string;
  ceremony!: Ceremony;
  ceremonyForm!: FormGroup;

  //Icons declaration
  faArrowLeft = faArrowLeft;

  ceremonyList = [
    'BAPTISM',
    'HOLY_COMMUNION',
    'HOLY_CONFIRMATION',
    'MARRIAGE',
    'ORDINATION',
    'AFTERLIFE',
  ];

  constructor(
    private ceremonyService: CeremoniesService,
    private route: ActivatedRoute,
    private router: Router,
    private fb: FormBuilder
  ) {}

  ngOnInit() {
    // get ceremony Id from url
    this.route.paramMap.subscribe((params) => {
      this.ceremonyId = params.get('id') ?? '';

      //load ceremony data if ceremonyId is in url
      if (this.ceremonyId) {
        this.ceremonyService
          .getCeremony(this.ceremonyId)
          .subscribe((ceremony) => {
            this.ceremony = ceremony;
            this.loadCeremonyForm();
          });
      }
    });
    this.loadCeremonyForm();
  }

  loadCeremonyForm() {
    this.ceremonyForm = this.fb.group({
      type: [this.ceremony?.type || ''],
      date: [this.ceremony?.date || ''],
      parishioner: [this.ceremony?.parishioner || false],
      priest: [this.ceremony?.minister?.name || ''],
      priest_title: [this.ceremony?.minister?.title || ''],
    });
    if (!this.isEditMode) {
      this.ceremonyForm.disable();
    }
  }

  onBackClick() {
    this.router.navigate(['/ceremonies']);
  }

  onModeUpdated(event: any) {
    this.isEditMode = event.isEditMode;
    this.isEditMode ? this.ceremonyForm.enable() : this.ceremonyForm.disable();
  }
}
