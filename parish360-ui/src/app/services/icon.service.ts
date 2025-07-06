import { Injectable } from '@angular/core';
import { FaIconLibrary } from '@fortawesome/angular-fontawesome';
import { faUsers, faCreditCard, faIndianRupeeSign } from '@fortawesome/free-solid-svg-icons';

@Injectable({
  providedIn: 'root', // singleton service
})
export class IconService {
  constructor(private library: FaIconLibrary) {
    this.registerIcons();
  }

  private registerIcons() {
    this.library.addIcons(faUsers, faCreditCard, faIndianRupeeSign);
  }
}