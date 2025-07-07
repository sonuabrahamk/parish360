import { CommonModule } from '@angular/common';
import { Component, Input, signal, SimpleChanges } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { AccordionComponent } from "../../common/accordion/accordion.component";
import { IconService } from '../../../services/icon.service';
import { faPlus } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';

@Component({
  selector: 'app-sacraments-section',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, AccordionComponent, FontAwesomeModule],
  templateUrl: './sacraments-section.component.html',
  styleUrl: './sacraments-section.component.css',
})
export class SacramentsSectionComponent {
  @Input() isEditMode: boolean = false;
  @Input() memberForm!: FormGroup;

  constructor(private fb: FormBuilder, private icon:IconService){}

  faPlus = faPlus;

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['isEditMode'] && this.memberForm) {
      if (this.isEditMode) {
        this.memberForm.enable();
      } else {
        this.memberForm.disable();
      }
    }
  }

  sacramentTypes = [
    {id: "baptism", name: "Baptism"},
    {id: "confirmation", name: "Holy Confirmation"},
    {id: "matrimony", name: "Holy Matrimony"},
    {id: "holy_communion", name: "Holy Communion"},
    {id: "anointing_the_sick", name: "Anointing the Sick"},
    {id: "holy_ordination", name: "Holy Ordination"}
  ]

  get sacramentFormArray(): FormArray {
    return this.memberForm.get('sacraments_details') as FormArray;
  }

  removeSacrament(index: number){
    this.sacramentFormArray.removeAt(index);
  }

  getSacramentTypeName(index: number): string{
    return this.sacramentTypes.find(type => type.id === this.sacramentFormArray.at(index)?.get('type')?.value)?.name ?? 'Click to Add Details';
  }

  addSacrament(){
    this.sacramentFormArray.push(this.fb.group({
      type: [''],
      date: [''],
      parish: [''],
      priest: [''],
      place: [''],
      god_father: [''],
      god_mother: [''],
      spouse: [''],
    }))
  }

}
