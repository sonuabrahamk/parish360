import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';
import { AssociationService } from '../../../services/api/associations.service';
import { FormArray, FormBuilder, FormControl, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { Member } from '../../../services/interfaces/associations.interface';

@Component({
  selector: 'app-association-committee',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './association-committee.component.html',
  styleUrl: './association-committee.component.css'
})
export class AssociationCommitteeComponent {
  @Input() parishYear: string = '';
  @Input() associationId: string = '';

  committeeMembers!: Member[];
  committeeForm!: FormGroup;

  committee: any;

  constructor(private associationService: AssociationService, private fb: FormBuilder){}

  ngOnInit(){
    this.associationService.getAssociationCommitteeMembers(this.associationId, this.parishYear).subscribe((committee) => {
      this.committeeMembers = committee;
      this.loadCommitteeForm();
    })
    
  }

  loadCommitteeForm() {
    const group: { [key:string]: FormControl } = {};
    this.committeeMembers.forEach(member => {
      group[member.role] = new FormControl(member.name);
    })
    this.committeeForm = new FormGroup(group);
  }

}
