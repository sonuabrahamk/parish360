import { Directive, Input, TemplateRef, ViewContainerRef } from '@angular/core';
import { PermissionsService } from '../services/common/permissions-api-service';

@Directive({
  selector: '[appCanCreate]',
  standalone: true
})
export class CanCreateDirective {

  private screen: string = '';

  constructor(private permissionService: PermissionsService, private templateRef: TemplateRef<unknown>, private viewContainer: ViewContainerRef) { }

  @Input()
  set appCanCreate(screen: string) {
    this.screen = screen;
    this.updateView();
  }

  private updateView(): void {
    const hasPermission = this.permissionService.canCreate(this.screen);
    if (hasPermission) {
      this.viewContainer.createEmbeddedView(this.templateRef);
    } else {
      this.viewContainer.clear();
    }
  }

}
